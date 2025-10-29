<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="iedc.aspx.cs" Inherits="IEF_Home.iedc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">

    <script src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/iedcAdvancedData.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/exceljs@4.3.0/dist/exceljs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/file-saver@2.0.5/dist/FileSaver.min.js"></script>
    <script type="text/javascript" src="js/xlsx.core.min.js"></script>
    <script type="text/javascript" src="js/xlsx.full.min.js"></script>
    <style>
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


        .grid-item-data {
            grid-template-columns: minmax(auto, 30%) 1fr;
            display: grid;
        }



        .grid-item-dataset {
            grid-template-columns: 1fr 1fr 1fr 1fr;
            display: grid;
            gap: 10px;
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

        #data-type th, #aspects th, #aspectsClass1 th, #aspectsClass2 th, #aspectsClass3 th, #dataset-list th{
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

        #dataset-list{
            border-radius: 10px;
            border-collapse: separate;
            overflow: hidden;
            max-height: 200px;
           
        }

        #data-type tbody, #aspects tbody, #aspectsClass1 tbody, #aspectsClass2 tbody, #aspectsClass3 tbody{
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

        #data-type tr:nth-child(even),#aspects tr:nth-child(even),#dataset-preview tr:nth-child(even), #dataset-list tr:nth-child(even), #dataset-previewInfo tr:nth-child(even) {
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

        #aspects tr, #aspectsClass1 tr, #aspectsClass2 tr, #aspectsClass3 tr{
          display: flex;
          flex-wrap: wrap;
        }

        .loader, .loader2 {

          width: 80px;
          height: 80px;

        }

        /* Safari */
        @-webkit-keyframes spin {
          0% { -webkit-transform: rotate(0deg); }
          100% { -webkit-transform: rotate(360deg); }
        }

        @keyframes spin {
          0% { transform: rotate(0deg); }
          100% { transform: rotate(360deg); }
        }

        .gray-row {
            background-color: #dddddd; /* Change this color to the desired shade of gray */
        }

        input {margin-bottom: 5px; padding: 2px 3px; width: 209px;}
    </style>

    <script>
        $(function () {
            $('#data-type').on('click', 'td', function (e) {

                // Add active class to current td target 
                $('#data-type td').removeClass('active');

                $(this).addClass('active');


            });
        })

        $(function () {
            $('#dataset-list').on('click', 'td', function (e) {

                // Add active class to current td target 
                $('#dataset-list td').removeClass('active');

                $(this).addClass('active');


            });
        })


        function updateRowColors(table) {
            // Reset background colors for all rows
            table.find('tbody tr').css('background-color', '');
            console.log(table)
            table.find('tbody tr:visible').each(function (index) {
                if (index % 2 === 0) {
                    $(this).css('background-color', '#dddddd');
                }
            });

        }
        

    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="grid-container">
        <div class="grid-intro">
            <div class="grid-intro-title">
                <h3><b>Industrial Ecology Data Commons (IEDC): Advanced search interface for up to three aspects simultaneously</b></h3>
                <p>This page offers advanced search options to browse the entire IEDC for data.
                    Back to standard interface and IEDC homepage<a href="https://www.database.industrialecology.uni-freiburg.de/" target="_blank">
                        <img src="resources/link.png" width="20" height="20" /></a>
                </p>
            </div>
            <div class="grid-intro-logo">
                <img class="iedcLogo" src="resources/iedcLogo23.png " width="200" />
            </div>
            <div class="grid-intro-expl">
                <p>The list below shows all IEDC data types. You first select a data type, after which the different aspects (time, region, material, etc.) used to describe the different datasets for this data type are shown.</p>
                <p>After selecting a specific aspect, the different classification items (labels for specific regions, materials, etc.) for which data are available are listed.</p>
                <p>After selecting one ore more labels, all available datasets that contain data for this label in the given aspect are shown and can be previewed.</p>
                <p>Up to three aspects can be selected and filtered at the same time.</p>
                <p>Note that the dropdown list for the labels shows all available labels from the different classifications. That means that for many labels, no data will be available. If you don't find anything here, 
                please check the simpler <a href="https://www.industrialecology.uni-freiburg.de/iedcQuickSearch" target="_blank">search by data type and main aspect</a>. 
                <p>Download is then possible via the download button below and the main interface. Any problem with advanced search? Conctact us via <a>in4mation@indecol.uni-freiburg.de</a></p>

            </div>


        </div>

        <div class="grid-item-data">

            <div class="grid-item-dataframe">
                <table id="data-type">
                </table>


            </div>

            <div class="grid-item-dataset">

                <table id="aspects">

                </table>
                <table id="aspectsClass1">
                </table>
                <table id="aspectsClass2">
                </table>
                <table id="aspectsClass3">
                </table>

            </div>

        </div>

        <div class="grid-dataset-list">
            <img class="loader" src="resources/IEDC_working.gif" style="display:none">       
            <table id="dataset-list">
            </table>

        </div>

        <div class="grid-dataset-preview">
            <img class="loader2" src="resources/IEDC_working.gif" style="display:none">
            <table id="dataset-preview">
            </table>
            <table id="hiddentable" style="display:none">
                
            </table>


        </div>

        <div class="grid-dataset-previewInfo">
            <table id="dataset-previewInfo"></table>
            <button id="btnExport" onclick="ExportToExcel('xlsx');" style="display: none" type="button">Download</button>
        </div>

    </div>
</asp:Content>
