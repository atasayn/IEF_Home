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

        public void DoesDataExist(string file, string sheetName, GridView compareTable, GridView reportView)
        {

            // Initialize a string to store the output
            string output = string.Empty;

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
                var cellD54Value = worksheet.Cell("D53").Value.ToString();
                

                // Call method from the service
                var coverCellCheck = new circomodService();
                coverCellCheck.CoverCellCheck(cellD5Value, cellD6Value, 
                    cellD8Value, cellD9Value, cellD10Value, cellD23Value, cellD53Value, cellD54Value, compareTable, reportView);


            }

        }

    }
}