<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="iedcValidate.aspx.cs" Inherits="IEF_Home.iedcValidate" EnableViewState="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script type="text/javascript">
        function enforceSingleSelection(checkbox) {
            document.getElementById('<%= simpleSearch.ClientID %>').checked = (checkbox.id === '<%= simpleSearch.ClientID %>') ? checkbox.checked : false;
            document.getElementById('<%= levenshteinSearch.ClientID %>').checked = (checkbox.id === '<%= levenshteinSearch.ClientID %>') ? checkbox.checked : false;
        }
    </script>
    <style>
        .row {
            display: flex;
            flex-wrap: wrap;
        }

        .column {
            flex: 1;
        }

        hr {
            display: block;
            height: 1px;
            border: 0;
            border-top: 1px solid #ccc;
            margin: 1em 0;
            padding: 0;
        }

        .form-control {
            display: block;
            width: auto;
            height: auto;
            padding: 2px;
            font-size: 14px;
            line-height: 1.42857143;
            color: #555;
            background-color: #fff;
            background-image: none;
            border: 1px solid #ccc;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
            -webkit-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
        }

        .title {
            text-align: center
        }

        h5 {
            text-align: center
        }

        .upload-button, .message {
            margin-left: 5px;
            margin-bottom: 5px;
        }

        .message {
            margin-bottom: auto;
            margin-top: auto;
        }

        .checkbox-label input[type="checkbox"]  {
            margin-right: 5px; /* Adjust spacing as needed */
            margin-top: 10px; /* Adjust spacing as needed */
            width: 1.3em;
            height: 1.3em;
            background-color: white;
            border-radius: 50%;
            vertical-align: text-bottom;
            border: 1px solid gray;
            appearance: none;
            -webkit-appearance: none;
            outline: none;
            cursor: pointer;
            position: relative;
        }
        .checkbox-label input[type="checkbox"]:checked {
            background-color: white; /* Keep background white */
            border: 1px solid gray; /* Optional: make border red */
        }
        .checkbox-label input[type="checkbox"]:checked::after {
            content: "";
            width: 0.5em; /* Size of the dot */
            height: 0.5em; /* Size of the dot */
            background-color: red;
            border-radius: 50%;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%); /* Center the dot */
        }

        .center-caption {
            text-align: center;
        }

            .center-caption th {
                text-align: center;
                background-color: #6CB4EE
            }

        .center-caption-remarks {
            text-align: left;
        }

        .caption-bold caption {
            font-weight: bold;
        }

        .zebra-grid tr:nth-child(even) {
            background-color: #ffffff; /* Light gray color for even rows */
        }

        .zebra-grid tr:nth-child(odd) {
            background-color: #dddddd
        }
        .loader {
            border: 16px solid #f3f3f3;
            border-radius: 50%;
            border-top: 16px solid #3498db;
            width: 30px;
            height: 0px;
            -webkit-animation: spin 2s linear infinite; /* Safari */
            animation: spin 2s linear infinite;
        }

        @media only screen and (min-width: 600px) {
            /* For tablets: */
            .column {
                width: 100%;
            }
        }

        @media only screen and (min-width: 768px) {
            /* For desktop: */
            .column {
                width: 100%;
            }
        }
        @-webkit-keyframes spin {
            0% { -webkit-transform: rotate(0deg); }
            100% { -webkit-transform: rotate(360deg); }
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div>
        <h2 class="title">Industrial ecology data commons (IEDC) data template validator </h2>
        <h3 class="title">Validate your data formatting and classifications against a general standard </h3>
        <%--<p style="color: red">This feature is currently under development and will be released in November of 2024</p>--%>
        <p>
            Datasets in industrial ecology and socio-metabolic research typically have between 1 and 10000 data points and are frequently stored in xlsx spreadsheets. The industrial ecology data commons (IEDC) offers a general data model, a set of classifications, 
            and spreadsheet templates to consistently format such data in order to facilitate data updating, archiving, and exchange across projects.
        </p>
        <p>
            The IEDC data model and formatting standard requires datasets to properly formatted, including a consistent description of the data, sufficient metadata, 
            a proper formatting of the data themselves, and the use of consistent classifications.
        </p>
        <p>
            This page provides a web-based tool to validate datasets formatted as spreadsheets against the IEDC data model, data formatting, and classifications. 
            Detailed info on the data model can be found on the (IEDC homepage) [<a href="https://www.database.industrialecology.uni-freiburg.de/" target="_blank">https://www.database.industrialecology.uni-freiburg.de/</a> ].
        </p>
        <p>
            The following material is available: a spreadsheet template for list-shaped data <a href="resources/3_LT_Vehicles_LIST_Sample.xlsx" >3_LT_Vehicles_LIST_Sample.xlsx</a>, a working example for list-shaped data <a href="resources/3_LT_Vehicles_LIST_Sample.xlsx" >3_LT_Vehicles_LIST_Sample.xlsx</a>, 
            and an example for list-based data with multiple errors included <a href="resources/3_LT_Vehicles_LIST_Sample_Errors.xlsx">3_LT_Vehicles_LIST_Sample_Errors.xlsx</a>; 
            a spreadsheet template for table-shaped data <a href="resources/3_MC_VehicleArchetypes_TABLE_Sample.xlsx" >3_MC_VehicleArchetypes_TABLE_Sample.xlsx</a>, a working example for table-shaped data <a href="resources/3_MC_VehicleArchetypes_TABLE_Sample.xlsx" >3_MC_VehicleArchetypes_TABLE_Sample.xlsx</a>, 
            and an example for table-based data with multiple errors included <a href="resources/3_MC_VehicleArchetypes_TABLE_Sample_Errors.xlsx">3_MC_VehicleArchetypes_TABLE_Sample_Errors.xlsx</a>.
        </p>
        <p>A tutorial video (tbd.) shows how to format the data according to the IEDC specifications and how to use the data template validator:</p>
    </div>

    <hr />
    <div class="mb-3">
        <label for="formFile" class="form-label">Upload and validate your data against the IEDC</label>
        
        <div class="row">
            <div class="column">
                <div class="row">
                    <asp:FileUpload ID="FileUpload" class="form-control" runat="server" accept=".xlsx" />
                    <asp:Button ID="upload" runat="server" Text="Upload File" CssClass="upload-button btn btn-primary" OnClick="ButtonUpload" />
                    <asp:Label ID="lblMessage" runat="server" Text="" CssClass="message"></asp:Label>
                    <div class="loader" id="loaderControl" style="display:none" runat="server"></div>
                </div>
                <asp:CheckBox ID="simpleSearch" runat="server" CssClass="checkbox-label" Text="Simple Search" AutoPostBack="false" OnClick="enforceSingleSelection(this)"/>
                <asp:CheckBox ID="levenshteinSearch" runat="server" CssClass="checkbox-label" Text="Levenshtein Search" Checked="True" AutoPostBack="false" OnClick ="enforceSingleSelection(this)"/>
            </div>
       
            <div class="column">
                <asp:Label ID="validatingDateAndTime" runat="server" Text=""></asp:Label>
            </div>

        </div>
    </div>

    <hr />
    <div>
        <div class="row" style="margin-top:20px ">

            <div class="column">
                <asp:GridView ID="templateType" runat="server" CssClass="center-caption zebra-grid" AutoGenerateColumns="False">
                    <columns>
                        <asp:BoundField DataField="Template Type" HeaderText="Template Type" HtmlEncode="False" />
                    </columns>
                </asp:GridView>
            </div>
            <div class="column">
                <asp:GridView ID="dataSheetRowNumber" runat="server" CssClass="center-caption center-caption-remarks zebra-grid"  AutoGenerateColumns="False">
                    <columns>
                        <asp:BoundField DataField="Number of rows with text" HeaderText="Number of rows with text" HtmlEncode="False" />
                    </columns>
                </asp:GridView>
            </div>
            <div class="column" id="columnDiv" runat="server" style="display: none;">
                <asp:BulletedList runat="server" ID="Ok" >
                    <asp:ListItem />
                </asp:BulletedList>

                <asp:BulletedList runat="server" ID="Warning">
                    <asp:ListItem />
                </asp:BulletedList>

                <asp:BulletedList runat="server" ID="Error">
                    <asp:ListItem />

                </asp:BulletedList>
            </div>
        </div>
        <div id="section1">
            <p><b>Section 1: Consistent description of the data</b></p>
            <div id="section1Full" runat="server" style="display: none">
                <p id="compareTableSection" style="display: none">
                    <b></b>The match between the uploaded excel data template and the iedc database is displayed below in the left table. Non-matching data between the two columns are marked in red. Please check these cells in the uploaded excel template and replace them with valid entries. In case of missing information in the uploaded excel template, the corresponding cell is displayed in red font in the right table. Please check these cells and fill them with valid data
                </p>
                <div class="row" style="row-gap: 20px">
                    <div class="column" style="overflow: auto">
                        <ul>
                            <li style="font-size: 1.17em;"> <b>Table 1:</b> Check dataset type and other specifications against iedc standards.</li>
                        </ul>
                        <asp:GridView ID="compareTable" runat="server" CssClass="center-caption center-caption-remarks zebra-grid" AutoGenerateColumns="False">
                            <columns>
                                <asp:BoundField DataField="Cell" HeaderText="Cell" HtmlEncode="False" />
                                <asp:BoundField DataField="Name/Label" HeaderText="Name/label" HtmlEncode="False" />
                                <asp:BoundField DataField="Given Value/Text" HeaderText="Given Value/Text" HtmlEncode="False" />
                                <asp:BoundField DataField="Closest Iedc Match" HeaderText="Closest Iedc Match" HtmlEncode="False" />
                                <asp:BoundField DataField="Validation Report" HeaderText="Validation Report" HtmlEncode="False" />
                            </columns>
                        </asp:GridView>
                    </div>
                </div>
                <div class="row" id="missingCellTableSec" style="display: none" runat="server">
                    <div class="column" style="margin-top: 30px;">
                        <ul>
                            <li style="font-size: 1.17em;">Check sufficient description and metadata</li>
                        </ul>
                        <asp:GridView ID="missingCellTable" runat="server" CssClass="center-caption zebra-grid" AutoGenerateColumns="False">
                            <columns>
                                <asp:BoundField DataField="Cell" HeaderText="Cell" HtmlEncode="False" />
                                <asp:BoundField DataField="Warning Message" HeaderText="Warning Message" HtmlEncode="False" />
                            </columns>
                        </asp:GridView>
                    </div>
                </div>
                <p id="remarksSection" style="display: none; margin-top: 20px">
                </p>
                <br />
                <div class="row">
                    <ul>
                        <li style="font-size: 1.17em;"><b>Table 2:</b> Validation for the data aspects and their classifications.</li>
                    </ul>
                    <asp:GridView ID="aspectReportTable" runat="server" CssClass="center-caption center-caption-remarks zebra-grid" AutoGenerateColumns="False">
                        <columns>
                            <asp:BoundField DataField="Aspect" HeaderText="Aspect" HtmlEncode="False" />
                            <asp:BoundField DataField="Aspect Remarks" HeaderText="Aspect Remarks" HtmlEncode="False" />
                            <asp:BoundField DataField="Classification" HeaderText="Classification" HtmlEncode="False" />
                            <asp:BoundField DataField="Classification Remarks" HeaderText="Classification Remarks" HtmlEncode="False" />
                            <asp:BoundField DataField="Dimension Remarks" HeaderText="Dimension Remarks" HtmlEncode="False" />
                        </columns>
                    </asp:GridView>
                </div>
                <br />
                <div class="row">
                    <asp:GridView ID="dimensionCompareTable" runat="server" CssClass="center-caption center-caption-remarks zebra-grid" AutoGenerateColumns="False">
                        <columns>
                            <asp:BoundField DataField="Aspect Dimension" HeaderText="Aspect Dimension" HtmlEncode="False" />
                            <asp:BoundField DataField="Classificiation Dimension" HeaderText="Classificiation Dimension" HtmlEncode="False" />
                            <asp:BoundField DataField="Dimension Remarks" HeaderText="Dimension Remarks" HtmlEncode="False" />
                        </columns>
                    </asp:GridView>
                </div>
            </div>

        </div>
        <div id="section2">
            <p><b>Section 2: Proper formatting of the numerical data</b></p>
            <div class="row" style="margin-top: 10px;">
                <asp:GridView ID="unitMoniDenomi" runat="server" CssClass="center-caption zebra-grid" AutoGenerateColumns="False">
                    <columns>
                        <asp:BoundField DataField="Cell" HeaderText="Cell" HtmlEncode="False" />
                        <asp:BoundField DataField="Unit name" HeaderText="Unit name" HtmlEncode="False" />
                        <asp:BoundField DataField="Given Value/Text" HeaderText="Given Value/Text" HtmlEncode="False" />
                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" HtmlEncode="False" />
                    </columns>
                </asp:GridView>
            </div>
            <div class="row">
                <div class="column" style="max-width: fit-content;margin-left: auto;margin-right: auto; ">

                    <asp:GridView ID="aspectMatch" runat="server" CssClass="center-caption center-caption-remarks zebra-grid"  AutoGenerateColumns="False" Caption="Table 3: Validation for the aspects on the cells D23-D46 and F12-..">
                    <columns>
                        <asp:BoundField DataField="Aspect (D23-D46)" HeaderText="Aspect (D23-D46)" HtmlEncode="False" />
                        <asp:BoundField DataField="Aspect (F12-..)" HeaderText="Aspect (F12-..)" HtmlEncode="False" />
                    </columns>
                    </asp:GridView>
                </div>
                <div class="column" >
                    <asp:GridView ID="aspectMatchRemarks" runat="server" CssClass="center-caption center-caption-remarks zebra-grid"  AutoGenerateColumns="False">
                        <columns>
                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" HtmlEncode="False" />
                        </columns>
                    </asp:GridView>
                </div>
                </div>
            <div class="row" id="section2Row" style="margin-top: 10px;margin-bottom:10px;display:none" runat="server">
                <div class="column">
                    <ul>
                        <li style="font-size: 1.17em;"><b>Table 4:</b> Validation for the orders of the aspects and data columns </li>
                    </ul>
                    <asp:GridView ID="aspectSequence" runat="server" CssClass="center-caption center-caption-remarks zebra-grid"  AutoGenerateColumns="False">
                        <columns>
                            <asp:BoundField DataField="Given Value/Text" HeaderText="Given Value/Text" HtmlEncode="False" />
                            <asp:BoundField DataField="Expected Order of Values" HeaderText="Expected Order of Values" HtmlEncode="False" />
                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" HtmlEncode="False" />
                        </columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
       
        <div id="section3">
            <p><b>Section 3: Use of consistent classifications</b></p>
            <div class="row" id="section2DataCheck" style="margin-top: 10px;margin-bottom: 10px; display: none;max-height:600px;overflow-y:scroll;" runat="server">
                <div class="column">
                    <ul>
                        <li style="font-size: 1.17em;"><b>Table 5:</b> Validation of the data against IEDC database </li>
                    </ul>
                    <asp:GridView ID="dataSheetMatch" runat="server" CssClass="center-caption center-caption-remarks zebra-grid"  AutoGenerateColumns="False">
                        <columns>
                            <asp:BoundField DataField="Line" HeaderText="Line" HtmlEncode="False" />
                            <asp:BoundField DataField="Aspect" HeaderText="Aspect" HtmlEncode="False" />
                            <asp:BoundField DataField="Given Value/Text" HeaderText="Given Value/Text" HtmlEncode="False" />
                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" HtmlEncode="False" />
                        </columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <asp:Button ID="ButtonReport" runat="server" Text="Export the report above to pdf" CssClass=" btn btn-primary" OnClick="Report" />
    </div>
    <hr />
    <%-- <div class="row">
        <div class="col">
            <label for="formFile" class="form-label">Upload field 2: for PDF xls</label>
            <div class="row">
                <input class="form-control" type="file" id="formFile">
                <input class="btn btn-primary" type="submit" value="Submit" style="margin-left: 5px;">
            </div>

        </div>
    </div>--%>
    <%--  <div class="row">
        <div class="col">
            <label for="formFile" class="form-label">Upload field 2: for PDF report</label>
            <div class="row">
                <input class="form-control" type="file" id="formFile">
                <input class="btn btn-primary" type="submit" value="Submit" style="margin-left: 5px;">
            </div>
            <div class="row">
                <div class="column">
                    <p>Download link: <a href="">iedc data template, spreadsheet, LIST format</a></p>
                    <p>Download link: <a href="">iedc data template, spreadsheet, TABLE format</a></p>
                </div>
                <div class="column">
                    <p>Tutorial video "How to use the iedc data templates and data validator"</p>
                </div>
            </div>

        </div>
    </div>--%>
    <%--<hr />--%>

    <h5>(c) 2024 - Nildem Atasayar and Stefan Pauliuk. For questions and support, contact <a href="in4mation@indecol.uni-freiburg.de">in4mation@indecol.uni-freiburg.de</a></h5>
</asp:Content>

