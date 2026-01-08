using System;

namespace IEF_Home.privacy
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string path = Request.Url.AbsolutePath.ToLower();

            // Tüm li classlarını temizle
            liHome.Attributes["class"] = "";
            liBlog.Attributes["class"] = "";
            liDatabase.Attributes["class"] = "";
            liModels.Attributes["class"] = "";
            liTeaching.Attributes["class"] = "";
            liCircomod.Attributes["class"] = "";
            liSankey.Attributes["class"] = "";
            liPapers.Attributes["class"] = "";
            liInternal.Attributes["class"] = "";

            // Aktif sayfayı seç
            if (path == "/main.aspx")
                liHome.Attributes["class"] = "active";
            else if (path.Contains("/odym-recc"))
                liModels.Attributes["class"] = "active";
            else if (path.Contains("/teaching"))
                liTeaching.Attributes["class"] = "active";
            else if (path.Contains("/circomod"))
                liCircomod.Attributes["class"] = "active";
            else if (path.Contains("/iefworkingpaper"))
                liPapers.Attributes["class"] = "active";
            else if (path.Contains("/internal"))
                liInternal.Attributes["class"] = "active";
        }


    }
}