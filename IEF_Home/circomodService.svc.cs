using IEF_Home.cls;
using MySql.Data.MySqlClient;
using MySqlX.XDevAPI.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using System.Web.Script.Serialization;
using MySqlX.Serialization;
using System.Text.Json;

namespace IEF_Home
{
    [ServiceContract(Namespace = "")]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class circomodService
    {

        DbConnect cn = new DbConnect();

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]

        public string Classification_RegionItem(string selectedRegion)
        {

            var selectedRegionId = "";
            var query = "SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion";
            if (cn.OpenConnection() == true)
            {
                var cmd = new MySqlCommand(query, cn.Connection);
                //cmd.Parameters.AddWithValue("@SelectedRegion", selecetedRegion);
                cmd.Parameters.AddWithValue("@SelectedRegion", selectedRegion);
                var reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    selectedRegionId = reader["id"].ToString();
                }

                reader.Close();
                cn.CloseConnection();
            }

            return selectedRegionId;
        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]

        public string Classification_ScenerioItem(string selecetedScenario)
        {
            var selectedScenarioId = "";
            var query = "SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario";
            if (cn.OpenConnection() == true)
            {
                var cmd = new MySqlCommand(query, cn.Connection);
                cmd.Parameters.AddWithValue("@SelectedScenario", selecetedScenario);
                var reader = cmd.ExecuteReader();



                while (reader.Read())
                {

                    selectedScenarioId = reader["id"].ToString();
                }


                reader.Close();
                cn.CloseConnection();


            }

            return selectedScenarioId;
        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]

        public List<List<string>> Classification_ResultItem(string selectedRegion, string selectedScenario)
        {

            //var out_str = String.Empty;
            var output = new List<List<string>>();
            const string query = @"SELECT ci4.attribute1_oto AS aspect_4, d.value, u1.unitcode, u2.unitcode
            FROM iedc.data d
            LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
            LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
            LEFT JOIN iedc.classification_items ci4 ON d.aspect4 = ci4.id
            INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
            WHERE d.dataset_id = 304
            AND d.aspect5 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
            AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)";

            if (!cn.OpenConnection()) return null;
            var cmd = new MySqlCommand(query, cn.Connection);

            cmd.Parameters.AddWithValue("@SelectedScenario", selectedScenario);
            cmd.Parameters.AddWithValue("@SelectedRegion", selectedRegion);

            var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                var row = new List<string>();
                for (var i = 0; i < reader.FieldCount; i++)
                {
                    row.Add(reader[i].ToString());
                }
                output.Add(row);
                //out_str += $"('{reader[0]}', '{reader[1]}', '{reader[2]}', '{reader[3]}')\n";
            }
            cn.CloseConnection();
            //var out_dict = new Dictionary<string, List<List<string>>>();
            //out_dict.Add("data", output);
            return output;
            //return out_str;
        }
    }
}
