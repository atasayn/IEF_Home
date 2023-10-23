<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="circomodiFrame.aspx.cs" Inherits="IEF_Home.circomodiFrame" %>

<!DOCTYPE html>
<style>

    .grid-sankey {
        background: #ffffff;
    }

    h3 {
        text-align: center
    }

    svg {
        pointer-events: none;
        user-SELECT: none;
        width: auto
    }

    .label {
        display: none;
    }

    #iframeContainer {
        position: relative;
        display: block;
        background: linear-gradient(-90deg, rgba(0,160,130,1) 30%, rgba(52,74,154,1) 100%);
        border-style: inset;
        border-color: #34499a;
        border-radius: 5px;
        width: auto;
        height: auto;

    }

    @media screen AND (max-width: 768px) {
        #iframeContainer {
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

    $(document).ready(function () {
        $("#DropDownListYear").append("<option>" + "Please SELECT year" + "</option>");

        const room = document.querySELECTor("#DropDownListYear");

        for (let i = 2022; i <= 2060; i++) {
            room.insertAdjacentHTML("beforeend", `<option value="${i}">${i}</option>`);
        }
    });



</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<div id="iframeContainer" >
    <a href="https://www.industrialecology.uni-freiburg.de/circomod" target="_blank">
        <img src="resources/IEF_LogoV_23_3.png" href="https://www.industrialecology.uni-freiburg.de/circomod" width="240px" height="110px">
    </a>
    <form id="form1" runat="server">
        <div class="grid-sankey">
    
    <h3>Sankey diagram of material flows (blue) AND GHG emissions (blue-green) for different countries, sectors, AND CE scenarios</h3>
    <br/>
    <SELECT id="DropDownListSankeyRegion">
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


    <SELECT id="DropDownListSankeyScenario">
        <option value="" SELECTed>Please SELECT scenerio</option>
        <option value="LED">LED</option>
        <option value="SSP1">SSP1</option>
        <option value="SSP2">SSP2</option>
    </SELECT>

    <SELECT id="DropDownListSector">
        <option value="" SELECTed>Please SELECT sector</option>
        <option value="Residential building">Residential building</option>
        <option value="Passenger vehicles">Passenger vehicles</option>
    </SELECT>

    <SELECT id="DropDownListYear">
    </SELECT>

    <SELECT id="DropDownListStrategy">
        <option value="" SELECTed>Please SELECT strategy</option>
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


    <SELECT id="DropDownListMaterial">
        <option value="" SELECTed>Please SELECT material</option>
        <option value="Cement">Cement</option>
        <option value="Steel">Steel</option>
        <option value="Aluminium ">Aluminium</option>
        <option value="Copper">Copper</option>
        <option value="Plastics">Plastic</option>
        <option value="Wood">Wood</option>

    </SELECT>


    <button type="button" class="DDSELECTSankey" >Click me</button>
    <br /><span id="errorMsg"  ></span>
   
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
    <span id="spnOutputMessage" class="label label-danger" ></span>
           
    <div id="div_svg">
    <p id="chart">
        <svg class="img-responsive" id="target_svg" xmlns="http://www.w3.org/2000/svg" version="1.1"></svg>
    </p>
    </div>
</div>

        <div>
        </div>
    </form>

</div>
</body>
</html>

