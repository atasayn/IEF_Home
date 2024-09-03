
using IEF_Home.cls;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;


namespace IEF_Home
{
    public partial class iedcValidate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ButtonUpload(object sender, EventArgs e)
        {
            try
            {
                if (FileUpload.HasFile)
                {


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
                            string htmlContent = $"<h4>On {dateTime}: Parsing and validating dataset {fileName} against the definitions of the iedc.</h4>";
                            validatingDateAndTime.Text = htmlContent;
                            lblMessage.Text = "File uploaded successfully.";
                            lblMessage.ForeColor = System.Drawing.Color.Green;
                            fileChecker.DoesDataExist(filePath, sheetName, compareTable, reportView);
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

                    gfx.DrawString(text, contentFont, XBrushes.Black,
                        new XRect(5, imageHeight + 10, page.Width, 0),
                        XStringFormats.TopCenter);

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


    }

}