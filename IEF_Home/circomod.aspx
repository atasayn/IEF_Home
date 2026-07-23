<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="circomod.aspx.cs" Inherits="IEF_Home.circomod" %>
<!DOCTYPE html>
<html>
<head>
    <title>Circomod</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link href="/css/bootstrap.css" rel="stylesheet" />
    <link href="/css/master.css" rel="stylesheet" />
    <link rel="icon" type="image/png" href="/resources/IEF_LogoV_23_3-Tab7.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>

        html {
            margin: 0px;
            height: 100%;
            width: 100%;
        }

        body {
            margin: 0px;
            min-width: 100%;
            width: 100%;
            display: grid
        }

        .col-md-8 {
            padding-left: 0;
            /* height: 0px; */
            display: block;
        }

        main {
            background-color: #f2f2f2;
            margin: 6px;
            padding: 0;
        }

        #DataMenu-Recc-GraphType {
            grid-template-columns: 25% 1fr 1fr 1fr;
            grid-template-areas:
                               'info          info                  info                   info'
                               'map           line-graph           line-graph-pop          StackedArea '
                               'country-info  sankeyBaseline       sankeyBaseline          GHG'
                               'control-panel sankeyFullCE         sankeyFullCE            line-graph-bar'
                               'control-panel ECD_Decoupling       ECD_Decoupling          chinaTeaser'
                               '.             energyServiceCascade energyServiceCascade    chinaTeaser'
                               'infoBottom    infoBottom           infoBottom              infoBottom';
            display: grid;
            grid-row-gap: 10px;
            grid-column-gap: 5px;
        }

        p {
            margin: 5px;
            font-size: 13px
        }

        #pageInfo {
            grid-area: info;
            height: auto;
            background: #ffffff;
            border-radius: 5px;
            width: auto;
        }

        #pageInfoBottom {
            grid-area: infoBottom;
            height: auto;
            background: #ffffff;
            border-radius: 5px;
            width: auto;
        }

        #sankeyConfig, #sankeyConfigLower {
            display: grid;
            margin: 5px;
            grid-template-columns: auto auto auto;
            padding: 10px;
            grid-row-gap: 5px;
            grid-column-gap: 5px;
        }

        .center-text {
            display: block;
            text-align: center;
            margin-bottom: 5px;
        }


        #DropDownListSector, #DropDownListMaterial {
            margin-left: 50px;
            width: auto;
            border-radius: 5px;
            background: #F5F5F5
        }


        #RegionName1, #RegionName2, #RegionName3, #RegionName4, #RegionName5 {
            text-align: right;
            clear: both;
            float: inline-end;
            margin-right: 15px;
            font-size: 75%;
            margin: 10px
        }

        #mapArea {
            background: #ffffff;
            height: fit-content;
            border-radius: 10px;
            grid-area: map;
            width: auto;
            position: relative;  /* add this */
            z-index: 1;          /* add this - keeps map above sankey */
            overflow: hidden;    /* add this */

        }

        #Graph1Line {
            display: block;
            position: relative;
            grid-area: line-graph;
            border-radius: 5px;
            width: auto;
            height: 100%;
        }

        #GraphPopulationLine {
            grid-area: line-graph-pop;
            position: relative;
            border-radius: 5px;
            width: auto;
            height: 100%;
        }

        #GraphPopulationBar {
            grid-area: line-graph-bar;
            position: relative;
            border-radius: 5px;
            width: auto;
            height: 100%;
        }

        #GraphStackedArea {
            grid-area: StackedArea;
            position: relative;
            border-radius: 5px;
            width: auto;
            height: 100%
        }

        #GHG {
            grid-area: GHG;
            border-radius: 5px;
            width: auto;
            height: 100%
        }        
        
        #waterfall {
            position: relative;
            border-radius: 5px;
            width: auto;
            height: 100%
        }
        

        #GraphStackedArea h2 {
            margin: auto;
        }

        #ChinaTeaser {
            grid-area: chinaTeaser;
            display: none;
            border-radius: 5px;
            width: auto
        }

        #ChinaTeaser img {
            border-radius: 5px;
            width: auto
        }

        #controlPanel {
            grid-area: control-panel;
            height: auto;
            background: #ffffff;
            border-radius: 5px;
            width: auto;
        }

        #countryInfo {
            grid-area: country-info;
            height: 100%;
            width: auto;
            background: #ffffff;
            border-radius: 5px;
        }

        #pdf {
            height: 50px;
            width: 74px;
            color: #fff;
            border: none;
            border-radius: 10px;
            box-shadow: 0px 0px 2px 2px rgb(0,0,0);
            background-color: #000000;
        }

        .button:hover {
            background-color:#002ead;
            transition: 0.7s;
        }


        body {
            margin: 0;
        }

        canvas {
            max-width: 100%;
            height: auto;
        }

        button {
            float: right;
            margin: 5px;
            pointer-events: auto;
        }


        .button {
            background-color: #04AA6D;
            border: none;
            color: white;
            padding: 5px 23px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            margin: 4px 2px;
            cursor: pointer;
            font-size: 10px;
        }

        #pdfButton {
            margin: 0px;
            width: 85px;
            height: 39px;
            font-size: 15px;
            border-radius: 5px;
        }

        #sankey {
            grid-area: sankeyBaseline;
            padding: 5px;
            border-radius: 5px;
            width: auto;
            min-height: 365px;
            background: #fff;
            text-align: center;
            position: relative;
            overflow: hidden;
