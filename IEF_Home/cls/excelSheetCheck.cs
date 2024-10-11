using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using OfficeOpenXml;
using System.Reflection.Emit;
using ClosedXML.Excel;
using System.Web.UI.WebControls;
using System.Data;


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

        public void DoesDataExist(string file, string sheetName, GridView compareTable, GridView reportView, GridView missingCellTable, GridView aspectReportTable)
        {
            // Call method from the service
            var coverCellCheck = new circomodService();


            // Open the Excel workbook
            using (var workbook = new XLWorkbook(file))
            {
                // Access the "cover" sheet
                var worksheet = workbook.Worksheet(sheetName);


                // Retrieve the values from cells D5 and D6
                var cellD5Value = worksheet.Cell("D5").Value.ToString();
                var cellD6Value = worksheet.Cell("D6").Value.ToString();
                var cellD8Value = worksheet.Cell("D8").Value.ToString();
                var cellD9Value = worksheet.Cell("D9").Value.ToString();
                var cellD10Value = worksheet.Cell("D10").Value.ToString();
                var cellD23Value = worksheet.Cell("D23").Value.ToString();
                var cellD53Value = worksheet.Cell("D53").Value.ToString();
                var cellD54Value = worksheet.Cell("D54").Value.ToString();
                //Check if cells are empty
                List<string> cellsToCheck = new List<string>
                {
                    "D11", "D12", "D13", "D14", "D15", "D16", "D17", "D18", "D19", "D20",
                    "D21", "D22", "D50", "D51", "D52", "D55", "D56", "D57", "D58", "D59",
                    "D60", "D61", "D62", "D63", "D64"
                };

                //// Report Table
                DataTable reportCell = new DataTable();
                reportCell.Columns.Add("Warning Message"); // Ensure column is added to the DataTable

                foreach (var item in cellsToCheck)
                {
                    var cellCheck = worksheet.Cell(item).Value.ToString();
                    if (string.IsNullOrEmpty(cellCheck)) // Check for empty or null string
                    {
                        reportCell.Rows.Add($"WARNING: Dataset description for cell {item} is empty, please provide some description here");
                    }
                }

                List<string> aspectList = new List<string>
                {
                    "D26", "D28", "D30", "D32", "D34", "D36", "D38", "D40", "D42", "D44", "D46", "D48"

                };
                foreach (var item in aspectList)
                {
                    var cellCheck = worksheet.Cell(item).Value.ToString();
                    coverCellCheck.DoesAspectExist(cellCheck,aspectReportTable,item);

                }
                // Bind the cells to the table after the loop
                missingCellTable.DataSource = reportCell;
                missingCellTable.DataBind();

                coverCellCheck.CoverCellCheck(cellD5Value, cellD6Value, 
                    cellD8Value, cellD9Value, cellD10Value, cellD23Value, cellD53Value, cellD54Value, aspectList, compareTable, reportView);


            }

        }

    }
}