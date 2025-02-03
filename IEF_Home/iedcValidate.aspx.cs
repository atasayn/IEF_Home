using DocumentFormat.OpenXml.Bibliography;
using DocumentFormat.OpenXml.Math;
using DocumentFormat.OpenXml.Spreadsheet;
using DocumentFormat.OpenXml.Wordprocessing;
using GrapeCity.Documents.Pdf;
using IEF_Home.cls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;
using Org.BouncyCastle.Asn1.Pkcs;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using PdfSharpCore.Pdf;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using static ClosedXML.Excel.XLPredefinedFormat;
using Font = iTextSharp.text.Font;
using Paragraph = iTextSharp.text.Paragraph;


namespace IEF_Home
{
    public partial class iedcValidate : System.Web.UI.Page
    {
        ExcelToPDF exc = new ExcelToPDF();

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ShowCompareTable(object sender, EventArgs e)
        {

        }
        protected void ButtonUpload(object sender, EventArgs e)
        {
           // loaderControl.Style["display"] = "block";
                ScriptManager.RegisterStartupScript(this, GetType(), "showLoader", "document.getElementById('loaderControl').style.display='block';", true);

            try
            {
                // this.ShowCompareTable(this, EventArgs.Empty);
                if (FileUpload.HasFile)
                {
                    circomodService.counterGlobal.Reset();
                    dataSheetMatch.DataSource=null;
                    dataSheetMatch.DataBind();
                    var fileChecker = new excelSheetCheck();
                    if (fileChecker.IsExcelFile(FileUpload.PostedFile))
                    {
                        
                        // Save the file to the server
                        string fileName = Path.GetFileName(FileUpload.PostedFile.FileName);
                        string filePath = Server.MapPath("~/UploadedFiles/" + fileName);
                        FileUpload.SaveAs(filePath);
                        ViewState["FilePath"] = filePath; // Store filePath in ViewState
                        // Check if the specific worksheet exists
                        string sheetName = "Cover"; // Replace with your actual sheet name
                        if (fileChecker.DoesCoverExist(FileUpload.PostedFile, sheetName))
                        {
                            
                            columnDiv.Style["display"] = "block";
                            section1Full.Style["display"] = "block";
                            section2Row.Style["display"] = "block";
                            section2DataCheck.Style["display"] = "block";
                            missingCellTableSec.Style["display"] = "block";
                            // Date and Time of Upload + File name + Success
                            string dateTime = System.DateTime.Now.ToString();
                            string htmlContent = $"<h4>On {dateTime}: Parsing and validating dataset {fileName} against the specifications of the iedc.</h4>";
                            validatingDateAndTime.Text = htmlContent;
                            lblMessage.Text = "File uploaded successfully.";
                            lblMessage.ForeColor = System.Drawing.Color.Green;
                            fileChecker.DoesDataExist(filePath, sheetName, compareTable, missingCellTable,aspectReportTable,dimensionCompareTable,aspectMatch,aspectMatchRemarks,missingCellTableSec);
                            fileChecker.isListOrTable(filePath, sheetName, templateType, aspectSequence, dataSheetRowNumber,dataSheetMatch, unitMoniDenomi, Ok, Warning, Error,loaderControl);
                        }
                        else
                        {
                            lblMessage.Text = "Uploaded file must contain a ‘Cover’ sheet.";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    else
                    {
                        lblMessage.Text = "Please upload a valid Excel .xlsx file.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
                else
                {
                    lblMessage.Text = "Please select a file to upload.";
                }
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception);
                throw;
            }
            
        }
        static void ConvertExcelToPdf(string excelPath, string pdfPath)
        {
            using (var package = new ExcelPackage(new FileInfo(excelPath)))
            {
                var workbook = package.Workbook;
                if (workbook == null || workbook.Worksheets.Count == 0)
                {
                    throw new Exception("No worksheets found in the Excel file.");
                }

                var worksheet = workbook.Worksheets[0];
                // Header
                // Define the relative path to the image
                string relativeImagePath = "resources/iedcValidatorReportHeader.png";
                string imagePath = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, relativeImagePath);
                XImage headerImage = XImage.FromFile(imagePath);
                iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(imagePath);

                // Calculate image dimensions to match page width


                int startRow = 2, endRow = 72;
                int startCol = 1, endCol = 4; // Columns A to D
                BaseColor bgColor = BaseColor.WHITE;
                // Define merged ranges for Column B (1-based index)
                List<(int start, int end)> mergedRanges = new List<(int, int)>
                {
                    (4, 6), (7, 10), (11, 20), (21, 25), (26, 52), (53, 60), (61, 67), (68, 72)
                };
                using (FileStream stream = new FileStream(pdfPath, FileMode.Create))
                {

                    iTextSharp.text.Document pdfDocument = new iTextSharp.text.Document(iTextSharp.text.PageSize.A4);
                    // Initialize the PDF writer to write to the file stream
                    PdfWriter writer = iTextSharp.text.pdf.PdfWriter.GetInstance(pdfDocument, stream);
                    // Attach the custom page event to the writer
                    writer.PageEvent = new FooterPageEvent();
                    float imageWidth = pdfDocument.PageSize.Width;
                    float imageHeight = headerImage.PixelHeight * imageWidth / headerImage.PixelWidth;
                    pdfDocument.Open();
                    logo.SetAbsolutePosition(0, pdfDocument.PageSize.Height-30);
                    logo.ScaleAbsolute(imageWidth, imageHeight);
                    pdfDocument.Add(logo);

                    PdfPTable table = new PdfPTable(4);
                    table.WidthPercentage = 100;

                    for (int row = startRow; row <= endRow; row++)
                    {
                        // Merge  B2, C2, D2 into one cell spanning all 3 columns
                        if (row == 2)
                        {
                            string mergedText = worksheet.Cells[row, 2].Text; // Take text from A2
                            PdfPCell mergedCell = new PdfPCell(new Phrase(mergedText))
                            {
                                Colspan = 4, // Spanning 
                                HorizontalAlignment = Element.ALIGN_CENTER,
                                VerticalAlignment = Element.ALIGN_MIDDLE,
                                BackgroundColor = new BaseColor(211, 211, 211)
                            };
                            table.AddCell(mergedCell);
                            continue; // Skip adding individual cells for B2, C2, D2
                        }

                        if (row == 3)
                        {
                            string mergedText = worksheet.Cells[row, 1].Text; // Take text from A2
                            table.AddCell(new PdfPCell(new Phrase(mergedText)));
                            string mergedText2 = worksheet.Cells[row, 2].Text; // Take text from A2
                            table.AddCell(new PdfPCell(new Phrase(mergedText2)));
                            string mergedText3 = worksheet.Cells[row, 3].Text; // Take text from A2
                            table.AddCell(new PdfPCell(new Phrase(mergedText3)));
                            string mergedText4 = worksheet.Cells[row, 4].Text; // Take text from A2
                            table.AddCell(new PdfPCell(new Phrase(mergedText4)));
                        }
                        if (row >= 4)
                        {
                            // Column A (Always added)
                            string colA = worksheet.Cells[row, 1].Text;
                            table.AddCell(new PdfPCell(new Phrase(colA)));

                            // Column B (Merged Handling)
                            int rowspan = GetRowspanForMergedRange(row, mergedRanges);
                            if (rowspan > 1) // First row of merged range
                            {
                                string colB = worksheet.Cells[row, 2].Text;
                                bgColor = GetExcelCellColor(worksheet.Cells[row, 2]); // Get background color
                                PdfPCell mergedCell = new PdfPCell(new Phrase(colB))
                                {
                                    Rowspan = rowspan,
                                    VerticalAlignment = Element.ALIGN_MIDDLE,
                                    BackgroundColor = bgColor
                                };
                                table.AddCell(mergedCell);
                            }
                            else if (IsInsideMergedRange(row, mergedRanges))
                            {
                                // Skip adding Column B if it's part of a merged range (already added in first row)
                            }

                            // Column C (Always added)
                            string colC = worksheet.Cells[row, 3].Text;
                            bgColor = GetExcelCellColor(worksheet.Cells[row, 3]); // Get background color
                            PdfPCell cellC = new PdfPCell(new Phrase(colC))
                            {
                                BackgroundColor = bgColor // Apply background color
                            };
                            table.AddCell(cellC);

                            // Column D (Always added)
                            string colD = worksheet.Cells[row, 4].Text;
                            PdfPCell cellD = new PdfPCell(new Phrase(colD))
                            {
                                BackgroundColor = bgColor // Apply background color
                            };
                            table.AddCell(cellD);

                        }

                    }

                    pdfDocument.Add(table);
                    pdfDocument.Close();
                    stream.Close();

                }
            }
        }
        
        // Helper function to check if a row is the start of a merged range
        static int GetRowspanForMergedRange(int currentRow, List<(int start, int end)> mergedRanges)
        {
            foreach (var (start, end) in mergedRanges)
            {
                if (currentRow == start)
                    return end - start + 1; // Calculate rowspan
            }
            return 0; // Not a merged cell start
        }

        // Helper function: Checks if a row is inside a merged range (but not the first row)
        static bool IsInsideMergedRange(int currentRow, List<(int start, int end)> mergedRanges)
        {
            foreach (var (start, end) in mergedRanges)
            {
                if (currentRow > start && currentRow <= end)
                    return true; // Row is inside a merged range
            }
            return false;
        }
        static BaseColor GetExcelCellColor(ExcelRange excelCell)
        {
     
            var fill = excelCell.Style.Fill.BackgroundColor;

            if (!string.IsNullOrEmpty(fill.Rgb)) // Ensure color exists
            {
                string hex = fill.Rgb;

                // Ensure hex is in valid format (6 or 8 characters)
                if (hex.Length == 8) // AARRGGBB format
                    hex = hex.Substring(2); // Remove alpha (AA)

                if (hex.Length == 6) // Ensure valid RRGGBB format
                {
                    int argb = int.Parse(hex, NumberStyles.HexNumber);
                    int red = (argb >> 16) & 0xFF;
                    int green = (argb >> 8) & 0xFF;
                    int blue = argb & 0xFF;
                    return new BaseColor(red, green, blue);
                }
            }
            return null; // No background color
        }
        protected void Report(object sender, EventArgs e)
        {
            try
            {
                // Save the document
                string dateTime = System.DateTime.Now.ToString("yyyyMMdd_HHmmss");
                // Combine directory path and filename
                string directoryPath = @"C:\Users\na1041\Desktop\Nildem_Start_Package\home\IEF_Home\imagesToPDF";
                if (!System.IO.Directory.Exists(directoryPath))
                {
                    System.IO.Directory.CreateDirectory(directoryPath);
                }
                string filename =  $"iedcValidatorReport_{dateTime}.pdf";
                // Ensure the directory exists
                ConvertExcelToPdf(ViewState["FilePath"].ToString(), filename);
                // Serve the file for download
                DownloadFile(ViewState["FilePath"].ToString(), filename);
               
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception);
                throw;
            }


        }
        private void DownloadFile(string filePath, string fileName)
        {
            FileInfo file = new FileInfo(filePath);
            if (file.Exists)
            {
                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
                Response.WriteFile(file.FullName);
                Response.End();
            }
        }

        public static void ErrorCounter(int errCount, int warningCount, int oKCount, BulletedList Ok, BulletedList Warning, BulletedList Error)
        {

            // Update OK ListItem
            if (Ok.Items.Count > 0) // Check if the ListItem exists
            {
                Ok.Items[0].Text = "Ok: " + oKCount; // Update the text of the first ListItem
                Ok.Items[0].Attributes["style"] = "color: green;"; // Ensure the color remains green
            }

            // Update Warning ListItem
            if (Warning.Items.Count > 0) // Check if the ListItem exists
            {
                Warning.Items[0].Text = "Warning: " + warningCount; // Update the text of the first ListItem
                Warning.Items[0].Attributes["style"] = "color: orange;"; // Ensure the color remains orange
            }

            // Update Error ListItem
            if (Error.Items.Count > 0) // Check if the ListItem exists
            {
                Error.Items[0].Text = "Error: " + errCount; // Update the text of the first ListItem
                Error.Items[0].Attributes["style"] = "color: red;"; // Ensure the color remains red
            }

        }
    }

}