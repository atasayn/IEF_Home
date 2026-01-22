<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="iefWorkingPaper.aspx.cs" Inherits="IEF_Home.iefWorkingPaper" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        #header {
            text-align: center
        }

        .row {
            display: flex;
            flex-wrap: wrap;
        }

        .column {
            flex: 1;
            padding: 5px;
            min-width: 100px; /* Minimum width to maintain readability */
            margin: auto
        }

        img {
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
        /* Add media queries for different screen sizes */
        @media (max-width: 1200px) {
            .column {
                flex: 0 0 50%; /* 2 columns on small screens */
            }
        }

        @media (max-width: 768px) {
            .column {
                flex: 0 0 50%; /* 2 columns on small screens */
            }
        }

        @media (max-width: 480px) {
            .column {
                flex: 0 0 100%; /* 1 column on extra small screens */
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div id="header">
        <h2>Industrial Ecology Freiburg (IEF) Working Papers</h2>
    </div>
    <div id="info">
        <p>
            <b>Industrial Ecology Freiburg (IEF) Working Papers</b> is a series of scientific reports by the research group for industrial ecology at the Faculty of Environment and Natural Resources, 
            University of Freiburg, Germany.The reports cover various topics and appear in irregular intervals. 
            They are not peer-reviewed, though some reports reflect governing bodies’ and expert group consensus or contain content that was put up for public feedback prior to publication. 
            The reports are published (DOI-minted) by our Uni’s publishing system FreiDok. All reports published so far are listed below. 
            To see all our publications, please check the Google Scholar profiles of the different group members.
        </p>
    </div>

   <div class="row">

        <div class="column">
            <img src="Content/workingPaperPngs/IEF_WP_1_2026.png" width="300">
        </div>
        <div class="column">
            <p>IEF Working paper 1 (2026)</p>
            <p>
                <b>Industrial Ecology Data Commons Handbook. </b>
                Stefan Pauliuk and Nildem Atasayar (2026). Industrial Ecology Freiburg (IEF) Working Paper 1(2026), Universität Freiburg im Breisgau.
            </p>
            <a href="https://doi.org/10.6094/UNIFR/xxx" target="_blank">To be published soon! </a>
        </div>
       <div class="column">
           <img src="Content/workingPaperPngs/IEF_WP_4_2025_Thumbnail.png" width="300">
       </div>
       <div class="column">
           <p>IEF Working paper 4 (2025)</p>
           <p>
               <b>Socio-metabolic inequality – A research agenda.</b>
               Stefan Pauliuk. Industrial Ecology Freiburg (IEF) Working Paper 4(2025), University of Freiburg, Germany.
           </p>
           <a href="https://doi.org/10.6094/UNIFR/269286  " target="_blank">https://doi.org/10.6094/UNIFR/269286 </a>
       </div>
    </div>

    <div class="row">
        <div class="column">
            <img src="Content/workingPaperPngs/IEF_WP_3_2025_Thumbnail.png" width="300">
        </div>
        <div class="column">
            <p>IEF Working paper 3 (2025)</p>
            <p>
                <b>Environmental Assessment of Circular Economy Strategies in an Element-based Multi-Purpose Wooden Building.</b>
                Christian Buschbeck, Stefan Pauliuk, Stephan Birk, Konstantin Goldschmidt, Cheng Lu, Hamid Sadegh-Azar, Viktor Poteschkin, 
                Reiner Klopfer, Wenchang Shi, and Jürgen Graf. Industrial Ecology Freiburg (IEF) Working Paper 3(2025), University of Freiburg, Germany.
            </p>
            <a href="https://doi.org/10.6094/UNIFR/268540 " target="_blank">https://doi.org/10.6094/UNIFR/268540 </a>
        </div>
        <div class="column">
            <img src="Content/workingPaperPngs/IEF_WP_2_2025_Thumbnail.png" width="300">
        </div>
        <div class="column">
            <p>IEF Working paper 2 (2025)</p>
            <p>
                <b>Short-Term Socio-Economic Impacts of EU Carbon Border Adjustment Mechanism (CBAM) on
                    EU Countries and Their Trade Partners under Different Revenue Redistribution Schemes.</b>
                Gilang
                Hardadi. Industrial Ecology Freiburg (IEF) Working Paper 2(2025), University of Freiburg, Germany.
            </p>
            <a href="https://doi.org/10.6094/UNIFR/266690 " target="_blank">https://doi.org/10.6094/UNIFR/266690 </a>
        </div>
    </div>
    <div class="row">

       
        <div class="column">
            <img src="Content/workingPaperPngs/IEF_WP_1_2025_Thumbnail.png" width="300">
        </div>
        <div class="column">
            <p>IEF Working paper 1 (2025)</p>
            <p>
                <b>Flächennutzung und Materialverbrauch der Infrastruktur für den motorisierten Individualverkehr in Freiburg im Breisgau. </b>
                Alexander McShane und Stefan Pauliuk. Industrial Ecology Freiburg (IEF) Working Paper 1(2025), Universität Freiburg im Breisgau.
            </p>
            <a href="https://doi.org/10.6094/UNIFR/266378 " target="_blank">https://doi.org/10.6094/UNIFR/266378</a>
        </div>
        <div class="column">
            <img src="Content/workingPaperPngs/guidelinesAndGoodPractice.png" width="300">
        </div>        
        <div class="column">
            <p>IEF Working paper 1 (2024)</p>
            <p>
                <b>Guidelines and Good Practice Examples for Complete Traceability of Workflows and Reproducibility of Results in Industrial Ecology Research.</b>
                Stefan Pauliuk, Christoph Helbig, Richard C Lupton, Peter Paul Pichler, Simon Schulte, Konstantin Stadler, Peng Wang, and Dominik Wiedenhofer. 
                Endorsed by the Board of the Topical Section for Research on Socio-Economic Metabolism (SEM) of the International Society for Industrial Ecology (ISIE).
                Industrial Ecology Freiburg (IEF) Working Paper 1(2024), University of Freiburg, Germany. 
            </p>
            <a href="https://doi.org/10.6094/UNIFR/255618" target="_blank">https://doi.org/10.6094/UNIFR/255618</a>
        </div>
    </div>

    <div class="row">
        <div class="column">
            <img src="Content/workingPaperPngs/IEF_WP_2_2024 (002).png" width="300">
        </div>
        <div class="column">
            <p>IEF Working paper 2 (2024)</p>
            <p>
                <b>Klimaschutz im Transportsektor – Eine Szenarioanalyse für Freiburg. </b>
                Tim Weber und Stefan Pauliuk. Industrial Ecology Freiburg (IEF) Working Paper 2 (2024), University of Freiburg, Germany.
            </p>
            <a href="https://doi.org/10.6094/UNIFR/257136" target="_blank">https://doi.org/10.6094/UNIFR/257136</a>
        </div>
        <div class="column">
            <img src="Content/workingPaperPngs/documentationOfTheRecc2.5.png" width="300">
        </div>
        <div class="column">
            <p>IEF Working paper 1 (2023)</p>
            <p>
                <b>Documentation of the RECC model v2.5 - Open Dynamic Material Systems Model for the Resource Efficiency-Climate Change (RECC) Nexus.</b>
                Stefan Pauliuk. Industrial Ecology Freiburg (IEF) Working Paper 1(2023), University of Freiburg, Germany.
            </p>
            <a href="https://doi.org/10.6094/UNIFR/242061" target="_blank">https://doi.org/10.6094/UNIFR/242061</a>
        </div>
    </div>
    <div class="row">
      
        <div class="column">
            <img src="Content/workingPaperPngs/characterizationFactorsFor.png" width="300">
        </div>
        <div class="column">
            <p>IEF Working paper 3 (2022)</p>
            <p>
                <b>Characterization factors for material flow accounting (material footprint) for process-based LCA – Documentation for ecoinvent 3.7.1 and 3.8 in openLCA.</b>
                Stefan Pauliuk. Industrial Ecology Freiburg (IEF) Working Paper 3(2022), University of Freiburg, Germany.
            </p>
            <a href="https://doi.org/10.6094/UNIFR/226265" target="_blank">https://doi.org/10.6094/UNIFR/226265</a>
        </div>
        <div class="column">
            <img src="Content/workingPaperPngs/szenarioanalyseFürMaterialverbrauch.png" width="300">
        </div>
        <div class="column">
            <p>IEF Working paper 2 (2022)</p>
            <p>
                <b>Szenarioanalyse für Materialverbrauch, Energiebedarf und Klimaauswirkungen des geplanten Stadtteils „Dietenbach“ in Freiburg.</b>
                Leonid Krebs und Stefan Pauliuk (2022). Industrial Ecology Freiburg (IEF) Working Paper 2(2022), Universität Freiburg im Breisgau. DOI
            </p>
            <a href="https://doi.org/10.6094/UNIFR/225544" target="_blank">https://doi.org/10.6094/UNIFR/225544</a>
        </div>
    </div>
    <div class="row">

        <div class="column">
            <img src="Content/workingPaperPngs/portableAndFlexibleTech.png" width="300">
        </div>
        <div class="column">
            <p>IEF Working paper 1 (2022)</p>
            <p>
                <b>Portable and Flexible Tech Setups for Blended Synchronous University Courses. </b>
                Stefan Pauliuk. Industrial Ecology Freiburg (IEF) Working Paper 1(2022), University of Freiburg, Germany.
            </p>
            <a href="https://doi.org/10.6094/UNIFR/224838" target="_blank">https://doi.org/10.6094/UNIFR/224838</a>
        </div>
        <div class="column">
            <img src="Content/workingPaperPngs/treibhausgasbilanzDerUniversitat.png" width="300">
        </div>
        <div class="column">
            <p>IEF Working paper 1 (2021)</p>
            <p>
                <b>Treibhausgasbilanz der Universität Freiburg im Breisgau 2017. </b>
                Stefan Pauliuk, Marcel Eichler, Benjamín Elizalde Durán, Andrew Bonneau, Arthur Jakobs, Jürgen Steck und Heiner Schanz (2021). Industrial Ecology Freiburg (IEF) Working Paper 1(2021), Universität Freiburg im Breisgau.
            </p>
            <a href="https://doi.org/10.6094/UNIFR/176419" target="_blank">https://doi.org/10.6094/UNIFR/176419 </a>
        </div>
    </div>
    <div class="row">

        <div class="column">
            <img src="Content/workingPaperPngs/guidelinesForDataModeling.png" width="300">
        </div>
        <div class="column">
            <p>IEF Working paper 2 (2021)</p>
            <p>
                <b>Guidelines for Data Modeling and Data Integration for Material Flow Analysis and Socio-Metabolic Research.</b>
                Issued by the Board of the Topical Section for Research on Socio-Economic Metabolism (SEM) of the International Society for Industrial Ecology (ISIE). 
                Industrial Ecology Freiburg (IEF) Working Paper 2(2021), University of Freiburg, Germany
            </p>
            <a href="https://doi.org/10.6094/UNIFR/217970" target="_blank">https://doi.org/10.6094/UNIFR/217970</a>
        </div>
        
        <div class="column">
            <img src="Content/workingPaperPngs/IEF_WP_1_2017.png" width="300">
        </div>
        <div class="column">
            <p>IEF Working paper 1 (2017)</p>
            <p>
                <b>Die Umweltauswirkungen der FreiburgCup – Eine Ökobilanzierung und Evaluierung des Freiburger Mehrwegsystems für ToGo-Becher. </b>
                Johannes Althammer, Kaja Weldner, Stefan Pauliuk (2017). Industrial Ecology Freiburg (IEF) Working Paper 1(2017), Universität Freiburg im Breisgau.
            </p>
            <a href="https://doi.org/10.6094/UNIFR/275671" target="_blank">https://doi.org/10.6094/UNIFR/275671 </a>
        </div>
    </div>

   <div class="row">

        <div class="column">
            <p> </p>
        </div>
        <div class="column">
            <p> </p>
        </div>
    </div>

<%--    <div class="row">
        
        
        <div class="column"></div>
        <div class="column"></div>
    </div>--%>
</asp:Content>
