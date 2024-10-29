using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using OfficeOpenXml;
using ClosedXML.Excel;
using System.Web.UI.WebControls;
using System.Data;

using DocumentFormat.OpenXml.Wordprocessing;
using ListItem = System.Web.UI.WebControls.ListItem;
using DocumentFormat.OpenXml.Drawing.Spreadsheet;



namespace IEF_Home.cls
{
    public class excelSheetCheck
    {
         
        public bool IsExcelFile(HttpPostedFile file)
        {
            // Check if the file has an .xlsx extension
            if (Path.GetExtension(file.FileName).ToLower() != ".xlsx")
            {
                return false;
            }

            // Optional: Check the MIME type for additional security
            if (file.ContentType != "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
            {
                return false;
            }

            // If both checks pass, the file is likely an Excel file
            return true;
        }

        public bool DoesCoverExist(HttpPostedFile file, string sheetName)
        {
            using (var stream = file.InputStream)
            using (var package = new ExcelPackage(stream))
            {
                foreach (ExcelWorksheet sheet in package.Workbook.Worksheets)
                {
                    if (sheet.Name == sheetName)
                    {
                        return true;
                    }
                }
            }

            return false;
        }

        public void DoesDataExist(string file, string sheetName, GridView compareTable, GridView missingCellTable, GridView aspectReportTable, GridView dimensionCompareTable,BulletedList Ok, BulletedList Warning,BulletedList Error)
        {
            // Call method from the service
            var coverCellCheck = new circomodService();


            // Open the Excel workbook
            using (var workbook = new XLWorkbook(file))
            {
                // Access the "cover" sheet
                var worksheet = workbook.Worksheet(sheetName);


                // Retrieve the values from cells D5 - D54
                var cellD5Value = HttpUtility.HtmlEncode(worksheet.Cell("D5").Value.ToString());
                var cellD6Value = HttpUtility.HtmlEncode(worksheet.Cell("D6").Value.ToString());
                var cellD8Value = HttpUtility.HtmlEncode(worksheet.Cell("D8").Value.ToString());
                var cellD9Value = HttpUtility.HtmlEncode(worksheet.Cell("D9").Value.ToString());
                var cellD10Value = HttpUtility.HtmlEncode(worksheet.Cell("D10").Value.ToString());
                var cellD23Value = HttpUtility.HtmlEncode(worksheet.Cell("D23").Value.ToString());
                var cellD53Value = HttpUtility.HtmlEncode(worksheet.Cell("D53").Value.ToString());
                var cellD54Value = HttpUtility.HtmlEncode(worksheet.Cell("D54").Value.ToString());

                var cellC5Value = HttpUtility.HtmlEncode(worksheet.Cell("C5").Value.ToString());
                var cellC6Value = HttpUtility.HtmlEncode(worksheet.Cell("C6").Value.ToString());
                var cellC8Value = HttpUtility.HtmlEncode(worksheet.Cell("C8").Value.ToString());
                var cellC9Value = HttpUtility.HtmlEncode(worksheet.Cell("C9").Value.ToString());
                var cellC10Value = HttpUtility.HtmlEncode(worksheet.Cell("C10").Value.ToString());
                var cellC23Value = HttpUtility.HtmlEncode(worksheet.Cell("C23").Value.ToString());      
                var cellC53Value = HttpUtility.HtmlEncode(worksheet.Cell("C53").Value.ToString());
                var cellC54Value = HttpUtility.HtmlEncode(worksheet.Cell("C54").Value.ToString());
                //Check if cells are empty
                List<string> cellsToCheck = new List<string>
                {
                    "D11", "D12", "D13", "D14", "D15", "D16", "D17", "D18", "D19", "D20",
                    "D21", "D22", "D50", "D51", "D52", "D55", "D56", "D57", "D58", "D59",
                    "D60", "D61", "D62", "D63", "D64"
                };

                // Report Table
                DataTable reportCell = new DataTable();
                // Aspect Remarrks Table
                DataTable AspectReportCell = new DataTable();

                // Report Table Columns
                reportCell.Columns.Add("Cell",typeof(string)); 
                reportCell.Columns.Add("Warning Message",typeof(string));
                // Aspect Table Columns
                AspectReportCell.Columns.Add("Aspect", typeof(string));
                AspectReportCell.Columns.Add("Aspect Remarks", typeof(string));
                AspectReportCell.Columns.Add("Classification", typeof(string));
                AspectReportCell.Columns.Add("Classification Remarks", typeof(string));
                AspectReportCell.Columns.Add("Dimension Remarks", typeof(string));

                //Dimension List Var
                var dimAspectList = new List<string>();
                var dimClassList = new List<string>();

                // aspect List Var
                //Temp Vars List
                var aspectReportTemp1StList = new List<string>();
                var aspectReportTemp2NdList = new List<string>();
                var classificationReportTemp1StList = new List<string>();
                var classificationReportTemp2NdList = new List<string>();

                foreach (var item in cellsToCheck)
                {
                    var cellCheck = worksheet.Cell(item).Value.ToString();
                    if (string.IsNullOrEmpty(cellCheck)) // Check for empty or null string
                    {
                        reportCell.Rows.Add($"<span style='color: orange;'>{item}</span>",$"<span style='color: orange;'>WARNING: Dataset description for cell <b>{item} ({"C"+ System.Text.RegularExpressions.Regex.Match(item, @"\d+").Value})</b> is empty, please provide some description here</span>");
                        circomodService.counterGlobal.warningCount++;
                    }
                }

                List<string> aspectList = new List<string>
                {
                    "26", "28", "30", "32", "34", "36", "38", "40", "42", "44", "46", "48"

                };
                var CxList = new List<string>();
                var Cxplus1List = new List<string>();
                foreach (var item in aspectList)
                {
                    var cellDxCheck = HttpUtility.HtmlEncode(worksheet.Cell("D"+item).Value.ToString());
                    var cellCxCheck = HttpUtility.HtmlEncode(worksheet.Cell("C"+item).Value.ToString());
                    CxList.Add(cellCxCheck);
                    var itemPlusOne = (int.Parse(item) + 1).ToString();
                    var cellDxplus1Check = HttpUtility.HtmlEncode(worksheet.Cell("D" + itemPlusOne).Value.ToString());
                    var cellCxplus1Check = HttpUtility.HtmlEncode(worksheet.Cell("C" + itemPlusOne).Value.ToString());
                    Cxplus1List.Add(cellCxplus1Check);
                    coverCellCheck.DoesAspectExist(cellDxCheck, cellCxCheck, cellDxplus1Check, cellCxplus1Check,aspectReportTable,  AspectReportCell  , 
                        dimensionCompareTable, "D" + item, dimAspectList, dimClassList, aspectReportTemp1StList,  aspectReportTemp2NdList, classificationReportTemp1StList,classificationReportTemp2NdList,Ok,Warning,Error);

                }
                coverCellCheck.CoverCellCheck(cellD5Value, cellD6Value,
                    cellD8Value, cellD9Value, cellD10Value, cellD23Value, cellD53Value, cellD54Value, cellC5Value, cellC6Value, cellC8Value, cellC9Value, cellC10Value, cellC23Value, cellC53Value, cellC54Value, aspectList, compareTable, Ok, Warning, Error);
                // Bind the cells to the table after the loop
                missingCellTable.DataSource = reportCell;
                missingCellTable.DataBind();

            }

        }

        public void isListOrTable(string file, string sheetName, GridView templateType)
        {
            try
            {
                // Vars
                List<string> aspectList = new List<string>();
                List<string> aspectAttributeList = new List<string>();
                List<string> colaApectList = new List<string>();
                List<string> colAspectAttributeList = new List<string>();
                
                var startPos = 12;

                // Data Table 
                DataTable isListTable = new DataTable();
                //Columns
                isListTable.Columns.Add("Template Type");

                // Open the Excel workbook
                using (var workbook = new XLWorkbook(file))
                {
                    // Access the specified sheet
                    var worksheet = workbook.Worksheet(sheetName);

                    // Retrieve the value from cell G10
                    var cellG10Value = worksheet.Cell("G10").Value.ToString();
                    int fPos = startPos;
                    switch (cellG10Value)
                    {
                        case "LIST":
                            isListTable.Rows.Add($"Type of data template (Dataset_RecordType) indicated: <b>LIST</b>");
                            templateType.DataSource = isListTable;
                            templateType.DataBind();
                            while (true)
                            {
                                var cellFValue = worksheet.Cell("F" + fPos).Value.ToString();
                                var cellGValue = worksheet.Cell("G" + fPos).Value.ToString();
                                // If cellFValue is empty, exit the loop
                                if (string.IsNullOrEmpty(cellFValue)) break;
                                    // Add to the lists
                                aspectList.Add(cellFValue);
                                aspectAttributeList.Add(cellGValue);
                                // Move to the next row
                                fPos++;
                            }
                            // Additional handling for LIST if needed
                            break;

                        case "TABLE":
                            isListTable.Rows.Add($"Type of data template (Dataset_RecordType) indicated: <b>TABLE</b>");
                            templateType.DataSource = isListTable;
                            templateType.DataBind();
                            while (true)
                            {
                                var cellFValue = worksheet.Cell("F" + fPos).Value.ToString();
                                var cellGValue = worksheet.Cell("G" + fPos).Value.ToString();
                                var cellHValue = worksheet.Cell("H" + fPos).Value.ToString();
                                var cellIValue = worksheet.Cell("I" + fPos).Value.ToString();
                                if (string.IsNullOrEmpty(cellFValue)) break;
                                // Add to the lists
                                aspectList.Add(cellFValue);
                                aspectAttributeList.Add(cellGValue);
                                colaApectList.Add(cellHValue);
                                colAspectAttributeList.Add(cellIValue);

                                // Move to the next row
                                fPos++;
                            }
                            // Additional handling for TABLE if needed
                            break;

                        default:
                            // If other cases are needed in the future, handle them here
                            isListTable.Rows.Add($"<span style='color: red;'>Dataset_RecordType (Cell G10) must either be LIST or TABLE. Please check the sample datasets provided on the iedc validation page</span>");
                            break;
                    }

                }

            }
            catch (ArgumentException ex)
            {
                // Handle exception
                Console.WriteLine($"An error occurred: {ex.Message}");
            }
        }

    }
}
