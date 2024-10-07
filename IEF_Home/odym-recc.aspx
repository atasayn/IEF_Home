<%@ Page Title="ODYM-RECC" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="odym-recc.aspx.cs" Inherits="IEF_Home.odym_recc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <style>
        @media screen and (max-width: 768px) {
          
            img{
                width: 90%;
                height: auto;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="row">
        <div class="col-md-12">
            At Industrial Ecology Freiburg, we work at the forefront of sustainability science. This work involves the development of research infrastructure, including data models, databases, and scenario models for the circular economy. We are committed to open science and share our core model infrastructure and data with the global sustainability science community.
            <center>
                <h2>ODYM – The Open Dynamic Material Systems Model</h2>
            </center>
            <br>
            <p>ODYM is an open source framework for material systems modeling programmed in Python. The description of systems, processes, stocks, flows, and parameters is object-based, which facilitates the development of modular software and testing routines for individual model blocks. ODYM MFA was developed for large MFA models that span many years (historic and future) and WHERE different products, components, sub-components, materials, alloys, waste, and chemical elements need to be traced simultaneously. ODYM features a new data structure for material flow analysis; all input and output data are stored in a standardized file format and can thus be exchanged across projects. It also comes with an extended library for dynamic stock modelling, which can also be used as standalone script. </p>
            <br>
            <b>ODYM resources:</b>
            <br>
            <br>
            Journal paper (open access):  <a href="https://doi.org/10.1111/jiec.12952" target="_blank">https://doi.org/10.1111/jiec.12952 </a>
            <br>
            <br>
            ODYM Python code on GitHub:   <a href="https://github.com/IndEcol/ODYM" target="_blank">https://github.com/IndEcol/ODYM </a>with documentation of ODYM classes and functions
            <br>
            <br>
            The Wiki of the ODYM software:<a href="https://github.com/IndEcol/ODYM/wiki " target="_blank"> https://github.com/IndEcol/ODYM/wiki  </a>
            <br>
            <br>
            ODYM tutorials and exercises (part of the Industrial Ecology Open Online Course IEooc):  <a href="https://www.industrialecology.uni-freiburg.de/teaching.aspx " target="_blank">https://www.industrialecology.uni-freiburg.de/teaching.aspx  </a>(scroll down for IEooc_Methods3_Software3 to IEooc_Methods3_Software8)
            <br>
            <br>
            ODYM is evolving into a community tool for industrial ecologist, MFA experts, and socio-economic metabolism researchers worldwide. A number of new developments and contributions by different community members are on their way, including routines for Monte-Carlo simulation, data reconciliation, and parallel computing.
            <br>
            <br>
            <center>
                  <h2>RECC - Resource Efficiency – Climate Change mitigation framework</h2>
              </center>
            <br>
            <p>
                The resource efficiency–climate change (RECC) mitigation model framework is a step towards the interdisciplinary scientific assessment of material efficiency and its links to service provision, material cycle management, and climate policy. 
                RECC is based on dynamic material flow analysis and links the services provided (individual motorized transport and shelter) to the operation of in-use stocks of products (passenger vehicles and residential buildings), to their expansion and maintenance, and to their material cycles to model mitigation strategies and analyze trade-offs for environmental impacts along the products’ life cycle. A key innovation of RECC is the upscaling of product archetypes with different degrees of material and energy efficiency, which are simulated with engineering tools. 
                RECC scenarios are driven by parameters that augment the storylines of the shared socioeconomic pathways (SSP) to describe future service demand and associated material requirements. In its current implementation (model versions 2.2., 2.4, and 2.5), ten material efficiency strategies at different stages of the material cycle can be assessed by ramping up their implementation rates to the identified technical potentials.
                RECC provides scenario results for the life cycle impacts of ambitious service–material decoupling concurrent with energy system decarbonization, giving detailed insights on the RECC mitigation nexus to policy-makers worldwide.
            </p>
            <br>
            <b>RECC system definition: </b>
            <br>
            <br>
             <center>
                <figure>
                    <img src="resources/RECC_SysDef_Model_v2_5a.png" alt="Recc Model" width="768" height="381">
                    <figcaption>Figure: System definition of the RECC model with global scope..</figcaption>
                </figure>
            </center>
            <br>
            <b>RECC resources:</b>
            <br>
                
            <br>
            Currently, about ten researchers contribute to further developing the RECC model and its database, mainly via the EU CIRCOMOD [<a href="https://circomod.eu/" target="_blank">https://circomod.eu/</a>] project. We plan to include transportation infrastructure, link the RECC scenarios to sectoral and general equilibrium models, couple RECC to forest growth models, and to study the impact of energy transition and circular economy strategies on different socioeconomic groups. We have a mailing list for internal communication around the model. Contact us if you want to be on the RECC model mailing list!
            <br>
            <br>
            RECC model brief: <a href="research/Documents/RECC_Model_Brief_Nov23.pdf" target="_blank">RECC_Model_Brief_Nov23.pdf</a> 
            <br>
            <br>
            Overview [presentation (pdf)] on the RECC model framework:  <a href="/research/Documents/RECC_Model_Overview_July_2023.pdf" target="_blank">RECC_Model_Overview_July_2023.pdf </a>
      
            <br>
            <br>
            First RECC results: IRP report link:  <a href="https://www.resourcepanel.org/reports/resource-efficiency-and-climate-change " target="_blank">https://www.resourcepanel.org/reports/resource-efficiency-and-climate-change  </a>
            <br>
            <br>
            Journal paper on the framework (open access):  <a href="https://onlinelibrary.wiley.com/doi/full/10.1111/jiec.13023 " target="_blank" >https://onlinelibrary.wiley.com/doi/full/10.1111/jiec.13023 </a>
            <br>
            <br>
            RECC Python code on GitHub:   <a href="https://github.com/IndEcol/RECC-ODYM" target="_blank">https://github.com/IndEcol/RECC-ODYM </a>
            <br>
            <br>
            JRECC model development canvas: <a href="https://docs.google.com/presentation/d/1Iw8LkWveC-BWy69ULVZdp5Wj2Q1udouwYPtFw2ixsQc/edit?usp=sharing  " target="_blank">https://docs.google.com/presentation/d/1Iw8LkWveC-BWy69ULVZdp5Wj2Q1udouwYPtFw2ixsQc/edit?usp=sharing</a>
            <br>
            <br>
            <b>RECC tutorials:</b>
            <br>
            <br>
            RECC model tutorial video: <a href="https://www.youtube.com/watch?v=zOfo1WTk7d8" target="_blank">https://www.youtube.com/watch?v=zOfo1WTk7d8</a>. This tutorial video show how to run the ODYM-RECC dynamic material flow analysis (MFA) model on your own machine. It explains where the model config information is stored and how the different model scripts work together to compute both single and multiple scenarios.
            <br>
            <br>           
            RECC multi-scenario generation tutorial video: <a href="research/Documents/RECC_Multiple_Scenarios_HowTo.mp4" target="_blank">RECC_Multiple_Scenarios_HowTo.mp4</a>
            <br>
            <br>              
            RECC results evaluation tutorial video:<a href="research/Documents/RECC_Aggregation_Visualisation_HowTo.mp4" target="_blank">RECC_Aggregation_Visualisation_HowTo.mp4</a>
            <br>
            <br>              
            Using RECC at the city level, tutorial video: <a href="research/Documents/RECC_City_Level_HowTo.mp4" target="_blank">RECC_City_Level_HowTo.mp4</a>
            <br>
            <br>
            Data documentation routine: The ODYM data process, see the short manual:<a href="research/Documents/ODYM_Data_Processes_ODP_Manual.pdf" target="_blank">ODYM_Data_Processes_ODP_Manual.pdf</a>.
            See the following sample parameter file as example: <a href="research/Documents/2_S_RECC_FinalProducts_2015_nonresbuildings_V2.2.xlsx" target="_blank">2_S_RECC_FinalProducts_2015_nonresbuildings_V2.2.xlsx</a>
            <br>
            <br>
            <b>RECC v2.5 (current model version):</b>
            <br>
            <br>
            RECC Python code on GitHub: <a href="https://github.com/IndEcol/RECC-ODYM" target="_blank">https://github.com/IndEcol/RECC-ODYM</a>
            <br>
            <br>
            RECC v2.5 model documentation:<a href="https://doi.org/10.6094/UNIFR/242061" target="_blank">https://doi.org/10.6094/UNIFR/242061</a>
            <br>
            <br>
            RECC v2.5 global building stock model input and result database - Input data and results of the RECC v2.5 model for the transformation scenarios of the global building stock: <a href="https://zenodo.org/records/12752350" target="_blank">https://zenodo.org/records/12752350</a>
            <br>
            <br>
            <b>RECC v2.4:</b>
            <br>
            <br>
            Journal paper on the global case study on vehicles and buildings (open access): <a href="https://doi.org/10.1038/s41467-021-25300-4 " target="_blank">https://doi.org/10.1038/s41467-021-25300-4 </a>
            <br>
            <br>
            Complete RECC v2.4 model documentation with additional results of global case study on vehicles and buildings:<a href="https://static-content.springer.com/esm/art%3A10.1038%2Fs41467-021-25300-4/MediaObjects/41467_2021_25300_MOESM1_ESM.pdf" target="_blank">https://static-content.springer.com/esm/art%3A10.1038%2Fs41467-021-25300-4/MediaObjects/41467_2021_25300_MOESM1_ESM.pdf</a>  
            <br>
            <br>
            RECC Python code on GitHub:<a href="https://github.com/IndEcol/RECC-ODYM" target="_blank"> https://github.com/IndEcol/RECC-ODYM</a>
            <br>
            <br>
            Final model commit for RECC global paper, RECC v2.4: 9c93d9b
            <br>
            <br>
            Final model commit for RECC v2.4 Germany: cb3a388
            <br>
            <br>
            RECC v2.4. input database:<a href="https://zenodo.org/record/4671644#.YtezrN9CRhE" target="_blank">https://zenodo.org/record/4671644#.YtezrN9CRhE </a> 
            <br>
            <br>
            RECC v2.4 model result database:<a href="https://zenodo.org/record/4698619#.Yte09t9CRhE" target="_blank">https://zenodo.org/record/4698619#.Yte09t9CRhE</a>  
        </div>
    </div>
</asp:Content>

