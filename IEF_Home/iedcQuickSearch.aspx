<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" EnableEventValidation="false" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="iedcQuickSearch.aspx.cs" Inherits="IEF_Home.iedcQuickSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script src="js/jquery-1.4.1.min.js" defer></script>
    <script type="text/javascript" src="js/iedcQuickSearch.js" defer ></script>
    <script src="js/ScrollableGridPlugin_ASP.NetAJAX_3.0.js" type="text/javascript" defer></script>
    <script src="js/exceljs.min.js" defer></script>
    <script src="js/FileSaver.min.js" defer></script>
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
            padding-bottom: 10px;
            padding-right: 10px;
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
                flex-direction: row;
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
                    <asp:Image ID="iedcLogo" runat="server" CssClass="iedcLogo" ImageUrl="resources/webP/iedcLogo.webp" Width="120" />
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

        // ================================
        // Loading icon
        // ================================
        function showLoadingIcon() {
            document.getElementById("loadingIcon").style.display = "block";
        }

        function hideLoadingIcon() {
            document.getElementById("loadingIcon").style.display = "none";
        }

        // ================================
        // Scrollable SAFE INITIALIZATION
        // ================================
        function initializeScrollable(tableId) {

            var $table = $("#" + tableId);

            // ✅ Prevent duplicate initialization
            if ($table.data("scrollable-initialized")) {
                return;
            }

            $table.Scrollable({
                ScrollHeight: 300,
                IsInUpdatePanel: false
            });

            // ✅ Mark as initialized
            $table.data("scrollable-initialized", true);
        }

        // ================================
        // First Page Load
        // ================================
        $(document).ready(function () {

            initializeScrollable('<%=gvAspects.ClientID %>');
        initializeScrollable('<%=dataset_names.ClientID%>');

    });

        // ================================
        // After UpdatePanel Partial Postback
        // ================================
        var prm = Sys.WebForms.PageRequestManager.getInstance();

        prm.add_endRequest(function () {

            initializeScrollable('<%=gvAspects.ClientID %>');
        initializeScrollable('<%=dataset_names.ClientID%>');

    });

        // ================================
        // Dataset Preview Logic
        // ================================

        window.fullDatasetForExcel = [];
        window.fullDatasetColumns = [];

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

        // ================================
        // Highlight selected cell
        // ================================
        var previouslyHighlightedCell = null;

        function highlightCell(cell) {

            if (previouslyHighlightedCell) {
                previouslyHighlightedCell.style.backgroundColor = '';
            }

            cell.style.backgroundColor = 'orange';
            previouslyHighlightedCell = cell;
        }

    </script>
</asp:Content>


