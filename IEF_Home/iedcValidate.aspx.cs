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
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;
using Font = iTextSharp.text.Font;
using System.Text.RegularExpressions;
using System.Web;
using iTextSharp.text.html.simpleparser;
using DocumentFormat.OpenXml.Drawing.Charts;
using GrapeCity.Documents.Pdf.Layers;
using static ClosedXML.Excel.XLPredefinedFormat;
using Paragraph = iTextSharp.text.Paragraph;



namespace IEF_Home
{
    public partial class iedcValidate : System.Web.UI.Page
    {
        ExcelToPDF exc = new ExcelToPDF();

        protected void Page_Load(object sender, EventArgs e)
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
                            columnDiv.Style["display"] = "none";
                            section1Full.Style["display"] = "none";
                            section2Row.Style["display"] = "none";
                            section2DataCheck.Style["display"] = "none";
                            missingCellTableSec.Style["display"] = "none";
                            templateType.Style["display"] = "none";
                            aspectMatch.Style["display"] = "none";
                            dataSheetRowNumber.Style["display"] = "none";
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
        public void ConvertExcelToPdf(string excelPath)
        {
            

            using (var package = new ExcelPackage(new FileInfo(excelPath)))
            {
                var workbook = package.Workbook;
                if (workbook == null || workbook.Worksheets.Count == 0)
                {
                    throw new Exception("No worksheets found in the Excel file.");
                }
                
                var worksheet = workbook.Worksheets[0];
                string pdfName = worksheet.Cells[5, 4].Text;
                // Date
                string dateTime = System.DateTime.Now.ToString("ddMMyyyy");
                // Combine directory path and filename
                string directoryPath = @"C:\Windows\Temp";
                string pdfPath = System.IO.Path.Combine(directoryPath, $"{pdfName}_validation_{dateTime}.pdf");
                // Header
                // Define the relative path to the image
                string relativeImagePath = "resources/iedcValidatorReportHeader.png";
                string imagePath = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, relativeImagePath);
                XImage headerImage = XImage.FromFile(imagePath);
                iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(imagePath);
                // Define a font with a custom size (e.g., 16)
                Font customFont = FontFactory.GetFont(FontFactory.HELVETICA, 8, Font.NORMAL);
                Font baseFont = FontFactory.GetFont(FontFactory.HELVETICA, 9, Font.BOLD);

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
                    // Parent Table


                    // Ok,Warning, Error List
                    // Create table for BulletedLists
                    PdfPTable tableBulletedLists = new PdfPTable(1); // Two columns: Type and Items
                    tableBulletedLists.WidthPercentage = 30;
                    tableBulletedLists.SpacingBefore = 10f;
                    tableBulletedLists.HorizontalAlignment = Element.ALIGN_RIGHT;

                    // Add header row
                   // AddCellToTable(tableBulletedLists, "Item Feedback", customFont, true);
                    int indexBulletList = 1;
                    // Function to extract only the number from "OK: 5"
                    string ExtractNumber(string text)
                    {
                        Match match = Regex.Match(text, @"\d+"); // Extracts the first number found
                        return match.Success ? match.Value : ""; // Return number or empty string if none found
                    }
                    // Function to add items from a BulletedList
                    void AddBulletedListToTable(BulletedList bl, string type, BaseColor color)
                    {
                        if (bl.Items.Count > 0)
                        {
                            foreach (System.Web.UI.WebControls.ListItem item in bl.Items)
                            {
                                PdfPCell typeCell = new PdfPCell(new Phrase(type, customFont));
                                typeCell.BackgroundColor = color;
                                tableBulletedLists.AddCell(typeCell);
                                tableBulletedLists.AddCell(ConvertHtmlToPdfPCell(writer, ExtractNumber(item.Text), indexBulletList));  // Column 2: Item
                                indexBulletList++;
                            }
                        }
                    }

                    // Add items from each BulletedList
                    AddBulletedListToTable(Ok, "OK", BaseColor.GREEN);
                    AddBulletedListToTable(Warning, "Warning", BaseColor.ORANGE);
                    AddBulletedListToTable(Error, "Error", BaseColor.RED);

                    // Template Type
                    PdfPTable tableTemplate = new PdfPTable(1);
                    tableTemplate.WidthPercentage = 50;
                    tableTemplate.SpacingBefore = 10f; // Adding spacing before the table
                    tableTemplate.HorizontalAlignment = Element.ALIGN_LEFT;
                    ;
                    // Add header row
                    AddCellToTable(tableTemplate, "Template Type", customFont, true);


                    int indexTemplate = 1;
                    // Add rows dynamically
                    foreach (GridViewRow row in templateType.Rows)
                    {
                        tableTemplate.AddCell(ConvertHtmlToPdfPCell(writer, row.Cells[0].Text, indexTemplate)); // Cell column

                        indexTemplate++;
                    }


                    // Number of rows with text
                    PdfPTable tableNoR = new PdfPTable(1);
                    tableNoR.WidthPercentage = 50;
                    tableNoR.SpacingBefore = 10f; // Adding spacing before the table
            
                    // Add header row
                    AddCellToTable(tableNoR, "Number of rows with text", customFont, true);
                    int indexNoR = 1;
                    // Add rows dynamically
                    foreach (GridViewRow row in dataSheetRowNumber.Rows)
                    {
                        tableNoR.AddCell(ConvertHtmlToPdfPCell(writer, row.Cells[0].Text, indexNoR)); // Cell column

                        indexNoR++;
                    }

                    // Create parent table with three columns
                    PdfPTable parentTable = new PdfPTable(2);
                    parentTable.WidthPercentage = 100;
                    parentTable.SpacingBefore = 10f;
                    parentTable.SetWidths(new float[] { 6, 2}); // Adjust column width ratios as needed

                    // Wrap the tables into cells
                    PdfPCell bulletListCell = new PdfPCell(tableBulletedLists);
                    bulletListCell.Border = Rectangle.NO_BORDER;
                    bulletListCell.HorizontalAlignment = Element.ALIGN_RIGHT;

                    PdfPCell templateNoRCell = new PdfPCell();
                    templateNoRCell.Border = Rectangle.NO_BORDER;
                    templateNoRCell.HorizontalAlignment = Element.ALIGN_LEFT;

                    // Create a new table to hold tableTemplate and tableNoR
                    PdfPTable templateAndNoRTable = new PdfPTable(1);
                    templateAndNoRTable.WidthPercentage = 100;
                    templateAndNoRTable.SpacingBefore = 10f;
                    templateAndNoRTable.DefaultCell.Border = Rectangle.NO_BORDER;
                    templateAndNoRTable.AddCell(tableTemplate);
                    templateAndNoRTable.AddCell(tableNoR);
                 

                    // Add the combined template and NoR table to the cell
                    templateNoRCell.AddElement(templateAndNoRTable);

                    // Add the cells to the parent table
                    parentTable.AddCell(templateNoRCell); // Both tableTemplate and tableNoR are now in the same column
                    parentTable.AddCell(bulletListCell);
                    parentTable.AddCell(new PdfPCell());


                    // Add parent table to document
                    pdfDocument.Add(parentTable);

                    Paragraph captionParagraphTable1 = new Paragraph("Table 1 and 2: Template Type and Number of rows with text", baseFont);
                    captionParagraphTable1.Alignment = Element.ALIGN_CENTER; // Center-align the caption
                    pdfDocument.Add(captionParagraphTable1);

                    // Dataset information Table
                    PdfPTable table = new PdfPTable(4);
                    table.WidthPercentage = 100;
                    table.SpacingBefore = 20f; // Adding spacing before the table
                    float[] columnWidths = { 1f, 2f, 3f, 3f };
                    table.SetWidths(columnWidths);
                   
                    for (int row = startRow; row <= endRow; row++)
                    {
                        // Merge  B2, C2, D2 into one cell spanning all 3 columns
                        if (row == 2)
                        {
                            string mergedText = worksheet.Cells[row, 2].Text; // Take text from A2
                            PdfPCell mergedCell = new PdfPCell(new Phrase(mergedText, customFont))
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
                            table.AddCell(new PdfPCell(new Phrase(mergedText, customFont)));
                            string mergedText2 = worksheet.Cells[row, 2].Text; // Take text from A2
                            table.AddCell(new PdfPCell(new Phrase(mergedText2, customFont)));
                            string mergedText3 = worksheet.Cells[row, 3].Text; // Take text from A2
                            table.AddCell(new PdfPCell(new Phrase(mergedText3, customFont)));
                            string mergedText4 = worksheet.Cells[row, 4].Text; // Take text from A2
                            table.AddCell(new PdfPCell(new Phrase(mergedText4, customFont)));
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
                                PdfPCell mergedCell = new PdfPCell(new Phrase(colB, customFont))
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
                            PdfPCell cellC = new PdfPCell(new Phrase(colC, customFont))
                            {
                                BackgroundColor = bgColor // Apply background color
                            };
                            table.AddCell(cellC);

                            // Column D (Always added)
                            string colD = worksheet.Cells[row, 4].Text;
                            PdfPCell cellD = new PdfPCell(new Phrase(colD, customFont))
                            {
                                BackgroundColor = bgColor // Apply background color
                            };
                            table.AddCell(cellD);

                        }

                    }

                    pdfDocument.Add(table);
                    // Create a Paragraph for the caption
                    Paragraph captionParagraph = new Paragraph("Table 3: Dataset information from Excel Sheet", baseFont);
                    captionParagraph.Alignment = Element.ALIGN_CENTER; // Center-align the caption
                    // Add the caption phrase to the document
                    pdfDocument.Add(captionParagraph);

                    // Second Table
                    PdfPTable tableSummary = new PdfPTable(5);
                    tableSummary.WidthPercentage = 100;
                    tableSummary.SpacingBefore = 20f; // Adding spacing before the table
                    float[] columnWidths2 = { 1f, 3f, 3f, 3f, 3f };
                    tableSummary.SetWidths(columnWidths2);

                    // Add header row
                    AddCellToTable(tableSummary, "Cell", customFont,true);
                    AddCellToTable(tableSummary, "Name/label", customFont,true);
                    AddCellToTable(tableSummary, "Given Value/Text", customFont, true);
                    AddCellToTable(tableSummary, "Closest Iedc Match", customFont, true);
                    AddCellToTable(tableSummary, "Validation Report", customFont, true);

                    int index = 1;
                    // Add rows dynamically
                    foreach (GridViewRow row in compareTable.Rows)
                    {
                        tableSummary.AddCell(ConvertHtmlToPdfPCell(writer, row.Cells[0].Text, index)); // Cell column
                        tableSummary.AddCell(ConvertHtmlToPdfPCell(writer, row.Cells[1].Text, index)); // Name/label column
                        tableSummary.AddCell(ConvertHtmlToPdfPCell(writer, row.Cells[2].Text, index)); // Given Value/Text column
                        tableSummary.AddCell(ConvertHtmlToPdfPCell(writer, row.Cells[3].Text, index)); // Closest IEDC Match column
                        tableSummary.AddCell(ConvertHtmlToPdfPCell(writer, row.Cells[4].Text, index)); // Closest IEDC Match column
                        index++;
                    }
                    pdfDocument.Add(tableSummary);

                    // Create a Paragraph for the caption
                    Paragraph captionDatasetWeb = new Paragraph("Table 4: Dataset type and other specifications against iedc standards", baseFont);
                    captionDatasetWeb.Alignment = Element.ALIGN_CENTER; // Center-align the caption
                    // Add the caption phrase to the document
                    pdfDocument.Add(captionDatasetWeb);

                    // Aspect/Classification Comparasion Table
                    PdfPTable tableSummaryAspects = new PdfPTable(5);
                    tableSummaryAspects.WidthPercentage = 100;
                    tableSummaryAspects.SpacingBefore = 20f; // Adding spacing before the table
                    // Add header row
                    AddCellToTable(tableSummaryAspects, "Aspect", customFont, true);
                    AddCellToTable(tableSummaryAspects, "Aspect Remarks", customFont, true);
                    AddCellToTable(tableSummaryAspects, "Classification", customFont, true);
                    AddCellToTable(tableSummaryAspects, "Classification Remarks", customFont, true);
                    AddCellToTable(tableSummaryAspects, "Dimension Remarks", customFont, true);

                    int indexAspects = 1;
                    // Add rows dynamically
                    foreach (GridViewRow row in aspectReportTable.Rows)
                    {
                        foreach (System.Web.UI.WebControls.TableCell cell in row.Cells)
                        {
                            tableSummaryAspects.AddCell(ConvertHtmlToPdfPCell(writer, cell.Text, indexAspects));
                            indexAspects++;
                        }
                    }
                    Paragraph captionParagraphAspect = new Paragraph("Table 5: Dataset aspects and classifications to iedc specifications", baseFont);
                    captionParagraphAspect.Alignment = Element.ALIGN_CENTER; // Center-align the caption
                    
                    // Add the caption phrase to the document
                    pdfDocument.Add(tableSummaryAspects);
                    pdfDocument.Add(captionParagraphAspect);
                    pdfDocument.Close();
                    stream.Close();
                    // Serve the file for download
                    // Serve the file for download
                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType = "application/pdf";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + pdfName + "_validation_" + $"{dateTime}");
                    Response.TransmitFile(pdfPath);
                    Response.End();

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

