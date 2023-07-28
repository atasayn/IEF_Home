using System;
using System.Data;
using System.Web.Services;
using MySql.Data.MySqlClient;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace IEF_Home.cls
{
    public class clsCommon
    {
        DbConnect cn = new DbConnect();
 
        public bool checkLogin(string userName, string password)
        {
            var type = this.user_type(userName, password);
            return (type != "");
        }
        
        public string user_type(string userName, string password)
        {
            var user_type = "";
            var query = "SELECT * FROM login_internal where user_name= @userName AND password= @password ";

            if (cn.OpenConnection() == true)
            {
                var cmd = new MySqlCommand(query, cn.Connection);
                cmd.Parameters.AddWithValue("@username", userName);
                var hash = Hash.HashString(password , userName);
                cmd.Parameters.AddWithValue("@password", hash);
                //System.Diagnostics.Debug.WriteLine("OUTPUTTTTTTT" + userName + ":" + hash);
                var reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    user_type = reader["user_type"].ToString();
                }

                reader.Close();
                cn.CloseConnection();
            }

            return user_type;
            
        }

       
     
    }

 
}