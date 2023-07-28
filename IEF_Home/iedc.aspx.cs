using IEF_Home.cls;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IEF_Home
{
    public partial class iedc : System.Web.UI.Page
    {
        DbConnect cn = new DbConnect();

        protected void Page_Load(object sender, EventArgs e)
        {

          
        }

        public string iedcDatatype(object sender, EventArgs e)
        {

            string data_type = "";
            var query = "SELECT dataset_name FROM idec.datasets";

            if (cn.OpenConnection() == true)
            {
                var cmd = new MySqlCommand(query, cn.Connection);
                var reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    data_type = reader.ToString();
                }

                reader.Close();
                cn.CloseConnection();
            }
            System.Diagnostics.Debug.WriteLine("AAAAAAAAAAAAAAAAAAAA" + data_type);
            return data_type;
            
        }


    }

   
}