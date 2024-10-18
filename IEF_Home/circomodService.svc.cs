using DocumentFormat.OpenXml.Office2010.Excel;
using DocumentFormat.OpenXml.Spreadsheet;
using DocumentFormat.OpenXml.Wordprocessing;
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
using System.Web;
using System.Web.Http.Results;
using System.Web.UI;
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
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]

        public List<List<string>> Classification_ResultItem(string SELECTedRegion)
        {

            var output = new List<List<string>>();
            if (!cn.OpenConnection()) return null;
            foreach (var SELECTedScenario in new List<string> { "LED", "SSP1", "SSP2" })
            {
                var scenarioArray = new List<string>();
                var yearArray = new List<string>();
                const string query = @"SELECT d.value,cls.attribute1_oto AS aspect_4
            FROM iedc.data d
            LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
            LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
            LEFT JOIN iedc.classification_items cls ON d.aspect4 = cls.id
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

                    scenarioArray.Add(reader["value"].ToString().Replace(",", "."));
                    yearArray.Add(reader["aspect_4"].ToString().Replace(",", "."));

                }

                output.Add(scenarioArray);
                output.Add(yearArray);

                reader.Close();
            }

            cn.CloseConnection();
            return output;
        }


        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]
        public List<List<string>> Classification_ResultItemBuildingRes(string selectedRegion)
        {

            var output = new List<List<string>>();
            try
            {
                if (!cn.OpenConnection()) return null;
                foreach (var selectedScenario in new List<string> { "LED", "SSP1", "SSP2" })
                {
                    var scenarioArray = new List<string>();
                    var yearArray = new List<string>();
                    const string query = @"SELECT 
                        first_query.value/second_query.value AS Total,
                        first_query.aspect_6 AS year
                    FROM 
                        (
                            SELECT 
                                d.value,
                                cls.attribute1_oto AS aspect_6 
                            FROM 
                                iedc.data d
                                LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
                                LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
                                LEFT JOIN iedc.classification_items cls ON d.aspect6 = cls.id
                                INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
                            WHERE 
                                d.dataset_id = 303
                                AND d.aspect5 IN (
                                    SELECT id FROM iedc.classification_items 
                                    WHERE classification_id = 78 AND attribute1_oto = 'Baseline'
                                )
                                AND d.aspect1 IN (
                                    SELECT id FROM iedc.classification_items 
                                    WHERE attribute1_oto = @selectedRegion
                                )
                                AND d.aspect3 IN (
                                    SELECT id FROM iedc.classification_items 
                                    WHERE attribute1_oto = 'use phase'
                                )
                                AND d.aspect2 IN (
                                    SELECT id FROM iedc.classification_items 
                                    WHERE attribute1_oto = 'Residential building'
                                )
                                AND d.aspect4 IN (
                                    SELECT id FROM iedc.classification_items 
                                    WHERE attribute1_oto = @selectedScenario
                                )
                        ) AS first_query
                    LEFT JOIN (
                        SELECT 
                            d.value,
                            cls.attribute1_oto AS aspect_1
                        FROM 
                            iedc.data d
                            LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
                            LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
                            LEFT JOIN iedc.classification_items cls ON d.aspect1 = cls.id
                            INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
                        WHERE 
                            d.dataset_id = 302
                            AND d.aspect3 = (
                                SELECT id FROM iedc.classification_items 
                                WHERE classification_id = 8 AND attribute1_oto = @selectedScenario
                            )
                            AND d.aspect2 = (
                                SELECT id FROM iedc.classification_items 
                                WHERE classification_id = 77 AND attribute1_oto = @selectedRegion
                            )
                    ) AS second_query ON first_query.aspect_6 = second_query.aspect_1 ";
                    var cmd = new MySqlCommand(query, cn.Connection);

                    cmd.Parameters.AddWithValue("@selectedScenario", selectedScenario);
                    cmd.Parameters.AddWithValue("@selectedRegion", selectedRegion);

                    var reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        // Assuming scenarioArray is a List<string> or similar collection.
                        scenarioArray.Add((double.Parse(reader["Total"].ToString())).ToString().Replace(",", "."));
                        yearArray.Add(reader["year"].ToString());

                    }

                    output.Add(scenarioArray);
                    output.Add(yearArray);

                    reader.Close();
                }

                cn.CloseConnection();
            }
            catch (Exception ex)
            {
                // Log the exception or handle it appropriately
                Console.WriteLine("An error occurred: " + ex.Message);
                // You can also throw the exception to propagate it further if needed
                throw;
            }

            return output;
        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]

        public List<List<string>> Classification_ResultItemPopulation(string SELECTedRegion)
        {

            var output = new List<List<string>>();
            if (!cn.OpenConnection()) return null;
            foreach (var SELECTedScenario in new List<string> { "LED", "SSP1", "SSP2" })
            {
                var scenarioArray = new List<string>();
                var yearArray = new List<string>();
                const string query = @"SELECT d.value,cls.attribute1_oto AS aspect_1
            FROM iedc.data d
            LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
            LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
            LEFT JOIN iedc.classification_items cls ON d.aspect1 = cls.id
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

                    scenarioArray.Add(reader["value"].ToString().Replace(",", "."));
                    yearArray.Add(reader["aspect_1"].ToString().Replace(",", "."));

                }

                output.Add(scenarioArray);
                output.Add(yearArray);
                reader.Close();
            }

            cn.CloseConnection();
            return output;
        }

        //[OperationContract]
        //[WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, ResponseFormat = WebMessageFormat.Json)]

        //public List<List<string>> Classification_ResultItemBuilding(string SELECTedRegion)
        //{

        //    var output = new List<List<string>>();
        //    if (!cn.OpenConnection()) return null;
        //    foreach (var SELECTedScenario in new List<string> { "LED", "SSP1", "SSP2" })
        //    {
        //        var scenarioArray = new List<string>();
        //        var yearArray = new List<string>();
        //        const string query = @"SELECT d.value * 1e+6 AS multiplied_value
        //    FROM iedc.data d
        //    LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id
        //    LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
        //    LEFT JOIN iedc.classification_items ci4 ON d.aspect4 = ci4.id
        //    INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id
        //    WHERE d.dataset_id = 303
        //    AND d.aspect4 = (SELECT id FROM iedc.classification_items WHERE classification_id = 8 AND attribute1_oto = @SELECTedScenario)
        //    AND d.aspect1 = (SELECT id FROM iedc.classification_items WHERE classification_id = 77 AND attribute1_oto = @SELECTedRegion)";
        //        var cmd = new MySqlCommand(query, cn.Connection);

        //        cmd.Parameters.AddWithValue("@SELECTedScenario", SELECTedScenario);
        //        cmd.Parameters.AddWithValue("@SELECTedRegion", SELECTedRegion);

        //        var reader = cmd.ExecuteReader();
        //        while (reader.Read())
        //        {

        //            scenarioArray.Add(reader["value"].ToString().Replace(",", "."));
        //            yearArray.Add(reader["aspect_6"].ToString().Replace(",", "."));

        //        }
        //        output.Add(scenarioArray);
        //        output.Add(yearArray);

        //        reader.Close();
        //    }
        //    cn.CloseConnection();
        //    return output;
        //}

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]
        public Dictionary<string, List<string>> Classification_Result1stAnd2ndProd(string selectedRegion,
            string selectedMaterial, string selectedSector)
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

                        if (process == "87")
                        {
                            if (i == 0)
                            {
                                string datavalue = reader["CumulativeSUM"].ToString().Replace(",", ".");
                                valuePri_SSP2_Baseline.Add(datavalue);
                            }
                            else if (i == 1)
                            {
                                string datavalue = reader["CumulativeSUM"].ToString().Replace(",", ".");
                                valuePri_SSP2_FullCE.Add(datavalue);
                            }
                            else if (i == 2)
                            {
                                string datavalue = reader["CumulativeSUM"].ToString().Replace(",", ".");
                                valuePri_LED_FullCE.Add(datavalue);
                            }
                        }
                        else if (process == "88")
                        {
                            if (i == 0)
                            {
                                string datavalue = reader["CumulativeSUM"].ToString().Replace(",", ".");
                                valueSec_SSP2_Baseline.Add(datavalue);
                            }
                            else if (i == 1)
                            {
                                string datavalue = reader["CumulativeSUM"].ToString().Replace(",", ".");
                                valueSec_SSP2_FullCE.Add(datavalue);
                            }
                            else if (i == 2)
                            {
                                string datavalue = reader["CumulativeSUM"].ToString().Replace(",", ".");
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
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]


        public Dictionary<string, List<string>> Classification_ResultAreaStacked(string selectedRegion,
            string selectedSector)
        {
            Dictionary<string, List<string>> output = new Dictionary<string, List<string>>();
            if (!cn.OpenConnection()) return null;
            var SelectedProcessTemp = new List<string>
                { "use phase", "waste management", "material production", "energy supply" };


            // Primary Production Scenerios
            List<string> valueUse_face = new List<string>();
            List<string> valueWaste_manegement = new List<string>();
            List<string> valuePriMaterial_production = new List<string>();
            List<string> valuePriEnergy_supply = new List<string>();
            List<string> years = new List<string>();

            foreach (var process in SelectedProcessTemp)
            {
                const string query = @" SELECT d.value,cls.attribute1_oto as aspect_8 
             FROM iedc.data d 
             LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id 
             LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
             LEFT JOIN iedc.classification_items AS cls ON d.aspect8 = cls.id
             INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id 
             where d.dataset_id = 307 
             AND d.aspect1 IN (SELECT id FROM iedc.classification_items WHERE attribute1_oto = @selectedRegion)
             AND d.aspect3 IN (SELECT id FROM iedc.classification_items WHERE attribute1_oto = @selectedSector)
             AND d.aspect4 IN (SELECT id FROM iedc.classification_items WHERE attribute1_oto = @selectedProcess)
             AND d.aspect6 IN (SELECT id FROM iedc.classification_items WHERE attribute1_oto = 'SSP2')         
             AND d.aspect7 IN (SELECT id FROM iedc.classification_items WHERE attribute1_oto = 'Baseline')";

                var cmd = new MySqlCommand(query, cn.Connection);
                cmd.Parameters.AddWithValue("@selectedRegion", selectedRegion);
                cmd.Parameters.AddWithValue("@selectedProcess", process);
                cmd.Parameters.AddWithValue("@selectedSector", selectedSector);


                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {

                    if (process == SelectedProcessTemp[0])
                    {
                        string Use_face = reader[0].ToString().Replace(",", ".");
                        valueUse_face.Add(Use_face);
                    }
                    else if (process == SelectedProcessTemp[1])
                    {
                        string Waste_manegement = reader[0].ToString().Replace(",", ".");
                        valueWaste_manegement.Add(Waste_manegement);
                    }
                    else if (process == SelectedProcessTemp[2])
                    {
                        string Material_production = reader[0].ToString().Replace(",", ".");
                        valuePriMaterial_production.Add(Material_production);
                    }
                    else if (process == SelectedProcessTemp[3])
                    {
                        string Energy_supply = reader[0].ToString().Replace(",", ".");
                        string yearsTemp = reader[1].ToString();
                        valuePriEnergy_supply.Add(Energy_supply);
                        years.Add(yearsTemp);
                    }

                    output["Use_face"] = valueUse_face;
                    output["Waste_manegement"] = valueWaste_manegement;
                    output["Material_production"] = valuePriMaterial_production;
                    output["Energy_supply"] = valuePriEnergy_supply;
                    output["Years"] = years;


                }

                reader.Close();

            }

            cn.CloseConnection();
            return output;
        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]


        public Dictionary<string, List<string>> Classification_ResultGHG(string selectedRegion, string selectedSector)
        {
            Dictionary<string, List<string>> output = new Dictionary<string, List<string>>();
            if (!cn.OpenConnection()) return null;
            var SelecteScenerioTemp = new List<string> { "Baseline", "HIY-RLU-MSU", "Full CE" };
            List<string> Baseline = new List<string>();
            List<string> HIY_RLU_MSU = new List<string>();
            List<string> Full_CE = new List<string>();
            List<string> Year = new List<string>();


            foreach (var scenerio in SelecteScenerioTemp)
            {

                const string query = @" SELECT sum(d.value),cls.attribute1_oto as aspect_8
             FROM iedc.data d 
             LEFT JOIN iedc.units u1 ON d.unit_nominator = u1.id 
             LEFT JOIN iedc.units u2 ON d.unit_denominator = u2.id
             LEFT JOIN iedc.classification_items AS cls ON d.aspect8 = cls.id
             INNER JOIN iedc.datasets ds ON d.dataset_id = ds.id 
             where d.dataset_id = 307 
             AND d.aspect1 IN (SELECT id FROM iedc.classification_items WHERE attribute1_oto = @selectedRegion)
             AND d.aspect3 IN (SELECT id FROM iedc.classification_items WHERE attribute1_oto = @selectedSector)
             AND d.aspect4 IN (SELECT id FROM iedc.classification_items WHERE attribute1_oto IN ( 'use phase', 'waste management', 'material production', 'energy supply'))
             AND d.aspect6 IN (SELECT id FROM iedc.classification_items WHERE attribute1_oto = 'LED')         
             AND d.aspect7 IN (SELECT id FROM iedc.classification_items WHERE attribute1_oto = @selectedScenerio)";

                var cmd = new MySqlCommand(query, cn.Connection);
                cmd.Parameters.AddWithValue("@selectedRegion", selectedRegion);
                cmd.Parameters.AddWithValue("@selectedSector", selectedSector);
                cmd.Parameters.AddWithValue("@selectedScenerio", scenerio);


                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {

                    if (scenerio == SelecteScenerioTemp[0])
                    {
                        string BaselineTemp = reader[0].ToString();
                        Baseline.Add(BaselineTemp);
                        string YearTemp = reader[1].ToString();
                        Year.Add(YearTemp);
                    }
                    else if (scenerio == SelecteScenerioTemp[1])
                    {
                        string HIY_RLU_MSU_Temp = reader[0].ToString();
                        HIY_RLU_MSU.Add(HIY_RLU_MSU_Temp);
                    }
                    else if (scenerio == SelecteScenerioTemp[2])
                    {
                        string Full_CE_Temp = reader[0].ToString();
                        Full_CE.Add(Full_CE_Temp);
                    }

                    ;

                    output["Baseline"] = Baseline;
                    output["HIY_RLU_MSU"] = HIY_RLU_MSU;
                    output["Full_CE"] = Full_CE;
                    output["Year"] = Year;

                }

                reader.Close();
            }

            cn.CloseConnection();
            return output;
        }



        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]
        public Dictionary<string, string> Classification_SankeyItem(string SELECTedRegion, string SELECTedScenario,
            string SELECTedMaterial, string SELECTedStrategy, string SELECTedYear, string SELECTedSector,
            string SELECTedFlow)
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
            var query =
                "SELECT a1.aspect AS aspect_1_name, a2.aspect AS aspect_2_name, a3.aspect AS aspect_3_name, a4.aspect AS aspect_4_name," +
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

                for (int i = 0; i < reader.FieldCount; i++)
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
        public List<string> iedcMatchAspects(string data_type, string classAspectlist1, string classAspectlist2,
            string classAspectlist3)
        {

            List<string> dataset_name = new List<string>();

            string[] classAspectList = new string[] { classAspectlist1, classAspectlist2, classAspectlist3 };
            if (!classAspectList.Any(c => c != ""))
            {
                return new List<string>();
            }

            string query =
                " SELECT dataset_name FROM iedc.datasets WHERE id IN (SELECT DISTINCT dataset_id FROM iedc.data WHERE " +
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

            var query =
                "SELECT dt.id,ds.dataset_name, a1.attribute1_oto AS aspect_1 , a2.attribute1_oto AS aspect_2, a3.attribute1_oto AS aspect_3, a4.attribute1_oto AS aspect_4," +
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
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]
        public Dictionary<string, List<string>> iedcDatasetPreview(string dataset_name)
        {
            Dictionary<string, List<string>> result = new Dictionary<string, List<string>>();
            List<string> dataset = new List<string>();
            List<string> columnNames = new List<string>();

            var query =
                "SELECT ds.id, ds.dataset_name, ds.dataset_version, ds.datagroup_id, ds.data_category, ds.data_type, ds.data_layer, ds.process_scope, ds.process_resolution, " +
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

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]
        public void CoverCellCheck(string D5, string D6, string D8, string D9,
            string D10, string D23, string D53, string D54, List<string> aspectList, GridView compareTable, GridView reportView)
        {
            // Create a new DataTable
            DataTable dt = new DataTable();
            // Report Table
            DataTable reportTable = new DataTable();
            // Add Column to Datatable
            dt.Columns.Add("Cell", typeof(string));
            dt.Columns.Add("Uploaded Excel Sheet", typeof(string));
            dt.Columns.Add("Iedc Database", typeof(string));
            // Report Table Columns
            reportTable.Columns.Add("Cell", typeof(string));
            reportTable.Columns.Add("Remark", typeof(string));

            var queryList = new Dictionary<string, string>
            {
                ["id_D5"] = @"SELECT id FROM iedc.datasets WHERE dataset_name = @D5 UNION ALL SELECT NULL WHERE NOT EXISTS (SELECT 1 FROM iedc.datasets WHERE dataset_name = @D5)",
                ["id_D6"] = @"SELECT id FROM iedc.datasets WHERE dataset_name = @D5 AND dataset_version = @D6 UNION ALL SELECT NULL WHERE NOT EXISTS (SELECT 1 FROM iedc.datasets WHERE dataset_name = @D5 AND dataset_version = @D6)",
                ["id_D8"] = @"SELECT id, name FROM iedc.categories WHERE id = @D8 UNION ALL SELECT NULL, NULL WHERE NOT EXISTS (SELECT 1 FROM iedc.categories WHERE id = @D8)",
                ["list_D9"] = @"SELECT id, name, reference_data_category FROM iedc.types WHERE name = @D9 UNION ALL SELECT NULL, NULL, NULL WHERE NOT EXISTS (SELECT 1 FROM iedc.types WHERE name = @D9)",
                ["list_D10"] = @"SELECT id, name FROM iedc.layers WHERE name = @D10 UNION ALL SELECT NULL, NULL WHERE NOT EXISTS (SELECT 1 FROM iedc.layers WHERE name = @D10)",
                ["list_D23"] = @"SELECT id, name FROM iedc.provenance WHERE name = @D23 UNION ALL SELECT NULL, NULL WHERE NOT EXISTS (SELECT 1 FROM iedc.provenance WHERE name = @D23)",
                ["list_D53"] = @"SELECT id, name FROM iedc.source_type WHERE name = @D53 UNION ALL SELECT NULL, NULL WHERE NOT EXISTS (SELECT 1 FROM iedc.source_type WHERE name = @D53)",
                ["list_D54"] = @"SELECT id, name FROM iedc.licences WHERE name = @D54 UNION ALL SELECT NULL, NULL WHERE NOT EXISTS (SELECT 1 FROM iedc.licences WHERE name = @D54)",
                ["list_aspect"] = @"SELECT id,name FROM iedc.licences WHERE name = @aspectList",
            };

            Dictionary<string, Tuple<List<string>, string, string>> result = new Dictionary<string, Tuple<List<string>, string, string>>();


            foreach (KeyValuePair<string, string> kvp in queryList)
            {
                try
                {
                    var queryName = kvp.Key;
                    var query = kvp.Value;

                    if (!cn.OpenConnection()) return;

                    var cmd = new MySqlCommand(query, cn.Connection);
                    cmd.Parameters.AddWithValue("@D5", D5);
                    cmd.Parameters.AddWithValue("@D6", D6);
                    cmd.Parameters.AddWithValue("@D8", D8);
                    cmd.Parameters.AddWithValue("@D9", D9);
                    cmd.Parameters.AddWithValue("@D10", D10);
                    cmd.Parameters.AddWithValue("@D23", D23);
                    cmd.Parameters.AddWithValue("@D53", D53);
                    cmd.Parameters.AddWithValue("@D54", D54);
                    cmd.Parameters.AddWithValue("@aspectList", aspectList);

                    var reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        var idValue = Convert.ToString(reader["id"]);
                        var nameValue =
                            reader.FieldCount > 1
                                ? Convert.ToString(reader["name"])
                                : null; // Handling cases where "name" might not be present
                        var reference_data_category =
                            reader.FieldCount > 2
                                ? Convert.ToString(reader["reference_data_category"])
                                : null; // Handling cases where "reference_data_category" might not be present
                        try
                        {
                            if (result.ContainsKey(queryName))
                            {
                                result[queryName].Item1.Add(idValue);
                            }
                            else
                            {
                                result.Add(queryName, System.Tuple.Create(new List<string> { idValue }, nameValue, reference_data_category));

                            }


                        }
                        catch (ArgumentException ex)
                        {
                            // Handle duplicate key scenarios if necessary
                        }
                    }

                    cn.CloseConnection();
                }
                catch (InvalidOperationException e)
                {
                    // Handle any exceptions that occur during query execution
                }

            }
            // Table Rows

            // Number of entries NoR

            string d5Entry = string.Empty;
            if (string.IsNullOrEmpty(result["id_D5"].Item1[0]))
            {
                d5Entry = $"<span style='color:red;'>No entry with dataset name {D5} were found in the IEDC database.</span>";
                dt.Rows.Add("<span style='color:red;'>D5</span >", $"<span style='color:red;'>{D5} </ span >", string.Empty);
                reportTable.Rows.Add("<span style='color:red'>D5</span>", d5Entry);
            }
            else if (!string.IsNullOrEmpty(result["id_D5"].Item1[0]))
            {
                d5Entry = $"{result["id_D5"].Item1.Count} entr(y/ies) with dataset name {D5} were found in the IEDC database.";
                dt.Rows.Add("D5", D5, D5);
                reportTable.Rows.Add("D5:", d5Entry);
            }


            string d6Entry =  string.Empty;
            if (string.IsNullOrEmpty(result["id_D6"].Item1[0]))
            {
                d6Entry = $"<span style='color:red;'>No entry with dataset name {HttpUtility.HtmlEncode(D5)} and version {HttpUtility.HtmlEncode(D6)} were found in database. Please write 'none' if dataset is unique and does not have a version ID.</span>";
                dt.Rows.Add($"<span style='color:red;'>D6</span >", $"<span style='color:red;'>{D6} </span >", string.Empty);
                reportTable.Rows.Add($"<span style='color:red;'>D6</span>", d6Entry);
            }
            else if (!string.IsNullOrEmpty(result["id_D6"].Item1[0]))
            {
                d6Entry = $"Entry with dataset name {D5} and version {D6} is already in the database";
                dt.Rows.Add("D6", D6, D6);
                reportTable.Rows.Add("D6:", d6Entry);
            }
            string d8Entry = string.Empty;
            if (string.IsNullOrEmpty(result["id_D8"].Item1[0]))
            {
                d8Entry = $"<span style='color:red;'>ERROR: The chosen data category {D8} does not exist. Please enter a valid iedc data category id for this dataset (number from 1-8). The list of defined categories is available under: <a href='https://www.database.industrialecology.uni-freiburg.de/datatypes.aspx'target='_blank'>https://www.database.industrialecology.uni-freiburg.de/datatypes.aspx</a></span>";
                dt.Rows.Add($"<span style='color:red;'>D8</span >", $"<span style='color:red;'>{D8} </ span >", string.Empty);
                reportTable.Rows.Add("<span style='color:red'>D8</span>", d8Entry);
            }
            else if (!string.IsNullOrEmpty(result["id_D8"].Item1[0]))
            {
                d8Entry = $"The data category (ID: {result["id_D8"].Item1[0]}, name: {result["id_D8"].Item2}) of the dataset is valid";
                dt.Rows.Add("D8", result["id_D8"].Item2, result["id_D8"].Item2);
                reportTable.Rows.Add("D8:", d8Entry);
            }

            string d9Entry = string.Empty;
            string d9EntrySub = string.Empty;
            if (string.IsNullOrEmpty(result["list_D9"].Item1[0]))
            {
                d9Entry = $"<span style='color:red;'>ERROR: The chosen data type {D9} does not exist. Please enter a valid iedc data type name for this dataset. The list of defined data types is available under <a href='http://www.database.industrialecology.uni-freiburg.de/resources/IEDC_DataTypes_Overview.pdf'target='_blank'>http://www.database.industrialecology.uni-freiburg.de/resources/IEDC_DataTypes_Overview.pdf</a></span>";
                dt.Rows.Add($"<span style='color:red;'>D9</span >", $"<span style='color:red;'>{D9} </ span >", string.Empty);
                reportTable.Rows.Add("<span style='color:red'>D9</span>", d9Entry);
            }
            else if (!string.IsNullOrEmpty(result["list_D9"].Item1[0]))
            {
                d9Entry = $"The data type (ID: {result["list_D9"].Item1[0]}, name: {result["list_D9"].Item2}) of the dataset is valid";
                dt.Rows.Add("D9", D9, result["list_D9"].Item2 ?? string.Empty);
                reportTable.Rows.Add("D9:", d9Entry);
                if (result["list_D9"].Item3 == D8)
                {
                    d9EntrySub = $"The indicated data type fits to the indicated data category";
                    reportTable.Rows.Add("", d9EntrySub);
                }
                else
                {
                    d9EntrySub = $"The indicated data type {D9} does not fit to the indicated data category {D8}. The data type must match the broader data category. The list of defined data types and the data categories they belong to is available under (<a href='http://www.database.industrialecology.uni-freiburg.de/resources/IEDC_DataTypes_Overview.pdf'target='_blank'>http://www.database.industrialecology.uni-freiburg.de/resources/IEDC_DataTypes_Overview.pdf</a>)";
                    reportTable.Rows.Add("", $"<span style='color:red'>{d9EntrySub}</span>");
                }
            }

            string d10Entry = string.Empty;
            if (string.IsNullOrEmpty(result["list_D10"].Item1[0]))
            {
                d10Entry = $"<span style='color:red;'>ERROR: The chosen data layer {D10} does not exist. Please enter a valid iedc data layer name for this dataset. The list of defined data layers is available under: <a href='https://www.database.industrialecology.uni-freiburg.de/datatypes.aspx'target='_blank'>https://www.database.industrialecology.uni-freiburg.de/datatypes.aspx</a></span>";
                dt.Rows.Add($"<span style='color:red;'>D10</span >", $"<span style='color:red;'>{D10} </ span >", string.Empty);
                reportTable.Rows.Add("<span style='color:red'>D10</span>", d10Entry);
            }
            else if (!string.IsNullOrEmpty(result["list_D10"].Item1[0]))
            {
                d10Entry = $"The data layer (ID: {result["list_D10"].Item1[0]}, name: {result["list_D10"].Item2}) of the dataset is valid";
                dt.Rows.Add("D10", D10, result["list_D10"].Item2 ?? string.Empty);
                reportTable.Rows.Add("D10:", d10Entry);
            }

            string d23Entry = string.Empty;
            if (string.IsNullOrEmpty(result["list_D23"].Item1[0]))
            {
                d23Entry = $"<span style='color:red;'>ERROR: The indicated data provenance {D23} does not exist. Please enter a valid iedc data provenance name. The list of defined provenance categories is available under: <a href='https://www.database.industrialecology.uni-freiburg.de/provenance.aspx'target='_blank'>https://www.database.industrialecology.uni-freiburg.de/provenance.aspx</a></span>";
                dt.Rows.Add($"<span style='color:red;'>D23</span >", $"<span style='color:red;'>{D23} </ span >", string.Empty);
                reportTable.Rows.Add("<span style='color:red'>D23</span>", d23Entry);
            }
            else if (!string.IsNullOrEmpty(result["list_D23"].Item1[0]))
            {
                d23Entry = $"The data provenance (ID: {result["list_D23"].Item1[0]}, name: {result["list_D23"].Item2}) of the dataset is valid";
                dt.Rows.Add("D23", D23, result["list_D23"].Item2 ?? string.Empty);
                reportTable.Rows.Add("D23:", d23Entry);
            }

            string d53Entry = string.Empty;
            if (string.IsNullOrEmpty(result["list_D53"].Item1[0]))
            {
                d53Entry = $"<span style='color:red;'>ERROR: The indicated type of data source {D53} does not exist. Please enter the name of a valid iedc type of data source. The list of defined types of data source is available under: <a href='https://www.database.industrialecology.uni-freiburg.de/provenance.aspx'target='_blank'>https://www.database.industrialecology.uni-freiburg.de/provenance.aspx</a></span>";
                dt.Rows.Add($"<span style='color:red;'>D53</span >", $"<span style='color:red;'>{D53} </ span >", string.Empty);
                reportTable.Rows.Add("<span style='color:red'>D53</span>", d53Entry);
            }
            else if (!string.IsNullOrEmpty(result["list_D53"].Item1[0]))
            {
                d53Entry = $"The data category (ID: {result["list_D53"].Item1[0]}, name: {result["list_D53"].Item2}) of the dataset is valid";
                dt.Rows.Add("D53", D53, result["list_D53"].Item2 ?? string.Empty);
                reportTable.Rows.Add("D53:", d53Entry);
            }            
            
            string d54Entry = string.Empty;
            if (string.IsNullOrEmpty(result["list_D54"].Item1[0]))
            {
                d54Entry = $"<span style='color:red;'>ERROR: The indicated licence of the dataset {D54} does not exist. Please enter a valid iedc dataset licence name. The list of defined dataset licences is available under: <a href='https://www.database.industrialecology.uni-freiburg.de/provenance.aspx'target='_blank'>https://www.database.industrialecology.uni-freiburg.de/provenance.aspx</a></span>";
                dt.Rows.Add($"<span style='color:red;'>D54</span >", $"<span style='color:red;'>{D54} </ span >", string.Empty);
                reportTable.Rows.Add("<span style='color:red'>D54</span>", d54Entry);
            }
            else if (!string.IsNullOrEmpty(result["list_D54"].Item1[0]))
            {
                d54Entry = $"The license provided for this dateset (ID: {result["list_D54"].Item1[0]}, name: {result["list_D54"].Item2}) of the dataset is valid";
                dt.Rows.Add("D54", D54, result["list_D54"].Item2 ?? string.Empty);
                reportTable.Rows.Add("D54:", d54Entry);
            }

            //Bind the cells to the table
            compareTable.DataSource = dt;
            compareTable.DataBind();
            //Bind the cells to the table
            reportView.DataSource = reportTable;
            reportView.DataBind();

        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest,
            ResponseFormat = WebMessageFormat.Json)]
        public void DoesAspectExist(string cellDxCheck, string cellCxCheck,string cellDxplus1Check, string cellCxplus1Check, 
            GridView aspectReportTable,GridView classificationReportTable, DataTable AspectReportCell, DataTable classificationTable, 
            GridView dimensionCompareTable, string item, List<string> dimAspectList,List<string> dimClassList)
        {

            //Aspect Vars
            var aspect = new List<string>();
            var dimension = new List<string>();
            var itemList = new List<string>();
            var Dx = new List<string>();
            var Cx = new List<string>();
            //Classification Vars
            var idClass = new List<string>();
            var classificationName = new List<string>();
            var dimensionClass = new List<string>();
            var itemListClass = new List<string>();
            var DxClass = new List<string>();
            var CxClass = new List<string>();
            var Dxplus1Class = new List<string>();
            var Cxplus1Class = new List<string>();
            DataTable compareTableTemp = new DataTable();
            //Columns
            compareTableTemp.Columns.Add("Aspect Dimension", typeof(string));
            compareTableTemp.Columns.Add("Classificiation Dimension", typeof(string));
            compareTableTemp.Columns.Add("Dimension Remarks", typeof(string));

            var queryList = new Dictionary<string, string>
            {
                ["aspect_list"] = @"SELECT aspect,dimension FROM iedc.aspects WHERE aspect = @cellDxCheck",
                ["classification_list"] = @"SELECT id, classification_name,dimension FROM iedc.classification_definition WHERE id = @cellDxplus1Check"
,
            };

            try
            {

                foreach (KeyValuePair<string, string> kvp in queryList)
                {

                    var queryName = kvp.Key;
                    var query = kvp.Value;

                    if (!cn.OpenConnection()) return;

                    var cmd = new MySqlCommand(query, cn.Connection);
                    cmd.Parameters.AddWithValue("@cellDxCheck", cellDxCheck);
                    cmd.Parameters.AddWithValue("@cellDxplus1Check", cellDxplus1Check);
                    var reader = cmd.ExecuteReader();


                    if (!reader.HasRows && cellDxCheck != "none")
                    {
                        if (queryName == "aspect_list")
                        {
                            aspect.Add("");
                            dimension.Add("");
                            itemList.Add(item);
                            Dx.Add(cellDxCheck);
                            Cx.Add(cellCxCheck);
                            AspectReportCell.Rows.Add($"<span style='color:red;'>{item}</span>",
                                $"<span style='color:red;'>ERROR: The indicated {Dx.Last()} of the dataset does not exist in the database. Please enter a valid aspect. The list of defined dataset aspects is available under: <a href='https://www.database.industrialecology.uni-freiburg.de/aspects.aspx' target='_blank'>https://www.database.industrialecology.uni-freiburg.de/aspects.aspx <a/></span>");
                            dimAspectList.Add("");
                        }
                        else if (queryName == "classification_list")
                        {
                            idClass.Add("");
                            classificationName.Add("");
                            dimensionClass.Add("");
                            itemListClass.Add(item);
                            DxClass.Add(cellDxCheck);
                            CxClass.Add(cellCxCheck);
                            Dxplus1Class.Add(cellDxplus1Check);
                            Cxplus1Class.Add(cellCxplus1Check);
                            classificationTable.Rows.Add($"<span style='color:red;'>{cellCxplus1Check}</span>", $"<span style='color:red;'>ERROR: The indicated {Cxplus1Class.Last()} of the dataset does not exist in the database. Please enter a valid aspect. The list of defined dataset aspects is available under: <a href='https://www.database.industrialecology.uni-freiburg.de/classifications.aspx' target='_blank'>https://www.database.industrialecology.uni-freiburg.de/classifications.aspx <a/></span>");
                            dimClassList.Add("");
                        }
                    }
                    else
                    {
                        while (reader.Read())
                        {

                            if (queryName == "aspect_list")
                            {
                                var aspectTemp = reader["aspect"].ToString();
                                var dimensionTemp = reader["dimension"].ToString();
                                aspect.Add(aspectTemp);
                                dimension.Add(dimensionTemp);
                                Dx.Add(cellDxCheck);
                                Cx.Add(cellCxCheck);
                                if (cellDxCheck == aspect.Last())
                                {
                                    for (int i = 0; i < aspect.Count(); i++)
                                    {
                                        AspectReportCell.Rows.Add($"{Cx[i]}",
                                            $"{Cx[i]} provided for this dataset (aspect: {aspect[i]}, dimension: {dimension[i]}) is valid.");
                                        dimAspectList.Add(dimension[i]);
                                    }
                                }
                            }
                            else if (queryName == "classification_list")
                            {
                                var idTemp = reader["id"].ToString();
                                var classificationTemp = reader["classification_name"].ToString();
                                var dimensionTempClass = reader["dimension"].ToString();
                                idClass.Add(idTemp);
                                classificationName.Add(classificationTemp);
                                dimensionClass.Add(dimensionTempClass);
                                itemListClass.Add(item);
                                DxClass.Add(cellDxCheck);
                                CxClass.Add(cellCxCheck);
                                Dxplus1Class.Add(cellDxplus1Check);
                                Cxplus1Class.Add(cellCxplus1Check);

                                if (cellDxplus1Check == idClass.Last())
                                {
                                    for (int i = 0; i < classificationName.Count(); i++)
                                    {
                                        classificationTable.Rows.Add($"{Cxplus1Class[i]}", $"{Cxplus1Class[i]} provided for this dataset (classification_name: {classificationName[i]}, dimension: {dimensionClass[i]}) is valid.");
                                        dimClassList.Add(dimensionClass[i]);
                                    }
                                }
                            }
                        }
                    }
                    cn.CloseConnection();
                }
                // Compare Dimension from Aspect and Classification Remark Table
                foreach (var i in dimAspectList)
                {
                    int index = dimAspectList.IndexOf(i);
                    if (i == dimClassList[index] && !string.IsNullOrEmpty(i))
                    {
                        compareTableTemp.Rows.Add(i, dimClassList[index], $"The dimension {i} of aspect_{index+1}_classification provided for this dataset matches the classification of aspect_{index+1} exists.");
                    }
                    else
                    {
                        compareTableTemp.Rows.Add(i, dimClassList[index], $"<span style='color:red;'>ERROR: The dimension {dimClassList[index+1]} of aspect_{index+1}_classification provided for this dataset does not match the classification of aspect_{index+1}. " +
                                                                          $"Please check your aspect and the classifications that you want to use for this aspect and pick a classification that points to the same dimension as the aspect." +
                                                                          $" See <a href=\"https://www.database.industrialecology.uni-freiburg.de/aspects.aspx\" target=\"_blank\">https://www.database.industrialecology.uni-freiburg.de/aspects.aspx</a>\r\n for a list of all dimensions and aspects. " +
                                                                          $"See <a href=\"https://www.database.industrialecology.uni-freiburg.de/classifications.aspx\" target=\"_blank\">https://www.database.industrialecology.uni-freiburg.de/classifications.aspx</a>\r\n for a list of all classifications defined so far.</span>");
                    }
                }
            }
            catch (ArgumentException ex)
            {
                // Handle duplicate key scenarios if necessary
                Console.WriteLine($"An error occurred: {ex.Message}");
            }
            dimensionCompareTable.DataSource = compareTableTemp;
            dimensionCompareTable.DataBind();
            aspectReportTable.DataSource = AspectReportCell;
            aspectReportTable.DataBind();
            classificationReportTable.DataSource = classificationTable;
            classificationReportTable.DataBind();
            
        }
    }
}



