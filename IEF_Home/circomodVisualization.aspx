<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="circomodVisualization.aspx.cs" Inherits="IEF_Home.circomodVisualization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
     
    <style>
        html {
            width: 100%;
            height: 100%;
            display: table;
        }

        body {
            width: 100%;
            display: table-cell;
        }

        html, body {
            margin: 0;
            padding: 0;
            background-color: #A9A9A9;
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
            background-color: #A9A9A9;
        }

        #DataMenu-Recc-GraphType {
            grid-template-columns: 350px auto auto auto;
            grid-template-areas: 'menu linePlot linePlot linePlot'
                'menu sankey sankey sankey';
            display: grid;
            grid-gap: 10px;
            height: auto
        }

        #DataMenu {
            grid-area: menu;
            display: block;
            background: #ffffff;
            padding: 15px;
            border-radius: 10px;
        }

        .center-text {
            display: block;
            text-align: center;
            margin-bottom: 5px;
        }

        input[type="checkbox"] {
            margin-bottom: 5px
        }

        select {
            margin-left: 0;
        }

        #recc {
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
            background: #FFD993;
            color: #000000;
            font-weight: bold;
        }

        label {
            text-align: right;
            clear: both;
            float: left;
            margin-right: 15px;
        }

        select {
            width: 150px;
        }

        #DropDownListGraphs {
            grid-area: plotTypes;
            width: 200px;
            height: 200px;
        }

        #graph-types {
            display: block;
            background: #ffffff;
            padding: 15px;
            border-radius: 10px;
            max-height: 500px;
        }

        #graph-list {
            text-align: right;
            clear: both;
            float: left;
            margin-right: 15px;
        }

        #Graph1Line, #Graph2Line, #Graph3Line {
            display: none;
            padding: 15px;
            border-radius: 10px;
            width: 500px;
            padding-left: 5px;
        }

        body {
            margin: 0;
            overflow: hidden;
        }

        #overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }

        #maximizedGraph {
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
        }

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
            display: none;
            padding: 15px;
            border-radius: 10px;
            padding-left: 5px;
            display: block;
            position: relative;
            width: 1000px;
            height: 500px;

        }

/*        svg:not(:root) {
            overflow: hidden;
            transform: scale(0.8) translateX(-7px);
            width: 1230px;
            height: 500px;
            border-radius: 10px;
        }*/

