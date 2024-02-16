
<!DOCTYPE html>
<html>
<head><title>

</title><meta charset="utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=edge" /><link href="/css/bootstrap.css" rel="stylesheet" /><link href="/css/master.css" rel="stylesheet" /><link rel="icon" type="image/png" href="/resources/IEF_LogoV_23_3-Tab7.png" /><meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
           display:grid
        }

        .col-md-8 {
	        padding-left: 0;
	        /* height: 0px; */
	        display: block;
        }
        main {
            background-color: #f2f2f2;
            margin:6px;
            padding:0;
        }

        #DataMenu-Recc-GraphType {
            grid-template-columns: 25% 1fr 1fr 1fr;
            grid-template-areas:
                'map           line-graph           line-graph-pop StackedArea '
                'country-info  sankeyBaseline       sankeyBaseline GHG'
                'control-panel sankeyFullCE         sankeyFullCE   line-graph-bar'
                '.  ECD_Decoupling       ECD_Decoupling chinaTeaser'
                '.             energyServiceCascade energyServiceCascade chinaTeaser';
            display: grid;
            grid-row-gap: 10px;
            grid-column-gap: 5px;
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
            border-radius:5px;
            background:#F5F5F5
        }


        #RegionName1, #RegionName2, #RegionName3, #RegionName4, #RegionName5{
            text-align: right;
            clear: both;
            float: inline-end;
            margin-right: 15px;
            font-size:75%;
            margin:10px
        }

        #mapArea {
            background: #ffffff;
            height: fit-content;
            border-radius: 10px;
            grid-area: map;
            width:auto

        }
        #Graph1Line {
            display: block;
            grid-area: line-graph;
            border-radius: 5px;
            width: auto;
            height: 100%;
        }

        #GraphPopulationLine{
            grid-area:line-graph-pop;
            border-radius: 5px;
            width:auto;
            height:100%;
        }

        #GraphPopulationBar{
            grid-area:line-graph-bar;
            border-radius: 5px;
            width:auto;
            height:100%;
                       
        }

        #GraphPopulationBar h2{
            margin: auto;
        }

        #GraphStackedArea{
            grid-area:StackedArea;
           
            border-radius: 5px;
            width:auto;
            height:100%
        }

        #GHG{
            grid-area:GHG;
            position:relative;
            border-radius: 5px;
            width:auto;
            height:100%
        }

        #GHG > div{
            border-radius:5px
        }

        #GraphStackedArea h2{
            margin: auto;
        }

        #ChinaTeaser{
            grid-area:chinaTeaser;
            display: none;
            border-radius:5px;
            width:auto
        }

        #ChinaTeaser img{
            border-radius:5px;
            width:auto
        }

        #controlPanel{
            grid-area: control-panel;
            height:auto;
            background:#ffffff;
            border-radius: 5px;
            width:auto;
        }

        #countryInfo{
            grid-area: country-info;
            height:100%;
            width:auto;
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
            pointer-events:auto;
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
            grid-area: sankeyBaseline;
            padding: 5px;
            border-radius: 5px;
            width:auto;
            min-height: 365px;
            background: #fff;
            text-align: center;
            position:relative;
            overflow:hidden;
            pointer-events:none
                
        }

        #energyServiceCascade{
            grid-area:energyServiceCascade

        }       
        #ecdDecoupling{
            grid-area:ECD_Decoupling

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


        #singleCountryImg, #singleCountryImgLower {
            margin: auto;
            height:30px;
            border:outset;
        }

        .target_svg {
            display: none;
        }

        .visible {
            display: block;
        }

        #countryFlag,#scenerioSelect,#sectorSelect,#yearSelect,#strategySelect,#materialSelect {
            width: auto;
            height: 79px;
            border-radius: 5px;
            background: #F5F5F5;
        }
        #countryFlagLower,#scenerioSelectLower,#sectorSelectLower,#yearSelectLower,#strategySelectLower,#materialSelectLower {
            width: auto;
            height: 79px;
            border-radius: 5px;
            background: #F5F5F5;
        }


        #countryFlagSpan ,#scenerioSelect span:nth-child(2), #sectorSelect span:nth-child(2), #yearSelect span:nth-child(2), #strategySelect span:nth-child(2), #materialSelect span:nth-child(2) {
            display: flex;
            text-align: center;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top:10px
        }
        
        #countryFlagSpanLower ,#scenerioSelectLower span:nth-child(2), #sectorSelectLower span:nth-child(2), #yearSelectLower span:nth-child(2), #strategySelectLower span:nth-child(2), #materialSelectLower span:nth-child(2) {
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

        @media screen and (max-width: 768px) {
            .grid-container {
                display: block;
            }
        }
        
    </style>
    
