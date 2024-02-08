using IEF_Home.cls;
using MySql.Data.MySqlClient;
using MySqlX.XDevAPI.Common;
using MySqlX.XDevAPI.Relational;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using System.Text.Json.Serialization;
using System.Web.Http.Results;
using System.Web.UI.WebControls;
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

        public string Classification_RegionItem(string SELECTedRegion)
        {

            var SELECTedRegionId = "";
            var query =
                "SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SELECTedRegion";
            if (cn.OpenConnection() == true)
            {
                var cmd = new MySqlCommand(query, cn.Connection);
                //cmd.Parameters.AddWithValue("@SELECTedRegion", selecetedRegion);
                cmd.Parameters.AddWithValue("@SELECTedRegion", SELECTedRegion);
                var reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    SELECTedRegionId = reader["id"].ToString();
                }

                reader.Close();
                cn.CloseConnection();
            }

            return SELECTedRegionId;
        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]

        public string Classification_ScenerioItem(string selecetedScenario)
        {
            var SELECTedScenarioId = "";
            var query =
                "SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SELECTedScenario";
            if (cn.OpenConnection() == true)
            {
                var cmd = new MySqlCommand(query, cn.Connection);
                cmd.Parameters.AddWithValue("@SELECTedScenario", selecetedScenario);
                var reader = cmd.ExecuteReader();



                while (reader.Read())
                {

                    SELECTedScenarioId = reader["id"].ToString();
                }


                reader.Close();
                cn.CloseConnection();


            }

            return SELECTedScenarioId;
        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]

        public List<List<string>> Classification_ResultItem(string SELECTedRegion)
        {

            var output = new List<List<string>>();
            if (!cn.OpenConnection()) return null;
            foreach (var SELECTedScenario in new List<string> { "LED", "SSP1", "SSP2" })
            {
                var scenarioArray = new List<string>();
                const string query = @"SELECT d.value
            FROM iedc.data d
            LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
            LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
            LEFT JOIN iedc.classification_items ci4 ON d.aspect4 = ci4.id
            INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
            WHERE d.dataset_id = 304
            AND d.aspect5 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SELECTedScenario)
            AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SELECTedRegion)";
                var cmd = new MySqlCommand(query, cn.Connection);

                cmd.Parameters.AddWithValue("@SELECTedScenario", SELECTedScenario);
                cmd.Parameters.AddWithValue("@SELECTedRegion", SELECTedRegion);

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

        public List<List<string>> Classification_ResultItemPopulation(string SELECTedRegion)
        {

            var output = new List<List<string>>();
            if (!cn.OpenConnection()) return null;
            foreach (var SELECTedScenario in new List<string> { "LED", "SSP1", "SSP2" })
            {
                var scenarioArray = new List<string>();
                const string query = @"SELECT d.value
            FROM iedc.data d
            LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
            LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
            LEFT JOIN iedc.classification_items ci4 ON d.aspect4 = ci4.id
            INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
            WHERE d.dataset_id = 302
            AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SELECTedScenario)
            AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SELECTedRegion)";
                var cmd = new MySqlCommand(query, cn.Connection);

                cmd.Parameters.AddWithValue("@SELECTedScenario", SELECTedScenario);
                cmd.Parameters.AddWithValue("@SELECTedRegion", SELECTedRegion);

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

        public List<List<string>> Classification_ResultItemBuilding(string SELECTedRegion)
        {

            var output = new List<List<string>>();
            if (!cn.OpenConnection()) return null;
            foreach (var SELECTedScenario in new List<string> { "LED", "SSP1", "SSP2" })
            {
                var scenarioArray = new List<string>();
                const string query = @"SELECT d.value * 1e+6 AS multiplied_value
            FROM iedc.data d
            LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
            LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
            LEFT JOIN iedc.classification_items ci4 ON d.aspect4 = ci4.id
            INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
            WHERE d.dataset_id = 303
            AND d.aspect4 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SELECTedScenario)
            AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SELECTedRegion)";
                var cmd = new MySqlCommand(query, cn.Connection);

                cmd.Parameters.AddWithValue("@SELECTedScenario", SELECTedScenario);
                cmd.Parameters.AddWithValue("@SELECTedRegion", SELECTedRegion);

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
        public Dictionary<string, List<string>> Classification_Result1stAnd2ndProd(string selectedRegion, string selectedMaterial, string selectedSector)
        {
            Dictionary<string, List<string>> output = new Dictionary<string, List<string>>();
            if (!cn.OpenConnection()) return null;
            var SelectedScenariosTemp = new List<string> { "SSP2", "SSP2", "LED" };
            var SelectedStrategiesTemp = new List<string> { "Baseline", "Full CE", "Full CE" };
            var selectedProcessId = new List<string> { "87", "88" };
            // Primary Production Scenerios
            List<string> valuePri_SSP2_Baseline = new List<string>();
            List<string> valuePri_SSP2_FullCE = new List<string>();
            List<string> valuePri_LED_FullCE = new List<string>();
            // Secondary Production Scenerios
            List<string> valueSec_SSP2_Baseline = new List<string>();
            List<string> valueSec_SSP2_FullCE = new List<string>();
            List<string> valueSec_LED_FullCE = new List<string>();
            foreach (var process in selectedProcessId)
            {
                for (int i = 0; i < SelectedScenariosTemp.Count; i++)
                {
                    var SelectedScenario = SelectedScenariosTemp[i];
                    var SelectedStrategy = SelectedStrategiesTemp[i];
                    const string query = @" SELECT d.value AS value,
             SUM(d.value) OVER (ORDER BY cls.attribute1_oto) as CumulativeSUM
             FROM iedc.data d 
             LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id 
             LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
             LEFT JOIN iedc.classification_items AS cls ON d.aspect8 = cls.id
             INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id 
             where d.dataset_id = 306 
             AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @selectedRegion)
             AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @selectedScenario)
             AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @selectedMaterial)
             AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @selectedSector)
             AND d.aspect8 BETWEEN 
             (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = '2020') 
             AND 
             (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = '2060')
             AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @selectedStrategy)
             AND d.aspect4 =  @process";
                    var cmd = new MySqlCommand(query, cn.Connection);
                    cmd.Parameters.AddWithValue("@selectedRegion", selectedRegion);
                    cmd.Parameters.AddWithValue("@selectedScenario", SelectedScenario);
                    cmd.Parameters.AddWithValue("@selectedMaterial", selectedMaterial);
                    cmd.Parameters.AddWithValue("@selectedSector", selectedSector);
                    cmd.Parameters.AddWithValue("@selectedStrategy", SelectedStrategy);
                    cmd.Parameters.AddWithValue("@selectedProcessId", selectedProcessId);
                    cmd.Parameters.AddWithValue("@process", process);

                    var reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {

                           if(process == "87")
                            {
                                if (i == 0)
                                {
                                    string datavalue = reader["CumulativeSUM"].ToString();
                                    valuePri_SSP2_Baseline.Add(datavalue);                                
                                }else if (i == 1)
                                {
                                    string datavalue = reader["CumulativeSUM"].ToString();
                                    valuePri_SSP2_FullCE.Add(datavalue);
                                }
                                else if (i == 2)
                                {
                                    string datavalue = reader["CumulativeSUM"].ToString();
                                    valuePri_LED_FullCE.Add(datavalue);
                                }
                            }
                            else if (process == "88")
                            {
                                if (i == 0)
                                {
                                    string datavalue = reader["CumulativeSUM"].ToString();                    
                                    valueSec_SSP2_Baseline.Add(datavalue);       
                                }
                                else if (i == 1)
                                {
                                    string datavalue = reader["CumulativeSUM"].ToString();                                   
                                    valueSec_SSP2_FullCE.Add(datavalue); 
                                }
                                else if (i == 2)
                                {
                                    string datavalue = reader["CumulativeSUM"].ToString();                                  
                                    valueSec_LED_FullCE.Add(datavalue);
                                }
                            }                           
                        
                        output["valuePri_SSP2_Baseline"] = valuePri_SSP2_Baseline;
                        output["valuePri_SSP2_FullCE"] = valuePri_SSP2_FullCE;
                        output["valuePri_LED_FullCE"] = valuePri_LED_FullCE;
                        output["valueSec_SSP2_Baseline"] = valueSec_SSP2_Baseline;
                        output["valueSec_SSP2_FullCE"] = valueSec_SSP2_FullCE;
                        output["valueSec_LED_FullCE"] = valueSec_LED_FullCE;
               
                    }
          
                    reader.Close();
                }
            }
            
            cn.CloseConnection();
            return output;
        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]
        public  Dictionary<string, string> Classification_SankeyItem(string SELECTedRegion, string SELECTedScenario, string SELECTedMaterial, string SELECTedStrategy, string SELECTedYear, string SELECTedSector, string SELECTedFlow)
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
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SELECTedRegion)
                    AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SELECTedScenario)
                    AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SELECTedMaterial)
                    AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SELECTedSector)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SELECTedYear)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SELECTedStrategy)
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
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SELECTedRegion)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SELECTedScenario)
                    AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SELECTedMaterial)
                    AND d.aspect4 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SELECTedSector)
                    AND d.aspect9 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SELECTedYear)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SELECTedStrategy)
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
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SELECTedRegion)
                    AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SELECTedScenario)
                    AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SELECTedMaterial)
                    AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SELECTedSector)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SELECTedYear)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SELECTedStrategy)
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
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SELECTedRegion)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SELECTedScenario)
                    AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SELECTedMaterial)
                    AND d.aspect4 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SELECTedSector)
                    AND d.aspect9 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SELECTedYear)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SELECTedStrategy)
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
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SELECTedRegion)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SELECTedScenario)
                    AND d.aspect2 = (SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SELECTedMaterial)
                    AND d.aspect4 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SELECTedSector)
                    AND d.aspect9 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SELECTedYear)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SELECTedStrategy)
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
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SELECTedRegion)
                    AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SELECTedScenario)
                    AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SELECTedSector)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SELECTedYear)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SELECTedStrategy)
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
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SELECTedRegion)
                    AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SELECTedScenario)
                    AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SELECTedSector)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SELECTedYear)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SELECTedStrategy)
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
                    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SELECTedRegion)
                    AND d.aspect6 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SELECTedScenario)
                    AND d.aspect3 = (SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SELECTedSector)
                    AND d.aspect8 = (SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SELECTedYear)
                    AND d.aspect7 = (SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SELECTedStrategy)
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
                    cmd.Parameters.AddWithValue("@SELECTedScenario", SELECTedScenario);
                    cmd.Parameters.AddWithValue("@SELECTedRegion", SELECTedRegion);
                    cmd.Parameters.AddWithValue("@SELECTedMaterial", SELECTedMaterial);
                    cmd.Parameters.AddWithValue("@SELECTedSector", SELECTedSector);
                    cmd.Parameters.AddWithValue("@SELECTedYear", SELECTedYear);
                    cmd.Parameters.AddWithValue("@SELECTedStrategy", SELECTedStrategy);
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
        public string Classification_SectorItem(string SELECTedSector)
        {
            var SELECTedSectorId = "";
            var query =
                "SELECT id FROM iedc.classification_items WHERE classification_id = 7 AND attribute1_oto = @SELECTedSector";
            if (cn.OpenConnection() == true)
            {
                var cmd = new MySqlCommand(query, cn.Connection);
                cmd.Parameters.AddWithValue("@SELECTedSector", SELECTedSector);
                var reader = cmd.ExecuteReader();



                while (reader.Read())
                {

                    SELECTedSectorId = reader["id"].ToString();
                }


                reader.Close();
                cn.CloseConnection();


            }

            return SELECTedSectorId;
        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]
        public string Classification_MaterialItem(string SELECTedMaterial)
        {
            var SELECTedMaterialId = "";
            var query =
                "SELECT id FROM iedc.classification_items WHERE classification_id = 4 AND attribute1_oto = @SELECTedMaterial";
            if (cn.OpenConnection() == true)
            {
                var cmd = new MySqlCommand(query, cn.Connection);
                cmd.Parameters.AddWithValue("@SELECTedMaterial", SELECTedMaterial);
                var reader = cmd.ExecuteReader();



                while (reader.Read())
                {

                    SELECTedMaterialId = reader["id"].ToString();
                }


                reader.Close();
                cn.CloseConnection();


            }

            return SELECTedMaterialId;
        }


        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]
        public string Classification_YearItem(string SELECTedYear)
        {
            var SELECTedYearId = "";
            var query =
                "SELECT id FROM iedc.classification_items WHERE classification_id = 3 AND attribute1_oto = @SELECTedYear";
            if (cn.OpenConnection() == true)
            {
                var cmd = new MySqlCommand(query, cn.Connection);
                cmd.Parameters.AddWithValue("@SELECTedYear", SELECTedYear);
                var reader = cmd.ExecuteReader();



                while (reader.Read())
                {

                    SELECTedYearId = reader["id"].ToString();
                }


                reader.Close();
                cn.CloseConnection();


            }

            return SELECTedYearId;
        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]
        public string Classification_StrategyItem(string SELECTedStrategy)
        {
            var SELECTedStrategyId = "";
            var query =
                "SELECT id FROM iedc.classification_items WHERE classification_id = 78 AND attribute1_oto = @SELECTedStrategy";
            if (cn.OpenConnection() == true)
            {
                var cmd = new MySqlCommand(query, cn.Connection);
                cmd.Parameters.AddWithValue("@SELECTedStrategy", SELECTedStrategy);
                var reader = cmd.ExecuteReader();



                while (reader.Read())
                {

                    SELECTedStrategyId = reader["id"].ToString();
                }

                reader.Close();
                cn.CloseConnection();


            }

            return SELECTedStrategyId;
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
        public List<string> iedcDatatypesIdNumbers(string userSELECT)
        {

            List<string> IdNumbers = new List<string>();


            var query = "SELECT id FROM iedc.datasets WHERE data_type = @userSELECT";


            if (!cn.OpenConnection()) return null;
            var cmd = new MySqlCommand(query, cn.Connection);
            cmd.Parameters.AddWithValue("@userSELECT", userSELECT);
            var reader = cmd.ExecuteReader();


            while (reader.Read())
            {

                string SELECTedStrategyId = reader["id"].ToString();
                IdNumbers.Add(SELECTedStrategyId);

            }


            reader.Close();
            cn.CloseConnection();
            // System.Diagnostics.Debug.WriteLine(string.Join(", ", SELECTedStrategyId));
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
                "WHERE (SELECT id FROM iedc.aspects WHERE aspect = @aspectName) IN (aspect_1, aspect_2, aspect_3, aspect_4, aspect_5, aspect_6, aspect_7, aspect_8, aspect_9, aspect_10, aspect_11, aspect_12) AND data_type = @data_type)";

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


        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
        ResponseFormat = WebMessageFormat.Json)]
        public List<string> iedcMatchAspects(string data_type, string classAspectlist1, string classAspectlist2, string classAspectlist3)
        {

            List<string> dataset_name = new List<string>();

            string[] classAspectList = new string[] { classAspectlist1, classAspectlist2, classAspectlist3 };
            if (!classAspectList.Any(c => c != ""))
            {
                return new List<string>();
            }
            string query = " SELECT dataset_name FROM iedc.datasets WHERE id IN (SELECT DISTINCT dataset_id FROM iedc.data WHERE " +
             " dataset_id IN (SELECT id FROM iedc.datasets WHERE data_type = @data_type) AND ";

            if (!cn.OpenConnection()) return null;

            for (int i = 0; i < 3; i++)
            {
                if (classAspectList[i] != "")
                {

                    query += "(";
                    for (int j = 1; j <= 12; j++)
                    {
                        query += $"aspect{j} IN (SELECT id FROM iedc.classification_items WHERE attribute1_oto IN (";


                        // System.Diagnostics.Debug.WriteLine(classAspectList[i].Count(item => item == ','));

                        if (classAspectList[i].Count(item => item == ',') == 0)
                        {
                            query += '"' + $"{classAspectList[i]}" + '"';
                        }
                        else
                        {
                            var classAspectListComma = classAspectList[i].Split(',');

                            foreach (string list in classAspectListComma)
                            {
                                query += '"' + $"{list}" + '"';
                                if (list != classAspectListComma.Last())
                                {
                                    query += ",";
                                }
                            }
                        }

                        query += "))";
                        if (j != 12)
                        {
                            query += " OR ";
                        }
                        else
                        {
                            query += ")";
                        }

                    }

                    if ((i == 0 || i == 1) && classAspectList[i + 1] != "")
                    {
                        query += " AND ";
                    }
                    else if (i == 0 && classAspectList[2] != "")
                    {
                        query += " AND ";
                    }
                    else
                    {
                        query += ")";
                    }


                }
                else
                {
                    continue;
                }
            }

            var cmd = new MySqlCommand(query, cn.Connection);
            cmd.Parameters.AddWithValue("@data_type", data_type);
            System.Diagnostics.Debug.WriteLine(query);
            var reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                string dataname = reader["dataset_name"].ToString();
                dataset_name.Add(dataname);
            }
            reader.Close();
            cn.CloseConnection();
            return dataset_name;
        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
          ResponseFormat = WebMessageFormat.Json)]
        public Dictionary<string, List<string>> iedcDataPreview(string dataset_name)
        {
            Dictionary<string, List<string>> result = new Dictionary<string, List<string>>();
            List<string> dataset = new List<string>();
            List<string> columns = new List<string>();

            var query = "SELECT dt.id,ds.dataset_name, a1.attribute1_oto AS aspect_1 , a2.attribute1_oto AS aspect_2, a3.attribute1_oto AS aspect_3, a4.attribute1_oto AS aspect_4," +
                " a5.attribute1_oto AS aspect_5, a6.attribute1_oto AS aspect_6, a7.attribute1_oto AS aspect_7, a8.attribute1_oto AS aspect_8," +
                " a9.attribute1_oto AS aspect_9, a10.attribute1_oto AS aspect_10, a11.attribute1_oto AS aspect_11, a12.attribute1_oto AS aspect_12 ,dt.value, un1.unitcode AS unit_nominator," +
                " un2.unitcode AS unit_denominator, st1.name AS stats_array_1,st2.name AS stats_array_2,st3.name AS stats_array_3,st4.name AS stats_array_4,dt.comment,dt.reserve1,dt.reserve2,dt.reserve3" +
                " FROM iedc.data AS dt " +
                " LEFT JOIN iedc.datasets AS ds ON dt.dataset_id = ds.id " +
                " LEFT JOIN iedc.stats_array AS st1 ON dt.stats_array_1 = st1.id " +
                " LEFT JOIN iedc.stats_array AS st2 ON dt.stats_array_2 = st2.id " +
                " LEFT JOIN iedc.stats_array AS st3 ON dt.stats_array_3 = st3.id " +
                " LEFT JOIN iedc.stats_array AS st4 ON dt.stats_array_4 = st4.id " +
                " LEFT JOIN iedc.classification_items AS a1 ON dt.aspect1 = a1.id " +
                " LEFT JOIN iedc.classification_items AS a2 ON dt.aspect2 = a2.id " +
                " LEFT JOIN iedc.classification_items AS a3 ON dt.aspect3 = a3.id " +
                " LEFT JOIN iedc.classification_items AS a4 ON dt.aspect4 = a4.id " +
                " LEFT JOIN iedc.classification_items AS a5 ON dt.aspect5 = a5.id " +
                " LEFT JOIN iedc.classification_items AS a6 ON dt.aspect6 = a6.id" +
                " LEFT JOIN iedc.classification_items AS a7 ON dt.aspect7 = a7.id " +
                " LEFT JOIN iedc.classification_items AS a8 ON dt.aspect8 = a8.id " +
                " LEFT JOIN iedc.classification_items AS a9 ON dt.aspect9 = a9.id " +
                " LEFT JOIN iedc.classification_items AS a10 ON dt.aspect10 = a10.id " +
                " LEFT JOIN iedc.classification_items AS a11 ON dt.aspect11 = a11.id " +
                " LEFT JOIN iedc.classification_items AS a12 ON dt.aspect12 = a12.id " +
                " LEFT JOIN iedc.units AS un1 ON dt.unit_nominator = un1.id " +
                " LEFT JOIN iedc.units AS un2 ON dt.unit_denominator = un2.id " +
                " WHERE ds.dataset_name=@dataset_name";

            if (!cn.OpenConnection()) return null;

            var cmd = new MySqlCommand(query, cn.Connection);
            cmd.Parameters.AddWithValue("@dataset_name", dataset_name);
            var reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                for (int i = 0; i < reader.FieldCount; i++)
                {

                    string colName = reader.GetName(i);
                    string dataname = reader[colName].ToString();
                    dataset.Add(dataname);
                    columns.Add(colName);
                    if (!result.ContainsKey(colName))
                    {
                        result[colName] = new List<string>();
                    }
                    result[colName].Add(!reader.IsDBNull(i) ? reader[i].ToString() : null);
                }
    

          


                result["fulldataset"] = dataset;

                columns = columns.Distinct().ToList();
                result["fullcolumns"] = columns;

            }

            reader.Close();
            cn.CloseConnection();

            return result;

        }




        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]
        public Dictionary<string, List<string>> iedcDatasetPreview(string dataset_name)
        {
            Dictionary<string, List<string>> result = new Dictionary<string, List<string>>();
            List<string> dataset = new List<string>();
            List<string> columnNames = new List<string>();

            var query = "SELECT ds.id, ds.dataset_name, ds.dataset_version, ds.datagroup_id, ds.data_category, ds.data_type, ds.data_layer, ds.process_scope, ds.process_resolution, " +
            " ds.product_scope, ds.product_resolution, ds.material_scope, ds.material_resolution, ds.regional_scope, ds.regional_resolution, ds.temporal_scope, ds.temporal_resolution, " +
            " ds.description, ds.keywords, ds.data_provenance, ds.dataset_size, ds.comment, " +
            " asp1.aspect AS aspect_1, aspect_1_classification, asp2.aspect AS aspect_2, aspect_2_classification, asp3.aspect AS aspect_3, aspect_3_classification, " +
            " asp4.aspect AS aspect_4, aspect_4_classification, asp5.aspect AS aspect_5, aspect_5_classification, asp6.aspect AS aspect_6, aspect_6_classification, " +
            " asp7.aspect AS aspect_7, aspect_7_classification, asp8.aspect AS aspect_8, aspect_8_classification, asp9.aspect AS aspect_9, aspect_9_classification, " +
            " asp10.aspect AS aspect_10, aspect_10_classification, asp11.aspect AS aspect_11, aspect_11_classification, asp12.aspect AS aspect_12, aspect_12_classification, " +
            " ds.tupel_notation, ds.semantic_string_example, ds.semantic_string_general, ds.type_of_source, ds.project_license, ds.main_author, ds.dataset_link, ds.dataset_format, ds.project_report, " +
            " ds.suggested_citation, ds.visible, ds.access_date, ds.submission_date, ds.submitting_user, ds.dataset_conversion_info, ds.review_date, ds.review_user, ds.review_comment, ds.reserve1, " +
            " ds.reserve2, ds.reserve3, ds.reserve4, ds.reserve5" +
            " FROM iedc.datasets AS ds" +
            " LEFT JOIN iedc.aspects AS asp1 ON ds.aspect_1 = asp1.id " +
            " LEFT JOIN iedc.aspects AS asp2 ON ds.aspect_2 = asp2.id " +
            " LEFT JOIN iedc.aspects AS asp3 ON ds.aspect_3 = asp3.id " +
            " LEFT JOIN iedc.aspects AS asp4 ON ds.aspect_4 = asp4.id " +
            " LEFT JOIN iedc.aspects AS asp5 ON ds.aspect_5 = asp5.id " +
            " LEFT JOIN iedc.aspects AS asp6 ON ds.aspect_6 = asp6.id " +
            " LEFT JOIN iedc.aspects AS asp7 ON ds.aspect_7 = asp7.id " +
            " LEFT JOIN iedc.aspects AS asp8 ON ds.aspect_8 = asp8.id " +
            " LEFT JOIN iedc.aspects AS asp9 ON ds.aspect_9 = asp9.id " +
            " LEFT JOIN iedc.aspects AS asp10 ON ds.aspect_10 = asp10.id " +
            " LEFT JOIN iedc.aspects AS asp11 ON ds.aspect_11 = asp11.id " +
            " LEFT JOIN iedc.aspects AS asp12 ON ds.aspect_12 = asp12.id " +
            " WHERE dataset_name = @dataset_name";

            if (!cn.OpenConnection())
            {
                result["dataset"] = null;
                result["columnNames"] = null;
                return result;
            }

            var cmd = new MySqlCommand(query, cn.Connection);
            cmd.Parameters.AddWithValue("@dataset_name", dataset_name);
            var reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
                // Get column names
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    columnNames.Add(reader.GetName(i));
                }

                result["columnNames"] = columnNames;

                while (reader.Read())
                {
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        string dataname = reader[i].ToString();
                        dataset.Add(dataname);
                    }
                }
            }
            else
            {
                result["columnNames"] = new List<string>(); // No results, return an empty list for column names.
                result["dataset"] = null;
            }

            reader.Close();
            cn.CloseConnection();

            result["dataset"] = dataset;
            return result;
        }

    }

}



