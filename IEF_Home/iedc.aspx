<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="iedc.aspx.cs" Inherits="IEF_Home.iedc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">

    <script src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/iedcAdvancedData.js"></script>


    <style>
        .grid-container {
            padding: 20px;
            display: grid;
            grid-gap: 30px
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

        .grid-item-data {
            grid-template-columns: 1fr 1fr 1fr;
            display: grid;
        }

        td:hover {
            background-color: #ffc000;
            color: #000000;
            cursor: pointer
        }

        th {
            padding: 5px;
            background: #0f8ca7;
            text-align:center;
        }

        #data-type, #datasets {
            border: 1px solid #0f8ca7;
            border-radius: 10px;
            border-collapse: separate;
            overflow: hidden;
        }

            #aspects th {
                border: 1px solid #000000;
                overflow: hidden;
            }

        tbody {
            display: block;
            height: 400px;
            overflow-y: auto;
        }

        tr:nth-child(even) {
            background-color: #dddddd;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="grid-container">
        <div class="grid-intro">
            <div class="grid-intro-title">
                <h3><b>Industrial Ecology Data Commons (iedc) prototype: Advanced search interface</b></h3>
                <p>This page offers some advanced options to search for data across datasets</p>
                <p>
                    Back to standard interface and iedc homepage<a href="https://www.database.industrialecology.uni-freiburg.de/" target="_blank">
                        <img src="resources/link.png" width="20" height="20" /></a>
                </p>
            </div>
            <div class="grid-intro-logo">
                <img class="iedcLogo" src="resources/iedcLogo23.png " width="200" />
            </div>
            <div class="grid-intro-expl">

                <h3><b>Search for available data within all datasets of a given type</b></h3>
                <p>Data in the iedc are organized into pre-defined (data types) <a href="https://www.database.industrialecology.uni-freiburg.de/datatypes.aspx " target="_blank">[https://www.database.industrialecology.uni-freiburg.de/datatypes.aspx]</a>, such as data for flows, stocks, material composition, or unit process inventories. </p>
                <p>In this interface, you first select a data type, upon which all the different aspects (time, region, material, etc.) used to describe the different datasets for this data type are shown.</p>
                <p>After selecting a specific aspect, the different classification items (specific regions, materials, etc.) for which data are available are listed.</p>
                <p>After selecting one ore more classification items, all available datasets that contain data for this classification item in the given aspect are shown and can be previewed.</p>
                <p>Download is then possible via the main interface.</p>

            </div>


        </div>

        <div class="grid-item-data">

            <div class="grid-item-dataframe">
                <table id="data-type">
                </table>
            </div>

            <div class="grid-item-dataset">
                <table id="datasets">
                </table>
            </div>

            <div class="grid-item-aspects">
                <table id="aspects">
                </table>
            </div>

        </div>



        <div class="grid-item"></div>
        <div class="grid-item"></div>
        <div class="grid-item"></div>
    </div>
</asp:Content>