/*            pointer-events: none
*/        }

        #sankeyFullCE {
            grid-area: sankeyFullCE;
            padding: 5px;
            border-radius: 5px;
            width: auto;
            min-height: 365px;
            background: #fff;
            text-align: center;
            position: relative;
            overflow: hidden;
/*            pointer-events: none
*/        }

        #energyServiceCascade {
            grid-area: energyServiceCascade
        }

        #ecdDecoupling {
            grid-area: ECD_Decoupling
        }


        .svgMap-map-wrapper {
            background: antiquewhite;
            fill: cornflowerblue;
            border-radius: 5px;
            height: 250px

        }

        .svgMap-country {
            fill: #4a90d9 !important;
            cursor: pointer;
            pointer-events: all !important;
            stroke: #ffffff;
            stroke-width: 0.5px;
            transition: stroke-width 0.1s, stroke 0.1s;
        }

        .svgMap-country.svgMap-selected {
            fill: #34499a !important;
        }

        .svgMap-country:hover {
            stroke: #000000 !important;
            stroke-width: 2px !important;
        }


        #singleCountryImg, #singleCountryImgLower {
            margin: auto;
            height: 30px;
            border: outset;
        }

        .target_svg {
            display: none;
        }

        .visible {
            display: block;
        }

        .anychart-credits {
            position: absolute
        }

        #countryFlag, #scenerioSelect, #sectorSelect, #yearSelect, #strategySelect, #materialSelect {
            width: auto;
            height: 79px;
            border-radius: 5px;
            background: #F5F5F5;
        }

        #countryFlagLower, #scenerioSelectLower, #sectorSelectLower, #yearSelectLower, #strategySelectLower, #materialSelectLower {
            width: auto;
            height: 79px;
            border-radius: 5px;
            background: #F5F5F5;
        }


        #countryFlagSpan, #scenerioSelect span:nth-child(2), #sectorSelect span:nth-child(2), #yearSelect span:nth-child(2), #strategySelect span:nth-child(2), #materialSelect span:nth-child(2) {
            display: flex;
            text-align: center;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top: 10px
        }

        #countryFlagSpanLower, #scenerioSelectLower span:nth-child(2), #sectorSelectLower span:nth-child(2), #yearSelectLower span:nth-child(2), #strategySelectLower span:nth-child(2), #materialSelectLower span:nth-child(2) {
            display: flex;
            text-align: center;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top: 10px
        }

        .loader, .loader1, .loader2, .loader3, .loader4, .loader5, .loader6 {
            border: 16px solid #f3f3f3;
            border-radius: 50%;
            border-top: 16px solid #3498db;
            width: 30px;
            height: 0px;
            -webkit-animation: spin 2s linear infinite; /* Safari */
            animation: spin 2s linear infinite;
            margin: auto;
            position: absolute;
            right: 0
        }



        #GHG > div > div {
            border-radius: 50%;
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

        @media screen and (max-width: 768px) {
            .grid-container {
                display: block;
            }
        }


        .navbar-custom .navbar-nav > .active > a {
            color: #ffffff;
            background-color: #E3AF39;
        }

            .navbar-custom .navbar-nav > li > a:hover,
            .navbar-custom .navbar-nav > li > a:focus,
            .navbar-custom .navbar-nav > .active > a:hover,
            .navbar-custom .navbar-nav > .active > a:focus,
            .navbar-custom .navbar-nav > .open > a {
                text-decoration: none;
                background-color: #E3AF39;
                color: #ffffff;
            }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <link href="css/svgMap.min.css" rel="stylesheet">
<%--    <script src="js/jquery.min.js"></script>--%>
    <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="js/svg-pan-zoom.min.js"></script>
    <script type="text/javascript" src="js/jspdf.min.js"></script>
    <script type="text/javascript" src="js/svgMap/svgmap.min.js"></script>
    <script type="text/javascript" src="js/PDFmaker/jspdf.plugin.autotable.js"></script>
    <script type="text/javascript" src="js/svgMap/svgMap.js"></script>
    <script type="text/javascript" src="js/svgMap/main.min.js"></script>
    <script type="text/javascript" src="js/mapConfig.js"></script>
    <script type="text/javascript" src="js/dropdownMenu.js"></script>
    <script src="js/chart.min.js"></script>
    <script type="text/javascript" src="js/circular_sankey_script.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/lib/d3.min.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/lib/d3.v3.min.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/circular_sankey_lib.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/fileExporter.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/fileUploader.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/custom_map.js"></script>
    <!-- Add this to your HTML file if using CDN -->
    <script src="js/xlsx.full.min.js"></script>
    <script type="text/javascript" src="js/anychart-core.min.js"></script>
    <script type="text/javascript" src="js/anychart-waterfall.min.js"></script>
    <script type="text/javascript" src="js/pdfMaker.js"></script>
    <script type="text/javascript" src="js/canvasjs.min.js"></script>
    <script type="text/javascript" src="js/html2canvas.min.js"></script>
    <!-- Matomo Image Tracker-->
    <img referrerpolicy="no-referrer-when-downgrade" src="https://www.blog.industrialecology.uni-freiburg.de/stats/collect.php?idsite=5&amp;rec=1" style="border:0" alt="" />
    <!-- End Matomo -->
