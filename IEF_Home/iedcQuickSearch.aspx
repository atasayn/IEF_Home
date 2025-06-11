<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" EnableEventValidation="false" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="iedcQuickSearch.aspx.cs" Inherits="IEF_Home.iedcQuickSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script type="text/javascript" src="js/xlsx.core.min.js"></script>
    <script type="text/javascript" src="js/xlsx.full.min.js"></script>
    <script src="js/jquery-1.4.1.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/iedcAdvancedData.js"></script>
    <script src="js/ScrollableGridPlugin_ASP.NetAJAX_3.0.js" type="text/javascript"></script>
    <script src="https://cdn.jsdelivr.net/npm/exceljs/dist/exceljs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>

    <style>
        .row {
            display: flex;
            flex-wrap: wrap;
        }

        .grid-container {
            padding: 20px;
            display: grid;
            grid-gap: 15px
        }

        .grid-intro {
            grid-template-columns: auto auto;
            grid-template-columns: auto auto;
            grid-template-rows: auto auto auto;
            display: grid;
        }

        .grid-intro-title p {
            font-size: 14px;
            padding-top: 5px;
        }

        .grid-intro-expl {
            font-size: 14px;
            padding-top: 5px;
        }


        .grid-item-dataframe {
            width: fit-content;
        }


        .grid-item-dataset {
            max-height: 400px;
            width: fit-content;
            width: 600px
        }

        .grid-dataset-list {
            padding-top: 30px;
            margin: auto;
        }

        .grid-dataset-preview {
            margin: auto;
            border-radius: 10px;
            overflow: hidden;
            max-width: 100%
        }

        .grid-dataset-previewInfo {
            margin: auto;
            border-radius: 10px;
            overflow: hidden;
            max-width: 100%;
            padding-top: 20px
        }

        td:hover {
            background-color: #ffc000;
            color: #000000;
            cursor: pointer
        }

        .active {
            background-color: #ffc000;
        }

        #data-type td, #aspects td, #aspectsClass1 td, #aspectsClass2 td, #aspectsClass3 td, #dataset-list td {
            width: 100%
        }

        #data-type th, #aspects th, #aspectsClass1 th, #aspectsClass2 th, #aspectsClass3 th, #dataset-list th {
            width: 100%
        }

        th {
            padding: 5px;
            background: #0f8ca7;
            text-align: center;
        }

        #data-type, #aspects, #aspectsClass1, #aspectsClass2, #aspectsClass3, #dataset-preview, #dataset-previewInfo {
            /*border: 1px solid #0f8ca7;*/
            border-radius: 10px;
            border-collapse: separate;
            overflow: hidden;
            max-height: 400px;
        }


        .table-style {
            border-collapse: collapse;
            width: 100%;
            overflow: hidden;
            max-height: 200px;
        }

            .table-style th, .table-style td {
                border: 1px solid #ddd;
                padding: 8px;
            }

            .table-style th {
                background-color: #0f8ca7;
                text-align: center;
            }

            .table-style tr:nth-child(even) {
                background-color: #f0f0f0; /* Light gray */
            }


        #data-type tbody, #aspects tbody, #aspectsClass1 tbody, #aspectsClass2 tbody, #aspectsClass3 tbody {
            display: block;
            height: 400px;
            overflow-y: auto;
        }

        #dataset-list tbody {
            display: block;
            height: 200px;
            overflow-y: auto;
        }

        #dataset-preview, #dataset-previewInfo {
            height: 400px;
            display: block;
            width: 100%;
            overflow: auto;
        }

            #dataset-preview th, #dataset-previewInfo th {
                position: sticky;
                top: 0;
            }

            #dataset-preview td {
                text-align: center;
                vertical-align: middle;
            }

            #dataset-preview tbody, #dataset-previewInfo tbody {
                max-height: 300px
            }

            #data-type tr:nth-child(even), #aspects tr:nth-child(even), #dataset-preview tr:nth-child(even), #dataset-list tr:nth-child(even), #dataset-previewInfo tr:nth-child(even) {
                background-color: #dddddd;
            }

        #btnExport {
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

        #aspects tr, #aspectsClass1 tr, #aspectsClass2 tr, #aspectsClass3 tr {
            display: flex;
            flex-wrap: wrap;
        }

        .loader, .loader2 {
            border: 16px solid #f3f3f3;
            border-radius: 50%;
            border-top: 16px solid #3498db;
            width: 50px;
            height: 50px;
            -webkit-animation: spin 2s linear infinite; /* Safari */
            animation: spin 2s linear infinite;
        }

        /* Safari */
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

        .gray-row {
            background-color: #dddddd; /* Change this color to the desired shade of gray */
        }

        .scrollable-container {
            height: 400px;
            width: 100%;
            overflow: auto;
            border: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="grid-container">
        <div class="grid-intro">
            <div class="grid-intro-title">
                <asp:Label ID="lblTitle" runat="server" Text="<h3><b>Industrial Ecology Data Commons (IEDC): Quick search by data type</b></h3>" />
                <p>
                    Data in the IEDC are organized into pre-defined data types 
                    <a href="https://www.database.industrialecology.uni-freiburg.de/datatypes.aspx" target="_blank">[https://www.database.industrialecology.uni-freiburg.de/datatypes.aspx]</a>, 
                    such as data for flows, stocks, material composition, or unit process inventories. In this interface, you first select a data type together with a central aspect that is characteristic for this type. 
                    E.g., choose “Lifetime by product”, after which all product (or other central aspect) entries for which this data type is available are shown. 
                    After selecting a product or other central label, all available datasets that contain data for this label in the given aspect are shown and can be previewed and downloaded.
                </p>

            </div>

            <div class="grid-intro-logo">
                <asp:Image ID="iedcLogo" runat="server" CssClass="iedcLogo" ImageUrl="~/resources/iedcLogo23.png" Width="200" />
            </div>

            <div class="grid-intro-expl">
                <!-- Labels and HyperLinks continue... -->
            </div>
        </div>
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
                            <div class="grid-item-dataset" id="divDatasetname" runat="server" visible="false" style="padding-left: 10px;padding-top: 10px">
                                <asp:GridView ID="dataset_names" runat="server" AutoGenerateColumns="true" CssClass="table-style" ClientIDMode="Static"
                                              OnRowDataBound="dataset_names_RowDataBound"
                                              DataKeyNames="Dataset List" />
                            </div>
                        

                        </div>
                        <div class="loader" id="loadingIcon" runat="server" style="display: none;margin:50px" ClientIDMode="Static"></div>
                    </div>
                    <div class="row">
                            <div class="grid-dataset-preview"  style="display: none;padding-top: 20px">
                                <h3>Preview: sample from selected dataset</h3>
                                <h4>The entry you are looking for may not be shown in this sample but will be included in the download</h4>
    <%--                            <div class="loader2" style="display: none"></div>--%>
                                <table id="dataset-preview">
                                </table>
                                <table id="hiddentable" style="display: none">
                                </table>


                            </div>

                            <div class="grid-dataset-previewInfo" style="display: none">
                                <h3>Description of selected dataset</h3>
                                <table id="dataset-previewInfo">
                                </table>
                                <button id="btnExport" onclick="ExportToExcel('xlsx');" style="display: none" type="button">Download</button>
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
    <script>

        function showLoadingIcon() {
            document.getElementById("loadingIcon").style.display = "block";
        }

        function hideLoadingIcon() {
            document.getElementById("loadingIcon").style.display = "none";
        }

        function cellClicked(cell) {
            showLoadingIcon();
            var userInputDataPreview = $(cell).text();
            $("#dataset-preview").empty();
            $("#dataset-previewInfo").empty();
            $("#hiddentable").empty();
            $(".grid-dataset-preview").css("display", "block");
            $(".grid-dataset-previewInfo").css("display", "block");


            //$('.loader2').css("display", "block");
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

                    const maxLength = Math.max(...ColumnNotNullValues.slice(0, -2).map(arr => arr.length));

                    const interleavedArray = [];
                    for (let i = 0; i < maxLength; i++) {
                        for (const arr of ColumnNotNullValues.slice(0, -2)) {
                            if (arr[i] !== undefined) {
                                interleavedArray.push(arr[i] !== undefined ? arr[i] : null);
                            }
                        }
                    }

                    innerHtml = "<thead><tr>";
                    for (var i = 0; i < ColumnNotNullKeys.slice(0, -2).length; i++) {
                        innerHtml += `<th><div>${ColumnNotNullKeys[i]}</div></th>`;
                    }
                    innerHtml += "</tr></thead><tbody>";
                    $("#dataset-preview").append(innerHtml);


                    innerHtml = "<thead><tr>";
                    for (var i = 0; i < columnTitle.slice(0, -2).length; i++) {
                        innerHtml += `<th><div>${columnTitle.slice(0, -2)[i]}</div></th>`;
                    }
                    innerHtml += "</tr></thead><tbody><tr></tr></tbody>";
                    $("#hiddentable").append(innerHtml);


                    document.getElementById("btnExport").style.display = "block";
                    var tbody = document.querySelector("#dataset-preview tbody ");
                    var hiddentabletbody = document.querySelector("#hiddentable tbody");
                    generateTable(interleavedArray, ColumnNotNullKeys.slice(0, -2).length, 50, tbody);

                    generateTable(columnNames.at(-2), columnNames.at(-1).length, columnNames.at(-2).length / columnNames.at(-1).length, hiddentabletbody);
                    // Now, you can retrieve the headers from the #dataset-preview table
                    const headers1 = Array.from($("#dataset-preview th")).map(cell => cell.innerText);

                    // Next, you can proceed to fetch and process the dataset-previewInfo data.
                    $.ajax({
                        type: "POST",
                        url: "circomodService.svc/iedcDatasetPreview",
                        data: `{"dataset_name": "${String(userInputDataPreview)}"}`,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (result) {
                            var res = new Map(result["d"].map(obj => [obj.Key, obj.Value]));
                            var columnNames = Array.from(res.values());
                            for (i = 0; i < columnNames[0].length; i++) {
                                // Create the table

                                var thead = $("<thead></thead>");
                                var tbody = $("<tbody></tbody>");
                                var tr = $("<tr></tr>");

                                // Create the first column (1st td)
                                var td1 = $("<th></th>").text(columnNames[0][i]);

                                // Create the second column (2nd td)
                                var td2 = $("<td></td>").text(columnNames[1][i]);

                                // Append the td elements to the tr
                                tr.append(td1, td2);

                                // Append the tr to the tbody
                                tbody.append(tr);

                                // Add the gray-row class to every second row in the second column
                                if (i % 2 === 1) {
                                    td2.addClass("gray-row");
                                }

                                // Append the thead and tbody to the table
                                $("#dataset-previewInfo").append(thead, tbody);


                            }

                            // Create a mapping of "aspect" headers in the first table to their corresponding values in the second table
                            var headerMapping = {};
                            headers1.forEach((header, index) => {
                                if (header.startsWith("aspect_")) {
                                    indexTitle = columnNames[0].indexOf(header)
                                    headerMapping[header] = columnNames[1][indexTitle];
                                }
                            });

                            // Replace the "aspect" headers in the #dataset-preview table with values from the second table
                            $("#dataset-preview th").each(function () {
                                var headerText = $(this).text();
                                if (headerMapping[headerText]) {
                                    $(this).text(headerText + "\n" + headerMapping[headerText]);
                                }
                            });

                            $("#hiddentable th").each(function () {
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