        static void AddCellToTable(PdfPTable table, string text, Font customFont, bool isHeader = false)
        {
            PdfPCell cell = new PdfPCell(new Phrase(text, customFont));
            if (isHeader)
            {
                cell.BackgroundColor = BaseColor.LIGHT_GRAY;
                cell.HorizontalAlignment = Element.ALIGN_CENTER;
            }
            else
            {
                cell.HorizontalAlignment = Element.ALIGN_LEFT;
            }
            table.AddCell(cell);
        }

        private PdfPCell ConvertHtmlToPdfPCell(PdfWriter writer, string htmlContent, int index)
        {
            // Set the custom font size, but we will merge it with existing styles
            Font baseFont = FontFactory.GetFont(FontFactory.HELVETICA, 8, Font.NORMAL);
            PdfPCell cell = new PdfPCell(new Phrase("", baseFont));
            // Apply grey background to every second cell (index is 1-based)
            if (index % 2 == 0)
            {
                cell.BackgroundColor = new BaseColor(221, 221, 221); ; // Grey background
            }
            using (StringReader sr = new StringReader(htmlContent))
            {
                // Parse the HTML into elements
                List<IElement> elements = HTMLWorker.ParseToList(sr, null);

                foreach (IElement element in elements)
                {
                    if (element is Phrase phrase)
                    {
                        foreach (Chunk chunk in phrase.Chunks)
                        {
                            // Create a new Font that keeps the chunk's existing styles
                            Font updatedFont = new Font(chunk.Font) // Copy the existing Font properties
                            {
                                Size = 8 // Set the new font size
                            };

                            chunk.Font = updatedFont; // Apply the updated font to the chunk
                        }
                    }

                    // Add the element (with the updated font) to the cell
                    cell.AddElement(element);
                }
            }

            return cell;
        }

        protected void Report(object sender, EventArgs e)
        {
            try
            {

                // Ensure the directory exists
                ConvertExcelToPdf(ViewState["FilePath"].ToString());

               
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception);
                throw;
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