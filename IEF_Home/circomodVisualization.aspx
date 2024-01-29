<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="circomodVisualization.aspx.cs" Inherits="IEF_Home.circomodVisualization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">



    <style>
        html {
            width: 100%;
            height: 100%;
            display: table;
        }

        body {
            width: 1280px;
            height: 720px;
            display: table-cell;
        }

        html, body {
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }

        .logo {
            position: relative;
            max-width: 100%;
            width: 100%;
            text-align: right;
            right: 0;
            display: block;
        }

        main {
            background-color: #f2f2f2;
        }

        #DataMenu-Recc-GraphType {
            grid-template-columns: 300px 600px 149px 149px 149px 149px 149px 149px;
            grid-template-areas:
                'map map countrySel scenerioSel yearSel sectorSel strategySel materialSel  '
                'map map sankey sankey sankey sankey sankey sankey  '
                'line-graph graph waterfall waterfall waterfall waterfall waterfall waterfall ';
            display: grid;
            grid-gap: 10px;
        }



        .center-text {
            display: block;
            text-align: center;
            margin-bottom: 5px;
        }


        select {
            margin-left: 0;
        }

       /* #recc {
            grid-area: recc;
            position: relative;
            width: 100%;
            background: #ffffff;
            margin: 0 15px;
            border-radius: 10px;
            max-width: 1100px;
            padding-right: 10px;
        }

        #well-being {
            position: absolute;
            top: 29.5%;
            left: 9.3%;
            transform: translate(-50%, -50%);
            cursor: pointer;
            border-radius: 5px;
            width: 122px;
            height: 62px;
            background: rgb(197,90,17);
            color: #ffffff;
            font-weight: bold;
        }

        #services-activities {
            position: absolute;
            top: 30%;
            left: 22.2%;
            transform: translate(-50%, -50%);
            cursor: pointer;
            border-radius: 5px;
            width: 124px;
            height: 65px;
            background: rgb(68,114,196);
            color: #ffffff;
            font-weight: bold;
        }

        #products-stocks {
            position: absolute;
            top: 29.8%;
            left: 35.1%;
            transform: translate(-50%, -50%);
            cursor: pointer;
            border-radius: 5px;
            width: 123px;
            height: 64px;
            background: rgb(68,114,196);
            color: #ffffff;
            font-weight: bold;
        }

        #build-up-energy {
            position: absolute;
            top: 20.3%;
            left: 48.1%;
            transform: translate(-50%, -50%);
            cursor: pointer;
            border-radius: 5px;
            width: 125px;
            height: 75px;
            background: rgb(68,114,196);
            color: #ffffff;
            font-weight: bold;
        }

        #operational-energy {
            position: absolute;
            top: 39%;
            left: 48.1%;
            transform: translate(-50%, -50%);
            cursor: pointer;
            border-radius: 5px;
            width: 123px;
            height: 73px;
            background: rgb(68,114,196);
            color: #ffffff;
            font-weight: bold;
        }

        #energy-carrier {
            position: absolute;
            top: 30.5%;
            left: 61.3%;
            transform: translate(-50%, -50%);
            cursor: pointer;
            border-radius: 5px;
            width: 120px;
            height: 110px;
            background: rgb(68,114,196);
            color: #ffffff;
            font-weight: bold;
        }

        #extraction {
            position: absolute;
            top: 30.8%;
            left: 75%;
            transform: translate(-50%, -50%);
            cursor: pointer;
            border-radius: 5px;
            width: 136px;
            height: 83px;
            background: rgb(68,114,196);
            color: #ffffff;
            font-weight: bold;
        }

        #climate-impact {
            position: absolute;
            top: 30%;
            left: 88.9%;
            transform: translate(-50%, -50%);
            cursor: pointer;
            border-radius: 5px;
            width: 123px;
            height: 62px;
            background: rgb(84,130,53);
            color: #ffffff;
            font-weight: bold;
        }

        #material-production {
            position: absolute;
            top: 58.5%;
            left: 48.3%;
            transform: translate(-50%, -50%);
            cursor: pointer;
            border-radius: 5px;
            width: 143px;
            height: 78px;
            background: #ffd993;
            color: #000000;
            font-weight: bold;
        }*/


        label {
            text-align: right;
            clear: both;
            float: left;
            margin-right: 15px;
        }

        select {
            width: 150px;
            padding-top: 5px;
        }

        #DropDownListGraphs {
            grid-area: plotTypes;
            width: 200px;
            height: 200px;
        }




        #Graph1Line {
            display: block;
            grid-area: line-graph;
            border-radius: 5px;
            width: 500px;
            height: 300px;
        }

        body {
            margin: 0;
        }

/*        #overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }*/

