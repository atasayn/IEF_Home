<%@ Page Title="CIRCOMOD" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="circomod.aspx.cs" Inherits="IEF_Home.circomod" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <style>
        .grid-container {
            grid-template-areas: 'circo circo'
                                 'dropdown graph';
            grid-auto-columns: auto 400px;
            gap: 10px;
            padding: 10px;
        }

        .grid-circo { grid-area: circo; }

        .grid-dropdown {
            grid-area: dropdown;
            padding-top: 2em;
        }


        .grid-graph { grid-area: graph; }

        h2 { text-align: center; }

        hr {
            text-align: center;
            border: none;
            height: 1px;
            color: #333;
            background-color: #333;
        }

        .DropDownMenu {
            padding-top: 15px;
            margin-left: 15px;
            margin-right: 15px;
        }

        svg {
            pointer-events: none;
            user-select: none;
        }

        .target_svg {
            height: 100%;
            width: 100%;
        }

        @media screen and (max-width: 768px) {
            .grid-container {
                display: block;
            }
        }
    </style>

    <script src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/dropdownMenu.js"></script>
    <script type="text/javascript" src="js/jquery-1.6.2.js"></script>
    <script type="module" src="js/chart.min.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/lib/d3.min.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/lib/d3.v3.min.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/circular_sankey_script.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/circular_sankey_lib.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/fileExporter.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/fileUploader.js"></script>
    <script src="https://www.visualisation.industrialecology.uni-freiburg.de/scripts/custom_map.js"></script>
    <script>

        $(document).ready(function() {
            $("#DropDownListYear").append("<option>" + "Please select year" + "</option>");

            const room = document.querySelector("#DropDownListYear");

            for (let i = 2022; i <= 2060; i++) {
                room.insertAdjacentHTML("beforeend", `<option value="${i}">${i}</option>`);
            }
        });



    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
<div class="grid-container">
    <div class="grid-circo">

        <h2>CIRCOMOD: circular economy modelling for climate change mitigation</h2>

        <br>
        <p>A circular economic system that aims to reduce primary material use (in addition to energy efficiency and fuel shifts) can address both Greenhous Gas emissions (GHG)s and increase resource efficiency. However, current GHG mitigation models and scenarios that inform climate policymakers do not generally include circular economy (CE) options. They also do not cover the possible synergies of the CE with other societal goals such as the Sustainable Development Goals (SDGs), nor the challenges involved in rearranging value chains and consumer behaviour.</p>
        <br>
        <p>CIRCOMOD addresses these challenges by developing a new generation of advanced models and scenarios that will assess how CE can reduce future GHGs and material use. The project brings together a unique consortium of leading research teams from different disciplines, including industrial ecology and material flow modelling, process-oriented integrated assessment modelling, and macro-economic modelling. It aims for a breakthrough in integrating CE and GHG mitigation assessments by a) developing an analytical framework that maps circular economy strategies to existing influential climate scenarios; b) providing robust and timely CE data in an open repository; and c) improving the representation of the CE in leading models used by European and global institutions, while strengthening links between the models. It will provide input to international assessments such as the Intergovernmental Panel on Climate Change (IPCC) and the International Resource Panel (IRP).</p>
        <br>
        <p>The EU research fund Horizon Europe has awarded 5 million euros to the project. The consortium consists of twelve partners from different EU countries. </p>
        <br>
        <p>
            Here, we will show different visualization options for circular economy profiles for materials, products, and regions.
            <a href="https://www.tilburguniversity.edu/current/news/more-news/eu-funds-research-project-circomod-eu-modeling-circular-economy-mitigate-climate-change" target="_blank">Tilburg University</a>
        </p>
        <hr/>
        <i>
            <b>Browse the results from the project’s database (prototype, under development)</b>
        </i>
    </div>

    <div class="grid-dropdown">

        <select id="DropDownListRegion">
            <option value="" selected>Please select region</option>
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


        <select id="DropDownListScenario">
            <option value="" selected>Please select scenerio</option>
            <option value="LED">LED</option>
            <option value="SSP1">SSP1</option>
            <option value="SSP2">SSP2</option>
        </select>


        <button type="button" class="DDSelectRegSce">Click me</button>

    </div>
    <canvas id="line-chart"></canvas>

</div>
<hr/>
<div class="grid-sankey">

    <select id="DropDownListSankeyRegion">
        <option value="" selected>Please select region</option>
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


    <select id="DropDownListSankeyScenario">
        <option value="" selected>Please select scenerio</option>
        <option value="LED">LED</option>
        <option value="SSP1">SSP1</option>
        <option value="SSP2">SSP2</option>
    </select>

    <select id="DropDownListSector">
        <option value="" selected>Please select sector</option>
        <option value="Residential building">Residential building</option>
        <option value="Passenger vehicles">Passenger vehicles</option>
    </select>

    <select id="DropDownListYear">
    </select>

    <select id="DropDownListStrategy">
        <option value="" selected>Please select strategy</option>
        <option value="Baseline">Baseline</option>
        <option value="HIY">HIY</option>
        <option value="HIY-RLU">HIY-RLU</option>
        <option value="HIY-RLU-MSU">HIY-RLU-MSU</option>
        <option value="HIY-RLU-MSU-ULD">HIY-RLU-MSU-ULD</option>
        <option value="HIY-RLU-MSU-DOS">HIY-RLU-MSU-DOS</option>
        <option value="HIY-RLU-MSU">HIY-RLU-MSU</option>
        <option value="HIY-RLU-MSU-DOS-CAS">HIY-RLU-MSU-DOS-CAS</option>
        <option value="Full CE">Full CE</option>
    </select>


    <select id="DropDownListMaterial">
        <option value="" selected>Please select material</option>
        <option value="Cement">Cement</option>
        <option value="Steel">Steel</option>
        <option value="Aluminium ">Aluminium</option>
        <option value="Copper">Copper</option>
        <option value="Plastics">Plastic</option>
        <option value="Wood">Wood</option>

    </select>


    <button type="button" class="DDSelectSankey" >Click me</button>
    <div style="display: none;">
        <input type="hidden" id="txtproject_name" value=""/>
        <input type="hidden" id="background_color" value="#FFFFFF"/>
        <input type="hidden" id="node_width" value="40"/>
        <input type="hidden" id="node_height" value="5"/>
        <input type="hidden" id="canvas_width" value="1300"/>
        <input type="hidden" id="canvas_height" value="900"/>
        <input type="hidden" id="unit_name" value="kt"/>
        <input type="hidden" id="font_size" value="12"/>
        <input type="hidden" id="default_node_opacity" value="5"/>
        <input type="hidden" id="flow_width" value="9" />
        <input type="hidden" id="font_face" value="sans-serif"/>
        <input type="hidden" id="default_flow_opacity" value="5"/>
        <input type="hidden" id="node_border" value="0"/>
        <input type="hidden" id="show_labels" checked/>
        <input type="hidden" id="curvature" value="5"/>
        <input type="hidden" id="txtRemarks" value=""/>
        <input type="hidden" id="font_color" value="#000000"/>
        

<textarea id="input_node_data" type="text" rows="8" cols="120" " onclick="process_sankey()" class="form-control">
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

    <textarea id="input_flow_data" type="text" rows="8" cols="120"  onchange="process_sankey()" class="form-control">    
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
    <span id="spnOutputMessage" class="label label-danger"></span>
    <div id="div_svg">
    <p id="chart">
        <svg class="img-responsive" id="target_svg" xmlns="http://www.w3.org/2000/svg" version="1.1"></svg>
    </p>
    </div>
</div>
</asp:Content>