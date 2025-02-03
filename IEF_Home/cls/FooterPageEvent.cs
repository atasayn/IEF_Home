using iTextSharp.text.pdf;
using iTextSharp.text;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace IEF_Home.cls
{
    // Custom Page Event Helper to add date in the footer
    public class FooterPageEvent : PdfPageEventHelper
    {
        public override void OnEndPage(PdfWriter writer, Document document)
        {
            base.OnEndPage(writer, document);

            // Get the current date
            string currentDate = "Date Printed: " + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

            // Get the position to place the date at the bottom-left corner
            float x = document.LeftMargin;  // Left margin
            float y = document.BottomMargin - 10; // Bottom margin, adjust for spacing

            // Set up the font for the date text
            Font font = new Font(Font.FontFamily.HELVETICA, 8, Font.NORMAL);

            // Create a Phrase and place it at the specified position
            Phrase footerText = new Phrase(currentDate, font);
            ColumnText.ShowTextAligned(writer.DirectContent, Element.ALIGN_LEFT, footerText, x, y, 0);
        }
    }
}