</head>
<body>
<div id="app">
        <form method="post" action="./circomod.aspx" id="form1" runat="server">
            <header>
            <div class="jumbotron" style="background: #34499a; padding: 0; margin-bottom: 0; border-radius: 0;">
                <div class="container-fluid header-row" style="display: flex; align-items: stretch; min-height: clamp(80px, 12vw, 160px); padding: 0;">

                    <!-- IEF Logo panel -->
                    <div class="header-logo-panel" style="background: #34499a; display: flex; align-items: center; justify-content: center; padding: clamp(12px, 2vw, 28px) clamp(20px, 3.5vw, 48px); min-width: clamp(160px, 20vw, 260px); flex-shrink: 0;">
                        <img src="resources/IEF_Logo.png"
                            style="height: clamp(54px, 7.2vw, 99px); width: auto; display: block;">
                    </div>

                    <!-- Title text -->
                    <div class="header-title-panel" style="flex: 1; display: flex; align-items: center; justify-content: center; padding: clamp(12px, 2vw, 36px); min-width: 0;">
                        <div style="text-align: center;">
                            <p style="margin: 0 0 4px 0; font-size: clamp(16px, 2.2vw, 38px); font-weight: 600; color: #ffffff; line-height: 1.3;">
                                Freiburg Open Science Portal
                            </p>
                            <p style="margin: 0 0 4px 0; font-size: clamp(16px, 2.2vw, 38px); font-weight: 600; color: #ffffff; line-height: 1.3;">
                                for Industrial Ecology and Socio-Metabolic Research
                            </p>
                        </div>
                    </div>

                    <!-- Uni Freiburg logo panel -->
                    <div class="header-logo-panel" style="background: #34499a; display: flex; align-items: center; justify-content: center; padding: clamp(12px, 2vw, 32px) clamp(20px, 3.5vw, 48px); min-width: clamp(160px, 20vw, 260px); flex-shrink: 0;">
                        <div style="background: #ffffff; padding: 8px 16px;">
                            <img src="resources/uniFreiburg.png"
                                style="height: clamp(40px, 4.95vw, 73px); width: auto; display: block;">
                        </div>
                    </div>

                </div>
            </div>

            <nav class="navbar navbar-default navbar-custom navbar">
                <div class="container-fluid">
                    <label for="collapsible" class="lbl-toggle">&equiv;</label>
                    <input id="collapsible" class="toggle" type="checkbox">
                    <div class="collapse navbar-collapse" id="myNavbar">
                        <ul class="nav navbar-nav">
                            <li id="liHome" runat="server"><a href="/main">Home</a></li>
                            <li id="liBlog" runat="server"><a href="https://www.blog.industrialecology.uni-freiburg.de" target="_blank">Blog</a></li>
                            <li id="liDatabase" runat="server"><a href="https://www.database.industrialecology.uni-freiburg.de">IEDC Database</a></li>
                            <li id="liModels" runat="server"><a href="/odym-recc">Our Models</a></li>
                            <li id="liTeaching" runat="server"><a href="/teaching">TEACHING: IEooc</a></li>
                            <li id="liCircomod" runat="server"><a href="/circomod">CIRCULAR ECONOMY PROFILES</a></li>
                            <li id="liSankey" runat="server"><a href="https://www.visualisation.industrialecology.uni-freiburg.de">CIRCULAR SANKEY APP</a></li>
                            <li id="liPapers" runat="server"><a href="/iefWorkingPaper">IEF Working Papers</a></li>
                            <li id="liInternal" runat="server"><a href="/internal">Internal</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

        </header>
        <main>
            <div id="DataMenu-Recc-GraphType">
                <div id="pageInfo">
                    <p>
                        Under the EU-funded project CIRCOMOD <a href="https://circomod.eu/" target="_blank">&#128279</a> (circular economy modelling for climate change mitigation), 
            we develop visualisations for the circular economy status and potentials for different regions, sectors, products, and materials. 
            Here, we show and test a visualization dashboard or circular economy profile for different regions and end-use sectors. The dashboard displays results from the RECC scenario model for the circular economy in buildings and vehicles <a href="https://www.industrialecology.uni-freiburg.de/odym-recc" target="_blank">&#128279 </a>. 
                        It is co-developed with our colleagues from the <a href="https://www.hs-pforzheim.de/en/research/research_institutes/inec”"> Institute for Industrial Ecology (INEC) at Pforzheim University of Applied Sciences  </a> as part of the CIRCOMOD project and continuously updated and improved.</p>
                </div>
                <div id="mapArea">
                    <div id="svgMap"></div>
                </div>
                <div id="Graph1Line" style="background-color: #ffffff">
                    <div class="loader1" style="display: none"></div>
                    <canvas id="line-plot1" style="position: absolute"></canvas>
                    <div id="NoDataline-plot1" style="margin:auto; display: none; width: 100%; height: 100%;">
                        <span style="line-height: 2; font-weight: 500; color: black; font-size: 25px; margin: auto">No Data</span>
                    </div>
                </div>
                <div id="GraphPopulationLine" style="background-color: #ffffff">
                    <div class="loader2" style="display: none"></div>
                    <canvas id="line-plot2" style="position: absolute"></canvas>
                    <div id="NoDataline-plot2" style="margin:auto; display: none; width: 100%; height: 100%;">
                        <span style="line-height: 2; font-weight: 500; color: black; font-size: 25px; margin: auto">No Data</span>
                    </div>
                </div>
                <div id="GraphPopulationBar" style="background-color: #ffffff">
                    <div class="loader3" style="display: none"></div>
                    <canvas id="line-plot3" style="position: absolute"></canvas>
                    <div id="NoDataline-plot3" style="margin:auto; display: none; width: 100%; height: 100%;">
                        <span style="line-height: 2; font-weight: 500; color: black; font-size: 25px; margin: auto">No Data</span>
                    </div>
                </div>
                <div id="GraphStackedArea" style="background-color: #ffffff">
                    <div class="loader4" style="display: none"></div>
                    <canvas id="line-plot4" style="position: absolute"></canvas>
                    <div id="NoDataline-plot4" style="margin:auto; display: none; width: 100%; height: 100%;">
                        <span style="line-height: 2; font-weight: 500; color: black; font-size: 25px; margin: auto">No Data</span>
                    </div>
                    <span id="RegionName4" class="label label-danger" style="background-color: #b6dbff; line-height: 2; font-weight: 500; color: black"></span>
                </div>
                <div style="background-color: #ffffff; display:none">
                    <img id="textScreenshot" src="" />
                </div>
                <div id="countryInfo">
                    <p style="margin: 10px"><b>Country Info:</b></p>
                    <span id='countryInfoCountryName' style="margin-left: 50px"></span>
                    <span id='proxyName' style="margin-left: 50px"></span>
                    <p style="margin: 10px">Population:</p>
                    <span id='population' style="margin-left: 50px"></span>
                    <p style="margin: 10px">GDP per capita (current US$):</p>
                    <span id='gdp' style="margin-left: 50px"></span>
                    <p style="margin: 10px">Population Density (people per sq. km of land area):</p>
                    <span id='populationDensity' style="margin-left: 50px"></span>
                    <p id="warningDisplay" class="w3-panel w3-red" style="margin: 20px; display: none"><b>Warning: </b><span id='proxyWarning'></span></p>
                </div>

                <div id="controlPanel">
                    <p style="margin: 10px">
                        <b><label for="DropDownListSector">Sector:</label></b>
                        <button id="pdfButton" class="button" type="button"  onclick="done()" style="">PDF</button>
                    </p>
                    <select id="DropDownListSector" required>
                        <option value="" disabled>Please select sector</option>
                        <option value="Residential building" selected>Residential building</option>
                        <option value="Passenger vehicles">Passenger vehicles</option>
                    </select>
                    <p style="margin: 10px">
                        <b>
                            <label for="DropDownListMaterial">Material:</label></b>
                    </p>
                    <select id="DropDownListMaterial" required>
                        <option value="Steel" selected>Steel</option>
                        <option value="Cement">Cement</option>
                        <option value="Wood">Wood</option>

                    </select>
                    <p style="margin: 10px"><b>Sankey:</b></p>
                    <p style="margin-left: 50px"><b>Upper Sankey Diagram:</b></p>
                    <p style="margin-left: 50px">&#8226 Sankey diagram for steel flows in [selected sector], [selected region], [selected year], SSP2 scenario, standard recycling</p>
                    <p id="steelUpperValue" style="margin-left: 50px">&#8226 Reference flow for final consumption of steel (blue): </p>
                    <p id="GhGUpperValue" style="margin-left: 50px">&#8226 Reference flow for GHG emissions (green):</p>
                    <div id="sankeyConfig">
                        <div id="countryFlag">
                            <span style="margin: 5px;">Country:</span>
                            <img id="singleCountryImg" style="margin-top: 8px; height: 20px">
                            <span id="countryFlagSpan" style="margin-top: 10px;"></span>
                        </div>
                        <div id="scenerioSelect">
                            <span style="margin: 5px;">Scenerio:</span>
                            <span id="scenerioSpan"></span>
                        </div>

                        <div id="sectorSelect">
                            <span style="margin: 5px;">Sector:</span>
                            <span id="sectorSpan"></span>
                        </div>
                        <div id="yearSelect">
                            <span style="margin: 5px;">Year:</span>
                            <span id="yearSpan"></span>
                        </div>
                        <div id="strategySelect">
                            <span style="margin: 5px;">Strategy:</span>
                            <span id="strategySpan"></span>
                        </div>
                        <div id="materialSelect">
                            <span style="margin: 5px;">Material:</span>
                            <span id="materialSpan"></span>
                        </div>

                    </div>
                    <p style="margin-left: 50px"><b>Lower Sankey Diagram:</b></p>
                    <p style="margin-left: 50px">
                        &#8226 Sankey diagram for steel flows in [selected sector], [selected region], [selected year]
                        <text style="color: #ba1a1a">LED scenario, full circular economy.</text>
                    </p>
                    <p id="steelLowerValue" style="margin-left: 50px">&#8226 Reference flow for final consumption of steel (blue): </p>
                    <p id="GhGLowerValue" style="margin-left: 50px">&#8226 Reference flow for GHG emissions (green):</p>
                    <div id="sankeyConfigLower">
                        <div id="countryFlagLower">
                            <span style="margin: 5px;">Country:</span>
                            <img id="singleCountryImgLower" style="margin-top: 8px; height: 20px">
                            <span id="countryFlagSpanLower" style="margin-top: 10px;"></span>
                        </div>
                        <div id="scenerioSelectLower">
                            <span style="margin: 5px;">Scenerio:</span>
                            <span id="scenerioSpanLower"></span>
                        </div>
                        <div id="sectorSelectLower">
                            <span style="margin: 5px;">Sector:</span>
                            <span id="sectorSpanLower"></span>
                        </div>
                        <div id="yearSelectLower">
                            <span style="margin: 5px;">Year:</span>
                            <span id="yearSpanLower"></span>
                        </div>
                        <div id="strategySelectLower">
                            <span style="margin: 5px;">Strategy:</span>
                            <span id="strategySpanLower"></span>
                        </div>
                        <div id="materialSelectLower">
                            <span style="margin: 5px;">Material:</span>
                            <span id="materialSpanLower"></span>
                        </div>
                    </div>
                </div>
                <div style="display: none;">
                    <input type="hidden" id="txtproject_name" value="" />
                    <input type="hidden" id="background_color" value="#FFFFFF" />
                    <input type="hidden" id="node_width" value="40" />
                    <input type="hidden" id="node_height" value="5" />
                    <input type="hidden" id="canvas_width" value="1300" />
                    <input type="hidden" id="canvas_height" value="900" />
                    <input type="hidden" id="unit_name" value="kt" />
                    <input type="hidden" id="font_size" value="12" />
                    <input type="hidden" id="default_node_opacity" value="5" />
                    <input type="hidden" id="flow_width" value="9" />
                    <input type="hidden" id="font_face" value="sans-serif" />
                    <input type="hidden" id="default_flow_opacity" value="5" />
                    <input type="hidden" id="node_border" value="0" />
                    <input type="hidden" id="show_labels" checked />
                    <input type="hidden" id="curvature" value="5" />
                    <input type="hidden" id="txtRemarks" value="" />
                    <input type="hidden" id="font_color" value="#000000" />
                    <textarea id="input_node_data" type="text" rows="8" cols="120" class="form-control">
