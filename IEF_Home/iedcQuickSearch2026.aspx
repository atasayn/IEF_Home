<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" EnableEventValidation="false" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="iedcQuickSearch2026.aspx.cs" Inherits="IEF_Home.iedcQuickSearch2026" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">

    <!-- ✅ Modern jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!-- ✅ Scripts (NO defer for WebForms) -->
    <script src="js/iedcQuickSearch.js"></script>
    <script src="js/ScrollableGridPlugin_ASP.NetAJAX_3.0.js"></script>
    <script src="js/FileSaver.min.js"></script>

    <script>
        function openDataFilter() {
            var el = document.getElementById('<%= hdnVal.ClientID %>');

            if (!el || !el.value) {
                console.warn('Dataset ID missing');
                return;
            }

            window.open(
                'https://www.database.industrialecology.uni-freiburg.de/dataFilter.aspx?value='
                + encodeURIComponent(el.value),
                '_blank'
            );
        }
    </script>

    <!-- ✅ ORIGINAL CSS (UNCHANGED) -->
    <style>
        * { box-sizing: border-box; }
        .row { display: flex; flex-wrap: wrap; }
        .grid-container { padding: 20px; }

        .grid-intro-title p, .grid-intro-expl {
            font-size: 14px;
            padding-top: 5px;
        }

        .grid-item-dataframe, .grid-item-dataset {
            width: 100%;
            max-width: 600px;
            padding-bottom: 10px;
            padding-right: 10px;
        }

        .grid-dataset-list {
            padding-top: 30px;
            margin: auto;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        .table-style {
            border-collapse: collapse;
            width: 100%;
            max-width: 100%;
        }

        .table-style th, .table-style td {
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
            color: white;
        }

        td:hover {
            background-color: #ffc000;
            color: #000000;
            cursor: pointer;
        }

        .active {
            background-color: #ffc000;
        }

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

        #dataset-preview tr:nth-child(even),
        #dataset-list tr:nth-child(even),
        #dataset-previewInfo tr:nth-child(even) {
            background-color: #dddddd;
        }

        #btnExport, #fltrData {
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
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <div class="grid-container">
        <div class="row">
            <div class="grid-intro">
                <div class="col-md-11">
                    <div class="grid-intro-title">
                        <asp:Label ID="lblTitle" runat="server"
                            Text="<h3><b>Industrial Ecology Data Commons (IEDC): Find datasets by data type and main aspect</b></h3>" />
                        <p>
                            The list below shows the most commonly used IEDC data types...
                        </p>
                    </div>
                </div>
                <div class="col-md-1" style="padding-top: 20px">
                    <asp:Image ID="iedcLogo" runat="server"
                        ImageUrl="resources/webP/iedcLogo.webp" Width="120" />
                </div>
            </div>
        </div>

        <div class="row">
            <asp:UpdatePanel ID="UpdatePanel" runat="server" UpdateMode="Conditional">
                <ContentTemplate>

                    <asp:GridView ID="gvDataType" runat="server"
                        CssClass="table-style"
                        ClientIDMode="Static"
                        OnSelectedIndexChanged="OnSelectedIndexChanged"
                        OnRowDataBound="OnRowDataBound"
                        DataKeyNames="Data Type" />

                    <asp:GridView ID="gvAspects" runat="server"
                        CssClass="table-style"
                        ClientIDMode="Static"
                        OnSelectedIndexChanged="OnSelectedIndexChangedAspect"
                        OnRowDataBound="OnRowDataBoundAspect"
                        DataKeyNames="Aspect List" />
                    <div id="divDatasetname" runat="server"></div>
                    <div id="gvAspectDiv" runat="server"></div>
                    <asp:GridView ID="dataset_names" runat="server"
                        CssClass="table-style"
                        ClientIDMode="Static"
                        DataKeyNames="Dataset List" />

                    <asp:HiddenField ID="hdnVal" runat="server" />

                    <button id="btnExport" style="display:none" type="button">Download</button>
                    <button id="fltrData" onclick="openDataFilter();" style="display:none" type="button">Filter Data</button>

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

    <!-- ✅ FIXED JS -->
    <script>
        (function () {

            function initializeScrollable(tableId) {
                var $table = $("#" + tableId);
                if (!$table.length) return;
                if ($table.data("scrollable-initialized")) return;

                if (typeof $table.Scrollable === "function") {
                    $table.Scrollable({ ScrollHeight: 300 });
                    $table.data("scrollable-initialized", true);
                }
            }

            function initPage() {
                initializeScrollable('<%=gvAspects.ClientID %>');
                initializeScrollable('<%=dataset_names.ClientID%>');
            }

            $(initPage);

            if (typeof Sys !== "undefined") {
                Sys.WebForms.PageRequestManager.getInstance()
                    .add_endRequest(initPage);
            }

        })();
    </script>

</asp:Content>