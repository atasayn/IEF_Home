using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using OfficeOpenXml;
using ClosedXML.Excel;
using System.Web.UI.WebControls;
using System.Data;
using System.Linq;
using static IEF_Home.circomodService;
using DocumentFormat.OpenXml.Spreadsheet;
using Microsoft.Office.Interop.Excel;
using DataTable = System.Data.DataTable;
using OfficeOpenXml.FormulaParsing.Ranges;
using System.Web.UI.HtmlControls;
using DocumentFormat.OpenXml.Vml.Office;
using System.Text;
using DocumentFormat.OpenXml.Drawing.Charts;
using MySqlX.XDevAPI.Relational;




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

        public void DoesDataExist(string file, string sheetName, GridView compareTable, GridView missingCellTable, GridView aspectReportTable, GridView dimensionCompareTable,
            GridView aspectMatch,GridView aspectMatchRemarks, HtmlGenericControl missingCellTableSec)
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
                        reportCell.Rows.Add($"<span style='color: orange;'>{item}</span>",
                            $"<span style='color: orange;'>WARNING: Dataset description for cell <b>{item} ({"C" + System.Text.RegularExpressions.Regex.Match(item, @"\d+").Value})</b> is empty, please provide some description here</span>");
                        circomodService.counterGlobal.warningCount++;
                    }
                }

                if(reportCell.Rows.Count ==0 )
                {
                    missingCellTableSec.Style["display"] = "none";
                }


                List<string> aspectList = new List<string>
                {
                    "26", "28", "30", "32", "34", "36", "38", "40", "42", "44", "46", "48"

                };

                var cellDxCheckList = new List<string>();
                foreach (var item in aspectList)
                {
                    var cellDxCheck = HttpUtility.HtmlEncode(worksheet.Cell("D"+item).Value.ToString());
                    var cellCxCheck = HttpUtility.HtmlEncode(worksheet.Cell("C"+item).Value.ToString());
                    if (!string.IsNullOrEmpty(cellDxCheck) && cellDxCheck != "none") cellDxCheckList.Add(cellDxCheck);
                    var itemPlusOne = (int.Parse(item) + 1).ToString();
                    var cellDxplus1Check = HttpUtility.HtmlEncode(worksheet.Cell("D" + itemPlusOne).Value.ToString());
                    var cellCxplus1Check = HttpUtility.HtmlEncode(worksheet.Cell("C" + itemPlusOne).Value.ToString());
                    coverCellCheck.DoesAspectExist(cellDxCheck, cellCxCheck, cellDxplus1Check, cellCxplus1Check,aspectReportTable,  AspectReportCell  , 
                        dimensionCompareTable, "D" + item, dimAspectList, dimClassList, aspectReportTemp1StList,  aspectReportTemp2NdList, classificationReportTemp1StList,classificationReportTemp2NdList);

                }

                
                coverCellCheck.CoverCellCheck(cellD5Value, cellD6Value,
                    cellD8Value, cellD9Value, cellD10Value, cellD23Value, cellD53Value, cellD54Value, cellC5Value, cellC6Value, cellC8Value, cellC9Value, cellC10Value, cellC23Value, cellC53Value, cellC54Value, aspectList, compareTable);
                // Bind the cells to the table after the loop
                missingCellTable.DataSource = reportCell;
                missingCellTable.DataBind();

                //Aspect match
                int i = 12;
                var aspectDoesExist = new List<string>();
                DataTable aspectMatchDataTable = new DataTable();
                DataTable aspectMatchRemarkTable = new DataTable();
                // Aspect Match Table Columns
                aspectMatchDataTable.Columns.Add("Aspect (D23-D46)", typeof(string));
                aspectMatchDataTable.Columns.Add("Aspect (F12-..)", typeof(string));
                // Aspect Match Remark Table Columns
                aspectMatchRemarkTable.Columns.Add("Remarks", typeof(string));
                //Table or List
                var cellG10Value = worksheet.Cell("G10").Value.ToString();
                // Take the apect labels from F12
                while (true)
                {
                    string cellF12Value = HttpUtility.HtmlEncode(worksheet.Cell("F" + i).Value.ToString()).Trim();

                    // Break the loop if cellF12Value is empty or "none"
                    if (string.IsNullOrEmpty(cellF12Value) || cellF12Value.Equals("none", StringComparison.OrdinalIgnoreCase))
                    {
                        break;
                    }
                    aspectDoesExist.Add(cellF12Value);
                    i++;
                }
                switch (cellG10Value)
                {
                    case "LIST":
                        break;
                    case "TABLE":
                        int t = 12;
                        while (true)
                        {
                            string cellH12Value = HttpUtility.HtmlEncode(worksheet.Cell("H" + t).Value.ToString()).Trim();

                            // Break the loop if cellF12Value is empty or "none"
                            if (string.IsNullOrEmpty(cellH12Value) || cellH12Value.Equals("none", StringComparison.OrdinalIgnoreCase))
                            {
                                break;
                            }
                            aspectDoesExist.Add(cellH12Value);
                            t++;
                        }

                        break;
                }

                int maxCount = Math.Max(cellDxCheckList.Count, aspectDoesExist.Count);

                // Populate the DataTable
                for (int t = 0; t < maxCount; t++)
                {
                    string checklistValue = t < cellDxCheckList.Count ? cellDxCheckList[t] : null; // or "" for empty string
                    string aspectValue = t < aspectDoesExist.Count ? aspectDoesExist[t] : null; // or "" for empty string

                    aspectMatchDataTable.Rows.Add(checklistValue, aspectValue);
                }

                // Assuming you have a DataGridView named dataGridView
                aspectMatch.DataSource = aspectMatchDataTable;
                aspectMatch.DataBind();

                // After populating, check for mismatches and color cells
                foreach (GridViewRow row in aspectMatch.Rows)
                {
                    string checklistValue = row.Cells[0].Text;
                    string aspectValue = row.Cells[1].Text;

                    if (string.IsNullOrEmpty(checklistValue) || !aspectDoesExist.Contains(checklistValue))
                    {
                        row.Cells[0].Text = $"<span style='color:red;'>{checklistValue}</span>";
                        if (!string.IsNullOrEmpty(checklistValue) && checklistValue.Trim() != "&nbsp;")
                        {
                            aspectMatchRemarkTable.Rows.Add($"<span style='color:red;'>ERROR: <b>{checklistValue}</b> does not exit in Aspects column in Dataset format information table." +
                                                            $"Please make sure that the indicated aspect exist in both Dataset information table and Dateset format Information table. </span>");
                            circomodService.counterGlobal.errCount++;
                        }
                        
                    }

                    if (string.IsNullOrEmpty(aspectValue) || !cellDxCheckList.Contains(aspectValue))
                    {
                        row.Cells[1].Text = $"<span style='color:red;'>{aspectValue}</span>";
                        if (!string.IsNullOrEmpty(aspectValue) && aspectValue.Trim() != "&nbsp;")
                        {
                            aspectMatchRemarkTable.Rows.Add($"<span style='color:red;'>ERROR: <b>{aspectValue}</b> does not exit in Aspects column in Dataset format information table." +
                                                            $"Please make sure that the indicated aspect exist in both Dataset information table and Dateset format Information table. </span>");
                            circomodService.counterGlobal.errCount++;
                        }

                        
                    }
                }
                aspectMatchRemarks.DataSource = aspectMatchRemarkTable;
                aspectMatchRemarks.DataBind();
            }
        }

        public void isListOrTable(string file, string sheetName, GridView templateType,GridView aspectSequence, GridView dataSheetRowNumber,GridView dataSheetMatch,GridView unitMoniDenomi,
            BulletedList Ok, BulletedList Warning, BulletedList Error, HtmlGenericControl loaderControl)
        {
            try
            {
                circomodService serviceInstance = new circomodService();

                // Vars
                List<string> aspectList = new List<string>();
                List<string> aspectAttributeList = new List<string>();
                List<string> dataSheetAspectList = new List<string>();
                List<string> expectedSheetAspectList = new List<string>();
                List<string> aspectConfirmList = new List<string>();
                var startPos = 12;

                // Data Table 
                DataTable isListTable = new DataTable();
                DataTable aspectSequenceMatch = new DataTable();
                DataTable noRowsTable = new DataTable();
                // DataTable
                DataTable dataMatch = new DataTable();
                DataTable dataMatchResult = new DataTable();
                //Columns
                dataMatch.Columns.Add("Line", typeof(string));
                dataMatch.Columns.Add("Aspect", typeof(string));
                dataMatch.Columns.Add("Given Value/Text", typeof(string));
                dataMatch.Columns.Add("Remarks", typeof(string));
                //Data Table Columns
                isListTable.Columns.Add("Template Type");

                aspectSequenceMatch.Columns.Add("Given Value/Text");
                aspectSequenceMatch.Columns.Add("Expected Order of Values");
                aspectSequenceMatch.Columns.Add("Remarks");

                noRowsTable.Columns.Add("Number of rows with text");

                // Open the Excel workbook
                using (var workbook = new XLWorkbook(file))
                {
                    // Access the specified sheet
                    var worksheet = workbook.Worksheet(sheetName);
                    var worksheetData = workbook.Worksheet("Data");
                    // Retrieve the value from cell G10
                    var cellG10Value = worksheet.Cell("G10").Value.ToString();
                    switch (cellG10Value)
                    {
                        case "LIST":

                            //Value,Unit nominator, Unit denominator,Stats_array, comment 
                            List<string> dataSheetOrderList = new List<string>
                            {
                                "value",
                                "unit nominator",
                                "unit denominator",
                                "stats_array string",
                                "comment"
                            };
                            var noRowsI10Value = worksheet.Cell("I10").Value.ToString();
                            var rowCount = worksheetData.LastRowUsed().RowNumber() - 1;
                            int fPos = startPos;
                            // Bind Number of Rows Table
                            if (rowCount.ToString() == noRowsI10Value)
                            {
                                noRowsTable.Rows.Add($"<span style='color:green;'>Number of rows with data as indicated in cell I10 on the Cover Sheet: <b>{noRowsI10Value}</b>" +
                                                     $"<br/>Number of rows with data as indicated on the Data Sheet: <b>{rowCount.ToString()}</b></span>");
                                circomodService.counterGlobal.oKCount++;
                            }
                            else
                            {
                                noRowsTable.Rows.Add($"<span style='color:red;'>Number of rows with data as indicated in cell I10 on the Cover Sheet: <b>{noRowsI10Value}</b>" +
                                                     $"<br/>Number of rows with data as indicated on the Data Sheet: <b>{rowCount.ToString()}</b><br/>" +
                                                     $"The NoR has to match in the both sheets</span>");
                                circomodService.counterGlobal.errCount++;
                            }
                            dataSheetRowNumber.DataSource = noRowsTable;
                            dataSheetRowNumber.DataBind();
                            // Aspect Order Check
                            aspectSequence.DataSource = null;
                            aspectSequence.DataBind();
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
                            // Does Aspect sequence meet the sequence in Data sheet?
                            // Loop through the alphabet
                            int rowIndex = 1;
                            int i = 12;
                            for (char c = 'A'; c <= 'Z'; c++)
                            {
                                string cellValue = HttpUtility.HtmlEncode(worksheetData.Cell(c + rowIndex.ToString()).Value.ToString()).Trim();
                                // Break the loop if cellValue is empty or "none"
                                if (string.IsNullOrEmpty(cellValue))
                                {
                                    break;
                                }
                                dataSheetAspectList.Add(cellValue);
                            }
                            while (true)
                            {
                                string cellF12Value = HttpUtility.HtmlEncode(worksheet.Cell("F" + i).Value.ToString()).Trim();

                                // Break the loop if cellF12Value is empty or "none"
                                if (string.IsNullOrEmpty(cellF12Value) || cellF12Value.Equals("none", StringComparison.OrdinalIgnoreCase))
                                {
                                    break;
                                }
                                expectedSheetAspectList.Add(cellF12Value);
                                i++;
                            }
                            expectedSheetAspectList.AddRange(dataSheetOrderList);
                            // Populate the DataTable
                            var maxCountAps = Math.Max(dataSheetAspectList.Count, expectedSheetAspectList.Count);
                            for (int t = 0; t < maxCountAps; t++)
                            {
                                string givenValue = t < dataSheetAspectList.Count ? dataSheetAspectList[t] : null; // or "" for empty string
                                string expectedValue = t < expectedSheetAspectList.Count ? expectedSheetAspectList[t] : null; // or "" for empty string

                                if (expectedValue == givenValue)
                                {
                                    var aspectSeqRemark =
                                        $"<span style='color: green;'>The order of <b>{givenValue}</b> as given value matches the order of {expectedValue} in idec database.</span>";
                                    circomodService.counterGlobal.oKCount++;
                                    aspectSequenceMatch.Rows.Add(givenValue, expectedValue, aspectSeqRemark);
                                    aspectConfirmList.Add(givenValue);
                                }
                                else if(expectedValue != givenValue && !string.IsNullOrEmpty(expectedValue))
                                {
                                    var aspectSeqRemark =
                                        $"<span style='color: red;'>ERROR: The order of <b>{givenValue}</b> as given value does not match the order of <b>{expectedValue}</b> in iedc database. Please correct " +
                                        $"the aspect columns with the same order as in Expected Order of Values.</span>";
                                    circomodService.counterGlobal.errCount++;
                                    aspectSequenceMatch.Rows.Add($"<span style='color: red;'>{givenValue}</span>", expectedValue,
                                         aspectSeqRemark);
                                }else if (!expectedSheetAspectList.Contains(givenValue))
                                {
                                    var aspectSeqRemark =
                                        $"<span style='color: orange;'>Data sheet contains additional information right of the 'comment' column: " +
                                            $" <b>{givenValue}</b>. This data will not be validated and transferred to the iedc, it is only visible in the excel template.</span>";
                                    circomodService.counterGlobal.warningCount++;
                                    aspectSequenceMatch.Rows.Add($"<span style='color: orange;'>{givenValue}</span>", expectedValue, aspectSeqRemark);
                                }
                            }
                            if (circomodService.counterGlobal.errCount == 0)
                            {
                                isDataRowValid(sheetName, "Data", file, dataSheetMatch, dataMatch, dataMatchResult, Int32.Parse(noRowsI10Value), Ok, Warning, Error);
                            }
                            aspectSequence.DataSource = aspectSequenceMatch;
                            aspectSequence.DataBind();
                            iedcValidate.ErrorCounter(counterGlobal.errCount, counterGlobal.warningCount, counterGlobal.oKCount, Ok, Warning, Error);
                            loaderControl.Style["display"] = "none";
                            break;
                            

                        case "TABLE":
                            aspectSequence.DataSource = null;
                            aspectSequence.DataBind();
                            isListTable.Rows.Add($"Type of data template (Dataset_RecordType) indicated: <b>TABLE</b>");
                            templateType.DataSource = isListTable;
                            templateType.DataBind();
                            // Empty Lists
                            Dictionary<string, string> rowAspectNamesandIDs = new Dictionary<string, string>();
                            Dictionary<string, string> colAspectNamesandIDs = new Dictionary<string, string>();
                            Dictionary<string, string> classIDList = new Dictionary<string, string>();
                            List<string> columnAspects = new List<string>();
                            List<string> rowAspects = new List<string>();
                            List<string> rowClassIDs = new List<string>();
                            List<string> colClassIDs = new List<string>();
                            DataTable tempDataMatchResult = new DataTable();
                            DataTable tempDataMatchResult2 = new DataTable();
                            loaderControl.Style["display"] = "none";
                            void PopulateAspects(string aspectLetter, string classIdLetter, int startRow)
                            {
                                int currentRow = startRow;
                                while (true)
                                {
                                    string cellAspectValue = HttpUtility.HtmlEncode(worksheet.Cell($"{aspectLetter}{currentRow}").Value.ToString()).Trim();
                                    string cellClassIdValue = HttpUtility.HtmlEncode(worksheet.Cell($"{classIdLetter}{currentRow}").Value.ToString()).Trim();

                                    // Break the loop if cellValue is empty or "none"
                                    if (string.IsNullOrEmpty(cellAspectValue) || cellAspectValue.Equals("none", StringComparison.OrdinalIgnoreCase) ||
                                        string.IsNullOrEmpty(cellClassIdValue) || cellClassIdValue.Equals("none", StringComparison.OrdinalIgnoreCase))
                                    {
                                        break;
                                    }
                                    if (aspectLetter == "F" )
                                    {
                                        colAspectNamesandIDs.Add(cellAspectValue, cellClassIdValue);
                                        columnAspects.Add(cellAspectValue);
                                    }
                                    else if (aspectLetter == "H" && startRow == 12)
                                    {
                                        rowAspectNamesandIDs.Add(cellAspectValue, cellClassIdValue);
                                        rowAspects.Add(cellAspectValue);
                                    }
                                    else if (startRow == 6)
                                    {
                                        cellAspectValue = HttpUtility.HtmlEncode(worksheet.Cell($"{aspectLetter}{currentRow}").Value.ToString()).Trim();
                                        cellClassIdValue = HttpUtility.HtmlEncode(worksheet.Cell($"{classIdLetter}{currentRow+1}").Value.ToString()).Trim();
                                        tempDataMatchResult = serviceInstance.UnitNomiDenomi($"{aspectLetter}{currentRow}", cellClassIdValue, cellAspectValue,
                                            Ok, Warning, Error);
                                        tempDataMatchResult2.Merge(tempDataMatchResult);
                                        break;
                                    }
                                    currentRow++;
                                }
                            }
                            PopulateAspects("F", "G",12);
                            PopulateAspects("H", "I",12);
                            PopulateAspects("H", "H",6);
                            PopulateAspects("I", "I",6);
                            unitMoniDenomi.DataSource = tempDataMatchResult2;
                            unitMoniDenomi.DataBind();

                            // Worksheet with the sheet name
                            var dPosClas = 27;
                            var dPos = 26;
                            while (true)
                            {

                                var cellPosDValueClass = HttpUtility.HtmlEncode(worksheet.Cell("D" + dPos).Value.ToString().Trim());
                                var cellClassDValueClass = HttpUtility.HtmlEncode(worksheet.Cell("D" + dPosClas).Value.ToString().Trim());
                            
                                // Stop the loop only if all cells contain "none" or are empty/null
                                if (string.IsNullOrEmpty(cellPosDValueClass) || cellPosDValueClass == "none" || 
                                    string.IsNullOrEmpty(cellClassDValueClass) || cellClassDValueClass == "none")
                                {
                                    break;
                                }
                                // Add non-null and non-"none" values to respective lists
                                if (!string.IsNullOrEmpty(cellPosDValueClass) && !string.IsNullOrEmpty(cellClassDValueClass)) classIDList.Add(cellPosDValueClass, cellClassDValueClass);

                                // Move to the next row
                                dPosClas += 2;
                                dPos += 2;
                            }
                            // Get Row and Column Numbers
                            // Safely get cell values
                            var rowNo = HttpUtility.HtmlEncode(worksheet.Cell("I" + 10).Value);
                            var colNo = HttpUtility.HtmlEncode(worksheet.Cell("K" + 10).Value);
                            // Encode if needed for HTML contexts
                            var rowCountTable = worksheetData.LastRowUsed().RowNumber() - rowAspectNamesandIDs.Keys.Count;
                            var colCountTable = worksheetData.LastColumnUsed().ColumnNumber() - colAspectNamesandIDs.Keys.Count;

                            // Bind Number of Rows Table
                            if (rowNo == rowCountTable.ToString() && colNo == colCountTable.ToString())
                            {
                                noRowsTable.Rows.Add($"<span style='color:green;'>Number of rows with data as indicated in cell I10 and K10 on the Cover Sheet: <b>{rowNo} and {colNo}</b>" +
                                                     $"<br/>Number of rows with data as indicated on the Data Sheet: <b>{rowCountTable.ToString()} and {colCountTable.ToString()}</b></span>");
                                circomodService.counterGlobal.oKCount++;
                            }
                            else
                            {
                                noRowsTable.Rows.Add($"<span style='color:red;'>Number of rows with data as indicated in cell I10 and K10 on the Cover Sheet: <b>{rowNo} and {colNo} </b>" +
                                                     $"<br/>Number of rows with data as indicated on the Data Sheet: <b>{rowCountTable.ToString()} and {colCountTable.ToString()}</b><br/>" +
                                                     $"The NoR has to match in the both sheets</span>");
                                circomodService.counterGlobal.errCount++;
                            }
                            dataSheetRowNumber.DataSource = noRowsTable;
                            dataSheetRowNumber.DataBind();
                            // Additional handling for TABLE if needed
                            if (circomodService.counterGlobal.errCount == 0)
                            {
                                isDataForTableValid(file, columnAspects ,rowAspects ,rowAspectNamesandIDs, colAspectNamesandIDs, classIDList,rowClassIDs, colClassIDs, rowNo, colNo, dataSheetMatch, dataMatch, dataMatchResult, Ok, Warning, Error);
                            }
                            iedcValidate.ErrorCounter(counterGlobal.errCount, counterGlobal.warningCount, counterGlobal.oKCount, Ok, Warning, Error);
                            break;

                        default:
                            // If other cases are needed in the future, handle them here
                            isListTable.Rows.Add($"<span style='color: red;'>Dataset_RecordType (Cell G10) must either be LIST or TABLE. Please check the sample datasets provided on the iedc validation page</span>");
                            iedcValidate.ErrorCounter(counterGlobal.errCount, counterGlobal.warningCount, counterGlobal.oKCount, Ok, Warning, Error);
                            circomodService.counterGlobal.errCount++;
                            loaderControl.Style["display"] = "none";
                            templateType.DataSource = isListTable;
                            templateType.DataBind();
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

        public void isDataForTableValid(string file, List<string> columnAspects, List<string> rowAspects, Dictionary<string, string> rowAspectNamesandIDs, 
            Dictionary<string, string> colAspectNamesandIDs,Dictionary<string, string> classIDList, List<string> rowClassIDs,List<string> colClassIDs, string rowNo,string colNo,
            GridView dataSheetMatch, DataTable dataMatch, DataTable dataMatchResult,BulletedList Ok, BulletedList Warning, BulletedList Error)
        {
            // Vars
            circomodService serviceInstance = new circomodService();

            DataTable tempDataMatchResult = new DataTable();

            using (var workbook = new XLWorkbook(file))
            {
                // Worksheet with the sheet name
                var excelApp = new Application();
                Microsoft.Office.Interop.Excel.Workbook wb = excelApp.Workbooks.Open(file);
                Microsoft.Office.Interop.Excel.Worksheet ws;
                ws = (Microsoft.Office.Interop.Excel.Worksheet)wb.Worksheets["Data"];
                // Get Col Aspects
                Range rangeRow = ws.Cells[rowAspects.Count + 1, 1];
                Range targetRangeCol = rangeRow.Resize[rowNo, columnAspects.Count];
                object[,] cellValues = (object[,])targetRangeCol.Value2;
                int rowCountCol = targetRangeCol.Rows.Count;
                int colCountCol = targetRangeCol.Columns.Count;

                for (int col = 1; col <= columnAspects.Count; col++)
                {
                
                    var cellAddresses = createCellAddress(rowAspects.Count+1 , rowCountCol + rowAspects.Count-1, col,"row based");
                    List<string> firstColumnValuesList = Enumerable.Range(1, cellValues.GetLength(0))
                        .Select(i => System.Net.WebUtility.HtmlEncode(cellValues[i, col]?.ToString()) ?? string.Empty)
                        .ToList();
                    var resultDictionary = cellAddresses.Zip(firstColumnValuesList, (key, value) => new { key, value })
                        .ToDictionary(x => x.key, x => x.value);

                    tempDataMatchResult = serviceInstance.selectAttrClosestMatch(
                    "attribute" + colAspectNamesandIDs.FirstOrDefault(x => x.Key == columnAspects[col - 1]).Value + "_oto",
                    classIDList.FirstOrDefault(x => x.Key == columnAspects[col - 1]).Value,
                    colAspectNamesandIDs.Keys.ToList(),
                    firstColumnValuesList,
                    columnAspects[col - 1],
                    resultDictionary,
                    dataSheetMatch,
                    dataMatch, Ok, Warning, Error);
                }

                //// Get Row Aspects
                Range range = ws.Cells[1, columnAspects.Count + 1];
                Range targetRange = range.Resize[rowAspects.Count, colNo];
                object[,] cellValues2 = (object[,])targetRange.Value2;
                // Initialize a new array to include cell addresses along with values
                int rowCount = targetRange.Rows.Count;
                int colCount = targetRange.Columns.Count;
  
                

                for (int row = 1; row <= rowAspects.Count; row++)
                {
                    var cellAddresses = createCellAddress(columnAspects.Count+1, colCount + columnAspects.Count, row, "column based");
                    List<string> firstColumnValuesList = Enumerable.Range(1, cellValues2.GetLength(1))
                        .Select(i => System.Net.WebUtility.HtmlEncode(cellValues2[row, i]?.ToString()) ?? string.Empty)
                        .ToList();
                    var resultDictionary = cellAddresses.Zip(firstColumnValuesList, (key, value) => new { key, value })
                        .ToDictionary(x => x.key, x => x.value);

                    tempDataMatchResult = serviceInstance.selectAttrClosestMatch("attribute" + rowAspectNamesandIDs.FirstOrDefault(x => x.Key == rowAspects[row - 1]).Value + "_oto",
                        classIDList.FirstOrDefault(x => x.Key == rowAspects[row - 1]).Value,
                        rowAspectNamesandIDs.Keys.ToList(),
                        firstColumnValuesList,
                        rowAspects[row - 1],
                        resultDictionary,
                        dataSheetMatch,
                        dataMatch, Ok, Warning, Error);

                }
                wb.Close();
                excelApp.Quit();
                dataSheetMatch.DataSource = tempDataMatchResult;
                dataSheetMatch.DataBind();
            }
            iedcValidate.ErrorCounter(counterGlobal.errCount, counterGlobal.warningCount, counterGlobal.oKCount, Ok, Warning, Error);

        }

        public void isDataRowValid(string sheetName1, string sheetName2,string file,GridView dataSheetMatch,DataTable dataMatch,
            DataTable dataMatchResult,int noRowsI10Value, BulletedList Ok, BulletedList Warning, BulletedList Error)
        {
            // Empty Variables
            Dictionary<string, string> aspectNames = new Dictionary<string, string>();
            Dictionary<string, string> classificationIDs = new Dictionary<string, string>();
            DataTable tempDataMatchResult = new DataTable();

            using (var workbook = new XLWorkbook(file))
            {
                // Worksheet with the sheet name
                var worksheet = workbook.Worksheet(sheetName1);
                // Retrieve the value from cell G Column
                var fPos = 12;
                var dPosAsp = 26;
                var dPosClas = 27;
                while (true)
                {
                    var cellDValueAsp = HttpUtility.HtmlEncode(worksheet.Cell("D" + dPosAsp).Value.ToString().Trim());
                    var cellDValueClass = HttpUtility.HtmlEncode(worksheet.Cell("D" + dPosClas).Value.ToString().Trim());
                    var cellFValue = HttpUtility.HtmlEncode(worksheet.Cell("F" + fPos).Value.ToString().Trim());
                    var cellGValue = HttpUtility.HtmlEncode(worksheet.Cell("G" + fPos).Value.ToString().Trim());

                    // Stop the loop only if all cells contain "none" or are empty/null
                    if ((string.IsNullOrEmpty(cellDValueAsp) || cellDValueAsp == "none") &&
                        (string.IsNullOrEmpty(cellDValueClass) || cellDValueClass == "none") &&
                        (string.IsNullOrEmpty(cellFValue) || cellFValue == "none") &&
                        (string.IsNullOrEmpty(cellGValue) || cellGValue == "none"))
                    {
                        break;
                    }

                    // Add non-null and non-"none" values to respective lists
                    if (!string.IsNullOrEmpty(cellDValueAsp) && !string.IsNullOrEmpty(cellDValueClass) && cellDValueAsp != "none" && cellDValueClass != "none") classificationIDs.Add(cellDValueAsp, cellDValueClass);
                    if (!string.IsNullOrEmpty(cellFValue) && !string.IsNullOrEmpty(cellGValue) && cellFValue != "none" && cellGValue != "none") aspectNames.Add(cellFValue, cellGValue);

                    
                  
                    // Move to the next row
                    fPos++;
                    dPosAsp+=2;
                    dPosClas+=2;
                }
                
                // Worksheet with the sheet name
                var excelApp = new Application();
                Microsoft.Office.Interop.Excel.Workbook wb = excelApp.Workbooks.Open(file);
                Microsoft.Office.Interop.Excel.Worksheet ws;
                ws = (Microsoft.Office.Interop.Excel.Worksheet)wb.Worksheets[sheetName2];
                // Determine used range and worksheet name
                int countRows = ws.UsedRange.Rows.Count;
                int countCols = ws.UsedRange.Columns.Count;


                circomodService serviceInstance = new circomodService();
                int NumRow =1;
                int NumCol = 1;
                Range range = ws.Cells[NumRow, NumCol];
                Range targetRange = range.Resize[countRows, countCols];
                object[,] cellValues = (object[,])targetRange.Value2;
                // Find the "commodity" column index
                Range headerRow = targetRange.Rows[1]; // First row for headers

            


                for (int col = 1; col <= countCols; col++)
                {

                    var headerValue = HttpUtility.HtmlEncode((headerRow.Cells[1, col] as Range)?.Value2);
                    if (headerValue != null && headerValue != "value" && headerValue != "comment" && headerValue != "stats_array string")
                    {
                        
                        var cellAddresses = createCellAddress(2, countRows, col, "row based");
                        List<string> firstColumnValuesList = Enumerable.Range(2, cellValues.GetLength(0)-1)
                            .Select(i => System.Net.WebUtility.HtmlEncode(cellValues[i, col]?.ToString()) ?? string.Empty)
                            .ToList();
                        var resultDictionary = cellAddresses.Zip(firstColumnValuesList, (key, value) => new { key, value })
                            .ToDictionary(x => x.key, x => x.value);
                        tempDataMatchResult = serviceInstance.selectAttrClosestMatch("attribute" + aspectNames.FirstOrDefault(x => x.Key == headerValue).Value + "_oto",
                            classificationIDs.FirstOrDefault(x => x.Key == headerValue).Value,
                            classificationIDs.Keys.ToList(),
                            firstColumnValuesList,
                            headerValue,
                            resultDictionary,
                            dataSheetMatch,
                            dataMatch, Ok, Warning, Error);

                    }
                }

                wb.Close(); 
                excelApp.Quit();
                dataSheetMatch.DataSource = tempDataMatchResult;
                dataSheetMatch.DataBind();

            }
;
        }

        static List<string> createCellAddress(int start, int end,int index,string movementDiraction)
        {
            List<string> cellAddresses = new List<string>();
            if (movementDiraction == "row based")
            {
                char letter = (char)('A' + (index - 1));
                cellAddresses = Enumerable.Range(start, end - start + 1)
                    .Select(i => $"{letter}{i}")
                    .ToList();
            }
            else
            {
                cellAddresses = Enumerable.Range(start,end - start + 1)
                    .Select(i => $"{GetExcelColumnName(i)}{index}")
                    .ToList();
            }
            


            return cellAddresses; // Join array elements into a single string, separated by commas
        }
        // Helper function to convert numbers to Excel-style column names
        static string GetExcelColumnName(int columnNumber)
        {
            return string.Concat(
                Enumerable.Reverse(
                    Enumerable
                        .Range(0, (int)Math.Log(columnNumber, 26) + 1)
                        .Select(_ => {
                            columnNumber--;
                            char letter = (char)('A' + (columnNumber % 26));
                            columnNumber /= 26;
                            return letter;
                        })
                )
            );
        }

    }
}
