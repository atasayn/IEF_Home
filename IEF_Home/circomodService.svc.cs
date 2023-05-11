using IEF_Home.cls;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;

namespace IEF_Home
{
    [ServiceContract(Namespace = "")]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class circomodService
    {

        DbConnect cn = new DbConnect();

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]

        public string Classification_RegionItem(string selectedRegion)
        {

            var selectedRegionId = "";
            var query =
                "SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion";
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
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]

        public string Classification_ScenerioItem(string selecetedScenario)
        {
            var selectedScenarioId = "";
            var query =
                "SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario";
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

        public List<List<string>> Classification_ResultItem(string selectedRegion)
        {

            var output = new List<List<string>>();
            if (!cn.OpenConnection()) return null;
            foreach (var selectedScenario in new List<string> { "LED", "SSP1", "SSP2" })
            {
                var scenarioArray = new List<string>();
                const string query = @"SELECT d.value
            FROM iedc.data d
            LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
            LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
            LEFT JOIN iedc.classification_items ci4 ON d.aspect4 = ci4.id
            INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
            WHERE d.dataset_id = 304
            AND d.aspect5 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
            AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)";
                var cmd = new MySqlCommand(query, cn.Connection);

                cmd.Parameters.AddWithValue("@SelectedScenario", selectedScenario);
                cmd.Parameters.AddWithValue("@SelectedRegion", selectedRegion);

                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    scenarioArray.Add(reader[0].ToString().Replace(",", "."));
                }
                output.Add(scenarioArray);
                reader.Close();
            }
            cn.CloseConnection();
            return output;
        }


        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]
        public  Dictionary<string, string> Classification_SankeyItem(string selectedRegion, string selectedScenario, string selectedMaterial, string selectedStrategy, string selectedYear, string selectedSector, string selectedFlow)
        {
            var queryList = new Dictionary<string, string>
            {
                ["query_Fa"] = @"SELECT CASE
                        WHEN d.value > 0 THEN max(d.value)
                        ELSE 0
                    END AS value, u1.unitcode,u2.unitcode
                    FROM iedc.data d
                    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
                    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
                    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
                    WHERE d.dataset_id = 306 
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
                    AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
                    AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SelectedMaterial)
                    AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
                    AND d.aspect4 = 87",
                ["query_Fn"] = @"SELECT CASE
                        WHEN d.value > 0 THEN max(d.value)
                        ELSE 0
                    END AS value,u1.unitcode,u2.unitcode
                    FROM iedc.data d
                    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
                    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
                    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
                    WHERE d.dataset_id = 308 
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
                    AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SelectedMaterial)
                    AND d.aspect4 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
                    AND d.aspect9 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
                    AND d.aspect3 = 1092",
                ["query_Fh"] = @"SELECT CASE
                        WHEN d.value > 0 THEN max(d.value)
                        ELSE 0
                    END AS value, u1.unitcode,u2.unitcode
                    FROM iedc.data d
                    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
                    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
                    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
                    WHERE d.dataset_id = 306  
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
                    AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
                    AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SelectedMaterial)
                    AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
                    AND d.aspect4 = 88",
                ["query_Fc"] = @"SELECT CASE
                        WHEN d.value > 0 THEN max(d.value)
                        ELSE 0
                    END AS value,u1.unitcode,u2.unitcode
                    FROM iedc.data d
                    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
                    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
                    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
                    WHERE d.dataset_id = 308 
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
                    AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SelectedMaterial)
                    AND d.aspect4 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
                    AND d.aspect9 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
                    AND d.aspect3 = 1182",
                ["query_Ff"] = @"SELECT CASE
                        WHEN d.value > 0 THEN max(d.value)
                        ELSE 0
                    END AS value,u1.unitcode,u2.unitcode
                    FROM iedc.data d
                    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
                    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
                    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
                    WHERE d.dataset_id = 308
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
                    AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SelectedMaterial)
                    AND d.aspect4 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
                    AND d.aspect9 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
                    AND d.aspect3 = 1083",
                ["query_Fk"] = @"SELECT CASE
                        WHEN d.value > 0 THEN max(d.value)
                        ELSE 0
                    END AS value,u1.unitcode,u2.unitcode
                    FROM iedc.data d
                    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
                    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
                    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
                    WHERE d.dataset_id = 307 
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
                    AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
                    AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
                    AND d.aspect4 = 53",
                ["query_Fl"] = @"SELECT CASE
                        WHEN d.value > 0 THEN max(d.value)
                        ELSE 0
                    END AS value,u1.unitcode,u2.unitcode
                    FROM iedc.data d
                    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
                    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
                    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
                    WHERE d.dataset_id = 307 
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
                    AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
                    AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
                    AND d.aspect4 = 56",
                ["query_Fm"] = @"SELECT CASE
                        WHEN d.value > 0 THEN max(d.value)
                        ELSE 0
                    END AS value,u1.unitcode,u2.unitcode
                    FROM iedc.data d
                    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
                    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
                    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
                    WHERE d.dataset_id = 307 
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
                    AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
                    AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
                    AND d.aspect4 = 55"
            };



             //DataTable dt = new DataTable();
             //dt.Columns.Add("flowname", typeof(string));
             //dt.Columns.Add("value", typeof(string));
             Dictionary<string, string> result = new Dictionary<string, string>();

            foreach (KeyValuePair<string, string> kvp in queryList)
            {
                try
                {
                    var queryName = kvp.Key;
                    var query = kvp.Value;

                    if (!cn.OpenConnection()) return null;
                    var cmd = new MySqlCommand(query, cn.Connection);

                    cmd.Parameters.AddWithValue("@SelectedScenario", selectedScenario);
                    cmd.Parameters.AddWithValue("@SelectedRegion", selectedRegion);
                    cmd.Parameters.AddWithValue("@SelectedMaterial", selectedMaterial);
                    cmd.Parameters.AddWithValue("@SelectedSector", selectedSector);
                    cmd.Parameters.AddWithValue("@SelectedYear", selectedYear);
                    cmd.Parameters.AddWithValue("@SelectedStrategy", selectedStrategy);


                    var reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        var value = Convert.ToString(reader["value"]);

                        try
                        {
                            result.Add(queryName, value);
                        }
                        catch (ArgumentException ex)
                        {
                            //if (result.ContainsKey("error_message"))
                            //{
                            //    result["error_message"] += "\n" + ex.Message + " for query " + queryName + ": " + value;
                            //}
                            //else
                            //{
                            //    result.Add("error_message", ex.Message + " for query " + queryName + ": " + value);
                            //}
                        }
                    }

                    cn.CloseConnection();
                }
                catch (InvalidOperationException e)
                {

                }

            }

            return result; //dt;
        }


        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]
        public string Classification_SectorItem(string selectedSector)
        {
            var selectedSectorId = "";
            var query =
                "SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector";
            if (cn.OpenConnection() == true)
            {
                var cmd = new MySqlCommand(query, cn.Connection);
                cmd.Parameters.AddWithValue("@SelectedSector", selectedSector);
                var reader = cmd.ExecuteReader();



                while (reader.Read())
                {

                    selectedSectorId = reader["id"].ToString();
                }


                reader.Close();
                cn.CloseConnection();


            }

            return selectedSectorId;
        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]
        public string Classification_MaterialItem(string selectedMaterial)
        {
            var selectedMaterialId = "";
            var query =
                "SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SelectedMaterial";
            if (cn.OpenConnection() == true)
            {
                var cmd = new MySqlCommand(query, cn.Connection);
                cmd.Parameters.AddWithValue("@SelectedMaterial", selectedMaterial);
                var reader = cmd.ExecuteReader();



                while (reader.Read())
                {

                    selectedMaterialId = reader["id"].ToString();
                }


                reader.Close();
                cn.CloseConnection();


            }

            return selectedMaterialId;
        }


        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]
        public string Classification_YearItem(string selectedYear)
        {
            var selectedYearId = "";
            var query =
                "SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear";
            if (cn.OpenConnection() == true)
            {
                var cmd = new MySqlCommand(query, cn.Connection);
                cmd.Parameters.AddWithValue("@SelectedYear", selectedYear);
                var reader = cmd.ExecuteReader();



                while (reader.Read())
                {

                    selectedYearId = reader["id"].ToString();
                }


                reader.Close();
                cn.CloseConnection();


            }

            return selectedYearId;
        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]
        public string Classification_StrategyItem(string selectedStrategy)
        {
            var selectedStrategyId = "";
            var query =
                "SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy";
            if (cn.OpenConnection() == true)
            {
                var cmd = new MySqlCommand(query, cn.Connection);
                cmd.Parameters.AddWithValue("@SelectedStrategy", selectedStrategy);
                var reader = cmd.ExecuteReader();



                while (reader.Read())
                {

                    selectedStrategyId = reader["id"].ToString();
                }

                reader.Close();
                cn.CloseConnection();


            }

            return selectedStrategyId;
        }












        //[OperationContract]
        //[WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]

        //public List<List<string>> Classification_FaItem(string selectedRegion, string selectedScenario,string selectedMaterial, string selectedStrategy,string selectedYear, string selectedSector, string selectedFlow)
        //{

        //    //var out_str = String.Empty;
        //    var output = new List<List<string>>();
        //    const string query = @"SELECT d.value, u1.unitcode,u2.unitcode
        //    FROM iedc.data d
        //    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
        //    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
        //    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
        //    WHERE d.dataset_id = 306
        //    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
        //    AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
        //    AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SelectedMaterial)
        //    AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
        //    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
        //    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
        //    AND d.aspect4 = @SelectedFlow";

        //    if (!cn.OpenConnection()) return null;
        //    var cmd = new MySqlCommand(query, cn.Connection);

        //    cmd.Parameters.AddWithValue("@SelectedScenario", selectedScenario);
        //    cmd.Parameters.AddWithValue("@SelectedRegion", selectedRegion);
        //    cmd.Parameters.AddWithValue("@SelectedMaterial", selectedMaterial);
        //    cmd.Parameters.AddWithValue("@SelectedSector", selectedSector);
        //    cmd.Parameters.AddWithValue("@SelectedYear", selectedYear);
        //    cmd.Parameters.AddWithValue("@SelectedStrategy", selectedStrategy);
        //    cmd.Parameters.AddWithValue("@SelectedFlow", selectedFlow);

        //    var reader = cmd.ExecuteReader();
        //    while (reader.Read())
        //    {
        //        var row = new List<string>();
        //        for (var i = 0; i < reader.FieldCount; i++)
        //        {
        //            row.Add(reader[i].ToString());
        //        }
        //        output.Add(row);
        //    }
        //    cn.CloseConnection();
        //    return output;
        //}

        //[OperationContract]
        //[WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]

        //public List<List<string>> Classification_FnFoFpItem(string selectedRegion, string selectedScenario, string selectedMaterial, string selectedStrategy, string selectedYear, string selectedSector, string selectedFlow)
        //{

        //    //var out_str = String.Empty;
        //    var output = new List<List<string>>();
        //    const string query = @"SELECT u1.unitcode,u2.unitcode
        //    FROM iedc.data d
        //    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
        //    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
        //    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
        //    WHERE d.dataset_id = 308
        //    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
        //    AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
        //    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SelectedMaterial)
        //    AND d.aspect4 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
        //    AND d.aspect9 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
        //    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
        //    AND d.aspect3 = fabrication scrap";

        //    if (!cn.OpenConnection()) return null;
        //    var cmd = new MySqlCommand(query, cn.Connection);

        //    cmd.Parameters.AddWithValue("@SelectedScenario", selectedScenario);
        //    cmd.Parameters.AddWithValue("@SelectedRegion", selectedRegion);
        //    cmd.Parameters.AddWithValue("@SelectedMaterial", selectedMaterial);
        //    cmd.Parameters.AddWithValue("@SelectedSector", selectedSector);
        //    cmd.Parameters.AddWithValue("@SelectedYear", selectedYear);
        //    cmd.Parameters.AddWithValue("@SelectedStrategy", selectedStrategy);
        //    cmd.Parameters.AddWithValue("@SelectedFlow", selectedFlow);
        //    var reader = cmd.ExecuteReader();
        //    while (reader.Read())
        //    {
        //        var row = new List<string>();
        //        for (var i = 0; i < reader.FieldCount; i++)
        //        {
        //            row.Add(reader[i].ToString());
        //        }
        //        output.Add(row);

        //    }
        //    cn.CloseConnection();
        //    return output;

        //}

        //[OperationContract]
        //[WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]

        //public List<List<string>> Classification_FhFiFjItem(string selectedRegion, string selectedScenario, string selectedMaterial, string selectedStrategy, string selectedYear, string selectedSector, string selectedFlow)
        //{

        //    //var out_str = String.Empty;
        //    var output = new List<List<string>>();
        //    const string query = @"SELECT u1.unitcode,u2.unitcode
        //    FROM iedc.data d
        //    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
        //    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
        //    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
        //    WHERE d.dataset_id = 306
        //    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
        //    AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
        //    AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SelectedMaterial)
        //    AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
        //    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
        //    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
        //    AND d.aspect4 = secondary production";

        //    if (!cn.OpenConnection()) return null;
        //    var cmd = new MySqlCommand(query, cn.Connection);

        //    cmd.Parameters.AddWithValue("@SelectedScenario", selectedScenario);
        //    cmd.Parameters.AddWithValue("@SelectedRegion", selectedRegion);
        //    cmd.Parameters.AddWithValue("@SelectedMaterial", selectedMaterial);
        //    cmd.Parameters.AddWithValue("@SelectedSector", selectedSector);
        //    cmd.Parameters.AddWithValue("@SelectedYear", selectedYear);
        //    cmd.Parameters.AddWithValue("@SelectedStrategy", selectedStrategy);
        //    cmd.Parameters.AddWithValue("@SelectedFlow", selectedFlow);
        //    var reader = cmd.ExecuteReader();
        //    while (reader.Read())
        //    {
        //        var row = new List<string>();
        //        for (var i = 0; i < reader.FieldCount; i++)
        //        {
        //            row.Add(reader[i].ToString());
        //        }
        //        output.Add(row);

        //    }
        //    cn.CloseConnection();

        //    return output;

        //}

        //[OperationContract]
        //[WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]

        //public List<List<string>> Classification_FcFdFeItem(string selectedRegion, string selectedScenario, string selectedMaterial, string selectedStrategy, string selectedYear, string selectedSector, string selectedFlow)
        //{

        //    //var out_str = String.Empty;
        //    var output = new List<List<string>>();
        //    const string query = @"SELECT u1.unitcode,u2.unitcode
        //    FROM iedc.data d
        //    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
        //    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
        //    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
        //    WHERE d.dataset_id = 308
        //    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
        //    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
        //    AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SelectedMaterial)
        //    AND d.aspect4 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
        //    AND d.aspect9 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
        //    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
        //    AND d.aspect3 = products for re-use";

        //    if (!cn.OpenConnection()) return null;
        //    var cmd = new MySqlCommand(query, cn.Connection);

        //    cmd.Parameters.AddWithValue("@SelectedScenario", selectedScenario);
        //    cmd.Parameters.AddWithValue("@SelectedRegion", selectedRegion);
        //    cmd.Parameters.AddWithValue("@SelectedMaterial", selectedMaterial);
        //    cmd.Parameters.AddWithValue("@SelectedSector", selectedSector);
        //    cmd.Parameters.AddWithValue("@SelectedYear", selectedYear);
        //    cmd.Parameters.AddWithValue("@SelectedStrategy", selectedStrategy);
        //    cmd.Parameters.AddWithValue("@SelectedFlow", selectedFlow);
        //    var reader = cmd.ExecuteReader();
        //    while (reader.Read())
        //    {
        //        var row = new List<string>();
        //        for (var i = 0; i < reader.FieldCount; i++)
        //        {
        //            row.Add(reader[i].ToString());
        //        }
        //        output.Add(row);

        //    }
        //    cn.CloseConnection();

        //    return output;

        //}

        //[OperationContract]
        //[WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]

        //public List<List<string>> Classification_FfItem(string selectedRegion, string selectedScenario, string selectedMaterial, string selectedStrategy, string selectedYear, string selectedSector, string selectedFlow)
        //{

        //    //var out_str = String.Empty;
        //    var output = new List<List<string>>();
        //    const string query = @"SELECT u1.unitcode,u2.unitcode
        //    FROM iedc.data d
        //    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
        //    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
        //    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
        //    WHERE d.dataset_id = 308
        //    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
        //    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
        //    AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SelectedMaterial)
        //    AND d.aspect4 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
        //    AND d.aspect9 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
        //    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
        //    AND d.aspect3 = collected EoL (end-of-life) products";

        //    if (!cn.OpenConnection()) return null;
        //    var cmd = new MySqlCommand(query, cn.Connection);

        //    cmd.Parameters.AddWithValue("@SelectedScenario", selectedScenario);
        //    cmd.Parameters.AddWithValue("@SelectedRegion", selectedRegion);
        //    cmd.Parameters.AddWithValue("@SelectedMaterial", selectedMaterial);
        //    cmd.Parameters.AddWithValue("@SelectedSector", selectedSector);
        //    cmd.Parameters.AddWithValue("@SelectedYear", selectedYear);
        //    cmd.Parameters.AddWithValue("@SelectedStrategy", selectedStrategy);
        //    cmd.Parameters.AddWithValue("@SelectedFlow", selectedFlow);
        //    var reader = cmd.ExecuteReader();
        //    while (reader.Read())
        //    {
        //        var row = new List<string>();
        //        for (var i = 0; i < reader.FieldCount; i++)
        //        {
        //            row.Add(reader[i].ToString());
        //        }
        //        output.Add(row);

        //    }
        //    cn.CloseConnection();

        //    return output;

        //}

        //[OperationContract]
        //[WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]

        //public List<List<string>> Classification_FkItem(string selectedRegion, string selectedScenario, string selectedMaterial, string selectedStrategy, string selectedYear, string selectedSector, string selectedFlow)
        //{

        //    //var out_str = String.Empty;
        //    var output = new List<List<string>>();
        //    const string query = @"SELECT u1.unitcode,u2.unitcode
        //    FROM iedc.data d
        //    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
        //    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
        //    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
        //    WHERE d.dataset_id = 307
        //    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
        //    AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
        //    AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
        //    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
        //    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
        //    AND d.aspect4 = material production";

        //    if (!cn.OpenConnection()) return null;
        //    var cmd = new MySqlCommand(query, cn.Connection);

        //    cmd.Parameters.AddWithValue("@SelectedScenario", selectedScenario);
        //    cmd.Parameters.AddWithValue("@SelectedRegion", selectedRegion);
        //    cmd.Parameters.AddWithValue("@SelectedSector", selectedSector);
        //    cmd.Parameters.AddWithValue("@SelectedYear", selectedYear);
        //    cmd.Parameters.AddWithValue("@SelectedStrategy", selectedStrategy);
        //    cmd.Parameters.AddWithValue("@SelectedFlow", selectedFlow);
        //    var reader = cmd.ExecuteReader();
        //    while (reader.Read())
        //    {
        //        var row = new List<string>();
        //        for (var i = 0; i < reader.FieldCount; i++)
        //        {
        //            row.Add(reader[i].ToString());
        //        }
        //        output.Add(row);

        //    }
        //    cn.CloseConnection();

        //    return output;

        //}

        //[OperationContract]
        //[WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]

        //public List<List<string>> Classification_FlRemItem(string selectedRegion, string selectedScenario, string selectedMaterial, string selectedStrategy, string selectedYear, string selectedSector, string selectedFlow)
        //{

        //    //var out_str = String.Empty;
        //    var output = new List<List<string>>();
        //    const string query = @"SELECT u1.unitcode,u2.unitcode
        //    FROM iedc.data d
        //    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
        //    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
        //    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
        //    WHERE d.dataset_id = 307
        //    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
        //    AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
        //    AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
        //    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
        //    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
        //    AND d.aspect4 = waste management";

        //    if (!cn.OpenConnection()) return null;
        //    var cmd = new MySqlCommand(query, cn.Connection);

        //    cmd.Parameters.AddWithValue("@SelectedScenario", selectedScenario);
        //    cmd.Parameters.AddWithValue("@SelectedRegion", selectedRegion);
        //    cmd.Parameters.AddWithValue("@SelectedSector", selectedSector);
        //    cmd.Parameters.AddWithValue("@SelectedYear", selectedYear);
        //    cmd.Parameters.AddWithValue("@SelectedStrategy", selectedStrategy);
        //    cmd.Parameters.AddWithValue("@SelectedFlow", selectedFlow);
        //    var reader = cmd.ExecuteReader();
        //    while (reader.Read())
        //    {
        //        var row = new List<string>();
        //        for (var i = 0; i < reader.FieldCount; i++)
        //        {
        //            row.Add(reader[i].ToString());
        //        }
        //        output.Add(row);

        //    }
        //    cn.CloseConnection();

        //    return output;

        //}

        //[OperationContract]
        //[WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]

        //public List<List<string>> Classification_FmRemItem(string selectedRegion, string selectedScenario, string selectedMaterial, string selectedStrategy, string selectedYear, string selectedSector, string selectedFlow)
        //{

        //    //var out_str = String.Empty;
        //    var output = new List<List<string>>();
        //    const string query = @"SELECT u1.unitcode,u2.unitcode
        //    FROM iedc.data d
        //    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
        //    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
        //    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
        //    WHERE d.dataset_id = 307
        //    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SelectedRegion)
        //    AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SelectedScenario)
        //    AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SelectedSector)
        //    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SelectedYear)
        //    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SelectedStrategy)
        //    AND d.aspect4 = use phase";

        //    if (!cn.OpenConnection()) return null;
        //    var cmd = new MySqlCommand(query, cn.Connection);

        //    cmd.Parameters.AddWithValue("@SelectedScenario", selectedScenario);
        //    cmd.Parameters.AddWithValue("@SelectedRegion", selectedRegion);
        //    cmd.Parameters.AddWithValue("@SelectedSector", selectedSector);
        //    cmd.Parameters.AddWithValue("@SelectedYear", selectedYear);
        //    cmd.Parameters.AddWithValue("@SelectedStrategy", selectedStrategy);
        //    cmd.Parameters.AddWithValue("@SelectedFlow", selectedFlow);
        //    var reader = cmd.ExecuteReader();
        //    while (reader.Read())
        //    {
        //        var row = new List<string>();
        //        for (var i = 0; i < reader.FieldCount; i++)
        //        {
        //            row.Add(reader[i].ToString());
        //        }
        //        output.Add(row);

        //    }
        //    cn.CloseConnection();

        //    return output;

        //}

    }
}