<meta name="viewport" content="width=device-width, initial-scale=1.0">

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
    <script src="https://cdn.anychart.com/releases/8.9.0/js/anychart-core.min.js"></script>
    <script src="https://cdn.anychart.com/releases/8.9.0/js/anychart-waterfall.min.js"></script> 

</head>
<body>
    <form method="post" action="./circomodVisualization.aspx" id="form1">
<div class="aspNetHidden">
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="0xLbnx0TJ9xSkJB30Vq6AWRQmOEF6fjpC/O9F9EyX+2Lj56Xv4mXKREgZ1TZ5cb5aQf+6YQAo2Fe4i2ZuMIHDenLMYXy/SB/vi47GBhf/3M=" />
</div>

<div class="aspNetHidden">

	<input type="hidden" name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="5FB1E55D" />
</div>
        <header>
            <div class="jumbotron">
                <div class="container-fluid">

                    <div class="col-md-2">
                        <img src="/resources/IEF_LogoV_23_3.png" style="padding-left: 0;" width="241" height="111" alt="IEF logo">
                    </div>

                    <div class="col-md-8" style="padding-left: 30px; height: 0px;">
                        <h2>Industrial Ecology Freiburg</h2>
                        <p style="font-size: 16px;">Research group at the Faculty of Environment and Natural Resources</p>
                    </div>

                    <div class="logo" >
                        <img src="/resources/uniFreiburg.png"  width="300" alt="Uni Freiburg logo">
                    </div>
                </div>
            </div>
            <nav class="navbar navbar-default navbar-custom navbar">
                <div class="container-fluid">
                    <label for="collapsible" class="lbl-toggle">&equiv;</label>
                    <input id="collapsible" class="toggle" type="checkbox">
                    <div class="collapse navbar-collapse" id="myNavbar">
                        <ul class="nav navbar-nav">
                            <li><a href="/">Home</a></li>
                            <li><a href="https://www.blog.industrialecology.uni-freiburg.de" target="_blank">Blog</a></li>
                            <!--  <li><a href="/research/research">Research</a></li>-->
                            <li><a href="https://www.database.industrialecology.uni-freiburg.de" target="_blank">Data</a></li>
                            <li><a href="/odym-recc">Models</a></li>
                            <li><a href="/teaching">Teaching</a></li>
                            <li><a href="/circomod">Circular Economy</a></li>
                            <li><a href="https://www.visualisation.industrialecology.uni-freiburg.de" target="_blank">Circular Sankey</a></li>       
                            <li><a href="/internal">Internal</a></li>
                            <li style="display:none"><a href="/circomodVisualization">circomodVisualization</a></li>
                            
                            
                            
                        </ul>

                    </div>
                </div>
            </nav>
        </header>
        <main>
            

    <div id="DataMenu-Recc-GraphType">

        <div id="mapArea">
            <div id="svgMap"></div>
        </div>
        
        <div id="Graph1Line" style="background-color: #ffffff">
            <span id="Graph1LineNoData" style="display:none">No Data</span>
            <canvas id="line-plot1" style="position:absolute"></canvas>
            <div id="NoDataline-plot1" style="margin=auto;display:none;width: 100%;height: 100%;">
                 <span style="line-height:2;font-weight:500;color:black;font-size:25px;margin:auto">No Data</span>
            </div>
        <%--    <span id="RegionName1" class="label label-danger" style="background-color:#b6dbff;line-height:2;font-weight:500;color:black"></span>--%>
        </div>

         <div id="GraphPopulationLine" style="background-color: #ffffff">
            <canvas id="line-plot2" style="position:absolute"></canvas>
             <div id="NoDataline-plot2" style="margin=auto;display:none;width:100%;height: 100%;">
                 <span style="line-height:2;font-weight:500;color:black;font-size:25px;margin:auto">No Data</span>
            </div>
            <%--<span id="RegionName2" class="label label-danger" style="background-color:#b6dbff;line-height:2;font-weight:500;color:black"></span>--%>
        </div>

        <div id="GraphPopulationBar" style="background-color: #ffffff">
            <div class="loader2" style="display:none"></div>
            <canvas id="line-plot3" style="position:absolute"></canvas>
           <div id="NoDataline-plot3" style="margin=auto;display:none;width:100%;height: 100%;">
                 <span style="line-height:2;font-weight:500;color:black;font-size:25px;margin:auto">No Data</span>
            </div>
            <span id="RegionName3" class="label label-danger" style="background-color:#b6dbff;line-height:2;font-weight:500;color:black"></span>
        </div>

        <div id="GraphStackedArea" style="background-color: #ffffff">
            <div class="loader3" style="display:none"></div>
            <canvas id="line-plot4" style="position:absolute"></canvas>
             <div id="NoDataline-plot4" style="margin=auto;display:none;width:100%;height: 100%;">
                 <span style="line-height:2;font-weight:500;color:black;font-size:25px;margin:auto">No Data</span>
            </div>
            <span id="RegionName4" class="label label-danger" style="background-color:#b6dbff;line-height:2;font-weight:500;color:black"></span>
        </div>

        <div id ="countryInfo">
           <p style="margin:10px"><b>Country Info:</b></p>
            <span id='countryInfoCountryName' style="margin-left:50px"></span>
            <span id='proxyName' style="margin-left:50px"></span>
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
            
            <p style="margin:10px"><b>Sankey:</b></p>
            <p style="margin-left:50px"><b>Upper Sankey Diagram:</b></p>
            <p style="margin-left:50px">&#8226 Sankey diagram for steel flows in [selected sector], [selected region], [selected year], SSP2 scenario, standard recycling</p>
            <p id="steelUpperValue" style="margin-left:50px">&#8226 Reference flow for final consumption of steel (blue): </p>
            <p id="GhGUpperValue"style="margin-left:50px">&#8226 Reference flow for GHG emissions (green):</p>
            <div id="sankeyConfig">
            <div id="countryFlag">
                <span style="margin: 5px;">Country:</span>
                <img id="singleCountryImg" style="margin-top:8px;height:20px">             
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
            <p style="margin-left:50px"><b>Lower Sankey Diagram:</b></p>
            <p style="margin-left:50px">&#8226 Sankey diagram for steel flows in [selected sector], [selected region], [selected year] <text style="color:red">LED scenario, full circular economy.</text></p>
            <p style="margin-left:50px">&#8226 Reference flow for final consumption of steel (blue): </p>
            <p style="margin-left:50px">&#8226 Reference flow for GHG emissions (green):</p>
           <div id="sankeyConfigLower">
            <div id="countryFlagLower">
                <span style="margin: 5px;">Country:</span>
                <img id="singleCountryImgLower" style="margin-top:8px;height:20px">             
                <span id="countryFlagSpanLower" style="margin-top:10px;"></span>
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
               <p  class="w3-panel w3-red" style="margin:20px"><b>Warning:</b><span id='proxyWarning'></span></p>
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

        <div id="sankeyFullCE">
         <%--  <div class="loader" style="display:none"></div>--%>
           <div id="sankeyDivsAllFullCE"></div>
        </div>

        <div id="GHG"  style="background-color: #ffffff">
             <canvas id="line-plot5" style="position:absolute"></canvas>
            <div id="NoDataline-plot5" style="margin=auto;display:none;width:100%;height: 100%;">
                 <span style="line-height:2;font-weight:500;color:black;font-size:25px;margin:auto">No Data</span>
            </div>
        </div>

        <div id="ChinaTeaser" >
            <img src="Content/ReccPlots/Buildings_China_LED_CE.png" style="border-radius:5px;width:auto" >  
            <img src="Content/ReccPlots/Buildings_China_SSP2.png" style="border-radius:5px;width:auto" >
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
            // Get the element with the ID steelUpperValue
            var steelUpperValueElement = document.getElementById("steelUpperValue");
            // Get all spans inside steelUpperValueElement
            var spans = steelUpperValueElement.getElementsByTagName("span");
             // Get the element with the ID GhGUpperValue
            var steelUpperValueElement = document.getElementById("GhGUpperValue");
            // Get all spans inside GhGUpperValue
            var spansGhg = steelUpperValueElement.getElementsByTagName("span");
            // Iterate through the divs 
            var visibleElements = [];
            for (var i = 0; i < divs.length; i++) {
                // Check if the div is visible
                if (divs[i].style.visibility === 'visible') {
                    // Return the id of the visible div
                    visibleElements.push({
                        divsVis: divs[i].id,
                        spansSteelUpperValueId: spans[i].id,
                        spansGhgUpperValueId: spansGhg[i].id
                    });
                }
            }
            return visibleElements;
        }


        function navigateFront() {
            // Get all div elements with id starting with "div_svg"
            var divs = document.querySelectorAll('[id^="div_svg"]');
            var visibleElements = findVisibleDivId(); // Store the return value in a variable
            var divsVis = visibleElements[0]["divsVis"]; // Access the first element of the array and then its properties
            var spansSteelUpperValueId = visibleElements[0]["spansSteelUpperValueId"];
            var spansGhgUpperValueId = visibleElements[0]["spansGhgUpperValueId"];
            divsStart = divs[0].id.slice(-4);
            divsEnd = divs[divs.length - 1].id.slice(-4);
            divsCurrent = divsVis.slice(-4);
            console.log(divsVis)
            console.log(divsStart, divsEnd, divsCurrent)
            if (divsVis && divsCurrent < divsEnd) {
                // Visible
                document.getElementById("div_svg" + (parseInt(divsVis.slice(-4)) + 10)).style.visibility = 'visible';
                document.getElementById("span_svg" + (parseInt(divsVis.slice(-4)) + 10)).style.visibility = 'visible';
                document.getElementById("steelUpper_span" + (parseInt(divsVis.slice(-4)) + 10)).style.display = 'block';
                document.getElementById("ghgUpper_span" + (parseInt(divsVis.slice(-4)) + 10)).style.display = 'block';
                // Hidden
                document.getElementById("div_svg" + divsVis.slice(-4)).style.visibility = 'hidden';
                document.getElementById("span_svg" + divsVis.slice(-4)).style.visibility = 'hidden';
                document.getElementById("steelUpper_span" + divsVis.slice(-4)).style.display = 'none';
                document.getElementById("ghgUpper_span" + divsVis.slice(-4)).style.display = 'none';                document.getElementById("steelUpper_span" + (parseInt(divsVis.slice(-4)) + 10)).style.visibility = 'visible';

            }
        }

        function navigateBack() {
            // Get all div elements with id starting with "div_svg"
            var divs = document.querySelectorAll('[id^="div_svg"]');
            var visibleElements = findVisibleDivId(); // Store the return value in a variable
            var divsVis = visibleElements[0]["divsVis"]; // Access the first element of the array and then its properties
            var spansSteelUpperValueId = visibleElements[0]["spansSteelUpperValueId"];
            var spansGhgUpperValueId = visibleElements[0]["spansGhgUpperValueId"];
            divsStart = divs[0].id.slice(-4);
            divsEnd = divs[divs.length - 1].id.slice(-4);
            divsCurrent = divsVis.slice(-4);
            if (divsVis && divsCurrent > divsStart) {
                // Visible
                document.getElementById("div_svg" + (divsVis.slice(-4) - 10)).style.visibility = 'visible';
                document.getElementById("span_svg" + (divsVis.slice(-4) - 10)).style.visibility = 'visible';
                document.getElementById("steelUpper_span" + (divsVis.slice(-4) - 10)).style.display = 'block';
                document.getElementById("ghgUpper_span" + (divsVis.slice(-4) - 10)).style.display = 'block';
                // Hidden
                document.getElementById("div_svg" + divsVis.slice(-4)).style.display = 'block';
                document.getElementById("span_svg" + divsVis.slice(-4)).style.display = 'block';
                document.getElementById("steelUpper_span" + divsVis.slice(-4)).style.display = 'none';
                document.getElementById("ghgUpper_span" + divsVis.slice(-4)).style.display = 'none';   
            }
        }

        function barChart(data, canvasID) {
            var res = new Map(data["d"].map(obj => [obj.Key, obj.Value]));
            var values = [...new Set(Array.from(res.values()))];
            //if (values.length == 0) {
            //    BarHide.style.display = "block"
            //}
            try {
                Chart.getChart(canvasID).destroy();
            } catch (e) { }
            new Chart(document.getElementById(canvasID), {

                type: 'bar',
                data: {
                    labels: ["SSP2 + Baseline", "SSP2 + Full CE", "LED + Full CE"],
                    datasets: [{
                        label: 'Primary Production',
                        backgroundColor: "#d55e00",
                        data: [values[0].slice(-1), values[1].slice(-1), values[2].slice(-1)]
                    }, {
                        label: 'Secondary Production',
                        backgroundColor: "#009e73",
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
            var canvasElement = document.getElementById("NoData" + canvasID);
            var res = new Map(data["d"].map(obj => [obj.Key, obj.Value]));
            var values = [...new Set(Array.from(res.values()))];
            var dataLength = values[0].length;
            //if (dataLength == 0) {
            //    BarHide.style.display = "block"
            //}
            try {
                Chart.getChart(canvasID).destroy();
            } catch (e) { }
            if (data.every(subarray => subarray.length === 0)) {
                canvasElement.style.display = "flex"
            } else {
                new Chart(document.getElementById(canvasID), {
                    type: 'line',
                    data: {
                        labels: Array.from({ length: dataLength }, (_, i) => values[4][i]),
                        datasets: [{
                            label: 'Use Phase',
                            borderColor: "#d55e00",
                            data: Array.from({ length: dataLength }, (_, i) => values[0][i]),
                            fill: true
                        },
                        {
                            label: 'Waste Management',
                            borderColor: "#009e73",
                            data: Array.from({ length: dataLength }, (_, i) => values[1][i]),
                            fill: true
                        },
                        {
                            label: 'Material Production',
                            borderColor: "#0072b2",
                            data: Array.from({ length: dataLength }, (_, i) => values[2][i]),
                            fill: true
                        },
                        {
                            label: 'Energy Supply',
                            borderColor: "#f0e442",
                            data: Array.from({ length: dataLength }, (_, i) => values[3][i]),
                            fill: true


                        }],
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            title: {
                                display: true,
                                text: 'Baseline GHG for 2016-2060 '
                            },
                        },
                        scales: {
                            x: {
                                title: {
                                    display: true,
                                    text: 'Year',

                                },
                                grid: {
                                    display: true,
                                    color: "blue",
                                    lineWidth: 2
                                }
                            },
                            y: {
                                title: {
                                    display: true,
                                    text: 'Unknown',

                                },
                                grid: {
                                    display: true,
                                    color: "blue"
                                }
                            }
                        }//end scales                            
                    }//end options 

                });
            }
        };

       

        
    </script>

        </main>
        <footer>
            <div>
                <a href="/">Home</a> 
                <a href="https://www.blog.industrialecology.uni-freiburg.de">Blog</a> 
            <!--<a href="research/research">Research</a> &#9679; -->
                <a href="https://www.database.industrialecology.uni-freiburg.de">Data</a>
                <a href="/odym-recc">Models</a> 
                <a href="/teaching">Teaching</a>
                   <a href="/circomod">Circular Economy</a><br/>
                <a href="https://www.visualisation.industrialecology.uni-freiburg.de">Circular Sankey</a> 
                <a href="/internal">Internal</a> 
                <a href="/legal">Legal Notes & Privacy</a>
                
            </div>
            <div>
                <h3>Industrial Ecology <span>Freiburg 2023</span></h3>
            </div>
        </footer>
    </form>
</body>
</html>
