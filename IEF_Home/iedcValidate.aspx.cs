using IEF_Home.cls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;
using Org.BouncyCastle.Asn1.Pkcs;
using PdfSharp.Drawing;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using Font = iTextSharp.text.Font;
using System.Text.RegularExpressions;
using System.Web;
using iTextSharp.text.html.simpleparser;
using Paragraph = iTextSharp.text.Paragraph;
using System.Web.Caching;
using System.Diagnostics;
using System.Linq.Expressions;


namespace IEF_Home
{
    public partial class iedcValidate : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.EnableViewState = false;

        }
        public static string IsMyCheckboxChecked(System.Web.UI.WebControls.CheckBox simpleSearch, System.Web.UI.WebControls.CheckBox levenshteinSearch)
        {
            if (simpleSearch.Checked)
            {
                return "simpleSearch";
            }
            else if (levenshteinSearch.Checked)
            {
                return "levenshteinSearch";
            }
            return ""; // Return empty string if nothing is checked
        }

        public void ButtonUpload(object sender, EventArgs e)
        {
            // Show loader
            ScriptManager.RegisterStartupScript(this, GetType(), "showLoader",
                "document.getElementById('loaderControl').style.display='block';", true);

            string filePath = null; // temp file path

            try
            {
                if (!FileUpload.HasFile)
                {
                    lblMessage.Text = "Please select a file to upload.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                var fileChecker = new excelSheetCheck();

                if (!fileChecker.IsExcelFile(FileUpload.PostedFile))
                {
                    lblMessage.Text = "Please upload a valid Excel .xlsx file.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // Save the uploaded file with a unique name to avoid locking issues
                string originalName = Path.GetFileName(FileUpload.PostedFile.FileName);
                string safeFileName = Guid.NewGuid().ToString() + Path.GetExtension(originalName);
                filePath = Server.MapPath("~/UploadedFiles/" + safeFileName);
                FileUpload.SaveAs(filePath);
                Cache["filePath"] = filePath;

                string sheetName = "Cover";

                // Check if the Cover sheet exists
                if (!fileChecker.DoesCoverExist(FileUpload.PostedFile, sheetName))
                {
                    HideAllSections();
                    lblMessage.Text = "Uploaded file must contain a ‘Cover’ sheet.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // Show sections
                columnDiv.Style["display"] = "block";
                section1Full.Style["display"] = "block";
                section2Row.Style["display"] = "block";
                section2DataCheck.Style["display"] = "block";
                missingCellTableSec.Style["display"] = "block";

                // Display upload info
                string dateTime = DateTime.Now.ToString();
                validatingDateAndTime.Text = $"<h5 style='font-weight:bold;font-size:18px'>IEDC validation report for {originalName}, uploaded on {dateTime}</h5>";
                lblMessage.Text = "File uploaded successfully.";
                lblMessage.ForeColor = System.Drawing.Color.Green;

                // Reset counters and tables
                circomodService.counterGlobal.Reset();
                dataSheetMatch.DataSource = null;
                dataSheetMatch.DataBind();



                // ✅ Process Cover sheet safely
                try
                {
                    fileChecker.DoesDataExist(filePath, sheetName,
                        compareTable, missingCellTable, aspectReportTable, dimensionCompareTable,
                        aspectMatch, aspectMatchRemarks, missingCellTableSec);
                }
                catch (Exception ex)
                {
                    Warning.Items.Add("Error processing Cover sheet: " + ex.Message);
                }

                // ✅ Process Data sheet safely
                try
                {
                    fileChecker.isListOrTable(filePath, sheetName,
                        templateType, aspectSequence, dataSheetRowNumber, dataSheetMatch,
                        unitMoniDenomi, Ok, Warning, Error, loaderControl,
                        simpleSearch, levenshteinSearch);
                }
                catch (Exception ex)
                {
                    Warning.Items.Add("Error processing Data sheet: " + ex.Message);
                }

                // Cache results for later use
                Cache["OkList"] = Ok;
                Cache["WarningList"] = Warning;
                Cache["ErrorList"] = Error;
                Cache["templateType"] = templateType;
                Cache["dataSheetRowNumber"] = dataSheetRowNumber;
                Cache["compareTable"] = compareTable;
                Cache["aspectReportTable"] = aspectReportTable;
                Cache["dataSheetMatch"] = dataSheetMatch;
            }
            catch (Exception ex)
            {
                // Log any unexpected errors
                Console.WriteLine(ex);
                Warning.Items.Add("Unexpected error: " + ex.Message);
                lblMessage.Text = "An error occurred while processing the file.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
            finally
            {
                // Hide loader
                ScriptManager.RegisterStartupScript(this, GetType(), "hideLoader",
                    "document.getElementById('loaderControl').style.display='none';", true);

                // Delete temporary file to avoid server accumulation
                if (!string.IsNullOrEmpty(filePath) && File.Exists(filePath))
                {
                    try { File.Delete(filePath); } catch { /* file may be locked */ }
                }
            }
        }

        // Helper method to hide all UI sections
        private void HideAllSections()
        {
            columnDiv.Style["display"] = "none";
            section1Full.Style["display"] = "none";
            section2Row.Style["display"] = "none";
            section2DataCheck.Style["display"] = "none";
            missingCellTableSec.Style["display"] = "none";
            templateType.Style["display"] = "none";
            aspectMatch.Style["display"] = "none";
            dataSheetRowNumber.Style["display"] = "none";
        }


        public void ConvertExcelToPdf(string excelPath,BulletedList Ok, BulletedList Warning, BulletedList Error,GridView templateType,
            GridView dataSheetRowNumber,GridView compareTable, GridView aspectReportTable, GridView dataSheetMatch)
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
                string directoryPath = @"~\Temp";
                string pdfPath = System.IO.Path.Combine(directoryPath, $"{pdfName}_validation_{dateTime}.pdf");
                // Header
                // Define the relative path to the image
                string relativeImagePath = "resources/iedcValidationReport.png";
                string imagePath = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, relativeImagePath);
                XImage headerImage = XImage.FromFile(imagePath);
                iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(imagePath);
                // Define a font with a custom size (e.g., 16)
                Font customFont = FontFactory.GetFont(FontFactory.HELVETICA, 8, Font.NORMAL);
                Font excelFont = FontFactory.GetFont(FontFactory.HELVETICA, 6, Font.NORMAL);
                Font titleFont = FontFactory.GetFont(FontFactory.HELVETICA, 6, Font.BOLD);
                Font tableColumnFont = FontFactory.GetFont(FontFactory.HELVETICA, 7, Font.BOLD);

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
                    PdfWriter writer = PdfWriter.GetInstance(pdfDocument, stream);
                    // Attach the custom page event to the writer
                    writer.PageEvent = new FooterPageEvent();
                    float imageWidth = pdfDocument.PageSize.Width;
                    float imageHeight = headerImage.PixelHeight * imageWidth / headerImage.PixelWidth;
                    pdfDocument.Open();
                    logo.SetAbsolutePosition(0, pdfDocument.PageSize.Height-30);
                    logo.ScaleAbsolute(imageWidth, imageHeight);
                    pdfDocument.Add(logo);
                    // Spacing
                    pdfDocument.Add(new Paragraph("\n")); // Add extra space before the table


                    // Dataset vesion
                    PdfPTable datasetVersion = new PdfPTable(1);
                    datasetVersion.WidthPercentage = 50;
                    datasetVersion.HorizontalAlignment = Element.ALIGN_LEFT;
                    datasetVersion.SpacingBefore = 5f;
                    // Add header
                    AddCellToTable(datasetVersion, "Version of Dataset",tableColumnFont,true);


                    // Dataset Name and Time Table
                    PdfPTable tableDatasetName = new PdfPTable(1);
                    tableDatasetName.WidthPercentage = 50;
                    tableDatasetName.HorizontalAlignment = Element.ALIGN_LEFT;
                    tableDatasetName.SpacingBefore = 5f;
                    // Add header row
                    AddCellToTable(tableDatasetName, "Name of Dataset", tableColumnFont, true);
                    tableDatasetName.AddCell(new PdfPCell(new Phrase(pdfName, customFont))); // Apply font to data cell
                    
                    // Time
                    PdfPTable tableTime = new PdfPTable(1);
                    tableTime.WidthPercentage = 50;
                    tableTime.SpacingBefore = 5f; // Adding spacing before the table
                    tableTime.HorizontalAlignment = Element.ALIGN_LEFT;
                    ;
                    // Add header row
                    AddCellToTable(tableTime, "Time Stap of Validation", tableColumnFont, true);
                    tableTime.AddCell(new PdfPCell(new Phrase(System.DateTime.Now.ToString(), customFont))); // Apply font to data cell



                    // Ok,Warning, Error List
                    // Create table for BulletedLists
                    PdfPTable tableBulletedLists = new PdfPTable(1); // Two columns: Type and Items
                    
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
                    // Add header row
                    AddCellToTable(tableTemplate, "Template Type", tableColumnFont, true);


                    int indexTemplate = 1;
                    // Add rows dynamically
                    foreach (GridViewRow row in templateType.Rows)
                    {
                        tableTemplate.AddCell(ConvertHtmlToPdfPCell(writer, row.Cells[0].Text, indexTemplate)); // Cell column

                        indexTemplate++;
                    }


                    // Number of rows with text
                    PdfPTable tableNoR = new PdfPTable(1);
                 

                    // Add header row
                    AddCellToTable(tableNoR, "Number of rows with text", tableColumnFont, true);
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
                    parentTable.SetWidths(new float[] {7, 1}); // Adjust column width ratios as needed

                    // Wrap the tables into cells
                    PdfPCell bulletListCell = new PdfPCell(tableBulletedLists);
                    

                    PdfPCell templateNoRCell = new PdfPCell();
                    // Create a new table to hold tableTemplate and tableNoR
                    PdfPTable templateAndNoRTable = new PdfPTable(1);
                    templateAndNoRTable.WidthPercentage = 100;
                    templateAndNoRTable.AddCell(tableTemplate);
                    templateAndNoRTable.AddCell(tableNoR);
                    
                 

                    // Add the combined template and NoR table to the cell
                    templateNoRCell.AddElement(templateAndNoRTable);

                    // Add the cells to the parent table
                    parentTable.AddCell(templateNoRCell); // Both tableTemplate and tableNoR are now in the same column
                    parentTable.AddCell(bulletListCell);
                    parentTable.AddCell(new PdfPCell());




                    Paragraph captionParagraphTable1 = new Paragraph("Table 1: Dataset Information", tableColumnFont);
                    captionParagraphTable1.Alignment = Element.ALIGN_LEFT; // Center-align the caption
                    captionParagraphTable1.SpacingBefore = 10f;
                    

                    // Dataset information Table
                    PdfPTable table = new PdfPTable(4);
                    table.WidthPercentage = 100;
                    table.SpacingBefore = 5f; // Adding spacing before the table
                    float[] columnWidths = { 0.3f, 1f,2f, 3f };
                    table.SetWidths(columnWidths);
                   
                    for (int row = startRow; row <= endRow; row++)
                    {
                        // Merge  B2, C2, D2 into one cell spanning all 3 columns
                        if (row == 2)
                        {
                            string mergedText = worksheet.Cells[row, 2].Text; // Take text from A2
                            PdfPCell mergedCell = new PdfPCell(new Phrase(mergedText, titleFont))
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
                            table.AddCell(new PdfPCell(new Phrase(mergedText, excelFont)));
                            string mergedText2 = worksheet.Cells[row, 2].Text; // Take text from A2
                            table.AddCell(new PdfPCell(new Phrase(mergedText2, excelFont)));
                            string mergedText3 = worksheet.Cells[row, 3].Text; // Take text from A2
                            if (mergedText3 == "Column name")
                            {
                                mergedText3 = "Property name";
                            }
                     
                            table.AddCell(new PdfPCell(new Phrase(mergedText3, excelFont)));
                            string mergedText4 = worksheet.Cells[row, 4].Text; // Take text from A2
                            table.AddCell(new PdfPCell(new Phrase(mergedText4, excelFont)));
                        }
                        if (row >= 4)
                        {
                            // Column A (Always added)
                            string colA = worksheet.Cells[row, 1].Text;
                            table.AddCell(new PdfPCell(new Phrase(colA, excelFont)));

                            // Column B (Merged Handling)
                            int rowspan = GetRowspanForMergedRange(row, mergedRanges);
                            if (rowspan > 1) // First row of merged range
                            {
                                string colB = worksheet.Cells[row, 2].Text;
                                bgColor = GetExcelCellColor(worksheet.Cells[row, 2]); // Get background color
                                PdfPCell mergedCell = new PdfPCell(new Phrase(colB, excelFont))
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
                            PdfPCell cellC = new PdfPCell(new Phrase(colC, excelFont))
                            {
                                BackgroundColor = bgColor // Apply background color
                            };
                            table.AddCell(cellC);

                            // Column D (Always added)
                            string colD = worksheet.Cells[row, 4].Text;
                            if (colC == "dataset_version")
                            {
                                datasetVersion.AddCell(new PdfPCell(new Phrase(colD, customFont)));
                                
                            }
                            PdfPCell cellD = new PdfPCell(new Phrase(colD, excelFont))
                            {
                                BackgroundColor = bgColor // Apply background color
                            };
                            table.AddCell(cellD);

                        }

                    }
                    // Add tables to the pdf
                    pdfDocument.Add(tableDatasetName);
                    pdfDocument.Add(datasetVersion);
                    pdfDocument.Add(tableTime);
                    pdfDocument.Add(parentTable);
                    pdfDocument.Add(captionParagraphTable1);
                    pdfDocument.Add(table);
                    // Create a Paragraph for the caption
                    Paragraph captionParagraph = new Paragraph("Table 2: Validation report for the data category, type, layer, and metadata", tableColumnFont);
                    captionParagraph.Alignment = Element.ALIGN_LEFT; // Center-align the caption
                    captionParagraph.SpacingBefore = 10f;
                    // Add the caption phrase to the document
                    pdfDocument.Add(captionParagraph);

                    // Second Table
                    PdfPTable tableSummary = new PdfPTable(5);
                    tableSummary.WidthPercentage = 100;
                    tableSummary.SpacingBefore = 5f; // Adding spacing before the table
                    float[] columnWidths2 = { 0.3f, 0.7f, 1f, 1f, 2f };
                    tableSummary.SetWidths(columnWidths2);

                    // Add header row
                    AddCellToTable(tableSummary, "Cell", tableColumnFont, true);
                    AddCellToTable(tableSummary, "Name/label", tableColumnFont, true);
                    AddCellToTable(tableSummary, "Given Value/Text", tableColumnFont, true);
                    AddCellToTable(tableSummary, "Closest Iedc Match", tableColumnFont, true);
                    AddCellToTable(tableSummary, "Validation Report", tableColumnFont, true);

                    int index = 1;

                    // Add rows dynamically
                    foreach (GridViewRow row in compareTable.Rows)
                    {
                        bool isEvenRow = index % 2 == 0; // every second row

                        for (int i = 0; i < 5; i++) // assuming 5 columns
                        {
                            PdfPCell pdfCell = ConvertHtmlToPdfPCell(writer, row.Cells[i].Text, index);

                            if (isEvenRow)
                            {
                                pdfCell.BackgroundColor = new BaseColor(230, 230, 230); // light grey
                            }

                            tableSummary.AddCell(pdfCell);
                        }

                        index++;
                    }
                    pdfDocument.Add(tableSummary);

                    // Create a Paragraph for the caption
                    Paragraph captionDatasetWeb = new Paragraph("Table 3: Validation report for the data aspects and their classifications", tableColumnFont);
                    captionDatasetWeb.Alignment = Element.ALIGN_LEFT; // Center-align the caption
                    captionDatasetWeb.SpacingBefore = 10f;

                    // Add the caption phrase to the document
                    pdfDocument.Add(captionDatasetWeb);

                    // Aspect/Classification Comparasion Table
                    PdfPTable tableSummaryAspects = new PdfPTable(5);
                    tableSummaryAspects.WidthPercentage = 100;
                    float[] columnWidth = { 0.3f, 1f,1f, 1f, 1f };
                    tableSummaryAspects.SetWidths(columnWidth);
                    tableSummaryAspects.SpacingBefore = 5f; // Adding spacing before the table
                    // Add header row
                    AddCellToTable(tableSummaryAspects, "Aspect", tableColumnFont, true);
                    AddCellToTable(tableSummaryAspects, "Aspect Remarks", tableColumnFont, true);
                    AddCellToTable(tableSummaryAspects, "Classification", tableColumnFont, true);
                    AddCellToTable(tableSummaryAspects, "Classification Remarks", tableColumnFont, true);
                    AddCellToTable(tableSummaryAspects, "Dimension Remarks", tableColumnFont, true);

                    int indexAspects = 1;
                    int rowIndex = 0;
                    foreach (GridViewRow row in aspectReportTable.Rows)
                    {
                        bool isEvenRow = rowIndex % 2 == 1; // zero-based index; every second row

                        foreach (System.Web.UI.WebControls.TableCell cell in row.Cells)
                        {
                            PdfPCell pdfCell = ConvertHtmlToPdfPCell(writer, cell.Text, indexAspects);

                            if (isEvenRow)
                            {
                                pdfCell.BackgroundColor = new BaseColor(230, 230, 230); // light grey
                            }

                            tableSummaryAspects.AddCell(pdfCell);
                            indexAspects++;
                        }

                        rowIndex++;
                    }

                    Paragraph captionParagraphAspect = new Paragraph("Table 4: Use of consistent classifications", tableColumnFont);
                    captionParagraphAspect.Alignment = Element.ALIGN_LEFT; // Center-align the caption
                    captionParagraphAspect.SpacingBefore = 10f;


                    // Add the caption phrase to the document
                    pdfDocument.Add(tableSummaryAspects);
                    pdfDocument.Add(captionParagraphAspect);

                    //Use of Consistent Classification, FINAL table
                    PdfPTable finalTable = new PdfPTable(4);
                    finalTable.WidthPercentage = 100;
                    finalTable.SpacingBefore = 5f; // Adding spacing before the table
                    float[] columnWidthFinal = { 0.1f, 0.5f, 1f, 1f };
                    finalTable.SetWidths(columnWidthFinal);
                    // Add header row
                    AddCellToTable(finalTable, "Line", tableColumnFont, true);
                    AddCellToTable(finalTable, "Aspect", tableColumnFont, true);
                    AddCellToTable(finalTable, "Given Value/Text", tableColumnFont, true);
                    AddCellToTable(finalTable, "Remarks", tableColumnFont, true);
                    int indexFinal = 1;
                    int rowIndex2 = 0;

                    // Add rows dynamically
                    foreach (GridViewRow row in dataSheetMatch.Rows)
                    {
                        bool isEvenRow = rowIndex2 % 2 == 1; // every second row (0-based index)

                        foreach (System.Web.UI.WebControls.TableCell cell in row.Cells)
                        {
                            PdfPCell pdfCell = ConvertHtmlToPdfPCell(writer, cell.Text, indexFinal);

                            if (isEvenRow)
                            {
                                pdfCell.BackgroundColor = new BaseColor(230, 230, 230); // light grey
                            }

                            finalTable.AddCell(pdfCell);
                            indexFinal++;
                        }

                        rowIndex2++;
                    }


                    pdfDocument.Add(finalTable);
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
                
               var test = Cache["filePath"]?.ToString();
               //var test = HttpRuntime.Cache["OkList_" + Session.SessionID];

               Debug.WriteLine(test);


                // Ensure the directory exists
                ConvertExcelToPdf(Cache["filePath"]?.ToString(),
                Cache["OkList"] as BulletedList,
                Cache["WarningList"] as BulletedList,
                Cache["ErrorList"] as BulletedList,
                Cache["templateType"] as GridView,
                Cache["dataSheetRowNumber"] as GridView,
                Cache["compareTable"] as GridView,
                Cache["aspectReportTable"] as GridView,
               Cache["dataSheetMatch"] as GridView

                );





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