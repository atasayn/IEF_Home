using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GrapeCity.Documents.Pdf;
using System.IO;
using System.Data;
using DocumentFormat.OpenXml.Spreadsheet;
using Microsoft.Office.Interop.Excel;
using DocumentFormat.OpenXml.Office2010.Excel;
using DataTable = System.Data.DataTable;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace IEF_Home
{
    public partial class iedcQuickSearch : System.Web.UI.Page
    {
        private circomodService circo = new circomodService();
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                //Read_Excel(Server.MapPath(@"resources/IEDC_advanced_search_lookupvalues_vMarch2025 (002).xlsx"));
                gvDataType.DataSource = GetData();
                gvDataType.DataBind();
                
            }
        }

        // Declare a DataTable to hold the data
        private DataTable GetData()
        {
            // Create a DataTable to hold the data
            DataTable dt = new DataTable();
            dt.Columns.Add("Data Type");

            // Add rows combining the Category, Subcategory, and Entries into one string
            dt.Rows.Add("Flow (1_F_) by material (1580173 entries)");
            dt.Rows.Add("Flow (1_F_) by product/commodity (1777545 entries)");
            dt.Rows.Add("In-use stock (2_IUS_) by material (11354 entries)");
            dt.Rows.Add("In-use stock (2_IUS_) by product/commodity (97200 entries)");
            dt.Rows.Add("Population (2_P_) by country/region (62856 entries)");
            dt.Rows.Add("Lifetime (3_LT_) by product/commodity (1934 entries)");
            dt.Rows.Add("Material composition (3_MC_) by material (77290 entries)");
            dt.Rows.Add("Material composition (3_MC_) by product/commodity (72061 entries)");
            dt.Rows.Add("Specific energy consumption of products (3_EI_) by product/commodity (496 entries)");
            dt.Rows.Add("Sector splits and other shares (3_SHA_) by chemical element (2834 entries)");
            dt.Rows.Add("Sector splits and other shares (3_SHA_) by material (0 entries)");
            dt.Rows.Add("Yield coefficient (4_PY_) by product/manufacturing process (7245 entries)");
            dt.Rows.Add("Yield coefficient (4_PY_) by material (33 entries)");
            dt.Rows.Add("Process extension (4_PE_) by process (112 entries)");
            dt.Rows.Add("Unit process inventory (4_UPI_) by process (568 entries)");
            dt.Rows.Add("Criticality indicators (6_CR) by chemical element (496 entries)");
            dt.Rows.Add("Criticality indicators (6_CR) by material (4020 entries)");

            return dt;
        }


        protected void OnRowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            dataset_names.DataSource = null;
            dataset_names.DataBind();

            ScriptManager.RegisterStartupScript(this, GetType(), "clearTables", @"
                document.getElementById('dataset-preview').innerHTML = '';
                document.getElementById('dataset-previewInfo').innerHTML = '';
                document.getElementById('hiddentable').innerHTML = '';
                ", true);


            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvDataType, "Select$" + e.Row.RowIndex);
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }
        protected void OnSelectedIndexChanged(object sender, EventArgs e)
        {
            if (gvAspectDiv.Visible == false)
            {
                gvAspectDiv.Visible = true;

            };

            gvDataType.DataSource = GetData();
            gvDataType.DataBind();

            var index = gvDataType.SelectedIndex;
            Read_Aspect_Label(index.ToString());
        }

        protected void OnRowDataBoundAspect(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            dataset_names.DataSource = null;
            dataset_names.DataBind();
            ScriptManager.RegisterStartupScript(this, GetType(), "clearTables", @"
                document.getElementById('dataset-preview').innerHTML = '';
                document.getElementById('dataset-previewInfo').innerHTML = '';
                document.getElementById('hiddentable').innerHTML = '';
                ", true);
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvAspects, "Select$" + e.Row.RowIndex);
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }
        protected void OnSelectedIndexChangedAspect(object sender, EventArgs e)
        {
            // Report Table
            DataTable datasetTable = new DataTable();
            List<string> datasetList = new List<string>();
            if (divDatasetname.Visible == false)
            {
                divDatasetname.Visible = true;

            };
            datasetTable.Columns.Add("Dataset List", typeof(string));

            var index = gvDataType.SelectedIndex;
            var value = gvAspects.SelectedValue?.ToString();

            string sheet = Server.MapPath(@"resources/IEDC_advanced_search_lookupvalues_vMay2025.xlsx");
            var file = new FileInfo(sheet);
            using (var package = new ExcelPackage(file))
            {
                var sheetName = package.Workbook.Worksheets[0];
                string dataType = sheetName.Cells[index + 2, 2].Text;
                datasetList = circo.Dataset_names_quickSearch(dataType, value);
                foreach (var data in datasetList)
                {
                    datasetTable.Rows.Add(data);
                }
                dataset_names.DataSource = datasetTable;
                dataset_names.DataBind();
            }

        }
        protected void dataset_names_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Check if it's a data row (not header or footer)
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Loop through all the cells in the row
                foreach (TableCell cell in e.Row.Cells)
                {
                    // Add a client-side JavaScript click event to each cell
                    cell.Attributes["onclick"] = "cellClicked(this);";
                }
            }
        }


        public void Read_Aspect_Label(string choiceIndex)
        {

            // Report Table
            DataTable dataAspectTable = new DataTable();
            dataAspectTable.Columns.Add("Aspect List", typeof(string));
            // Excel Sheet to read
            string sheet = Server.MapPath(@"resources/IEDC_advanced_search_lookupvalues_vMay2025.xlsx");
            var file = new FileInfo(sheet);
            using (var package = new ExcelPackage(file))
            {
                var sheetName = package.Workbook.Worksheets[0];
                string columnName = "Labels_" + choiceIndex;
                int colIndex = 0;
                // Step 1: Find the column index
                for (int col = 4; col <= sheetName.Dimension.End.Column ; col++)
                {
                    var header = sheetName.Cells[1, col].Text;
                    if (header.Equals(columnName, StringComparison.OrdinalIgnoreCase))
                    {
                        colIndex = col;
                        break;
                    }
                }

                // Step 2: Read values from that column
                for (int row = 2; row <= sheetName.Dimension.End.Row; row++)
                {
                    var value = sheetName.Cells[row, colIndex].Text;
                    if (value == "") break;
                    dataAspectTable.Rows.Add(value);
                    
                }
                
                gvAspects.DataSource = dataAspectTable;
                gvAspects.DataBind();
            }

        }

    }
}