using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using DataTable = System.Data.DataTable;

namespace IEF_Home
{
    public partial class iedcQuickSearch : System.Web.UI.Page
    {
        private circomodService circo = new circomodService();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Always bind (data is static — safe to rebind)
            gvDataType.DataSource = GetData();
            gvDataType.DataBind();
        }

        // ===============================
        // Master Data Table (Static Data)
        // ===============================
        private DataTable GetData()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Data Type");

            dt.Rows.Add("Flow (1_F_) by material (1581093 data points)");
            dt.Rows.Add("Flow (1_F_) by product/commodity (1804511 data points)");
            dt.Rows.Add("In-use stock (2_IUS_) by material (11354 data points)");
            dt.Rows.Add("In-use stock (2_IUS_) by product/commodity (215564 data points)");
            dt.Rows.Add("Population (2_P_) by country/region (62856 data points)");
            dt.Rows.Add("Lifetime (3_LT_) by product/commodity (2752 daa points)");
            dt.Rows.Add("Material composition (3_MC_) by material (103588 data points)");
            dt.Rows.Add("Material composition (3_MC_) by product/commodity (96205 data points)");
            dt.Rows.Add("Material composition (3_MC_) by type of building and other products (37741 data points)");
            dt.Rows.Add("Specific energy consumption of products (3_EI_) by product/commodity (3311 data points)");
            dt.Rows.Add("Specific energy consumption of products (3_EI_) by type of building and other products (6090 data points)");
            dt.Rows.Add("Sector splits and other shares (3_SHA_) by chemical element (2834 data points)");
            dt.Rows.Add("Sector splits and other shares (3_SHA_) by material (64134 data points)");
            dt.Rows.Add("Market shares and other process shares (4_SHR) by material (272 data points)");
            dt.Rows.Add("Yield coefficient (4_PY_) by product/manufacturing process (7564 data points)");
            dt.Rows.Add("Yield coefficient (4_PY_) by material (1530 data points)");
            dt.Rows.Add("Process extension (4_PE_) by process (112 data points)");
            dt.Rows.Add("Unit process inventory (4_UPI_) by process (939 data points)");
            dt.Rows.Add("Criticality indicators (6_CR) by chemical element (496 data points)");
            dt.Rows.Add("Criticality indicators (6_CR) by material (4434 data points)");

            return dt;
        }

        // ===============================
        // gvDataType Row Bind
        // ===============================
        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            dataset_names.DataSource = null;
            dataset_names.DataBind();

            ScriptManager.RegisterStartupScript(this, GetType(), "clearTables", @"
                document.getElementById('dataset-preview').innerHTML = '';
                document.getElementById('dataset-previewInfo').innerHTML = '';
            ", true);

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] =
                    Page.ClientScript.GetPostBackClientHyperlink(gvDataType, "Select$" + e.Row.RowIndex);

                e.Row.Attributes["style"] = "cursor:pointer";

                if (e.Row.RowIndex == gvDataType.SelectedIndex)
                {
                    e.Row.BackColor = System.Drawing.Color.Orange;
                }
            }
        }

        // ===============================
        // gvDataType Selection
        // ===============================
        protected void OnSelectedIndexChanged(object sender, EventArgs e)
        {
            var index = gvDataType.SelectedIndex;
            // Rebind to refresh highlighting
            gvDataType.DataSource = GetData();
            gvDataType.DataBind();
            Read_Aspect_Label(index.ToString());
        }

        // ===============================
        // gvAspects Row Bind
        // ===============================
        protected void OnRowDataBoundAspect(object sender, GridViewRowEventArgs e)
        {
            dataset_names.DataSource = null;
            dataset_names.DataBind();

            ScriptManager.RegisterStartupScript(this, GetType(), "clearTables", @"
                document.getElementById('dataset-preview').innerHTML = '';
                document.getElementById('dataset-previewInfo').innerHTML = '';
            ", true);

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string postback =
                    Page.ClientScript.GetPostBackClientHyperlink(gvAspects, "Select$" + e.Row.RowIndex);

                string combinedScript =
                    $"showLoadingIcon(); setTimeout(function() {{{postback}}}, 100);";

                e.Row.Attributes["onclick"] = combinedScript;
                e.Row.Attributes["style"] = "cursor:pointer";

                if (e.Row.RowIndex == gvAspects.SelectedIndex)
                {
                    e.Row.BackColor = System.Drawing.Color.Orange;
                }
            }
        }

        // ===============================
        // gvAspects Selection
        // ===============================
        protected void OnSelectedIndexChangedAspect(object sender, EventArgs e)
        {
            Read_Aspect_Label(gvDataType.SelectedIndex.ToString());

            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "hideLoader",
                "hideLoadingIcon();",
                true
            );

            DataTable datasetTable = new DataTable();
            datasetTable.Columns.Add("Dataset List", typeof(string));

            List<string> datasetList = new List<string>();

            if (!divDatasetname.Visible)
                divDatasetname.Visible = true;

            var index = gvDataType.SelectedIndex;
            var value = gvAspects.SelectedValue?.ToString();

            string sheet = Server.MapPath(@"resources/IEDC_advanced_search_lookupvalues_vJanuary2026.xlsx");
            var file = new FileInfo(sheet);

            using (var package = new ExcelPackage(file))
            {
                var sheetName = package.Workbook.Worksheets[0];
                string dataType = sheetName.Cells[index + 2, 2].Text;

                datasetList = circo.Dataset_names_quickSearch(dataType, value);

                foreach (var data in datasetList)
                    datasetTable.Rows.Add(data);
            }

            dataset_names.DataSource = datasetTable;
            dataset_names.DataBind();
        }

        // ===============================
        // dataset_names Row Bind
        // ===============================
        protected void dataset_names_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                foreach (TableCell cell in e.Row.Cells)
                {
                    cell.Attributes["onclick"] =
                        "cellClicked(this); highlightCell(this);";
                }
            }
        }

        // ===============================
        // Read Aspects from Excel
        // ===============================
        public void Read_Aspect_Label(string choiceIndex)
        {
            if (!gvAspectDiv.Visible)
                gvAspectDiv.Visible = true;

            DataTable dataAspectTable = new DataTable();
            dataAspectTable.Columns.Add("Aspect List", typeof(string));

            string sheet = Server.MapPath(@"resources/IEDC_advanced_search_lookupvalues_vJanuary2026.xlsx");
            var file = new FileInfo(sheet);

            using (var package = new ExcelPackage(file))
            {
                var sheetName = package.Workbook.Worksheets[0];
                string columnName = "Labels_" + choiceIndex;
                int colIndex = 0;

                // Find column index
                for (int col = 4; col <= sheetName.Dimension.End.Column; col++)
                {
                    var header = sheetName.Cells[1, col].Text;

                    if (header.Equals(columnName, StringComparison.OrdinalIgnoreCase))
                    {
                        colIndex = col;
                        break;
                    }
                }

                // Read column values
                for (int row = 2; row <= sheetName.Dimension.End.Row; row++)
                {
                    var value = sheetName.Cells[row, colIndex].Text;
                    if (string.IsNullOrEmpty(value))
                        break;

                    dataAspectTable.Rows.Add(value);
                }

                gvAspects.DataSource = dataAspectTable;
                gvAspects.DataBind();
            }
        }
    }
}