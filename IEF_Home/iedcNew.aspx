<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="iedcNew.aspx.cs" Inherits="IEF_Home.iedcNew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
<%--    <script src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/iedcAdvancedData.js"></script>--%>

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
            overflow-y: scroll;
            max-height: 400px;
            width: fit-content;
        }


        .grid-item-dataset {
            overflow-y: scroll;
            max-height: 400px;
            width: fit-content;
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
    </style>

    <script>
        function cellClick(cell) {
            var rowIndex = cell.parentNode.rowIndex - 1; // Includes header rows
            return rowIndex;
        }

    </script>
<%--    <script type="text/javascript" src="js/xlsx.core.min.js"></script>
    <script type="text/javascript" src="js/xlsx.full.min.js"></script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    
    <div class="grid-container">
        <div class="grid-intro">
            <div class="grid-intro-title">
                <asp:Label ID="lblTitle" runat="server" Text="<h3><b>Industrial Ecology Data Commons (IEDC): Advanced search interface</b></h3>" />
                <asp:Label ID="lblIntroText" runat="server" Text="This page offers advanced search options to browse the entire IEDC for data." />

                <p>
                    Back to standard interface and IEDC homepage
                    <asp:HyperLink ID="hlIedc" runat="server" NavigateUrl="https://www.database.industrialecology.uni-freiburg.de/" Target="_blank">
                        <asp:Image ID="imgLink" runat="server" ImageUrl="~/resources/link.png" Width="20" Height="20" />
                    </asp:HyperLink>
                </p>
            </div>

            <div class="grid-intro-logo">
                <asp:Image ID="iedcLogo" runat="server" CssClass="iedcLogo" ImageUrl="~/resources/iedcLogo23.png" Width="200" />
            </div>

            <div class="grid-intro-expl">
                <!-- Labels and HyperLinks continue... -->
            </div>
        </div>
        <asp:ScriptManager ID="ScriptManager" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="grid-item-data">
                    <div class="row">
                        <div class="grid-item-dataframe">
                            <asp:GridView ID="gvDataType" runat="server" AutoGenerateColumns="true" CssClass="table-style"
                                OnSelectedIndexChanged="OnSelectedIndexChanged"
                                OnRowDataBound="OnRowDataBound"
                                          DataKeyNames="Data Type">
                            </asp:GridView>
                        </div>
                        <div class="grid-item-dataset" id="gvAspectDiv" runat="server" visible="false" style="padding-left: 10px">
                            <asp:GridView ID="gvAspects" runat="server" AutoGenerateColumns="true" CssClass="table-style" />
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>