[Primary Production] [(255,255,255)] [0] [40.00] [51.60] [58] [205]
[Production/Manufacturing] [(121,121,121)] [0] [30.00] [81.70] [291] [205]
[Use Phase] [(161,161,161)] [0] [140.00] [86.00] [585] [156]
[Waste management] [(121,121,121)] [0] [30.00] [38.70] [1009] [205]
[Final Sink] [(255,255,255)] [0] [40.00] [12.90] [1218] [205]
[Re-use] [(0,191,255)] [180] [40.00] [8.60] [727] [340]
[  ] [(0,191,255)] [180] [40.00] [8.60] [624] [340]
[   ] [(0,191,255)] [180] [40.00] [25.80] [1036] [418]
[Secondary Production] [(0,191,255)] [180] [40.00] [25.80] [321] [418]
[ ] [(255,255,255)] [90] [40.00] [25.80] [319] [20]
[    ] [(255,255,255)] [90] [40.00] [25.80] [319] [204]
[     ] [(255,255,255)] [90] [40.00] [25.80] [1036] [20]
[      ] [(255,255,255)] [90] [40.00] [25.80] [1036] [204]
[GHG Emissions (all materials)] [(255,255,255)] [90] [40.00] [25.80] [668] [20]
[       ] [(255,255,255)] [90] [40.00] [25.80] [668] [155]
[         ] [(0,191,255)] [180] [5.00] [4.30] [323] [320]
[Fabrication scrap] [(0,191,255)] [180] [5.00] [4.30] [296] [320]</textarea>

                    <textarea id="input_flow_data" type="text" rows="8" cols="120" class="form-control">    
