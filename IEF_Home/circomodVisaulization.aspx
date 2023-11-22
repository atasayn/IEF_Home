<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="circomodVisaulization.aspx.cs" Inherits="IEF_Home.circomodVisaulization" %>
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

        main{
            background-color: #A9A9A9;
        }

        #DataMenu-Recc-GraphType {
            grid-template-columns: 260px auto auto;
            grid-template-rows: auto ;
            display: grid;
        }

        #DataMenu{
            display:block;
            background: #ffffff;
            padding:15px;
            border-radius:10px;

        }

        #recc{
            position: relative;
            width: 100%;
            background: #ffffff;
            margin:0 15px;
            border-radius: 10px;
            max-width:1100px;
                 
        }

        #well-being {
	        position: absolute;
	        top: 30.2%;
	        left: 9.8%;
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
	        left: 22.9%;
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
	        top: 30%;
	        left: 35.9%;
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
	        top: 21.5%;
	        left: 49%;
	        transform: translate(-50%, -50%);
	        cursor: pointer;
	        border-radius: 5px;
	        width: 123px;
	        height: 73px;
	        background: rgb(68,114,196);
	        color: #ffffff;
	        font-weight: bold;
        }

        #operational-energy {
	        position: absolute;
	        top: 40%;
	        left: 49%;
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
	        top: 31.1%;
	        left: 62.2%;
	        transform: translate(-50%, -50%);
	        cursor: pointer;
	        border-radius: 5px;
	        width: 120px;
	        height: 104px;
	        background: rgb(68,114,196);
	        color: #ffffff;
	        font-weight: bold;
        }

        #extraction {
	        position: absolute;
	        top: 32%;
	        left: 76.2%;
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
	        top: 31%;
	        left: 90.2%;
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
	        top: 59.3%;
	        left: 49%;
	        transform: translate(-50%, -50%);
	        cursor: pointer;
	        border-radius: 5px;
	        width: 143px;
	        height: 74px;
	        background: #FFD993;
	        color: #000000;
	        font-weight: bold;
        }

        label{
            text-align: right;
            clear: both;
            float:left;
            margin-right:15px;
        }
        select{
            width:150px;
            float:right;
        }



    </style>
    <script src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/dropdownMenu.js"></script>
    <script type="text/javascript" src="js/jquery-1.6.2.js"></script>
    <script type="module" src="js/chart.min.js"></script>

    <script>

        $(document).ready(function() {
            const room = document.querySelector("#DropDownListYear");

            for (let i = 2022; i <= 2060; i++) {
                room.insertAdjacentHTML("beforeend", `<option value="${i}">${i}</option>`);
            }
        });

    </script>   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
<div id="DataMenu-Recc-GraphType" >
    <div id="DataMenu" class="column">
    
        <b>CE Profiles</b> 
        <br>
        <br>
        <label for="Title">Region:</label>
        <select id="DropDownListSankeyRegion" size="8" required>
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

     <label for="Title">Scenario:</label>
     <select id="DropDownListSankeyScenario" size="8" required>
        <option value="LED">LED</option>
        <option value="SSP1">SSP1</option>
        <option value="SSP2">SSP2</option>
    </select>
    
    <label for="Title">Sector: </label>
    <select id="DropDownListSector" size="8" required>
        <option value="Passenger vehicles">Passenger vehicles</option>
        <option value="Residential building">Residential building</option>
        <option value="Non-Residential building">Residential building</option>
    </select>
    </div>

   
    <div id="RECCScheme">
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
      <div />
    </div>
    </div>
 <div />
</asp:Content>
