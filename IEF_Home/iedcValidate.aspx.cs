
using DocumentFormat.OpenXml.Spreadsheet;
using IEF_Home.cls;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace IEF_Home
{
    public partial class iedcValidate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ShowCompareTable(object sender, EventArgs e)
        {
            // Register a JavaScript code to set the style to display block
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showTable", "document.getElementById('compareTableSection').style.display = 'block';", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showTable1", "document.getElementById('remarksSection').style.display = 'block';", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showTable2", "document.getElementById('section2Row').style.display = 'block';", true);
        }
        protected void ButtonUpload(object sender, EventArgs e)
        {

            try
            {
                this.ShowCompareTable(this, EventArgs.Empty);
                if (FileUpload.HasFile)
                {
                    circomodService.counterGlobal.Reset();
                    columnDiv.Style["display"] = "block";
                    section1Full.Style["display"] = "block";
                    section2Row.Style["display"] = "block";

                    var fileChecker = new excelSheetCheck();
                    if (fileChecker.IsExcelFile(FileUpload.PostedFile))
                    {
                        // Save the file to the server
                        string fileName = Path.GetFileName(FileUpload.PostedFile.FileName);
                        string filePath = Server.MapPath("~/UploadedFiles/" + fileName);
                        FileUpload.SaveAs(filePath);

                        // Check if the specific worksheet exists
                        string sheetName = "Cover"; // Replace with your actual sheet name
                        if (fileChecker.DoesCoverExist(FileUpload.PostedFile, sheetName))
                        {
                            // Date and Time of Upload + File name + Success
                            string dateTime = DateTime.Now.ToString();
                            string htmlContent = $"<h4>On {dateTime}: Parsing and validating dataset {fileName} against the specifications of the iedc.</h4>";
                            validatingDateAndTime.Text = htmlContent;
                            lblMessage.Text = "File uploaded successfully.";
                            lblMessage.ForeColor = System.Drawing.Color.Green;
                            fileChecker.DoesDataExist(filePath, sheetName, compareTable, missingCellTable,aspectReportTable,dimensionCompareTable,aspectMatch,aspectMatchRemarks);
                            fileChecker.isListOrTable(filePath, sheetName, templateType, aspectSequence, dataSheetRowNumber,dataSheetMatch, Ok, Warning, Error);
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

        protected void Report(object sender, EventArgs e)
        {
  
            try
            {
                if (lblMessage.Text == "File uploaded successfully.")
                {

                    // Create a new PDF document
                    PdfDocument document = new PdfDocument();
                    document.Info.Title = "Iedc Validator Report";

                    // Create an empty page
                    PdfPage page = document.AddPage();

                    // Get an XGraphics object for drawing
                    XGraphics gfx = XGraphics.FromPdfPage(page);

                    // Create a font
                    XFont font = new XFont("Verdana", 10, XFontStyle.Bold);


                    // Define the relative path to the image
                    string relativeImagePath = "resources/iedcValidatorReportHeader.png";
                    string imagePath = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, relativeImagePath);
                    // Load the image
                    XImage headerImage = XImage.FromFile(imagePath);

                    // Draw the image at the top of the page
                    // Calculate image dimensions to match page width
                    double pageWidth = page.Width;
                    double imageWidth = pageWidth; // Set the image width to the page width
                    double imageHeight =
                        headerImage.PixelHeight * imageWidth / headerImage.PixelWidth; // Maintain aspect ratio
                    gfx.DrawImage(headerImage, 0, 0, imageWidth, imageHeight); // Adjust coordinates as needed



                    // Draw the text
                    XFont contentFont = new XFont("Verdana", 12, XFontStyle.Regular);
                    string text = validatingDateAndTime.Text;

                    // Remove <h4> and </h4> tags
                    text = text.Replace("<h4>", "").Replace("</h4>", "");
                    // Padding is 5px for the text. So -10 for fitting in the page
                    double maxWidth = page.Width - 10;


                    // Measure the width of the text
                    XSize textSize = gfx.MeasureString(text, contentFont);

                    // Scale the font size down if the text is too wide
                    if (textSize.Width > maxWidth)
                    {
                        double scaleFactor = maxWidth / textSize.Width;
                        contentFont = new XFont(contentFont.FontFamily.Name, contentFont.Size * scaleFactor);
                    }


                    var textYpos = imageHeight + 10;
                    gfx.DrawString(text, contentFont, XBrushes.Black,
                        new XRect(5, textYpos, page.Width, 0),
                        XStringFormats.TopCenter);



                    // Draw table header
                    GridViewRow headerRow = compareTable.HeaderRow;
                    // Create a list to store the maximum width for each column
                    var maxColumnCell1Col = new List<double>();
                    var maxColumnCell2Col = new List<double>();
                    var maxColumnCell3Col = new List<double>();

                    // Iterate through all rows in the GridView
                    foreach (GridViewRow row in compareTable.Rows)
                    {
                        // Iterate through all columns (cells) in the current row
                        for (int i = 0; i < row.Cells.Count; i++)
                        {
                            TableCell cell = row.Cells[i];
                            // Measure the width of the text in the current cell
                            XSize textSizeColumnMax = gfx.MeasureString(cell.Text, contentFont);

                            // Update the maximum width for the column if this text is wider
                            if (i == 0 || i == 3 || i == 6)
                            {
                                maxColumnCell1Col.Add(textSizeColumnMax.Width);
                            }
                            else if (i == 1 || i == 4 || i == 7)
                            {
                                maxColumnCell2Col.Add(textSizeColumnMax.Width);
                            }
                            else if (i == 2 || i == 5 || i == 8)
                            {
                                maxColumnCell3Col.Add(textSizeColumnMax.Width);
                            }

                        }
                    }

                    // Determine the total width of the columns before scaling
                    double totalColumnWidth = 0;
                    for (int i = 0; i < headerRow.Cells.Count; i++)
                    {
                        double cellwidth = 0;
                        if (i == 0)
                        {
                            cellwidth = maxColumnCell1Col.Max() + 5; // adding padding
                        }
                        else if (i == 1)
                        {
                            cellwidth = maxColumnCell2Col.Max() + 5; // adding padding
                        }
                        else if (i == 2)
                        {
                            cellwidth = maxColumnCell3Col.Max() + 5; // adding padding
                        }
                        totalColumnWidth += cellwidth;
                    }

                    // Get page dimensions
                    double pageWidthSc = gfx.PageSize.Width;
                    double pageHeight = gfx.PageSize.Height;

                    // Calculate the scaling factor based on page width
                    double scalingFactor = (pageWidthSc - 20) / totalColumnWidth; // subtracting some padding

                    // Apply scaling factor to cell widths and font size
                    double xStart = 5; // Starting X position with padding
                    double rowHeight = 20 * scalingFactor; // Scale row height as well
                    double yStart = textYpos + 40;


                    for (int i = 0; i < headerRow.Cells.Count; i++)
                    {
                        double cellwidth = 0;
                        if (i == 0)
                        {
                            cellwidth = (maxColumnCell1Col.Max() + 5) * scalingFactor; // scaling width
                        }
                        else if (i == 1)
                        {
                            cellwidth = (maxColumnCell2Col.Max() + 5) * scalingFactor; // scaling width
                        }
                        else if (i == 2)
                        {
                            cellwidth = (maxColumnCell3Col.Max() + 5) * scalingFactor; // scaling width
                        }

                        gfx.DrawRectangle(XPens.Black, XBrushes.LightGray, xStart, yStart, cellwidth, rowHeight);

                        // Measure the text size after scaling font size
                        XSize textsizecell = gfx.MeasureString(headerRow.Cells[i].Text, contentFont);

                        // Center the text vertically and horizontally within the rectangle
                        double textx = xStart + (cellwidth - textsizecell.Width) / 2;  // center horizontally
                        double texty = yStart + (rowHeight - textsizecell.Height) / 2; // center vertically

                        // Draw the text inside the rectangle
                        gfx.DrawString(headerRow.Cells[i].Text, contentFont, XBrushes.Black,
                            new XRect(textx, texty, cellwidth, textsizecell.Height), XStringFormats.TopLeft);

                        // Move the xStart to the position for the next cell
                        xStart += cellwidth;
                    }

                    
                    // Loop through each row in the GridView
                    foreach (GridViewRow row in compareTable.Rows)
                    {

                        for (int i = 0; i < row.Cells.Count; i++)
                        {
                            var cellwidth = new double(); ;
                            if (i == 0)
                            {
                                // define the rectangle for the current cell
                                cellwidth = (maxColumnCell1Col.Max() + 5) * scalingFactor;  // adding some padding if needed
                            }
                            else if (i == 1)
                            {
                                cellwidth = (maxColumnCell2Col.Max() + 5) * scalingFactor; // adding some padding if needed
                            }
                            else if (i == 2)
                            {
                                cellwidth = (maxColumnCell3Col.Max() + 5) * scalingFactor; // adding some padding if needed
                            }
                            // measure the width of the text in the current cell
                            XSize textsizecell = gfx.MeasureString(row.Cells[i].Text, contentFont);

                            gfx.DrawRectangle(XPens.Black, XBrushes.White, xStart, yStart, cellwidth, rowHeight);
                            // center the text vertically and horizontally within the rectangle
                            double textx = xStart + (cellwidth - textsizecell.Width) / 2;  // center horizontally
                            double texty = yStart + (rowHeight - textsizecell.Height) / 2; // center vertically
                            // Draw the text inside the rectangle
                            gfx.DrawString(row.Cells[i].Text, contentFont, XBrushes.Black,
                                new XRect(textx, texty, cellwidth, textsizecell.Height), XStringFormats.TopLeft);
                            xStart += cellwidth;
                        }
                        yStart += rowHeight;
                        xStart = 5;  // Reset xStart for the next row
                    }
                    // Define the directory path (example: "C:\\Reports")
                    string directoryPath = @"C:\Users\na1041\Desktop\Nildem_Start_Package\home\IEF_Home\imagesToPDF";

                    // Ensure the directory exists
                    if (!System.IO.Directory.Exists(directoryPath))
                    {
                        System.IO.Directory.CreateDirectory(directoryPath);
                    }

                    // Save the document
                    string dateTime = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                    // Combine directory path and filename
                    string filename = System.IO.Path.Combine(directoryPath, $"iedcValidatorReport_{dateTime}.pdf");
                    document.Save(filename);
                    Console.WriteLine($"PDF file '{filename}' created successfully!");

                    // Open the created PDF (optional)
                    System.Diagnostics.Process.Start(filename);
                }
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