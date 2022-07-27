using IEF_Home.cls;
using System;

namespace IEF_Home
{
    public partial class Internal : System.Web.UI.Page
    {
        private readonly clsCommon _clsCommon = new clsCommon();
        public string UserName;
        public string Password;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            UserName = Convert.ToString(txtUserName.Text);
            Password = Convert.ToString(txtPassword.Text);
            var loginStatus = _clsCommon.checkLogin(UserName, Password);

            if (loginStatus == true)
            {
                var userType = _clsCommon.user_type(UserName, Password);
                Session["USER_NAME"] = UserName;
                Session["USER_TYPE"] = userType;
                Response.Redirect("internal.aspx", false);
            }
            else
            {
                login_warning.Text = "Username or password is invalid!";
            }
        }
    }
}