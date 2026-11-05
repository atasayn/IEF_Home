using System;
using System.Configuration;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;

namespace IEF_Home.cls
{
    public class GisProxyHandler : HttpTaskAsyncHandler
    {
        // One HttpClient for the whole app (creating one per request exhausts sockets)
        private static readonly HttpClient Client = new HttpClient { Timeout = TimeSpan.FromSeconds(60) };

        private static readonly string Upstream = ConfigurationManager.AppSettings["QgisServerUrl"];
        private static readonly string Project = ConfigurationManager.AppSettings["QgisProjectFile"];

        public override bool IsReusable => true;

        public override async Task ProcessRequestAsync(HttpContext ctx)
        {
            // Later: only logged-in users may see the map
            // if (!ctx.User.Identity.IsAuthenticated) { ctx.Response.StatusCode = 401; return; }

            // 0) Settings check: QgisServerUrl must be a full address like http://localhost/qgis/qgis_mapserv.fcgi.exe
            Uri upstreamUri;
            if (!Uri.TryCreate(Upstream, UriKind.Absolute, out upstreamUri) ||
                (upstreamUri.Scheme != Uri.UriSchemeHttp && upstreamUri.Scheme != Uri.UriSchemeHttps))
            {
                ctx.Response.StatusCode = 500;
                ctx.Response.ContentType = "text/plain";
                ctx.Response.Write("Map service is not configured: appSetting 'QgisServerUrl' must be a full http(s) address.");
                return;
            }

            // 1) Copy the query string; never let the browser choose the project file
            var query = HttpUtility.ParseQueryString(ctx.Request.Url.Query);
            query.Remove("MAP");                       // case-insensitive
            if (!string.IsNullOrEmpty(Project))
                query["MAP"] = Project;

            // 2) Build the upstream request
            var request = new HttpRequestMessage(new HttpMethod(ctx.Request.HttpMethod),
                                                 Upstream + "?" + query);
            if (ctx.Request.HttpMethod == "POST")
            {
                request.Content = new StreamContent(ctx.Request.InputStream);
                if (ctx.Request.ContentType != null)
                    request.Content.Headers.TryAddWithoutValidation("Content-Type", ctx.Request.ContentType);
            }

            // Tell QGIS its public address, so URLs inside GetCapabilities point to /gis
            request.Headers.TryAddWithoutValidation("X-Qgis-Service-Url",
                ctx.Request.Url.GetLeftPart(UriPartial.Path));

            // 3) Send it and stream the answer back
            try
            {
                using (var response = await Client.SendAsync(request, HttpCompletionOption.ResponseHeadersRead))
                {
                    ctx.Response.StatusCode = (int)response.StatusCode;
                    ctx.Response.ContentType = response.Content.Headers.ContentType?.ToString();
                    var stream = await response.Content.ReadAsStreamAsync();
                    await stream.CopyToAsync(ctx.Response.OutputStream);
                }
            }
            catch (HttpRequestException)
            {
                ctx.Response.StatusCode = 502;
                ctx.Response.ContentType = "text/plain";
                ctx.Response.Write("QGIS Server is not reachable.");
            }
            catch (TaskCanceledException)                // HttpClient timeout
            {
                ctx.Response.StatusCode = 504;
                ctx.Response.ContentType = "text/plain";
                ctx.Response.Write("QGIS Server did not answer in time.");
            }
        }
    }
}