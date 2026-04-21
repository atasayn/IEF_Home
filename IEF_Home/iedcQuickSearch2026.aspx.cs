using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Runtime.InteropServices.ComTypes;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IEF_Home
{
    public partial class iedcQuickSearch2026 : System.Web.UI.Page
    {
        private readonly circomodService circo = new circomodService();

        // ===============================
        // PAGE LOAD
        // ===============================
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDataTypes();
            }
        }

        // ===============================
        // DATA TYPES (STATIC)
        // ===============================
        private void BindDataTypes()
        {
            gvDataType.DataSource = GetData();
            gvDataType.DataBind();
        }

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
        // DATA TYPE ROW BIND
        // ===============================
        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            ClearClientPreview();

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] =
                    Page.ClientScript.GetPostBackClientHyperlink(gvDataType, "Select$" + e.Row.RowIndex);

                e.Row.Attributes["style"] = "cursor:pointer";

                if (e.Row.RowIndex == gvDataType.SelectedIndex)
                    e.Row.BackColor = System.Drawing.Color.Orange;
            }
        }

        protected void OnSelectedIndexChanged(object sender, EventArgs e)
        {
            BindDataTypes();

            int index = gvDataType.SelectedIndex;
            Read_Aspect_Label(index.ToString());
        }

        // ===============================
        // ASPECT ROW BIND
        // ===============================
        protected void OnRowDataBoundAspect(object sender, GridViewRowEventArgs e)
        {
            ClearClientPreview();

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string postback =
                    Page.ClientScript.GetPostBackClientHyperlink(gvAspects, "Select$" + e.Row.RowIndex);

                e.Row.Attributes["onclick"] =
                    $"showLoadingIcon(); setTimeout(function(){{ {postback} }}, 100);";

                e.Row.Attributes["style"] = "cursor:pointer";

                if (e.Row.RowIndex == gvAspects.SelectedIndex)
                    e.Row.BackColor = System.Drawing.Color.Orange;
            }
        }

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

            BindDatasets();
        }

        // ===============================
        // DATASET BIND
        // ===============================
        private void BindDatasets()
        {
            DataTable datasetTable = new DataTable();
            datasetTable.Columns.Add("Dataset List");

            divDatasetname.Visible = true;

            int index = gvDataType.SelectedIndex;
            string value = gvAspects.SelectedValue?.ToString();

            string path = Server.MapPath(@"resources/IEDC_advanced_search_lookupvalues_vJanuary2026.xlsx");

            var datasetList = new List<string>();

            using (var package = new ExcelPackage(new FileInfo(path)))
            {
                var sheet = package.Workbook.Worksheets[0];

                string dataType = sheet.Cells[index + 2, 2].Text;

                datasetList = circo.Dataset_names_quickSearch(dataType, value);
            }

            foreach (var item in datasetList)
                datasetTable.Rows.Add(item);

            dataset_names.DataSource = datasetTable;
            dataset_names.DataBind();
        }

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
        // EXCEL LABEL READER
        // ===============================
        public void Read_Aspect_Label(string choiceIndex)
        {
            gvAspectDiv.Visible = true;

            DataTable dt = new DataTable();
            dt.Columns.Add("Aspect List");

            string path = Server.MapPath(@"resources/IEDC_advanced_search_lookupvalues_vJanuary2026.xlsx");

            using (var package = new ExcelPackage(new FileInfo(path)))
            {
                var sheet = package.Workbook.Worksheets[0];
                string columnName = "Labels_" + choiceIndex;

                int colIndex = FindColumnIndex(sheet, columnName);

                if (colIndex == 0)
                    return;

                for (int row = 2; row <= sheet.Dimension.End.Row; row++)
                {
                    string value = sheet.Cells[row, colIndex].Text;

                    if (string.IsNullOrWhiteSpace(value))
                        break;

                    dt.Rows.Add(value);
                }
            }

            gvAspects.DataSource = dt;
            gvAspects.DataBind();
        }

        // ===============================
        // HELPER
        // ===============================
        private int FindColumnIndex(ExcelWorksheet sheet, string columnName)
        {
            for (int col = 4; col <= sheet.Dimension.End.Column; col++)
            {
                string header = sheet.Cells[1, col].Text;

                if (string.Equals(header, columnName, StringComparison.OrdinalIgnoreCase))
                    return col;
            }

            return 0;
        }

        // ===============================
        // CLEAR UI SAFE
        // ===============================
        private void ClearClientPreview()
        {
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "clearTables",
                @"
                    if(document.getElementById('dataset-preview')) 
                        document.getElementById('dataset-preview').innerHTML = '';

                    if(document.getElementById('dataset-previewInfo')) 
                        document.getElementById('dataset-previewInfo').innerHTML = '';
                ",
                true
            );
        }
    }
}