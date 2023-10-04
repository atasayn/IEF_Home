using IEF_Home.cls;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Xml;

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
                        WHEN d.value IS NOT NULL THEN max(d.value)
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
                        WHEN d.value IS NOT NULL THEN max(d.value)
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
                        WHEN d.value IS NOT NULL THEN max(d.value)
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
                        WHEN d.value IS NOT NULL THEN max(d.value)
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
                        WHEN d.value IS NOT NULL THEN max(d.value)
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
                        WHEN d.value IS NOT NULL THEN max(d.value)
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
                        WHEN d.value IS NOT NULL THEN max(d.value)
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
                        WHEN d.value IS NOT NULL THEN max(d.value)
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

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
           ResponseFormat = WebMessageFormat.Json)]

        public List<string> iedcDatatype()
        {
            
            var output = new List<string>();
            var query = "SELECT * FROM iedc.types";

            if (!cn.OpenConnection()) return null;
            var cmd = new MySqlCommand(query, cn.Connection);
            var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                string name = reader["name"].ToString();
                string reference = reader["reference_data_category"].ToString();
                string symbol = reader["symbol"].ToString();
                output.Add(name + " (" + string.Join("_", reference, symbol) + ")");
            }
            reader.Close();
            cn.CloseConnection();
            //System.Diagnostics.Debug.WriteLine(string.Join(", ", output));
            return output;
        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
          ResponseFormat = WebMessageFormat.Json)]
        public List<string> iedcDatatypesIdNumbers(string userSelect)
        {

            List<string> IdNumbers = new List<string>();


            var query = "SELECT id FROM iedc.datasets WHERE data_type = @userSelect";


            if (!cn.OpenConnection()) return null;
            var cmd = new MySqlCommand(query, cn.Connection);
            cmd.Parameters.AddWithValue("@userSelect", userSelect);
            var reader = cmd.ExecuteReader();


            while (reader.Read())
            {

                string selectedStrategyId = reader["id"].ToString();
                IdNumbers.Add(selectedStrategyId);

            }


            reader.Close();
            cn.CloseConnection();
            // System.Diagnostics.Debug.WriteLine(string.Join(", ", selectedStrategyId));
            return IdNumbers;

        }
        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
           ResponseFormat = WebMessageFormat.Json)]
        public List<string> iedcDatatypeAspect(string userInput)
        {

            List<string> aspectsTemp = new List<string>();
            // aspect_1_classification for each aspect
            var query = "SELECT a1.aspect AS aspect_1_name, a2.aspect AS aspect_2_name, a3.aspect AS aspect_3_name, a4.aspect AS aspect_4_name," +
                " a5.aspect AS aspect_5_name, a6.aspect AS aspect_6_name, a7.aspect AS aspect_7_name, a8.aspect AS aspect_8_name, " +
                " a9.aspect AS aspect_9_name, a10.aspect AS aspect_10_name, a11.aspect AS aspect_11_name, a12.aspect AS aspect_12_name " +
                " FROM iedc.datasets AS ds " +
                " LEFT JOIN iedc.aspects AS a1 ON ds.aspect_1 = a1.id " +
                " LEFT JOIN iedc.aspects AS a2 ON ds.aspect_2 = a2.id " +
                " LEFT JOIN iedc.aspects AS a3 ON ds.aspect_3 = a3.id " +
                " LEFT JOIN iedc.aspects AS a4 ON ds.aspect_4 = a4.id " +
                " LEFT JOIN iedc.aspects AS a5 ON ds.aspect_5 = a5.id " +
                " LEFT JOIN iedc.aspects AS a6 ON ds.aspect_6 = a6.id " +
                " LEFT JOIN iedc.aspects AS a7 ON ds.aspect_7 = a7.id " +
                " LEFT JOIN iedc.aspects AS a8 ON ds.aspect_8 = a8.id " +
                " LEFT JOIN iedc.aspects AS a9 ON ds.aspect_9 = a9.id " +
                " LEFT JOIN iedc.aspects AS a10 ON ds.aspect_10 = a10.id " +
                " LEFT JOIN iedc.aspects AS a11 ON ds.aspect_11 = a11.id " +
                " LEFT JOIN iedc.aspects AS a12 ON ds.aspect_12 = a12.id " +
                " WHERE ds.id IN (SELECT id FROM iedc.datasets WHERE data_type = @userInput)";

            if (!cn.OpenConnection()) return null;
            var cmd = new MySqlCommand(query, cn.Connection);
            cmd.Parameters.AddWithValue("@userInput", userInput);
            var reader = cmd.ExecuteReader();

            while (reader.Read())
            {

                for(int i=0; i < reader.FieldCount; i++)
                {
                    string classification = reader[i].ToString();
                    aspectsTemp.Add(classification);

                }

                aspectsTemp = aspectsTemp.Distinct().ToList();
                aspectsTemp.RemoveAll(item => item == "");
               
            }

            reader.Close();
            cn.CloseConnection();
            return aspectsTemp;

        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
           ResponseFormat = WebMessageFormat.Json)]
        public Dictionary<string, string> iedcDatatypeClassAspects(string aspectName, string data_type)
        {

            var id_aspect = new Dictionary<string, string>();

            var query = "SELECT id, attribute1_oto FROM iedc.classification_items WHERE classification_id IN (SELECT " +
                "CASE " +
                "WHEN aspect_1 = (SELECT id FROM iedc.aspects WHERE aspect = @aspectName)  THEN aspect_1_classification " +
                "WHEN aspect_2 = (SELECT id FROM iedc.aspects WHERE aspect = @aspectName)  THEN aspect_2_classification " +
                "WHEN aspect_3 = (SELECT id FROM iedc.aspects WHERE aspect = @aspectName)  THEN aspect_3_classification " +
                "WHEN aspect_4 = (SELECT id FROM iedc.aspects WHERE aspect = @aspectName)  THEN aspect_4_classification " +
                "WHEN aspect_5 = (SELECT id FROM iedc.aspects WHERE aspect = @aspectName)  THEN aspect_5_classification " +
                "WHEN aspect_6 = (SELECT id FROM iedc.aspects WHERE aspect = @aspectName)  THEN aspect_6_classification " +
                "WHEN aspect_7 = (SELECT id FROM iedc.aspects WHERE aspect = @aspectName)  THEN aspect_7_classification " +
                "WHEN aspect_8 = (SELECT id FROM iedc.aspects WHERE aspect = @aspectName)  THEN aspect_8_classification " +
                "WHEN aspect_9 = (SELECT id FROM iedc.aspects WHERE aspect = @aspectName)  THEN aspect_9_classification " +
                "WHEN aspect_10 = (SELECT id FROM iedc.aspects WHERE aspect = @aspectName) THEN aspect_10_classification " +
                "WHEN aspect_11 = (SELECT id FROM iedc.aspects WHERE aspect = @aspectName) THEN aspect_11_classification " +
                "WHEN aspect_12 = (SELECT id FROM iedc.aspects WHERE aspect = @aspectName) THEN aspect_12_classification " +
                "ELSE NULL " +
                "END AS  classification " +
                "FROM iedc.datasets " +
                "WHERE (SELECT id FROM iedc.aspects WHERE aspect = @aspectName) IN (aspect_1, aspect_2, aspect_3, aspect_4, aspect_5, aspect_6, aspect_7, aspect_8, aspect_9, aspect_10, aspect_11, aspect_12) and data_type = @data_type)";

            if (!cn.OpenConnection()) return null;
            var cmd = new MySqlCommand(query, cn.Connection);
            cmd.Parameters.AddWithValue("@aspectName", aspectName);
            cmd.Parameters.AddWithValue("@data_type", data_type);
            var reader = cmd.ExecuteReader();
        

            while (reader.Read())
            {
                    id_aspect.Add(reader.GetString(0), reader.GetString(1));
 
            }
            reader.Close();
            cn.CloseConnection();
            return id_aspect;

        }


    }
}