/*        svg {
            pointer-events: none;
            user-select: none;
        }*/


        .active {
            display: block;
        }
    </style>
    <script src="js/jquery.min.js"></script>
    
    <script type="text/javascript" src="js/dropdownMenu.js"></script>
    <script type="text/javascript" src="js/jquery-1.6.2.js"></script>
    <script type="module" src="js/chart.min.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/lib/d3.min.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/lib/d3.v3.min.js"></script>
    <script type="text/javascript" src="js/circular_sankey_script.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/circular_sankey_lib.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/fileExporter.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/fileUploader.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/custom_map.js"></script>
    <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="js/datepicker.js"></script>
    <script type="text/javascript" src="js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="js/mapConfig.js"></script>
    
   <%-- <script type="text/javascript" src="js/perfect-scrollbar.min.js"></script>--%>
    <script type="text/javascript" src="js/moment.min.js"></script>
    <script type="text/javascript" src="js/jquery.peity.min.js"></script>
    <script type="text/javascript" src="js/highlight.pack.min.js"></script>
    <script type="text/javascript" src="js/jquery.vmap.min.js"></script>
    <script type="text/javascript" src="js/jquery.vmap.world.js"></script> 
    <script type="text/javascript" src="js/bracket.js"></script>
    <script type="text/javascript" src="js/jquery.vmap.sampledata.js"></script>
    
    
    
    
    
    

    <script>


        function enlarge() {
            const overlay = document.getElementById('overlay');
            overlay.style.display = 'block';
            const maximizedGraph = document.getElementById('maximizedGraph');
            maximizedGraph.style.display = 'block';
        }


        function restore() {
            overlay.style.display = 'none';
            maximizedGraph.style.display = 'none';
        }





    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div id="DataMenu-Recc-GraphType">
        <div id="DataMenu">
            <div id="Entries" style="width: 60%; float: left">
                <b class="center-text">CE Profiles</b>

                <%-- <input type="Checkbox" id="CE1Checkbox" name="CE1_profile" value="CE1" onchange="toggleDivVisibility('CE1Checkbox', 'CE1')">--%>
                <b>CEP 1: Region</b>
                <div id="vmap" style="width: 600px; height: 400px">



                </div>
                <div id="CE1">
                    
                    <%--<label for="Title">Region:</label>--%>
                    <select id="DropDownListPlotRegion" size="8" required>
                        <option value="France">France</option>
                        <option value="Germany">Germany</option>
                        <option value="Italy">Italy</option>
                        <option value="Poland">Poland</option>
                        <option value="Spain">Spain</option>
                        <option value="UK">UK</option>
                        <option value="Oth_R32EU15">Oth_R32EU15</option>
                        <option value="Oth_R32EU12-H">Oth_R32EU12-H</option>
                        <option value="R32EU12-M">R32EU12-M</option>
                        <option value="R32CAN">R32CAN</option>
                        <option value="R32CHN">R32CHN</option>
                        <option value="R32IND">R32IND</option>
                        <option value="R32JPN">R32JPN</option>
                        <option value="R32USA">R32USA</option>
                        <option value="R5.2OECD_Other">R5.2OECD_Other</option>
                        <option value="R5.2REF_Other">R5.2REF_Other</option>
                        <option value="R5.2ASIA_Other">R5.2ASIA_Other</option>
                        <option value="R5.2MNF_Other">R5.2MNF_Other</option>
                        <option value="R5.2SSA_Other">R5.2SSA_Other</option>
                        <option value="R5.2LAM_Other">R5.2LAM_Other</option>
                        <option value="EU28">EU28</option>
                        <option value="G7">G7</option>
                        <option value="Global_South">Global_South</option>
                        <option value="Global_North">Global_North</option>
                        <option value="Global">Global</option>
                    </select>
                </div>
                <br />
                <%--<input type="Checkbox" id="CE2Checkbox" name="CE2_profile" value="CE2" onchange="toggleDivVisibility('CE2Checkbox', 'CE2')">--%>
                <b>CEP 2: Material</b>
                <div id="CE2">

                    <%--<label for="Title">Material: </label>--%>
                    <select id="DropDownListMaterial" size="8" required>
                        <option value="Cement">Cement</option>
                        <option value="Steel">Steel</option>
                        <option value="Aluminium ">Aluminium</option>
                        <option value="Copper">Copper</option>
                        <option value="Plastics">Plastic</option>
                        <option value="Wood">Wood</option>

                    </select>
                </div>
                <br />
                <%--<input type="Checkbox" id="CE3Checkbox" name="CE3_profile" value="CE3" onchange="toggleDivVisibility('CE3Checkbox', 'CE3')">--%>
                <b>CEP 3: Product</b>
                <div id="CE3"></div>
            </div>
            <b style="padding-bottom: 5px; margin: 5px;">Plot Types</b>
            <div id="graph-types" style="background: #ffffff; width: 40%; float: left">

                <input type="Checkbox" id="LinePlot" name="CE1_profile" value="CE1" onchange="toggleDivVisibility('CE1Checkbox', 'CE1')">
                <b>Line Plot</b>
                <br>
                <input type="Checkbox" id="Sankey" name="CE1_profile" value="CE1" onchange="toggleDivVisibility('CE1Checkbox', 'CE1')">
                <b>Sankey Diagram</b>
                <br>
                <input type="Checkbox" id="WaterFall" name="CE1_profile" value="CE1" onchange="toggleDivVisibility('CE1Checkbox', 'CE1')">
                <b>Waterfall Plot</b>
            </div>
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

        <%--<div id="graph-types" style="background:#ffffff">
     <b style="padding-bottom:5px;" >Plot Types</b>
     
     <select id="DropDownListGraphs" size="8" required>
        <option value="Line Plot">Line Plot</option>
        <option value="Sankey Diagram">Sankey Diagram</option>
        <option value="Waterfall Plot">Waterfall Plot</option>

    </select>
    </div>--%>

        <div id="Graph1Line" style="background-color: #ffffff">
            <canvas id="line-plot1"></canvas>
            <span id="RegionName1" class="label label-danger"></span>
            <button onclick="enlarge()" style="float: right;" type="button">Maximize</button>

        </div>
        <div id="overlay">
            <div id="maximizedGraph">
                <canvas id="line-plot-maximized"></canvas>
                <button onclick="restore()" type="button">Restore</button>
            </div>
        </div>

        <div id="Graph2Line" style="background-color: #ffffff">
            <canvas id="line-plot2"></canvas>
            <span id="RegionName2" class="label label-danger"></span>
            <button onclick="enlarge()" style="float: right;" type="button">Maximize</button>

        </div>


        <div id="Graph3Line" style="background-color: #ffffff">
            <canvas id="line-plot3"></canvas>
            <span id="RegionName3" class="label label-danger"></span>
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
</asp:Content>
