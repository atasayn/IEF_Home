<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="iedcValidate.aspx.cs" Inherits="IEF_Home.iedcValidate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
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

        #title {
            text-align: center
        }

        h5 {
            text-align: center
        }

        .upload-button, .message {
            margin-left: 5px;
        }

        .message {
            margin-bottom: auto;
            margin-top: auto;
        }

        .center-caption {
            text-align: center;
        }

            .center-caption th {
                text-align: center;
                background-color: #0f8ca7
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div>
        <h2 id="title">Welcome to the industrial ecology data commons (iedc) data validator!</h2>
        <p style="color: red">This feature is currently under development and will be released in November of 2024</p>
        <p>
            Most iedc datasets have between 1 and 10000 data points and are handled via xlsx spreadsheets. 
            For supplying own data to the iedc via excel spreadsheets, these need to be properly formatted, including a consistent description of the data, 
            sufficient metadata, a proper formatting of the data themselves, and the use of consistent classifications. Two spreadsheet templates and a tutorial video are available:
        </p>
    </div>

    <hr />
    <div class="mb-3">
        <label for="formFile" class="form-label">Validate your data template against the iedc:</label>
        <div class="row">
            <asp:FileUpload ID="FileUpload" class="form-control" runat="server" accept=".xlsx" />
            <asp:Button ID="upload" runat="server" Text="Upload File" CssClass="upload-button btn btn-primary" OnClick="ButtonUpload" />
            <asp:Label ID="lblMessage" runat="server" Text="" CssClass="message"></asp:Label>
        </div>

    </div>
    <hr />
    <div>
        <asp:Label ID="validatingDateAndTime" runat="server" Text=""></asp:Label>
        <div id="section1">
            <p><b>Section 1:</b> Consistent description of the data</p>
            <p id="compareTableSection" style="display: none">
                <b></b> The data match between the Uploaded Excel Sheet and Iedc Database is displayed below on the left table. In case of a non-matching data between two columns, it is marked with the red font. Please check these cells
                in the Uploaded Excel Sheet and replace them with a valid data.  in order to match to the database. In case of a missing cell(s) in the Uploaded Excel Sheet, it is displayed with the red font below on the right table. Please check these cells and replace them with a valid data.
            </p>
            <div class="row" style="row-gap: 20px">
                <div class="column">
                    <asp:GridView ID="compareTable" runat="server" CssClass="center-caption zebra-grid" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="Cell" HeaderText="Cell" HtmlEncode="False" />
                            <asp:BoundField DataField="Uploaded Excel Sheet" HeaderText="Uploaded Excel Sheet" HtmlEncode="False" />
                            <asp:BoundField DataField="Iedc Database" HeaderText="Iedc Database" HtmlEncode="False" />
                        </Columns>
                    </asp:GridView>
                </div>
                <div class="column" style="margin-left: 30px">
                    <asp:GridView ID="missingCellTable" runat="server" CssClass="center-caption zebra-grid" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="Cell" HeaderText="Cell" HtmlEncode="False" />
                            <asp:BoundField DataField="Warning Message" HeaderText="Warning Message" HtmlEncode="False" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <p id="remarksSection" style="display: none;margin-top: 20px">
                <b></b> The detailed description of the cells and their comparison with the iedc database is displayed in Remarks table.Non-matching data is displayed with the red font. Please check these cells and replace them with a valid data.
            </p>
            <div class="row" style="row-gap: 20px">
                <asp:GridView ID="reportView" runat="server" CssClass="center-caption center-caption-remarks zebra-grid" GridLines="Both" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="Cell" HeaderText="Cell" HtmlEncode="False" />
                        <asp:BoundField DataField="Remark" HeaderText="Remarks" HtmlEncode="False" />
                    </Columns>
                </asp:GridView>
            </div>
            <br/>
            <div class="row" style="row-gap: 20px">
                <asp:GridView ID="aspectReportTable" runat="server" CssClass="center-caption center-caption-remarks zebra-grid" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="Cell" HeaderText="Cell" HtmlEncode="False" />
                        <asp:BoundField DataField="Aspect Remarks" HeaderText="Aspect Remarks" HtmlEncode="False" />
                    </Columns>
                </asp:GridView>
            </div>
            <br/>
            <div class="row" style="row-gap: 20px">
                <asp:GridView ID="classificationReportTable" runat="server" CssClass="center-caption center-caption-remarks zebra-grid" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="Cell" HeaderText="Cell" HtmlEncode="False" />
                        <asp:BoundField DataField="Classification Remarks" HeaderText="Classification Remarks" HtmlEncode="False" />
                    </Columns>
                </asp:GridView>
            </div>
            <br/>
            <div class="row" style="row-gap: 20px">
                <asp:GridView ID="dimensionCompareTable" runat="server" CssClass="center-caption center-caption-remarks zebra-grid" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="Aspect Dimension" HeaderText="Aspect Dimension" HtmlEncode="False" />
                        <asp:BoundField DataField="Classificiation Dimension" HeaderText="Classificiation Dimension" HtmlEncode="False" />
                        <asp:BoundField DataField="Dimension Remarks" HeaderText="Dimension Remarks" HtmlEncode="False" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <div id="section2">
            <p><b>Section 2:</b> Sufficient metadata</p>
        </div>
        <div id="section3">
            <p><b>Section 3:</b> Proper formatting of the numerical data</p>
        </div>
        <div id="section4">
            <p><b>Section 4:</b> Use of consistent classifications</p>
        </div>
        <asp:Button ID="ButtonReport" runat="server" Text="Export the report above to pdf" CssClass=" btn btn-primary" OnClick="Report" />
    </div>
    <hr />
    <div class="row">
        <div class="col">
            <label for="formFile" class="form-label">Upload field 2: for PDF xls</label>
            <div class="row">
                <input class="form-control" type="file" id="formFile">
                <input class="btn btn-primary" type="submit" value="Submit" style="margin-left: 5px;">
            </div>

        </div>
    </div>
    <div class="row">
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
    </div>

    <hr />

    <h5>(c) 2024 - Nildem Atasayar and Stefan Pauliuk. For questions and support, contact <a href="in4mation@indecol.uni-freiburg.de">in4mation@indecol.uni-freiburg.de</a></h5>
</asp:Content>

