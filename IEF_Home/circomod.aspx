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


        h3 { text-align: center; }

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
            user-SELECT: none;
        }

        .target_svg {
            height: 100%;
            width: 100%;
        }

        .chart {
            height: auto;
            width: auto;
        }
   
        .label {
            display: none
        }

        svg:not(:root) {
            width: auto;
            height: auto;
            transform: scale(0.88) translateX(-76px);
        }

        @media screen AND (max-width: 768px) {
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
            $("#DropDownListYear").append("<option value='' disabled SELECTed>" + "Please SELECT year" + "</option>");
            
            const room = document.querySELECTor("#DropDownListYear");

            for (let i = 2022; i <= 2060; i++) {
                room.insertAdjacentHTML("beforeend", `<option value="${i}">${i}</option>`);
            }
        });

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
<div class="grid-container">
    <div class="grid-circo">

        <h2 style="text-align: center;">Circular Economy – Vision for Sustainable Material Cycles </h2>

        <br>
        <p>The use of biomass, metal ores, AND construction minerals is a major driver of environmental destruction AND climate impacts of material production. The circular economy is a vision for reducing material use by designing out waste AND pollution, keeping products AND materials in use for as long as possible, AND maximising the recycling of materials AND thus contribute to the reduction of environmental impacts of industrial production. The circular economy seeks to create a closed-loop system of production AND consumption, WHERE resources are used, reused, AND regenerated, AND the generation of waste AND environmental impacts is minimized. </p>
        <br>
        <p>In practice, there are many circular economy strategies to narrow (less material use), slow (longer material use), AND close (better recycling) technical material cycles. These strategies include product light-weighting, longevity, AND demountability by design, higher yields in fabrication, scrap recovery, AND recycling, as well as more efficient use of products.</p>
        <br>
        <p>In industrial ecology, we see the circular economy as the central vision for the sustainable use of natural resources AND a main driver for the sustainability transformation of the industrial system. At the same time, there is a lot of hot air around the circular economy. Scientific scrutiny is needed to understAND which products, business models, incentives, AND regulations will effectively decouple human wellbeing FROM resource use. Industrial ecology research offers a number of important tools, including material flow analysis, life cycle assessment, AND scenario modelling of production AND consumption, to find out which of the many circular economy strategies are the most promising ones, to estimate their resource savings potential AND their economic costs/gains, AND to understAND how different strategies can be combined effectively to reach multiple sustainable development goals.</p>
        <br>
        <p> Check our blog entries on the topic:</p>
        <p>How will a sustainable circular economy look like? <a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2023/06/01/how-will-a-sustainable-circular-economy-look-like/" target="_blank"> Click here to read the blog post </a></p>

        <p>The Circular Economy: Breakthrough or Distraction?<a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2017/12/15/the-circular-economy-breakthrough-or-distraction/" target="_blank"> Click here to read the blog post</a></p>

        <p>Wanted: Lead Indicators for the Circular Economy in Organizations<a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2017/10/22/wanted-lead-indicators-for-the-circular-economy-in-organizations/" target="_blank"> Click here to read the blog post</a></p>

        <p>Growth of in-use stocks: Central obstacle to closing material cycles<a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2017/11/13/growth-of-in-use-stocks-central-obstacle-to-closing-material-cycles/" target="_blank"> Click here to read the blog post</a></p>

        <p>The lifetime of materials in the techno-sphere<a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2017/10/29/the-lifetime-of-materials-in-the-technosphere/" target="_blank"> Click here to read the blog post</a></p>
        <br>
        <p>A circular economic system that reduces material extraction can also reduce GHG emissions FROM carbon-intensive material production. To understAND the climate, policy, AND business implications of circular economy AND the energy transition combined, an inter-disciplinary scientific assessment is necessary. However, current GHG mitigation models AND scenarios that inform climate policymakers do not generally include circular economy (CE) options. They also do not cover the possible synergies of the CE with other societal goals such as the Sustainable Development Goals (SDGs), nor the challenges involved in rearranging value chains AND consumer behaviour.</p>
        <br>
        <h2 style="text-align: center;">CIRCOMOD: circular economy modelling for climate change mitigation </h2>
        <br>
        <p>The EU-funded project CIRCOMOD (circular economy modelling for climate change mitigation) is the main funding source AND research platform for our current circular economy modelling activities. In CIRCOMOD, we develop a new generation of advanced models AND scenarios that will assess how CE can reduce future GHGs AND material use. The project brings together a unique consortium of leading research teams FROM different disciplines, including industrial ecology AND material flow modelling, process-oriented integrated assessment modelling, AND macro-economic modelling. It aims for a breakthrough in integrating CE AND GHG mitigation assessments AND will provide input to international assessments such as the Intergovernmental Panel on Climate Change (IPCC) AND the International Resource Panel (IRP). See the project’s homepage <a href="https://circomod.eu/" target="_blank">[https://circomod.eu/]</a> for details!</p>
        <br>
        <h2 style="text-align: center;">Visualising the circular economy </h2>
        <br>
         Here, we show AND test different visualization options for our circular economy scenarios.
        <hr/>


        <i>
            <b>Browse the results of our circular economy AND climate impact assessment of different global development scenarios (Pauliuk et al. 2021) <a href="https://doi.org/10.1038/s41467-021-25300-4" target="_blank">[https://doi.org/10.1038/s41467-021-25300-4]</a> </b>
        </i>
      
<div class="grid-sankey">
    
    <h3>Sankey diagram of material flows (blue) AND GHG emissions (blue-green) for different countries, sectors, AND CE scenarios</h3>
    <br/>

    <SELECT id="DropDownListSankeyRegion"  required>
        <option value="" disabled SELECTed>Please SELECT region</option>
        <option value="France">France</option>
        <option value="Germany">Germany</option>
        <option value="Italy">Italy</option>
        <option value="PolAND">PolAND</option>
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
    </SELECT>


    <SELECT id="DropDownListSankeyScenario" required>
        <option value="" disabled SELECTed>Please SELECT scenerio</option>
        <option value="LED">LED</option>
        <option value="SSP1">SSP1</option>
        <option value="SSP2">SSP2</option>
    </SELECT>

    <SELECT id="DropDownListSector" required>
        <option value="" disabled SELECTed>Please SELECT sector</option>
        <option value="Residential building">Residential building</option>
        <option value="Passenger vehicles">Passenger vehicles</option>
    </SELECT>

    <SELECT id="DropDownListYear"  required>
    </SELECT>

    <SELECT id="DropDownListStrategy"  required>
        <option value="" disabled SELECTed>Please SELECT strategy</option>
        <option value="Baseline">Baseline</option>
        <option value="HIY">HIY</option>
        <option value="HIY-RLU">HIY-RLU</option>
        <option value="HIY-RLU-MSU">HIY-RLU-MSU</option>
        <option value="HIY-RLU-MSU-ULD">HIY-RLU-MSU-ULD</option>
        <option value="HIY-RLU-MSU-DOS">HIY-RLU-MSU-DOS</option>
        <option value="HIY-RLU-MSU">HIY-RLU-MSU</option>
        <option value="HIY-RLU-MSU-DOS-CAS">HIY-RLU-MSU-DOS-CAS</option>
        <option value="Full CE">Full CE</option>
    </SELECT>


    <SELECT id="DropDownListMaterial" required>
        <option value="" disabled SELECTed>Please SELECT material</option>
        <option value="Cement">Cement</option>
        <option value="Steel">Steel</option>
        <option value="Aluminium ">Aluminium</option>
        <option value="Copper">Copper</option>
        <option value="Plastics">Plastic</option>
        <option value="Wood">Wood</option>

    </SELECT>
   

    <input type="button" class="DDSELECTSankey" value="Click me">
    <br/>
    <span id="errorMsg"  ></span>

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
        

<textarea id="input_node_data" type="text" rows="8" cols="120"   class="form-control">
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

    <textarea id="input_flow_data" type="text" rows="8" cols="120"   class="form-control">    
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
    <span id="spnOutputMessage" class="label label-danger" ></span>
    <div id="div_svg">
    <p id="chart">
        <svg class="img-responsive" id="target_svg" xmlns="http://www.w3.org/2000/svg" version="1.1"></svg>
    </p>
    </div>
</div>
        <hr/>
          <h3>Service level by country AND scenario for passenger vehicle transportation</h3>
    </div>

    <div class="grid-dropdown">

        <SELECT id="DropDownListRegion">
            <option value="" SELECTed>Please SELECT region</option>
            <option value="France">France</option>
            <option value="Germany">Germany</option>
            <option value="Italy">Italy</option>
            <option value="PolAND">PolAND</option>
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
        </SELECT>
        <button type="button" class="DDSELECTRegSce">Click me</button>

    </div>
    <canvas id="line-chart"></canvas>

</div>

</asp:Content>