<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="iedcValidate.aspx.cs" Inherits="IEF_Home.iedcValidate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <style>
        .row {
            display: flex;
            flex-wrap: wrap;
        }

        .column {
            flex: 1;
            min-width: 100px; /* Minimum width to maintain readability */

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

        #submitGap1 + #submitGap2 {
            margin-left: 10px;
        }

        h5 {
            text-align: center
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div>
        <h2>Welcome to the industrial ecology data commons (iedc) data validator!</h2>
        <p>Most iedc datasets have between 1 and 10000 data points and are handled via xlsx spreadsheets. 
            For supplying own data to the iedc via excel spreadsheets, these need to be properly formatted, including a consistent description of the data, 
            sufficient metadata, a proper formatting of the data themselves, and the use of consistent classifications. Two spreadsheet templates and a tutorial video are available: </p>
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
    <hr />
    <div class="mb-3">
        <label for="formFile" class="form-label">Validate your data template against the iedc:</label> 
        <input class="form-control" type="file" id="formFile">
    </div>
    <hr/>
    <div>
        <h3>Data template valiation for [filename.xlsx] (of uploaded file), checked on [date-time].</h3>
        <div id="section1">
            <p><b>Section 1:</b> Consistent description of the data</p>
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
        <button type="button" class="btn btn-primary" data-bs-toggle="button" autocomplete="off">Export the report above to pdf</button>
    </div>
    <hr/>
    <div class="row">
        <div class="col">
            <label for="formFile" class="form-label">Upload field 2: for PDF xls</label>
            <div class="row">
                <input class="form-control" type="file" id="formFile">
                <input class="btn btn-primary" type="submit" value="Submit" style="margin-left:5px;">
            </div>

        </div>
    </div>     
    <div class="row">
        <div class="col">
            <label for="formFile" class="form-label">Upload field 2: for PDF report</label>
            <div class="row">
                <input class="form-control" type="file" id="formFile">
                <input class="btn btn-primary" type="submit" value="Submit" style="margin-left:5px;">
            </div>

        </div>
    </div>       

   <hr/>

    <h5>(c) 2024- Nildem Atasayar and Stefan Pauliuk. For questions and support, contact <a href="in4mation@indecol.uni-freiburg.de">in4mation@indecol.uni-freiburg.de</a></h5>
</asp:Content>

