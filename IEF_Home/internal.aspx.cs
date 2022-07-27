using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IEF_Home
{
    public partial class _internal1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var user_name = Session["USER_NAME"] as string;
            if (user_name == null || user_name == "")
            {
                Response.Redirect("/internal_login", false);
            }

        }
        protected void btnLoggOut_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("/internal_login", false);
        }
    }
}