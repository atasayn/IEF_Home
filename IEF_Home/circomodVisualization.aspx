<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="circomodVisualization.aspx.cs" Inherits="IEF_Home.circomodVisualization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">



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
           grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
           display:grid
        }

        body {display: flex; flex-wrap: wrap}

        .flex {
        display: flex; /* displays flex-items (children) inline */
        flex-wrap: wrap; /* enables them to wrap (default: nowrap) */
        /* 16:9 ratio */
        width: 10px;
        height: auto;
        margin: 5px;
        
        }

        .flex > div {
        flex-grow: 1; /* enabled (default: 0); can grow/expand beyond 50% of the parent's width */
        flex-basis: 50%; /* initial width set to 50% because none of the items will be less than that, no matter how many of them */
        border: 1px solid; /* just to see the result better */
        box-sizing: border-box; /* recommended because of the border; otherwise you'd need to use the CSS calc() function: "flex-basis: calc(50% - 2px);" -2px because of the left and right border, which is 1px each; same applies for margins, if you're going to use them, then you also need to use the calc(), e.g.: calc(x% - twice the defined margin) */
        background: #eff0f1;
        }
        main {
            background-color: #f2f2f2;
            margin:6px;
            padding:0;
        }

        #DataMenu-Recc-GraphType {
            grid-template-columns: 25% 25% 25% 25%;
            grid-template-areas:
                'map  line-graph line-graph-pop line-graph-bar '
                'country-info StackedArea Sec-pro Sec-pro'
                'control-panel sankeyConfig sankeyConfig sankeyConfig'
                'control-panel sankey sankey sankey'
                'control-panel chinaTeaser chinaTeaser chinaTeaser'
                'control-panel energyServiceCascade energyServiceCascade energyServiceCascade'
                'control-panel ECD_Decoupling ECD_Decoupling ECD_Decoupling';
            display: grid;
            grid-row-gap: 10px;
            grid-column-gap: 2px;
        }


        #sankeyConfig {
            grid-area: sankeyConfig;
            display: flex
        }

        .center-text {
            display: block;
            text-align: center;
            margin-bottom: 5px;
        }


        #DropDownListSector, #DropDownListMaterial {
            margin-left: 50px;
            width: 300px;
            border-radius:5px;
            background:#F5F5F5
        }


        #RegionName1 {
            text-align: right;
            clear: both;
            float: inline-end;
            margin-right: 15px;
            font-size:75%;
            margin:5px
        }

        #mapArea {
            background: #ffffff;
            height: fit-content;
            border-radius: 10px;
            grid-area: map;
            width:465px

        }
        #Graph1Line {
            display: block;
            grid-area: line-graph;
            border-radius: 5px;
            width: 465px;
            height: 250px;
        }

        #GraphPopulationLine{
            grid-area:line-graph-pop;
            border-radius: 5px;
            width:465px;
        }

        #GraphPopulationBar{
            grid-area:line-graph-bar;
            border-radius: 5px;
            width:465px;
            position:relative;
            display:flex
               
        }

        #GraphPopulationBar h2{
            margin: auto;
        }

        #GraphStackedArea{
            grid-area:StackedArea;
            position:relative;
            border-radius: 5px;
            width:465px;
        }

        #GraphStackedArea h2{
            margin: auto;
        }

        #ChinaTeaser{
            grid-area:chinaTeaser;
            height: 365px;
            display: none;
            border-radius:5px
        }

        #ChinaTeaser img{
            border-radius:5px
        }

        #controlPanel{
            grid-area: control-panel;
            height:250px;
            background:#ffffff;
            border-radius: 5px;
            width:465px;
        }

        #countryInfo{
            grid-area: country-info;
            height:250px;
            width:465px;
            background:#ffffff;
            border-radius: 5px;
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

        #sankey {
            grid-area: sankey;
            display: block;
            padding: 5px;
            border-radius: 5px;
            padding-left: 5px;
            display: block;
            position: relative;
            width: 950px;
            height: 365px;
            background: #fff;
            text-align: center;
            position:relative
        }

        #energyServiceCascade{
            grid-area:energyServiceCascade

        }       
        #ecdDecoupling{
            grid-area:ECD_Decoupling

        }

        #divSelection {
            grid-area: selection;
            display: block ruby;
            width: 950px;
            height: 80px;
            align-items: center;
        }

        .svgMap-map-wrapper {
            background: antiquewhite;
            fill: cornflowerblue;
            border-radius: 5px;
            height:250px
        }

        .svgMap-country {
            cursor: pointer
        }

        .svgMap-map-wrapper .svgMap-country:hover {
            -webkit-tap-highlight-color: #333;
            stroke-width: 1;
        }


        #singleCountryImg {
            display: inline;
            margin-left: 27px
        }

        .target_svg {
            display: none;
        }

        .visible {
            display: block;
        }

        #countryFlag {
            grid-area: countrySel;
            width: 154px;
            height: 79px;
            border-radius: 5px;
            background: #FFF;
        }

        #scenerioSelect {
            grid-area: scenerioSel;
            width: 154px;
            height: 79px;
            border-radius: 5px;
            background: #FFF;
            margin-left: 5px;
        }

        #sectorSelect {
            grid-area: sectorSel;
            width: 154px;
            height: 79px;
            border-radius: 5px;
            background: #FFF;
            margin-left: 5px;
        }

        #yearSelect {
            grid-area: yearSel;
            width: 154px;
            height: 79px;
            border-radius: 5px;
            background: #FFF;
            margin-left: 5px;
        }

        #strategySelect {
            grid-area: strategySel;
            width: 154px;
            height: 79px;
            border-radius: 5px;
            background: #FFF;
            margin-left: 5px;
        }

        #materialSelect {
            grid-area: materialSel;
            width: 154px;
            height: 79px;
            border-radius: 5px;
            background: #FFF;
            margin-left: 5px;
        }

        #scenerioSelect span:nth-child(2), #sectorSelect span:nth-child(2), #yearSelect span:nth-child(2), #strategySelect span:nth-child(2), #materialSelect span:nth-child(2) {
            display: flex;
            text-align: center;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top:10px
        }

        .loader,.loader2,.loader3 {
          border: 16px solid #f3f3f3;
          border-radius: 50%;
          border-top: 16px solid #3498db;
          width: 50px;
          height: 50px;
          -webkit-animation: spin 2s linear infinite; /* Safari */
          animation: spin 2s linear infinite;
          margin: auto;
          top: 0;
          bottom: 0;
          position: absolute;
          left: 0;
          right: 0;
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

        
    </style>

    <link rel="stylesheet" href="css/style.css">
    <link href="https://cdn.jsdelivr.net/gh/StephanWagner/svgMap@v2.7.2/dist/svgMap.min.css" rel="stylesheet">
    <script src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/svg-pan-zoom@3.6.1/dist/svg-pan-zoom.min.js"></script>
    <script type="text/javascript" src="js/svgMap/svgmap.min.js"></script>
    <script type="text/javascript" src="js/svgMap/svgMap.js"></script>
    <script type="text/javascript" src="js/svgMap/main.min.js"></script>
    <script type="text/javascript" src="js/mapConfig.js"></script>
    <script type="text/javascript" src="js/dropdownMenu.js"></script>
    <script type="module" src="js/chart.min.js"></script>
    <script type="text/javascript" src="js/circular_sankey_script.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/lib/d3.min.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/lib/d3.v3.min.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/circular_sankey_lib.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/fileExporter.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/fileUploader.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/custom_map.js"></script>
    <!-- Add this to your HTML file if using CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>
    <script type="text/javascript" src="https://npmcdn.com/chart.js@2.4.0/dist/Chart.bundle.js"></script> 


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <div id="DataMenu-Recc-GraphType">

        <div id="mapArea">
            <div id="svgMap"></div>
        </div>
        
        <div id="Graph1Line" style="background-color: #ffffff">
            <canvas id="line-plot1" style="position:absolute"></canvas>
            <span id="RegionName1" class="label label-danger"></span>
        </div>

         <div id="GraphPopulationLine" style="background-color: #ffffff">
            <canvas id="line-plot2" style="position:absolute"></canvas>
            <span id="RegionName2" class="label label-danger"></span>
        </div>

        <div id="GraphPopulationBar" style="background-color: #ffffff">
            <div class="loader2" style="display:none"></div>
            <canvas id="line-plot3" style="position:absolute"></canvas>
            <h1 id="GraphPopulationBarNoData" style="display:none">No Data</h1>
        </div>

        <div id="GraphStackedArea" style="background-color: #ffffff">
            <div class="loader3" style="display:none"></div>
            <canvas id="line-plot4" style="position:absolute"></canvas>
           <h1 id="GraphStackedAreaNoData" style="display:none">No Data</h1>
        </div>

        <div id ="countryInfo">
           <p style="margin:10px"><b>Country Info:</b></p>
           <p style="margin:10px">Population:</p>
            <span id='gdp' style="margin-left:50px"></span>
            <p style="margin:10px">GDP per capita (current US$):</p>
            <span id='population' style="margin-left:50px"></span>
            <p style="margin:10px">Population Density (people per sq. km of land area):</p>
            <span id='populationDensity' style="margin-left:50px"></span>
     
        </div>

        <div id="controlPanel">
            <p style="margin:10px"><b>Sector:</b></p>               
            <select id="DropDownListSector" required>
                <option value="" disabled selected>Please select sector</option>
                <option value="Residential building">Residential building</option>
                <option value="Passenger vehicles">Passenger vehicles</option>
            </select>

            <p style="margin:10px"><b>Material:</b></p>               
            <select id="DropDownListMaterial" required>
                
            </select>
            <p  class="w3-panel w3-red" style="margin:20px"><span id='proxyWarning'></span></p>
        </div>

        <div id="sankeyConfig">
            <div id="countryFlag">
                <span style="margin: 5px;">Country:</span>
                <br />
                <img id="singleCountryImg" style="margin-top:8px;margin-left: 35px;height:25px">
                <span id="countryFlagSpan" style="margin-top:10px;"></span>

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
[Fabrication scrap] [(0,191,255)] [180] [5.00] [4.30] [296] [320]


</textarea>

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
[Fabrication scrap]  [F_p]  [(0,191,255)] [ab] [Production/Manufacturing]





     </textarea>
        </div>

        <span id="spnOutputMessage" style="display: none"></span>
        <div id="sankey">
           <div class="loader" style="display:none"></div>
           <div id="sankeyDivsAll"></div>
        </div>
        <div id="ChinaTeaser" >
            <img src="Content/ReccPlots/Buildings_China_LED_CE.png" width="800" style="height: 100%; width: auto; border-radius:5px" >  
            <img src="Content/ReccPlots/Buildings_China_SSP2.png" width="800" style="height: 100%; width: auto;border-radius:5px" > 
        </div>
        <div id="energyServiceCascade" >
            <img id="energyServiceCascadePNG" width:"700" style="height: 100%; width: auto; border-radius:5px"> 
        </div>   
        <div id="ecdDecoupling" style="width: 900px;" >
            <img id="ecdDecouplingPNG" style="height: 100%; width: auto; border-radius:5px"> 
        </div>

</div>
    <script>


        function findVisibleDivId() {
            // Get all div elements with id starting with "div_svg"
            var divs = document.querySelectorAll('[id^="div_svg"]');
            
            // Iterate through the divs
            for (var i = 0; i < divs.length; i++) {
                // Check if the div is visible
                if (divs[i].style.visibility === 'visible') {
                    // Return the id of the visible div
                    divsVis = divs[i].id
                    return divsVis;

                }
            }

        }


        function navigateFront() {
            findVisibleDivId();
            var divs = document.querySelectorAll('[id^="div_svg"]');
            divsStart = divs[0].id.slice(-4);
            divsEnd = divs[divs.length - 1].id.slice(-4);
            divsCurrent = divsVis.slice(-4);
            if (divsVis && divsCurrent < divsEnd) {
                document.getElementById("div_svg" + (parseInt(divsVis.slice(-4)) + 10)).style.visibility = 'visible';
                document.getElementById("span_svg" + (parseInt(divsVis.slice(-4)) + 10)).style.visibility = 'visible';
                document.getElementById("div_svg" + divsVis.slice(-4)).style.visibility = 'hidden';
                document.getElementById("span_svg" + divsVis.slice(-4)).style.visibility = 'hidden';
            }
        }

        function navigateBack() {
            findVisibleDivId();
            var divs = document.querySelectorAll('[id^="div_svg"]');
            divsStart = divs[0].id.slice(-4);
            divsEnd = divs[divs.length - 1].id.slice(-4);
            divsCurrent = divsVis.slice(-4);
            console.log(divsCurrent)
            if (divsVis && divsCurrent > divsStart) {
                document.getElementById("div_svg" + (divsVis.slice(-4) - 10)).style.visibility = 'visible';
                document.getElementById("span_svg" + (divsVis.slice(-4) - 10)).style.visibility = 'visible';
                document.getElementById("div_svg" + divsVis.slice(-4)).style.visibility = 'hidden';
                document.getElementById("span_svg" + divsVis.slice(-4)).style.visibility = 'hidden';
            }
        }




        function barChart(data, canvasID) {  
            var res = new Map(data["d"].map(obj => [obj.Key, obj.Value]));
            var values = [...new Set(Array.from(res.values()))];
            if (values.length == 0) {
                BarHide.style.display = "block"
            } 
            try {
                Chart.getChart(canvasID).destroy();
            } catch (e) { }
            new Chart(document.getElementById(canvasID), {

                type: 'bar',
                data: {
                    labels: ["SSP2 + Baseline", "SSP2 + Full CE", "LED + Full CE"],
                    datasets: [{
                        label: 'Primary Production',
                        backgroundColor: "blue",
                        data: [values[0].slice(-1), values[1].slice(-1), values[2].slice(-1)]
                    }, {
                        label: 'Secondary Production',
                        backgroundColor: "green",
                        data: [values[3].slice(-1), values[4].slice(-1), values[5].slice(-1)]
                    }],
                },
                options: {
                    locale: "fr-CA",
                    plugins: {
                        title: {
                            display: true,
                            text: 'Production between 2020-2060'
                        },
                    },
                    scales: {
                        x: {
                            stacked: true,
                        },
                        y: {
                            stacked: true,
                            title: {
                                display: true,
                                text: 'Tg/year',

                            },
                        }
                    }
                }

            });
        };
        
        function stackedAreaChart(data, canvasID) {   
            var BarHide = document.getElementById("GraphStackedAreaNoData")
            BarHide.style.display = "none"
            var res = new Map(data["d"].map(obj => [obj.Key, obj.Value]));
            var values = [...new Set(Array.from(res.values()))];
            var dataLength = values[0].length;
            console.log(values)
            
            if (dataLength == 0) {       
                BarHide.style.display = "block"
            } 
            try {
                Chart.getChart(canvasID).destroy();
            } catch (e) { }
            new Chart(document.getElementById(canvasID), {
                type: 'line',
                data: {
                    labels: Array.from({ length: dataLength }, (_, i) => values[4][i]),
                    datasets: [{
                        label: 'Use Phase',
                        borderColor: "blue",
                        data: Array.from({ length: dataLength }, (_, i) => values[0][i]),
                        fill: true
                    },
                    {
                        label: 'Waste Management',
                        borderColor: "green",
                        data: Array.from({ length: dataLength }, (_, i) => values[1][i]),
                        fill: true
                    },
                    {
                        label: 'Material Production',
                        borderColor: "yellow",
                        data: Array.from({ length: dataLength }, (_, i) => values[2][i]),
                        fill: true
                    },
                    {
                        label: 'Energy Supply',
                        borderColor: "red",
                        data: Array.from({ length: dataLength }, (_, i) => values[3][i]),
                        fill: true
                     

                    }],
                },
                options: {
                    responsive: true,
                    title:
                    {
                        display: true,
                        text: 'Chart JS Gridlines - Line Chart'
                    },
                    scales: {
                        x: {
                            grid: {
                                display: true,
                                color: "blue",
                                lineWidth: 2
                            }
                        },
                        y: {
                            grid: {
                                display: true,
                                color: "blue"
                            }
                        }
                    }//end scales                            
                }//end options 
                            
            });
        };

    </script>
</asp:Content>
