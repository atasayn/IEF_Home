using System;

namespace IEF_Home
{
    public partial class _internal1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var user_name = Session["USER_NAME"] as string;
            if (string.IsNullOrEmpty(user_name))
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