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
        private const string LookupValuesPath = "resources/IEDC_main_aspect_search_lookupvalues_v_Oct_2026.xlsx";

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

            var file = new FileInfo(Server.MapPath(LookupValuesPath));

            using (var package = new ExcelPackage(file))
            {
                var sheetName = package.Workbook.Worksheets[0];

                for (int row = 2; row <= sheetName.Dimension.End.Row; row++)
                {
                    var label = sheetName.Cells[row, 1].Text;
                    if (string.IsNullOrWhiteSpace(label))
                        break;

                    dt.Rows.Add(label.Trim());
                }
            }

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
            // Rebind to refresh highlighting
            gvDataType.DataSource = GetData();
            gvDataType.DataBind();
            var index = gvDataType.SelectedIndex;

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

            string sheet = Server.MapPath(LookupValuesPath);
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

            string sheet = Server.MapPath(LookupValuesPath);
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