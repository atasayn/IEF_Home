<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" EnableEventValidation="false" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="iedcQuickSearch.aspx.cs" Inherits="IEF_Home.iedcQuickSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script type="text/javascript" src="js/xlsx.core.min.js"></script>
    <script type="text/javascript" src="js/xlsx.full.min.js"></script>
    <script src="js/jquery-1.4.1.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/iedcQuickSearch.js"></script>
    <script src="js/ScrollableGridPlugin_ASP.NetAJAX_3.0.js" type="text/javascript"></script>
    <script src="https://cdn.jsdelivr.net/npm/exceljs/dist/exceljs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
    <script>
        function openDataFilter() {
            const datasetId = document.getElementById('<%= hdnVal.ClientID %>').value;
            console.log(datasetId);
            window.open('https://www.database.industrialecology.uni-freiburg.de/dataFilter.aspx?value=' + encodeURIComponent(datasetId), '_blank');
        }
    </script>
    <style>
        /* ===============================
   GLOBAL
=================================*/

        * {
            box-sizing: border-box;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
 
        }

        .grid-container {
            padding: 20px;
        }

        /* ===============================
   INTRO GRID
=================================*/


        .grid-intro-title p,
        .grid-intro-expl {
            font-size: 14px;
            padding-top: 5px;
        }

        /* ===============================
   DATA AREA
=================================*/

        .grid-item-dataframe,
        .grid-item-dataset {
            width: 100%;
            max-width: 600px;
        }

        .grid-dataset-list {
            padding-top: 30px;
            margin: auto;
        }

        /* ===============================
   TABLE WRAPPER (IMPORTANT)
=================================*/

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        /* ===============================
   TABLE STYLE
=================================*/

        .table-style {
            border-collapse: collapse;
            width: 100%;
            max-width: 100%;
        }

            .table-style th,
            .table-style td {
                border: 1px solid #ddd;
                padding: 8px;
                word-break: break-word;
            }

            .table-style th {
                background-color: #0f8ca7;
                text-align: center;
            }

            .table-style tr:nth-child(even) {
                background-color: #f0f0f0;
            }

        th {
            padding: 5px;
            background: #0f8ca7;
            text-align: center;
        }

        /* ===============================
   CLICK + ACTIVE STATES
=================================*/

        td:hover {
            background-color: #ffc000;
            color: #000000;
            cursor: pointer;
        }

        .active {
            background-color: #ffc000;
        }

        /* ===============================
   SCROLLABLE GRIDVIEW BODIES
=================================*/

        #data-type tbody,
        #aspects tbody,
        #aspectsClass1 tbody,
        #aspectsClass2 tbody,
        #aspectsClass3 tbody {
            display: block;
            height: 400px;
            overflow-y: auto;
        }

        #dataset-list tbody {
            display: block;
            height: 200px;
            overflow-y: auto;
        }

        /* keep headers aligned */
        #data-type thead,
        #aspects thead,
        #aspectsClass1 thead,
        #aspectsClass2 thead,
        #aspectsClass3 thead,
        #dataset-list thead {
            display: table;
            width: 100%;
            table-layout: fixed;
        }

        #data-type tbody tr,
        #aspects tbody tr,
        #dataset-list tbody tr {
            display: table;
            width: 100%;
            table-layout: fixed;
        }

        /* ===============================
   DATASET PREVIEW TABLES
=================================*/

        .grid-dataset-preview,
        .grid-dataset-previewInfo {
            overflow-x: auto;
            padding-top: 20px;
        }

        #dataset-preview,
        #dataset-previewInfo {
            height: 400px;
            display: block;
            width: 100%;
            overflow: auto;
            border-radius: 10px;
        }

            #dataset-preview th,
            #dataset-previewInfo th {
                position: sticky;
                top: 0;
                background: #0f8ca7;
                z-index: 2;
            }

            #dataset-preview td {
                text-align: center;
                vertical-align: middle;
            }

                #dataset-preview td:not(:first-child),
                #dataset-preview th:not(:first-child) {
                    word-break: break-word;
                    white-space: normal;
                }

            #dataset-preview tr:nth-child(even),
            #dataset-list tr:nth-child(even),
            #dataset-previewInfo tr:nth-child(even) {
                background-color: #dddddd;
            }

        /* ===============================
   BUTTONS
=================================*/

        #btnExport,
        #fltrData {
            display: block;
            height: 45px;
            width: 110px;
            margin: 10px auto;
            background: #ffc000;
            border-color: #ffc000;
            border-radius: 10px;
            font-weight: bold;
            font-size: 14px;
        }

        /* ===============================
   LOADER ANIMATION
=================================*/

        @-webkit-keyframes spin {
            0% {
                -webkit-transform: rotate(0deg);
            }

            100% {
                -webkit-transform: rotate(360deg);
            }
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }

        /* ===============================
   HELPERS
=================================*/

        .gray-row {
            background-color: #dddddd;
        }

        .scrollable-container {
            height: 400px;
            width: 100%;
            overflow: auto;
            border: 0;
        }

        /* ===============================
   RESPONSIVE BREAKPOINTS
=================================*/

        /* Tablet */
        @media (max-width: 1100px) {

            .row {
                flex-direction: column;
            }

            .grid-item-dataframe,
            .grid-item-dataset {
                max-width: 100%;
                width: 100%;
                padding-left: 0 !important;
            }
        }

        /* Small tablet */
        @media (max-width: 900px) {

            .grid-intro {
                grid-template-columns: 1fr;
                text-align: center;
            }
        }

        /* Mobile */
        @media (max-width: 600px) {

            h3 {
                font-size: 18px;
            }

            h4 {
                font-size: 15px;
            }

            #btnExport,
            #fltrData {
                width: 100%;
                max-width: 250px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="grid-container">
        <div class="row">
            <div class="grid-intro">
                <div class="col-md-11">
                    <div class="grid-intro-title">
                        <asp:Label ID="lblTitle" runat="server" Text="<h3><b>Industrial Ecology Data Commons (IEDC): Find datasets by data type and main aspect</b></h3>" />
                        <p>
                            The list below shows the most commonly used IEDC data types, together with their different main aspects. 
                            After selecting a combination of data type and aspect from the list below, all labels for this aspect for which the IEDC contains data for the given data type are shown.
                            <br>
                            After searching and selecting a label, all available datasets for this data type that contain data for this label in the given aspect are shown and can be previewed and downloaded.<br>
                            E.g., if you select “Lifetime by product/commodity”, all products for which the IEDC contains lifetime data are shown and can be selected, upon which the list of datasets that contain lifetime data for this product is shown.
                        </p>

                    </div>
                </div>
                <div class="col-md-1" style="padding-top: 20px">
                    <asp:Image ID="iedcLogo" runat="server" CssClass="iedcLogo" ImageUrl="~/resources/iedcLogo23.png" Width="120" />
                </div>



            </div>
        </div>
        <div class="row">
            <asp:UpdatePanel ID="UpdatePanel" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="grid-item-data">
                        <div class="row">
                            <div class="grid-item-dataframe">
                                <asp:GridView ID="gvDataType" runat="server" AutoGenerateColumns="true" CssClass="table-style" ClientIDMode="Static"
                                    OnSelectedIndexChanged="OnSelectedIndexChanged"
                                    OnRowDataBound="OnRowDataBound"
                                    DataKeyNames="Data Type" />

                            </div>
                            <div class="column">
                                <div class="grid-item-dataset" id="gvAspectDiv" runat="server" visible="true" style="padding-left: 10px">
                                    <asp:GridView ID="gvAspects" runat="server" AutoGenerateColumns="true" CssClass="table-style" ClientIDMode="Static"
                                        OnSelectedIndexChanged="OnSelectedIndexChangedAspect"
                                        OnRowDataBound="OnRowDataBoundAspect"
                                        DataKeyNames="Aspect List" />
                                </div>
                                <div class="grid-item-dataset" id="divDatasetname" runat="server" visible="false" style="padding-left: 10px; padding-top: 10px">
                                    <asp:GridView ID="dataset_names" runat="server" AutoGenerateColumns="true" CssClass="table-style" ClientIDMode="Static"
                                        OnRowDataBound="dataset_names_RowDataBound"
                                        DataKeyNames="Dataset List" />
                                </div>


                            </div>
                            <div class="loader" id="loadingIcon" runat="server" style="display: none; margin: 50px" clientidmode="Static">
                                <img src="resources/IEDC_working.gif" style="height: 100px; width: 100px">
                            </div>

                        </div>
                        <div class="row">
                            <div class="grid-dataset-preview" style="display: none; padding-top: 20px">
                                <h3>Preview: sample from selected dataset</h3>
                                <h4>The entry you are looking for may not be shown in this sample but will be included in the download. As an alternative, you can filter this dataset</h4>
                                <%--                            <div class="loader2" style="display: none"></div>--%>
                                <table id="dataset-preview">
                                </table>
                                <table id="hiddentable" style="display: none">
                                </table>
                            </div>
                            <div class="grid-dataset-previewInfo" style="display: none">
                                <h3>Description of selected dataset</h3>
                                <asp:HiddenField ID="hdnVal" runat="server" Value="" />

                                <table id="dataset-previewInfo">
                                </table>
                                <div class="row">
                                    <button id="btnExport" onclick="ExportToExcel('xlsx');" style="display: none" type="button">Download</button>
                                    <button id="fltrData" onclick="openDataFilter();" style="display: none" type="button">Filter Data</button>
                                </div>


                            </div>
                        </div>

                    </div>

                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="gvDataType" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="gvAspects" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </div>



    </div>

    <script>

             function showLoadingIcon() {
                 document.getElementById("loadingIcon").style.display = "block";
             }

             function hideLoadingIcon() {
                 document.getElementById("loadingIcon").style.display = "none";
             }

             function generateTable(data, colCount, maxRows, tbody) {
                 tbody.innerHTML = "";
                 const rows = Math.min(maxRows, Math.floor(data.length / colCount));
                 for (let r = 0; r < rows; r++) {
                     const tr = document.createElement("tr");
                     for (let c = 0; c < colCount; c++) {
                         const td = document.createElement("td");
                         const idx = r * colCount + c;
                         td.textContent = data[idx] !== undefined ? data[idx] : "";
                         tr.appendChild(td);
                     }
                     tbody.appendChild(tr);
                 }
             }

             // Global variables to store full dataset for Excel
             window.fullDatasetForExcel = [];
             window.fullDatasetColumns = [];

             function cellClicked(cell) {
                 showLoadingIcon();
                 var userInputDataPreview = $(cell).text();
                 console.log(userInputDataPreview);
                 $("#dataset-preview").empty();
                 $("#dataset-previewInfo").empty();
                 $(".grid-dataset-preview").css("display", "block");
                 $(".grid-dataset-previewInfo").css("display", "block");

                 $.ajax({
                     type: "POST",
                     url: "/circomodService.svc/iedcDataPreview",
                     data: JSON.stringify({ dataset_name: userInputDataPreview }),
                     dataType: "json",
                     contentType: "application/json; charset=utf-8",
                     success: function (result) {
                         hideLoadingIcon();
                         var res = new Map(result["d"].map(obj => [obj.Key, obj.Value]));
                         var columnNames = Array.from(res.values());
                         var columnTitle = Array.from(res.keys());

                         var ColumnNotNullValues = [...res.values()].filter(array =>
                             array.some(value => value !== null)
                         );
                         var ColumnNotNullKeys = [...res.keys()].filter(key =>
                             res.get(key).some(value => value !== null)
                         );

                         // --- Store full dataset for Excel ---
                         window.fullDatasetForExcel = [];
                         window.fullDatasetColumns = ColumnNotNullKeys.slice(0, -2); // same as preview
                         const maxLength = Math.max(...ColumnNotNullValues.slice(0, -2).map(arr => arr.length));
                         for (let i = 0; i < maxLength; i++) {
                             for (const arr of ColumnNotNullValues.slice(0, -2)) {
                                 window.fullDatasetForExcel.push(arr[i] !== undefined ? arr[i] : null);
                             }
                         }

                         // --- Build preview table (50 rows) ---
                         innerHtml = "<thead><tr>";
                         for (var i = 0; i < ColumnNotNullKeys.slice(0, -2).length; i++) {
                             innerHtml += `<th><div>${ColumnNotNullKeys[i]}</div></th>`;
                         }
                         innerHtml += "</tr></thead><tbody>";
                         $("#dataset-preview").append(innerHtml);

                         document.getElementById("btnExport").style.display = "block";
                         document.getElementById("fltrData").style.display = "block";
                         var tbody = document.querySelector("#dataset-preview tbody ");
                         generateTable(window.fullDatasetForExcel, window.fullDatasetColumns.length, 50, tbody);

                         // --- Dataset info (same as original) ---
                         const headers1 = Array.from($("#dataset-preview th")).map(cell => cell.innerText);
                         $.ajax({
                             type: "POST",
                             url: "circomodService.svc/iedcDatasetPreview",
                             data: `{"dataset_name": "${String(userInputDataPreview)}"}`,
                             dataType: "json",
                             contentType: "application/json; charset=utf-8",
                             success: function (result) {
                                 var res = new Map(result["d"].map(obj => [obj.Key, obj.Value]));
                                 var columnNames = Array.from(res.values());
                                 document.getElementById('<%= hdnVal.ClientID %>').value = columnNames[1][0];

                            for (i = 0; i < columnNames[0].length; i++) {
                                var thead = $("<thead></thead>");
                                var tbody = $("<tbody></tbody>");
                                var tr = $("<tr></tr>");
                                var td1 = $("<th></th>").text(columnNames[0][i]);
                                var td2 = $("<td></td>").text(columnNames[1][i]);
                                tr.append(td1, td2);
                                tbody.append(tr);
                                if (i % 2 === 1) td2.addClass("gray-row");
                                $("#dataset-previewInfo").append(thead, tbody);
                            }

                            var headerMapping = {};
                            headers1.forEach((header, index) => {
                                if (header.startsWith("aspect_")) {
                                    indexTitle = columnNames[0].indexOf(header);
                                    headerMapping[header] = columnNames[1][indexTitle];
                                }
                            });

                            $("#dataset-preview th").each(function () {
                                var headerText = $(this).text();
                                if (headerMapping[headerText]) {
                                    $(this).text(headerText + "\n" + headerMapping[headerText]);
                                }
                            });
                        }
                    });
                }
            });
             }

             // --- Export to Excel ---
             function ExportToExcel() {
                 const workbook = new ExcelJS.Workbook();

                 // --- Sheet1: Dataset Description ---
                 const sheet1 = workbook.addWorksheet('Dataset Description');

                 // KEEP THIS ENTIRE SECTION EXACTLY AS YOUR ORIGINAL CODE
                 sheet1.getColumn(2).width = 40;
                 sheet1.getColumn(3).width = 30;
                 sheet1.getColumn(4).width = 50;

                 sheet1.mergeCells('B2:D2');
                 const titleCell = sheet1.getCell('B2');
                 titleCell.value = 'Dataset Information';
                 titleCell.alignment = { horizontal: 'center', vertical: 'middle', wrapText: true, shrinkToFit: true };
                 titleCell.font = { bold: true };
                 titleCell.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'FFD9D9D9' } };

                 sheet1.getCell('C3').value = 'Dataset descriptors';
                 sheet1.getCell('D3').value = 'Dataset description from IEDC dataset catalogue';
                 sheet1.getCell('C3').font = { bold: true };
                 sheet1.getCell('D3').font = { bold: true };

                 const headerBorderStyle = {
                     top: { style: 'thin', color: { argb: 'FF000000' } },
                     left: { style: 'thin', color: { argb: 'FF000000' } },
                     bottom: { style: 'thin', color: { argb: 'FF000000' } },
                     right: { style: 'thin', color: { argb: 'FF000000' } }
                 };

                 ['B4', 'C4', 'D4'].forEach(cellAddress => {
                     const cell = sheet1.getCell(cellAddress);
                     cell.border = headerBorderStyle;
                     cell.alignment = { wrapText: true, shrinkToFit: true, vertical: 'middle' };
                 });

                 const mergedRegions = [
                     { range: 'B4:B6', text: 'Identification', color: '#F4CCCC' },
                     { range: 'B7:B10', text: 'Grouping', color: '#FCE5CD' },
                     { range: 'B11:B20', text: 'System location: What elements and objects in the system are described?', color: '#FCF2CC' },
                     { range: 'B21:B25', text: 'Description', color: '#D9EAD3' },
                     { range: 'B26:B52', text: 'Data model for this dataset: Aspects, classifications, tuple notation, and semantic strings.', color: '#D0E0E3' },
                     { range: 'B53:B60', text: 'Data access and licence', color: '#C9DAF8' },
                     { range: 'B61:B67', text: 'Data submission, review, and conversion info', color: '#CFE2F3' },
                     { range: 'B68:B72', text: 'Reserve – currently not used.', color: '#EEECE1' }
                 ];

                 function convertColor(hex) {
                     const rgb = hex.replace('#', '');
                     return `FF${rgb.toUpperCase()}`;
                 }

                 mergedRegions.forEach(region => {
                     sheet1.mergeCells(region.range);
                     const cell = sheet1.getCell(region.range.split(":")[0]);
                     cell.value = region.text;
                     cell.alignment = { vertical: 'middle', horizontal: 'center', wrapText: true, shrinkToFit: true };
                     cell.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: convertColor(region.color) } };
                     cell.font = { bold: true };
                 });

                 const table1 = document.getElementById('dataset-previewInfo');
                 const rowOffset = 4;
                 const colOffset = 3;
                 for (let i = 0; i < table1.rows.length; i++) {
                     const row = table1.rows[i];
                     for (let j = 0; j < row.cells.length; j++) {
                         const cell = sheet1.getCell(i + rowOffset, j + colOffset);
                         cell.value = row.cells[j].innerText;
                         cell.alignment = { wrapText: true, shrinkToFit: true, vertical: 'middle' };
                     }
                 }

                 const lastRow = table1.rows.length + rowOffset - 1;
                 const outerBorderStyle = { style: 'thin', color: { argb: 'FF000000' } };
                 for (let i = 3; i <= lastRow; i++) {
                     for (let j = 2; j <= 4; j++) {
                         const cell = sheet1.getCell(i, j);
                         cell.border = {
                             top: i === 3 ? outerBorderStyle : undefined,
                             bottom: i === lastRow ? outerBorderStyle : undefined,
                             left: j === 2 ? outerBorderStyle : undefined,
                             right: j === 4 ? outerBorderStyle : undefined,
                         };
                     }
                 }

                 // --- Sheet2: Data ---
                 const sheet2 = workbook.addWorksheet('Data');

                 const colCount = window.fullDatasetColumns.length;

                 // Add headers
                 window.fullDatasetColumns.forEach((header, j) => {
                     const cell = sheet2.getCell(1, j + 1);
                     cell.value = header;
                     cell.font = { bold: true };
                 });

                 // Add all rows
                 const totalRows = Math.floor(window.fullDatasetForExcel.length / colCount);
                 for (let r = 0; r < totalRows; r++) {
                     for (let c = 0; c < colCount; c++) {
                         const idx = r * colCount + c;
                         sheet2.getCell(r + 2, c + 1).value = window.fullDatasetForExcel[idx];
                     }
                 }

                 // --- Save Excel ---
                 const cellD5 = sheet1.getCell('D5');
                 const text = cellD5.text || cellD5.value || '';
                 const fileName = text ? text + '.xlsx' : 'export.xlsx';

                 workbook.xlsx.writeBuffer().then(buffer => {
                     const blob = new Blob([buffer], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
                     saveAs(blob, fileName);
                 });
             }

             // --- Helper: generateTable for preview ---
             function generateTable(data, colCount, maxRows, tbody) {
                 tbody.innerHTML = "";
                 const rows = Math.min(maxRows, Math.floor(data.length / colCount));
                 for (let r = 0; r < rows; r++) {
                     const tr = document.createElement("tr");
                     for (let c = 0; c < colCount; c++) {
                         const td = document.createElement("td");
                         const idx = r * colCount + c;
                         td.textContent = data[idx] !== undefined ? data[idx] : "";
                         tr.appendChild(td);
                     }
                     tbody.appendChild(tr);
                 }
             }
             var previouslyHighlightedCell = null;

             function highlightCell(cell) {
                 // Reset the previously highlighted cell
                 if (previouslyHighlightedCell) {
                     previouslyHighlightedCell.style.backgroundColor = ''; // or set to the original color if it's not empty string
                 }

                 // Highlight the new cell
                 cell.style.backgroundColor = 'orange';

                 // Update the reference
                 previouslyHighlightedCell = cell;
             }

             // Preserve state and reapply after UpdatePanel request ends
             Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                 var aspectsId = '<%=gvAspects.ClientID %>';
            var datasetId = '<%=dataset_names.ClientID%>';

            // Save scroll + search before rebuilding
            var aspectsDiv = document.querySelector("#header" + aspectsId)?.nextElementSibling;
            if (aspectsDiv) scrollPositions[aspectsId] = aspectsDiv.scrollTop;

            var aspectsSearch = document.querySelector("#header" + aspectsId)?.previousSibling?.querySelector(".table-search-box");
            if (aspectsSearch) searchValues[aspectsId] = aspectsSearch.value.toLowerCase();

            $("#" + aspectsId).Scrollable({
                ScrollHeight: 300,
                IsInUpdatePanel: false
            });

            var datasetDiv = document.querySelector("#header" + datasetId)?.nextElementSibling;
            if (datasetDiv) scrollPositions[datasetId] = datasetDiv.scrollTop;

            $("#" + datasetId).Scrollable({
                ScrollHeight: 300,
                IsInUpdatePanel: false
            });
        });
    </script>
</asp:Content>


