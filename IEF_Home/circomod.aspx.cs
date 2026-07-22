using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Policy;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IEF_Home
{
    public partial class circomod : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            liHome.Attributes["class"] = "";
            liDatabase.Attributes["class"] = "";
            liModels.Attributes["class"] = "";
            liTeaching.Attributes["class"] = "";
            liCircomod.Attributes["class"] = "";
            liSankey.Attributes["class"] = "";
            liPapers.Attributes["class"] = "";
            liInternal.Attributes["class"] = "";

            liCircomod.Attributes["class"] = "active";
        }

    }
}