/*        #maximizedGraph {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 2;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: all 0.3s ease;
            border-radius: 10px;
            width: 700px;
            margin: 5px;
        }*/

        canvas {
            max-width: 100%;
            height: auto;
        }

        button {
            float: right;
            margin: 5px;
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
        }

        #mapArea {
            background: #ffffff;
            height: 455px;
            border-radius: 10px;
            grid-area: map
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
        }

        .svgMap-country {
            cursor: pointer
        }

        .svgMap-map-wrapper .svgMap-country:hover {
            -webkit-tap-highlight-color: #333;
            stroke-width: 1;
        }


        #singleCountryImg {
            display:block;
            margin-left:50px
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

        .target_svg {
            display: none;
        }

        .visible {
            display: block;
        }

        .column {
            float: left;
            text-align: center;
            width: 100px;
            margin: 30px;
            font-family: "poppins";
   
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
        }

        #sectorSelect {
            grid-area: sectorSel;
            width: 154px;
            height: 79px;
            border-radius: 5px;
            background: #FFF;
        }

        #yearSelect {
            grid-area: yearSel;
            width: 154px;
            height: 79px;
            border-radius: 5px;
            background: #FFF;
        }

        #strategySelect {
            grid-area: strategySel;
            width: 154px;
            height: 79px;
            border-radius: 5px;
            background: #FFF;
        }

        #materialSelect {
            grid-area: materialSel;
            width: 154px;
            height: 79px;
            border-radius: 5px;
            background: #FFF;
        }

        #countryFlagSpan, #scenerioSelect span:nth-child(2),#sectorSelect span:nth-child(2), #yearSelect span:nth-child(2),#strategySelect span:nth-child(2),#materialSelect span:nth-child(2)   {
            display: flex;
            text-align: center;
            flex-direction: column;
            align-items: center;
            justify-content: center;
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
    




</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <div id="DataMenu-Recc-GraphType">

        <div id="mapArea">
            <div id="svgMap"></div>
        </div>

        <div id="countryFlag">
            <span style="margin: 5px;">Country:</span>
            <image id="singleCountryImg" style="margin-left: 50px;"></image>
            <span id="countryFlagSpan"></span>
            
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


        <%--<label for="Title">Scenario:</label>
     <select id="DropDownListSankeyScenario" size="8" required>
        <option value="LED">LED</option>
        <option value="SSP1">SSP1</option>
        <option value="SSP2">SSP2</option>
    </select>
    
    <label for="Title">Sector: </label>
    <select id="DropDownListSector" size="8" required>
        <option value="Passenger vehicles">Passenger vehicles</option>
        <option value="Residential building">Residential building</option>
        <option value="Non-Residential building">Non-Residential building</option>
    </select>

        <label for="Title">Strategy: </label>
       <select id="DropDownListStrategy" size="8" required>
        <option value="Baseline">Baseline</option>
        <option value="HIY">HIY</option>
        <option value="HIY-RLU">HIY-RLU</option>
        <option value="HIY-RLU-MSU">HIY-RLU-MSU</option>
        <option value="HIY-RLU-MSU-ULD">HIY-RLU-MSU-ULD</option>
        <option value="HIY-RLU-MSU-DOS">HIY-RLU-MSU-DOS</option>
        <option value="HIY-RLU-MSU">HIY-RLU-MSU</option>
        <option value="HIY-RLU-MSU-DOS-CAS">HIY-RLU-MSU-DOS-CAS</option>
        <option value="Full CE">Full CE</option>
    </select>--%>

        <%--    <div id="RECCScheme">
        <div id="recc">
            <img src="resources/ReccScheme.png" width="1100" height="500" style="width:100%">

            <button id="well-being"> Well-being</button>
            <button id="services-activities">Services,activities</button>
            <button id="products-stocks">Products/Stocks</button>
            <button id ="build-up-energy" >Build-up Energy and Material</button>
            <button id ="operational-energy" >Operational Energy and Material</button>
            <button id ="energy-carrier" >Energy carrier,Raw materials</button>
            <button id ="extraction" >Extraction & conversion technologies</button>
            <button id ="climate-impact" >Climate imp. land use</button>
            <button id ="material-production" >Material Production</button>
        </div>
   </div>--%>


        <div id="Graph1Line" style="background-color: #ffffff">
            <canvas id="line-plot1"></canvas>
            <span id="RegionName1" class="label label-danger"></span>
            <button onclick="enlarge()" style="float: right;" type="button">Maximize</button>

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
        </div>

    </div>
        <script>


            //function enlarge() {
            //    const overlay = document.getElementById('overlay');
            //    overlay.style.display = 'block';
            //    const maximizedGraph = document.getElementById('maximizedGraph');
            //    maximizedGraph.style.display = 'block';
            //}


            //function restore() {
            //    overlay.style.display = 'none';
            //    maximizedGraph.style.display = 'none';
            //}

            //function moveMouse(e) {
            //    var x = e.clientX;
            //    var y = e.clientY;
            //    document.getElementById("divSingleCountry").style.left = x + "px";
            //    document.getElementById("divSingleCountry").style.top = y + "px";
            //}



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
                console.log()
                divsStart = divs[0].id.slice(-4);
                divsEnd = divs[divs.length - 1].id.slice(-4);
                divsCurrent = divsVis.slice(-4);
                if (divsVis && divsCurrent < divsEnd) {
                    document.getElementById("div_svg" + (parseInt(divsVis.slice(-4)) + 1)).style.visibility = 'visible';
                    document.getElementById("span_svg" + (parseInt(divsVis.slice(-4)) + 1)).style.visibility = 'visible';
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
                    document.getElementById("div_svg" + (divsVis.slice(-4) - 1)).style.visibility = 'visible';
                    document.getElementById("span_svg" + (divsVis.slice(-4) - 1)).style.visibility = 'visible';
                    document.getElementById("div_svg" + divsVis.slice(-4)).style.visibility = 'hidden';
                    document.getElementById("span_svg" + divsVis.slice(-4)).style.visibility = 'hidden';
                }
            }


        </script>
</asp:Content>
