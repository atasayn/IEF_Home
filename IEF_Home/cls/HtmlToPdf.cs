using System;
using System.Collections.Generic;
using System.IO;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Threading.Tasks;
using System.Web;
using System.Linq;
using System.Net.Http;
using System.Net;

namespace IEF_Home.cls
{
    public class HtmlToPdf
    {
        public static String Code(string url)
        {
            HttpWebRequest myRequest = (HttpWebRequest)WebRequest.Create(url);
            myRequest.Method = "GET";
            WebResponse myResponse = myRequest.GetResponse();
            StreamReader sr = new StreamReader(myResponse.GetResponseStream(), System.Text.Encoding.UTF8);
            string html = sr.ReadToEnd();
            sr.Close();
            myResponse.Close();
            return html;
        }
    }
}