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
            The industrial ecology group in Freiburg develops and maintains the ODYM dynamic material flow analysis (MFA) software and the RECC scenario model for services, stocks, material cycles, and energy and environmental extensions.
            <center>
                <h3>ODYM – The Open Dynamic Material Systems Model</h3>
            </center>
            <br>
            <p>ODYM is an open source framework for material systems modeling programmed in Python. The description of systems, processes, stocks, flows, and parameters is object-based, which facilitates the development of modular software and testing routines for individual model blocks. ODYM MFA models can handle any depth of flow and stock specification: products, components, sub-components, materials, alloys, waste, and chemical elements can be traced simultaneously. ODYM features a new data structure for material flow analysis; all input and output data are stored in a standardized file format and can thus be exchanged across projects. It also comes with an extended library for dynamic stock modeling.</p>
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
            <br>
            <br>
            <center>
                  <h3>RECC - Resource Efficiency – Climate Change mitigation framework</h3>
              </center>
            <br>
            <p>
                The resource efficiency–climate change (RECC) mitigation model framework is a step towards the interdisciplinary scientific assessment of material efficiency and its links to service provision, material cycle management, and climate policy. 
                RECC is based on dynamic material flow analysis and links the services provided (individual motorized transport and shelter) to the operation of in-use stocks of products (passenger vehicles and residential buildings), to their expansion and maintenance, and to their material cycles to model mitigation strategies and analyze trade-offs for environmental impacts along the products’ life cycle. A key innovation of RECC is the upscaling of product archetypes with different degrees of material and energy efficiency, which are simulated with engineering tools. 
                RECC scenarios are driven by parameters that augment the storylines of the shared socioeconomic pathways (SSP) to describe future service demand and associated material requirements. In its current implementation (model versions 2.2., 2.4, and 2.5), ten material efficiency strategies at different stages of the material cycle can be assessed by ramping up their implementation rates to the identified technical potentials.
                RECC provides scenario results for the life cycle impacts of ambitious service–material decoupling concurrent with energy system decarbonization, giving detailed insights on the RECC mitigation nexus to policy-makers worldwide.
            </p>
            <br>
            <b>RECC resources:</b>
            <br>
            <br>
            Journal paper on the framework (open access):  <a href="https://onlinelibrary.wiley.com/doi/full/10.1111/jiec.13023" target="_blank">https://onlinelibrary.wiley.com/doi/full/10.1111/jiec.13023 </a>
            <br>
            <br>
            RECC Python code on GitHub:   <a href="https://github.com/YaleCIE/RECC-ODYM" target="_blank">https://github.com/YaleCIE/RECC-ODYM </a>
            <br>
            <br>
            Journal paper on a major case study (open access): <a href="https://doi.org/10.1038/s41467-021-25300-4 " target="_blank">https://doi.org/10.1038/s41467-021-25300-4  </a>
            <br>
            <br>
            Complete RECC model documentation with additional results of global case study on vehicles and buildings:  <a href="https://static-content.springer.com/esm/art%3A10.1038%2Fs41467-021-25300-4/MediaObjects/41467_2021_25300_MOESM1_ESM.pdf  " target="_blank">https://static-content.springer.com/esm/art%3A10.1038%2Fs41467-021-25300-4/MediaObjects/41467_2021_25300_MOESM1_ESM.pdf   </a>
            <br>
            <br>
            RECC v2.4. input database:    <a href="https://zenodo.org/record/4671644#.YtezrN9CRhE " target="_blank">https://zenodo.org/record/4671644#.YtezrN9CRhE  </a>
            <br>
            <br>
            RECC v2.4 model result database: <a href="https://zenodo.org/record/4698619#.Yte09t9CRhE " target="_blank">https://zenodo.org/record/4698619#.Yte09t9CRhE  </a>
            <br>
            <br>
            RECC model tutorial video:  <a href="https://www.youtube.com/watch?v=zOfo1WTk7d8.  " target="_blank">https://www.youtube.com/watch?v=zOfo1WTk7d8.</a> This tutorial video show how to run the ODYM-RECC dynamic material flow analysis (MFA) model on your own machine. 
             It explains where the model config information is stored and how the different model scripts work together to compute both single and multiple scenarios.
            <br>
            <br>
            <center>
                <figure>
                    <img src="resources/SysDef_Model_v2_4.png" alt="Recc Model" width="650" height="400">
                    <figcaption>Figure: System definition of the RECC model with global scope..</figcaption>
                </figure>
            </center>


        </div>
    </div>
</asp:Content>