[Primary Production]  [F_a]  [(0,191,255)] [ab] [Production/Manufacturing]
[Production/Manufacturing]  [F_b]  [(0,191,255)] [ab] [Use Phase]
[Use Phase]  [F_c]  [(0,191,255)] [ab] [Re-use]
[Re-use]  [F_d]  [(0,191,255)] [ab] [  ]
[  ]  [F_e]  [(0,191,255)] [ab] [Use Phase]
[Use Phase]  [F_f]  [(0,191,255)] [ab] [Waste management]
[Waste management]  [F_g]  [(0,191,255)] [ab] [Final Sink]
[Waste management]  [F_h]  [(0,191,255)] [ab] [   ]
[   ]  [F_i]  [(0,191,255)] [ab] [Secondary Production]
[Secondary Production]  [F_j]  [(0,191,255)] [ab] [Production/Manufacturing]
[ ]  [F_k]  [(0,225,141)] [ab] [    ]
[     ]  [F_l]  [(0,225,141)] [ab] [      ]
[GHG Emissions (all materials)]  [F_m]  [(0,225,141)] [ab] [       ]
[Production/Manufacturing]  [F_n]  [(0,191,255)] [ab] [         ]
[         ]  [F_o]  [(0,191,255)] [ab] [Fabrication scrap]
[Fabrication scrap]  [F_p]  [(0,191,255)] [ab] [Production/Manufacturing]</textarea>
                </div>
                <span id="spnOutputMessage" style="display: none"></span>
                <div id="sankey">
                    <div class="loader" style="display: none"></div>
                    <div id="sankeyDivsAll"></div>
                </div>

                <div id="sankeyFullCE">
                    <div class="loader6" style="display: none"></div>
                    <div id="sankeyDivsAllFullCE"></div>
                </div>
                <div id="GHG" style="background-color: #ffffff">
                    <div class="loader5" style="display: none;"></div>
                    <div id="waterfall" >
                    </div>
                </div>
                <div id="ChinaTeaser">
                    <img src="Content/ReccPlots/Buildings_China_LED_CE.png" style="border-radius: 5px; width: auto">
                    <img src="Content/ReccPlots/Buildings_China_SSP2.png" style="border-radius: 5px; width: auto">
                </div>
                <div id="energyServiceCascade">
                    <img id="energyServiceCascadePNG" style="height: 100%; width: auto; border-radius: 5px">
                </div>
                <div id="ecdDecoupling" style="width: auto;">
                    <img id="ecdDecouplingPNG" style="height: 100%; width: auto; border-radius: 5px">
                </div>
                <div id="pageInfoBottom">
                    <h3 style="text-align: center"><b>Background: Circular Economy – Vision for Sustainable Material Cycles</b></h3>
                    <p>The use of biomass, metal ores, and construction minerals is a major driver of environmental destruction and climate impacts of material production. The circular economy is a vision for reducing material use by designing out waste and pollution, keeping products and materials in use for as long as possible, and maximising the recycling of materials and thus contribute to the reduction of environmental impacts of industrial production. The circular economy seeks to create a closed-loop system of production and consumption, where resources are used, reused, and regenerated, and the generation of waste and environmental impacts is minimized.</p>
                    <br />
                    <p>In practice, there are many circular economy strategies to narrow (less material use), slow (longer material use), and close (better recycling) technical material cycles. These strategies include product light-weighting, longevity, and demountability by design, higher yields in fabrication, scrap recovery, and recycling, as well as more efficient use of products.</p>
                    <br />
                    <p>In industrial ecology, we see the circular economy as the central vision for the sustainable use of natural resources and a main driver for the sustainability transformation of the industrial system. At the same time, there is a lot of hot air around the circular economy. Scientific scrutiny is needed to understand which products, business models, incentives, and regulations will effectively decouple human wellbeing from resource use. Industrial ecology research offers a number of important tools, including material flow analysis, life cycle assessment, and scenario modelling of production and consumption, to find out which of the many circular economy strategies are the most promising ones, to estimate their resource savings potential and their economic costs/gains, and to understand how different strategies can be combined effectively to reach multiple sustainable development goals.</p>
                    <br />
                    <p>Check our blog entries on the topic:</p>
                    <p>How will a sustainable circular economy look like? <a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2023/06/01/how-will-a-sustainable-circular-economy-look-like/" target="_blank">Click here to read the blog post </a></p>
                    <p>The Circular Economy: Breakthrough or Distraction?<a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2017/12/15/the-circular-economy-breakthrough-or-distraction/" target="_blank"> Click here to read the blog post</a></p>
                    <p>Wanted: Lead Indicators for the Circular Economy in Organizations<a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2017/10/22/wanted-lead-indicators-for-the-circular-economy-in-organizations/" target="_blank"> Click here to read the blog post</a></p>
                    <p>Growth of in-use stocks: Central obstacle to closing material cycles<a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2017/11/13/growth-of-in-use-stocks-central-obstacle-to-closing-material-cycles/" target="_blank"> Click here to read the blog post</a></p>
                    <p>The lifetime of materials in the techno-sphere<a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2017/10/29/the-lifetime-of-materials-in-the-technosphere/" target="_blank"> Click here to read the blog post</a></p>
                    <br />
                    <p>A circular economic system that reduces material extraction can also reduce GHG emissions from carbon-intensive material production. To understand the climate, policy, and business implications of circular economy and the energy transition combined, an inter-disciplinary scientific assessment is necessary. However, current GHG mitigation models and scenarios that inform climate policymakers do not generally include circular economy (CE) options. They also do not cover the possible synergies of the CE with other societal goals such as the Sustainable Development Goals (SDGs), nor the challenges involved in rearranging value chains and consumer behaviour.</p>
                    <br />
                    <p>CIRCOMOD: circular economy modelling for climate change mitigation</p>
                    <p>The EU-funded project CIRCOMOD (circular economy modelling for climate change mitigation) is the main funding source and research platform for our current circular economy modelling activities. In CIRCOMOD, we develop a new generation of advanced models and scenarios that will assess how CE can reduce future GHGs and material use. The project brings together a unique consortium of leading research teams from different disciplines, including industrial ecology and material flow modelling, process-oriented integrated assessment modelling, and macro-economic modelling. It aims for a breakthrough in integrating CE and GHG mitigation assessments and will provide input to international assessments such as the Intergovernmental Panel on Climate Change (IPCC) and the International Resource Panel (IRP). See the project’s homepage <a href="https://circomod.eu/" target="_blank">&#128279</a> for details!</p>
                </div>
            </div>
        <script>
            // Use let/const to avoid global scope pollution
            function findVisibleDivId() {
                const divs = document.querySelectorAll('[id^="div_svg"]');
                for (let div of divs) {
                    if (div.style.visibility === 'visible') {
                        return div.id;
                    }
                }
                return null;
            }

            function findVisibleDivIdLower() {
                const divs = document.querySelectorAll('[id^="Lowerdiv_svg"]');
                for (let div of divs) {
                    if (div.style.visibility === 'visible') {
                        return div.id;
                    }
                }
                return null;
            }

            function navigateFront() {
                const divsVis = findVisibleDivId();
                if (!divsVis) return;

                const divs = document.querySelectorAll('[id^="div_svg"]');
                const divsEnd = parseInt(divs[divs.length - 1].id.slice(-4));
                const divsCurrent = parseInt(divsVis.slice(-4));

                if (divsCurrent < divsEnd) {
                    const nextId = divsCurrent + 10;

                    // Show next — divs/spans use visibility, value spans use display
                    document.getElementById("div_svg" + nextId).style.visibility = 'visible';
                    document.getElementById("span_svg" + nextId).style.visibility = 'visible';
                    var steelNext = document.getElementById("steelUpper_span" + nextId);
                    var ghgNext = document.getElementById("ghgUpper_span" + nextId);
                    if (steelNext) steelNext.style.display = 'block';
                    if (ghgNext) ghgNext.style.display = 'block';

                    // Hide current
                    document.getElementById("div_svg" + divsCurrent).style.visibility = 'hidden';
                    document.getElementById("span_svg" + divsCurrent).style.visibility = 'hidden';
                    var steelCur = document.getElementById("steelUpper_span" + divsCurrent);
                    var ghgCur = document.getElementById("ghgUpper_span" + divsCurrent);
                    if (steelCur) steelCur.style.display = 'none';
                    if (ghgCur) ghgCur.style.display = 'none';
                }
            }

            function navigateBack() {
                const divsVis = findVisibleDivId();
                if (!divsVis) return;

                const divs = document.querySelectorAll('[id^="div_svg"]');
                const divsStart = parseInt(divs[0].id.slice(-4));
                const divsCurrent = parseInt(divsVis.slice(-4));

                if (divsCurrent > divsStart) {
                    const prevId = divsCurrent - 10;

                    document.getElementById("div_svg" + prevId).style.visibility = 'visible';
                    document.getElementById("span_svg" + prevId).style.visibility = 'visible';
                    var steelPrev = document.getElementById("steelUpper_span" + prevId);
                    var ghgPrev = document.getElementById("ghgUpper_span" + prevId);
                    if (steelPrev) steelPrev.style.display = 'block';
                    if (ghgPrev) ghgPrev.style.display = 'block';

                    document.getElementById("div_svg" + divsCurrent).style.visibility = 'hidden';
                    document.getElementById("span_svg" + divsCurrent).style.visibility = 'hidden';
                    var steelCur = document.getElementById("steelUpper_span" + divsCurrent);
                    var ghgCur = document.getElementById("ghgUpper_span" + divsCurrent);
                    if (steelCur) steelCur.style.display = 'none';
                    if (ghgCur) ghgCur.style.display = 'none';
                }
            }

            function navigateFrontLower() {
                const divsVis = findVisibleDivIdLower();
                if (!divsVis) return;

                const divs = document.querySelectorAll('[id^="Lowerdiv_svg"]');
                const divsEnd = parseInt(divs[divs.length - 1].id.slice(-4));
                const divsCurrent = parseInt(divsVis.slice(-4));

                if (divsCurrent < divsEnd) {
                    const nextId = divsCurrent + 10;

                    document.getElementById("Lowerdiv_svg" + nextId).style.visibility = 'visible';
                    document.getElementById("Lowerspan_svg" + nextId).style.visibility = 'visible';
                    var steelNext = document.getElementById("steelLower_span" + nextId);
                    var ghgNext = document.getElementById("ghgLower_span" + nextId);
                    if (steelNext) steelNext.style.display = 'block';
                    if (ghgNext) ghgNext.style.display = 'block';

                    document.getElementById("Lowerdiv_svg" + divsCurrent).style.visibility = 'hidden';
                    document.getElementById("Lowerspan_svg" + divsCurrent).style.visibility = 'hidden';
                    var steelCur = document.getElementById("steelLower_span" + divsCurrent);
                    var ghgCur = document.getElementById("ghgLower_span" + divsCurrent);
                    if (steelCur) steelCur.style.display = 'none';
                    if (ghgCur) ghgCur.style.display = 'none';
                }
            }

            function navigateBackLower() {
                const divsVis = findVisibleDivIdLower();
                if (!divsVis) return;

                const divs = document.querySelectorAll('[id^="Lowerdiv_svg"]');
                const divsStart = parseInt(divs[0].id.slice(-4));
                const divsCurrent = parseInt(divsVis.slice(-4));

                if (divsCurrent > divsStart) {
                    const prevId = divsCurrent - 10;

                    document.getElementById("Lowerdiv_svg" + prevId).style.visibility = 'visible';
                    document.getElementById("Lowerspan_svg" + prevId).style.visibility = 'visible';
                    var steelPrev = document.getElementById("steelLower_span" + prevId);
                    var ghgPrev = document.getElementById("ghgLower_span" + prevId);
                    if (steelPrev) steelPrev.style.display = 'block';
                    if (ghgPrev) ghgPrev.style.display = 'block';

                    document.getElementById("Lowerdiv_svg" + divsCurrent).style.visibility = 'hidden';
                    document.getElementById("Lowerspan_svg" + divsCurrent).style.visibility = 'hidden';
                    var steelCur = document.getElementById("steelLower_span" + divsCurrent);
                    var ghgCur = document.getElementById("ghgLower_span" + divsCurrent);
                    if (steelCur) steelCur.style.display = 'none';
                    if (ghgCur) ghgCur.style.display = 'none';
                }
            }

            // CHART FUNCTIONS
            function barChart(data, canvasID, region, sector, material) {
                const canvasElement = document.getElementById("NoData" + canvasID);
                const res = new Map(data["d"].map(obj => [obj.Key, obj.Value]));
                const values = [...new Set(Array.from(res.values()))];

                try { Chart.getChart(canvasID)?.destroy(); } catch (e) { }

                if (values.length === 0) {
                    canvasElement.style.display = "flex";
                    return null;
                } else {
                    canvasElement.style.display = "none";
                    return new Chart(document.getElementById(canvasID), {
                        type: 'bar',
                        data: {
                            labels: ["SSP2 Baseline", "Slow+Close", "Narrow + Slow + Close"],
                            datasets: [
                                { label: 'Primary Production', backgroundColor: "#a6cee3", data: [values[0].slice(-1), values[1].slice(-1), values[2].slice(-1)] },
                                { label: 'Secondary Production', backgroundColor: "#1f78b4", data: [values[3].slice(-1), values[4].slice(-1), values[5].slice(-1)] },
                            ],
                        },
                        options: {
                            devicePixelRatio: 2,
                            locale: "fr-CA",
                            plugins: { title: { display: true, text: `Cumulative material production 2020-2060,  [${region}], [${sector}], [${material}]` } },
                            scales: { x: { stacked: true }, y: { stacked: true, title: { display: true, text: 'Mt' } } }
                        }
                    });
                }
            }

            function stackedAreaChart(data, canvasID, region, sector) {
                const canvasElement = document.getElementById("NoData" + canvasID);
                const res = new Map(data["d"].map(obj => [obj.Key, obj.Value]));
                const values = [...new Set(Array.from(res.values()))];

                try { Chart.getChart(canvasID)?.destroy(); } catch (e) { }

                if (values.length === 0) {
                    canvasElement.style.display = "flex";
                    return null;
                } else {
                    canvasElement.style.display = "none";
                    const dataLength = values[0].length;
                    return new Chart(document.getElementById(canvasID), {
                        type: 'line',
                        data: {
                            labels: Array.from({ length: dataLength }, (_, i) => values[4][i]),
                            datasets: [
                                { label: 'Use Phase', borderColor: "#a6611a", backgroundColor: "rgba(166, 97, 26, 0.9)", data: values[0], fill: true },
                                { label: 'Waste Management', borderColor: "#018571", backgroundColor: "rgba(1, 133, 113, 0.9)", data: values[1], fill: true },
                                { label: 'Material Production', borderColor: "#80cdc1", backgroundColor: "rgba(128, 205, 193, 0.9)", data: values[2], fill: true },
                                { label: 'Energy Supply', borderColor: "#dfc27d", backgroundColor: "rgba(223, 194, 125, 0.9)", data: values[3], fill: true },
                            ]
                        },
                        options: {
                            responsive: true,
                            devicePixelRatio: 2,
                            plugins: { title: { display: true, text: `Annual GHG 2020-2060 by process, [${region}], [${sector}], SSP2 Baseline` } },
                            scales: {
                                x: { title: { display: true, text: 'Year' }, grid: { color: "#f2f2f2", lineWidth: 2 } },
                                y: { stacked: true, title: { display: true, text: 'Mt/yr' }, grid: { color: "#f2f2f2" } }
                            }
                        }
                    });
                }
            }
        </script>
        </main>
        <footer>
            <div>
                <a href="/">Home</a>
                <a href="https://www.blog.industrialecology.uni-freiburg.de">Blog</a>
                <!--<a href="research/research">Research</a> &#9679; -->
                <a href="https://www.database.industrialecology.uni-freiburg.de">iedc Database</a>
                <a href="/odym-recc">Our Models</a>
                <a href="/teaching">TEACHING: IEooc</a>
                <a href="/circomod">CIRCULAR ECONOMY PROFILES</a><br />
                <a href="https://www.visualisation.industrialecology.uni-freiburg.de">CIRCULAR SANKEY APP</a>
                <a href="/iefWorkingPaper">IEF Working Papers</a>
                <a href="/internal">Internal</a>
                <a href="/legal">Legal Notes & Privacy</a>
            </div>
            <div>
                <h3>Industrial Ecology <span style="color:#E3AF39">Freiburg 2026</span></h3>
            </div>
        </footer>
    </form>
</div>

</body>
</html>