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
        .grid-circo {
            grid-area: circo;
        }

        .grid-dropdown {
            grid-area: dropdown;
            padding-top: 2em ;
        }

     
        .grid-graph {
            grid-area: graph;
        }

        h2 {
            text-align: center;

        }

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
    </style>
    
    <script src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/dropdownMenu.js"></script>
    <script type="text/javascript" src="js/jquery-1.6.2.js"></script>
    <script type="module" src="js/chart.min.js"></script>



   
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
            <hr />
            <i><b>Browse the results from the project’s database (prototype, under development)</b></i>
        </div>

        <div class="grid-dropdown">

            <select id="DropDownListRegion" >
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



            <select id="DropDownListScenario" >
                <option value="" selected>Please select scenerio</option>
                <option value="LED">LED</option>
                <option value="SSP1">SSP1</option>
                <option value="SSP2">SSP2</option>
            </select>
            <button type="button" class="DDSelectRegSce">Click me</button>

        </div>
        <canvas id="line-chart"></canvas>

    </div>

</asp:Content>
