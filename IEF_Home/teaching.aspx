<%@ Page Title="Teaching" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="teaching.aspx.cs" Inherits="IEF_Home.teaching" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script>
        function jupyterLink(path, text) {
            document.write(`<a href="${path}" download target="new">${text} (ipynb)</a> | `);
            document.write(`<a href="https://nbviewer.org/urls/www.industrialecology.uni-freiburg.de${path}" target="_blank">Run externally in nbviewer</a>`);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="row">

        <div class="col-md-12">
            <center>
                <br>
                <br>
                <img src="/Content/IEooc_Logo_V2.png" width="250">
                <h2>Industrial Ecology Open Online Course </h2>
                <h4>Online since 2018 </h4>
                <br>
                <br>
            </center>
        </div>

    </div>

    <div class="row">

        <div class="col-md-12">
            The <i>Industrial Ecology Open Online Course (IEooc) </i>is a collection of online material that documents and explains the core industrial ecology concepts, methods, data, and applications. It serves as guide to new industrial ecology researchers by enabling them to conduct state-of-the-art science for sustainability.
            <br>
            <br>
            The course was developed for university students at all levels. It features lectures (screencasts and webinars of 15-60 minutes), exercises with sample solutions, code samples or notebooks, and reading material (papers, essays, reports, blog entries). There are now more than 50 exercises and tutorials, and these form the core of this course. All material is freely available for educational use.
            <br>
            <br>
            The course is divided into three broad sections: background, methods, and applications. In the background section a general introduction to the topic is given and the theoretical foundations of interdisciplinary systems science in general, and industrial ecology in particular, are laid. In the methods section the core industrial ecology methods material flow analysis, life cycle assessment, and input-output analysis are introduced. In the application section a number of selected case studies and other examples are presented. Readers can choose their preferred level of exposure to conceptual foundations, and can jump to the methods section, which also contains most of the exercises, at any point. For fully appreciating the origin, structure, and interrelation of the different industrial ecology methods, however, some extra work with the background material will be helpful. To grasp the content of the application section some familiarity with the industrial ecology methods is necessary. For each course item a quick summary of the content is provided, the prerequisites are stated, and the level of difficulty is indicated on a scale reaching from (+) (not very difficult) to (+++) (rather difficult).
            <br>
            <br>
            The course is built using freely available tools and data wherever possible. For the basic parts of the course a pdf reader, Excel or a similar spreadsheet tool, and access to Youtube are sufficient. The more advanced parts make use of the programming language Python via <a href="https://jupyter.org/" target="new">Jupyter notebooks</a>, and some of the LCA exercises use <a href="http://www.openlca.org" target="new">openLCA</a> in Connection with the <a href="http://www.ecoinvent.org/" target="new">ecoinvent</a> life cycle database. For some exercises reading material that is not generally available is required.
            <br>
            <br>
            The course consists of a combination of own and external material. I linked to content created by other scholars of the industrial ecology and other communities where appropriate. If you would like to have a link added or removed, let me know. If you would like to see your own content added, drop a line to stefan.pauliuk[at]indecol.uni-freiburg.de, and I will check whether it fits into the course. The course material will be improved and expanded over the next years, so that the syllabus can grow bit by bit. 
            <br>
            <br>
            Most of the material is made available under a Creative Commons Licence. It can be used in own teaching, modified and expanded. The slide material is available upon request.
            <br>
            <br>
            The course and its parts are designed for self-study. I don't have the capacity for individual supervision and guidance and will decline such requests unless they are related to mistakes in the material or parts of it that are confusing. There is no exam for this course and no certificate of participation.
            <br>
            <br>
            Suggestions for improvements or new content are welcome! 
            <br>
            <br>
            Stefan Pauliuk<br>
            University of Freiburg, Germany.
            <br>
            <br>
            <table>
                <tr>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>
                <tr>
                    <td>
                        <img src="/Content/440px-Global_Open_Educational_Resources_Logo.svg.png" width="200"></td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>The IEooc is an open educational resource (OER), which is a publicly accessible collection of teaching and study materials for any user to use, re-mix, improve, and redistribute. It is designed to reduce knowledge accessibility barriers, to implement best practices in teaching, and to be adapted to local contexts. </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>
                        <img src="/Content/OER.png" width="250"></td>
                </tr>
            </table>
        </div>
    </div>
    <br>
    <br>


    <div class="row">
        <div class="col-md-12">
            <center>
                <h2>IEooc Syllabus</h2>
                <h4>Last update: January 9th, 2024.</h4>
            </center>
            <br>
            <h3>Part I: Background </h3>
            <br>
        </div>
    </div>


    <div class="row">
        <div class="col-md-12">

		<b>A new introductory textbook for our field, "Industrial Ecology and Sustainability", by T.E. Graedel and M.J. Eckelman, was published in 2023.</b> Details: 512 pages, ISBN-13: 9789811277603, Publisher: World Scientific Publishing Company. The book is available both as hardcover and as e-book. It can be ordered online via Amazon, Barnes and Noble, etc.
            <br>
            <br>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <table border="0">

                <tr colspan="2">
                    <td><a name="Background"></a><b>Background 1: Conceptual Foundations</b></td>
                </tr>

                <tr>
                    <td width="30%"></td>
                    <td width="70%">
                        <b>Introductory text about systems thinking:</b> "Quantitative Analysis of Industrial Systems: Intellectual Framing". The text (16 pages) gives a brief introduction to systems thinking, contains a general theory for analysing coupled human-environment systems, and provides an explanation of what industrial ecology exactly is.
                        <br>
                        <a href="/Content/IEooc_Background1_Reading1_Framing.pdf" target="new">IEooc_Background1_Reading1</a>
                        <br>
                        <br>
                        <b>Introductory video: </b>17 min video lecture about industrial ecology:
                        <br>
                        <a href="https://www.youtube.com/watch?v=uHmFEqYLMT0" target="new">IEooc_Background1_Lecture1</a> (part of an online course on Systems Ecology by <a href="http://complexitylabs.io/product/systems-ecology-book/">Complexity Labs</a>.) 
                        <br>
                        <br>
                        <b>Classical reading: "The Economics of the Coming Spaceship Earth"</b>, by Kenneth E Boulding (1968):
                        <br>
                        <a href="/Content/IEooc_Background1_Reading2_Boulding_SpaceshipEarth.pdf" target="new">IEooc_Background1_Reading2</a>
                        <br>
                        <br>
                        <b>Classical reading: "Strategies for Manufacturing"</b>, by Frosch and Gallopoulus (1989):
                        <br>
                        <a href="/Content/IEooc_Background1_Reading3_Strategies_For_Manufacturing_Sci_American_1989.pdf" target="new">IEooc_Background1_Reading3</a>
                        <br>
                        <br>
                        <b>Exercise: Energy service cascade and stock-flow-service nexus.</b> Understand the way the social, economic, and environmental aspects of sustainability are linked in the field of industrial ecology and socio-metabolic research. Quantify product functions and estimate the impacts of energy supply and material production for providing these functions. <b>Prerequisites:</b> None. <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Background1_Exercise1_Stock_Flow_Service_Nexus.pdf" target="new">IEooc_Background1_Exercise1</a>.
                        <br>
                        A data workbook is available for this exercise:<br>
                        <a href="/Content/IEooc_Background1_Exercise1_Stock_Flow_Service_Nexus_Data.xlsx" target="new">IEooc_Background1_Exercise1_Stock_Flow_Service_Nexus_Data (xlsx)</a>
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Background1_Exercise1_Stock_Flow_Service_Nexus_Solution.xlsx" target="new">IEooc_Background1_Exercise1_Solution (xlsx)</a>
                        <br>
                        <br>
                        <b>Theory lecture: </b>24 min video lecture on industrial ecology as systems science, metabolism of socio-ecological systems, the central system linkages studied by industrial ecology, and the relation between industrial ecology and its neighbouring disciplines:
                        <br>
                        <a href="https://youtu.be/g3qa6zmSmGU" target="new">IEooc_Background1_Lecture2</a>
                        <br>
                        <br>
                        <b>Method overview lecture: </b>16 min video lecture on the five core industrial ecology methods, their main research questions and history. Overview of industrial ecology research infrastructure:
                        <br>
                        <a href="https://youtu.be/atDWS9KnE_U" target="new">IEooc_Background1_Lecture3</a>
                        <br>
                        <br>
                        <b>Blog entry: "Why a Two-Pillar Model is a Better Choice for Conceptualizing Sustainability</b>  than the Common Three-Pillar Conceptualisation:
                        <br>
                        <a href="http://www.blog.industrialecology.uni-freiburg.de/index.php/2018/12/02/why-a-two-pillar-model-is-a-better-choice-for-conceptualizing-sustainability/" target="new">IEooc_Background1_Reading4</a>
                        <br>
                        <br>
                        <b>Classical reading: "Design Through the 12 Principles of Green Engineering"</b>, by By Paul T. Anastas and Julie B. Zimmerman (2003, DOI: 10.1021/es032373g):
                        <br>
                        <a href="https://pubs.acs.org/doi/pdf/10.1021/es032373g" target="new">IEooc_Background1_Reading5</a> Alternative link with no access restrictions: <a href="http://www.precaution.org/lib/08/prn_green_engineering.htm" target="new">IEooc_Background1_Reading5</a>
                        <br>
                        <br>
                        <br>
                    </td>
                </tr>

                <tr colspan="2">
                    <td><b>Background 2: Climate, circular economy, sustainability, and the contribution of industrial ecology</b></td>
                </tr>

                <tr>
                    <td width="30%"></td>
                    <td width="70%">
                        <b>Video lecture</b> on the big picture: Climate change:
                        <br>
                        <a href="https://www.youtube.com/watch?v=8iEj76iX-xE" target="new">IEooc_Background2_Lecture1</a>
                        <br>
                        <br>

                        <b>Video lecture</b> on the big picture: Sustainability and sustainable development:
                        <br>
                        <a href="https://youtu.be/p6nvQYJFsDY" target="new">IEooc_Background2_Lecture2</a>
                        <br>
                        <br>

                        <b>Video lecture</b> on the big picture: Sustainability from a different angle:
                        <br>
                        <a href="https://www.youtube.com/watch?v=8v4sZSDz484" target="new">IEooc_Background2_Lecture3</a>
                        <br>
                        <br>

                        <b>Video lecture:</b> Systems thinking for sustainability:
                        <br>
                        <a href="https://youtu.be/HJmNxi3nNh0" target="new">IEooc_Background2_Lecture4</a>
                        <br>
                        <br>

                        <b>Link to methodology video lecture on the basic principles of industrial ecology data modelling and accounting: material and energy flow analysis: </b>
                        <br>
                        <a href="https://youtu.be/wK_02bGTh1E" target="new">IEooc_Methods1_Lecture1</a>
                        <br>
                        In this lecture, the practicalities of quantitative systems analysis are explained: Definitions and basic methodology for material and energy flow accounting are presented, including the basic elements of the quantitative system definition, the process balancing equations, indicator elements, units of measurement, multi-layer system descriptions, and a number of examples. <b>Prerequisites:</b> No advanced math is required at this stage. <b>Level of difficulty: (+)</b>
                        <br>
                        <br>

                        <b>Video lecture:</b> Measuring sustainability and sustainable development:
                        <br>
                        <a href="https://youtu.be/vSRyT7PJ7Z8" target="new">IEooc_Background2_Lecture5</a>
                        <br>
                        <br>

                        <b>Link to methodology exercise on the practicalities of quantitative systems analysis: Locating data in a system definition and indicator development.</b> Learn how to establish a system definition to allocate quantitative information that is given as text. Define and calculate indicators based on the system definition. <b>Prerequisites:</b> No advanced math is required at this stage. <b>Level of difficulty: (+)</b><br>
                        <a href="/Content/IEooc_Methods1_Exercise1_Indicator_Definition.pdf" target="new">IEooc_Methods1_Exercise1</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods1_Exercise1_Indicator_Definition_Solution.pdf" target="new">IEooc_Methods1_Exercise1_Solution (pdf)</a>
                        <br>
                        <br>

                        <b>Video lecture:</b> The scaling behaviour of cities:
                        <br>
                        <a href="https://www.youtube.com/watch?v=XyCY6mjWOPc" target="new">IEooc_Background2_Lecture6</a>
                        <br>
                        <br>

                        <b>Exercise: Systems thinking for renewable energy.</b> Learn about the main types of renewable energy, the main barriers for their implementation, and the system linkages that determine their future contribution to climate change mitigation by reading the relevant chapter of the IPCC 5th Assessment Report. <b>Prerequisites:</b> None. <b>Level of difficulty: (+)</b><br>
                        <a href="/Content/IEooc_Background2_Exercise1_RenewableEnergy_IPCC.pdf" target="new">IEooc_Background2_Exercise1</a>.
                        <br>
                        Chapter 7 of part III of the IPCC 4th Assessment report is the reading material for this exercise:<br>
                        <a href="http://www.ipcc.ch/pdf/assessment-report/ar5/wg3/ipcc_wg3_ar5_chapter7.pdf" target="new">Reading material: Chapter 7 of part III of the IPCC 4th assessment report (pdf)</a>
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Background2_Exercise1_RenewableEnergy_IPCC_Solution.pdf" target="new">IEooc_Background2_Exercise1_Solution (pdf)</a>
                        <br>
                        <br>

                        <b>Exercise: Global Warming Potential (GWP) calculations.</b> Understand and replicate central calculations of the atmospheric physics of greenhouse gases
(GHG) and the global warming potential to compare the impact of different GHG on global warming. <b>Level of difficulty: (+++)</b><br>
                        <a href="/Content/IEooc_Background2_Exercise2_GWP.pdf" target="new">IEooc_Background2_Exercise2</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Background2_Exercise2_GWP_Sample_Solution.pdf" target="new">IEooc_Background2_Exercise2_GWP_Sample_Solution (pdf)</a><br>
                        <a href="/Content/IEooc_Background2_Exercise2_GWP_Sample_Solution.xlsx" target="new">IEooc_Background2_Exercise2_GWP Workbook (xlsx)</a>
                        <br>
                        <br>
                    </td>
                </tr>

                <tr colspan="2">
                    <td><b>Background 3: Open science for sustainability</b></td>
                </tr>

                <tr>
                    <td width="30%"></td>
                    <td width="70%">
                        <b>Reading: </b>Proposal for higher data transparency in industrial ecology: With the growth of the field of industrial ecology (IE), research and results have increased significantly leading to a desire for better utilization of the accumulated data in more sophisticated analyses. This implies the need for greater transparency, accessibility, and reusability of IE data, paralleling the considerable momentum throughout the sciences. It is argued that increased transparency, accessibility, and reusability of IE data will enhance IE research by enabling more detailed and reproducible research, and also facilitate meta-analyses. Two initial actions intended to advance these goals are presented:
                        <br>
                        <a href="http://onlinelibrary.wiley.com/doi/10.1111/jiec.12738/full" target="new">IEooc_Background3_Reading1</a>
                        <br>
                        <br>
                        <b>Reading:</b> Guidelines for software development for industrial ecology:
                        <br>
                        <a href="/Content/IEooc_Background3_Reading2_OpenSoftwareIndustrialEcology.pdf" target="new">IEooc_Background3_Reading2</a>
                        <br>
                        <br>
                        <b>Webinar</b> on open LCA software:
                        <br>
                        <a href="https://www.youtube.com/watch?v=wZk2EQq4w6M" target="new">IEooc_Background3_Lecture1</a>
                        <br>
                        <br>
                        <b>Reading:</b> Input from other communities: A comment on transparency in energy system modelling:
                        <br>
                        <a href="https://www.nature.com/polopoly_fs/1.21517!/menu/main/topColumns/topLeftColumn/pdf/542393a.pdf" target="new">IEooc_Background3_Reading3</a>
                        <br>
                        <br>
                        <b>Reading:</b> Python hacks for industrial ecology: Tips for how to speed up and professionalize your analysis and modelling:
                        <br>
                        <a href="https://github.com/IndEcol/OpenScience/wiki/Python-hacks-for-industrial-ecology" target="new">IEooc_Background3_Reading4</a>

                    </td>
                </tr>

            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <br>
            <br>
            <br>
            <h3>Part II: Methods </h3>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <table border="0">
                <tr>
                    <td width="30%"></td>
                    <td width="70%">
                        <b>Reading:</b> Good Scientific Practice in Industrial Ecology - A Factsheet. This document provides researchers and students with a condensed overview of three main aspects of good scientific practice in industrial ecology: research ethics, best practice for conducting and documenting research, and research tools.
The following topics are covered:
                        <br>
                        1) Research ethics overview. Core scientific principles and good scientific conduct.<br>
                        2) Best practice for carrying out, documenting, and publishing research: including recommendations for report structure and scientific writing as well as reproducible research.<br>
                        3) Some state-of-the art tools and infrastructure for IE research.<br>
                        <a href="/Content/IEooc_Methods_Good_Scientific_Practice.pdf" target="new">IEooc_Methods_Good_Scientific_Practice</a>
                        <br>
                        <br>
                    </td>
                </tr>

                <tr colspan="2">
                    <td><a name="Accounting"></a><b>Methodology 1: Basics of industrial ecology data and accounting.</b></td>
                </tr>

                <tr>
                    <td width="30%"></td>
                    <td width="70%">
                        <b>Video lecture on the basic principles of industrial ecology data modelling and accounting: material and energy flow analysis: </b>
                        <br>
                        <a href="https://youtu.be/wK_02bGTh1E" target="new">IEooc_Methods1_Lecture1</a>
                        <br>
                        In this lecture, the definitions and basic methodology for material and energy flow accounting are presented, including the basic elements of the quantitative system definition, the process balancing equations, indicator elements, units of measurement, multi-layer system descriptions, and a number of examples. <b>Prerequisites:</b> No advanced math is required at this stage. <b>Level of difficulty: (+)</b>
                        <br>
                        NOTE: An update of the slides with minor corrections is available here:<br>
                        <a href="/Content/IEooc_Methods1_Lecture1.pdf" target="new">IEooc_Methods1_Lecture1_CorrectedSlides</a>
                        <br>
                        <br>
                        <b>Exercise: Locating data in a system definition and indicator development.</b> Learn how to establish a system definition to allocate quantitative information that is given as text. Define and calculate indicators based on the system definition. <b>Prerequisites:</b> No advanced math is required at this stage. <b>Level of difficulty: (+)</b><br>
                        <a href="/Content/IEooc_Methods1_Exercise1_Indicator_Definition.pdf" target="new">IEooc_Methods1_Exercise1</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods1_Exercise1_Indicator_Definition_Solution.pdf" target="new">IEooc_Methods1_Exercise1_Solution (pdf)</a>
                        <br>
                        <br>
			<b>Exercise on energy and power definitions,</b> salient measures/indicators, and the energy supply chain. Learn about the different energy and power definitions, units, and measures/indicators,
			as well as the definitions of primary, final, and useful energy. Define and calculate energy measures based on the system definition. <b>Prerequisites:</b> Concepts of energy and power in physics. No advanced math is required at this stage. <b>Level of difficulty: (+)</b><br>
			<a href="/Content/IEooc_Methods1_Exercise1a_Energy_Conversion_Chain.pdf" target="new">IEooc_Methods1_Exercise1a</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods1_Exercise1a_Energy_Conversion_Chain_Solution.pdf" target="new">IEooc_Methods1_Exercise1a_Solution (pdf)</a>
                        <br>
                        <br>
                        <b>Reading:</b> The supporting documents of the material and energy flow analysis software <a href="http://www.stan2web.net/" target="new">STAN</a> are a good reference for building proper system definitions and for data modelling in material and energy flow analysis and industrial in general. An overview of the different documents can be found <a href="http://www.stan2web.net/support/mfa-basics" target="new">here</a>.
                        <br>
                        Recommended STAN reading 1: Glossary of basic systems analysis terms:<br>
                        <a href="http://www.stan2web.net/support/mfa-basics/terms" target="new">IEooc_Methods1_Reading1</a>
                        <br>
                        Recommended STAN reading 2: Principles of establishing a system definition:<br>
                        <a href="http://www.stan2web.net/support/mfa-basics/building-a-mfa-model" target="new">IEooc_Methods1_Reading2</a>

                        <br>
                        <br>
                        <b>Reading:</b> A more theoretical paper explains the underlying system structure of material and energy flow analysis, life cycle assessment, and input-output analysis: <b>Level of 
difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Methods1_Reading3_Accounting_Framework_SEM_2015.pdf" target="new">IEooc_Methods1_Reading3</a>
                        <br>
                        Related video lecture (17 minutes)<br>
                        <a href="https://www.youtube.com/watch?v=19f4tG6pyRk " target="new">IEooc_Methods1_Lecture2</a>
                        <br>
                        <br>
                        <b>Video lecture and reading on a general data model for socioeconomic metabolism: </b>
                        <br>
                        <a href="https://youtu.be/1aCynUvSVRY" target="new">IEooc_Methods1_Lecture2</a>
                        <br>
                        In this lecture, a general data model for locating data in the systems context is presented. It allows researchers to format data describing stocks, flows, material composition of products, lifetimes, prices, life cycle inventories, IO tables, etc. in a common structure. The data model can be used to build databases that combine data that are commonly associated with specific methods, but which are of use to many researchers. It can also be used to develop data sharing infrastructure for research groups, institutions, and the entire community.
                        <br>
                        <a href="/Content/IEooc_Methods1_Reading4_SEM_DataModel.pdf" target="new">IEooc_Methods1_Reading4 (related journal article)</a>
                        <br>
                        <b>Prerequisites:</b> No advanced math is required at this stage. <b>Level of difficulty: (++)</b>
                        <br>
                        <br>
                        <b>Exercise: Basic data reconciliation.</b> You will learn about the principles of data reconciliation and apply data reconciliation to a simple system. You will make use of the mass balance to formulate constraints and to determine non-measured variables. You will understand the basics of the maximum entropy principle. Note: For this exercise a copy of "Data Reconciliation and Gross Error Detection. An Intelligent Use of Process Data" by Shankar Narasimhan and Cornelius Jordache, ISBN: <a href="https://www.sciencedirect.com/science/book/9780884152552" target="new">978-0-88415-255-2</a>, is required. <b>Prerequisites:</b> Linear programming and its application in Excel. <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Methods1_Exercise2_Data_Reconciliation.pdf" target="new">IEooc_Methods1_Exercise2 (pdf)</a>.
                        <br>
                        <a href="/Content/IEooc_Methods1_Exercise2_Data_Reconciliation_Data.xlsx" target="new">IEooc_Methods1_Exercise2 (data)</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods1_Exercise2_Data_Reconciliation_Solution.xlsx" target="new">IEooc_Methods1_Exercise2_Solution (xlsx)</a>
                        <br>
                        <br>
                        <b>Reading:</b> A dialogue with ChatGPT on stocks and flows. Read what one of the world's most advanced chat bots has to say on how we should model phenomena in the industrial system. Helps to clarify the own understanding of stocks vs. flows. <b>Level of 
difficulty: (+)</b><br>
                        <a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2023/04/07/a-dialogue-with-chatgpt-on-stocks-and-flows/
" target="new">IEooc_Methods1_Reading5</a>
                        <br>
                        <br>
			    
                    </td>
                </tr>

                <tr colspan="2">
                    <td><a name="MFA"></a><b>Methodology 2: Basics of material and energy flow analysis.</b></td>
                </tr>

                <tr>
                    <td width="30%"></td>
                    <td width="70%">
                        <b>Video lecture</b> on MFA system models and their analytical and numerical solution. <b>Prerequisites:</b> Matrix algebra and its implementation in Excel. <b>Level of difficulty: (++)</b>
                        <br>
                        <a href="https://youtu.be/562-lBuoF1Q" target="new">IEooc_Methods2_Lecture1</a>
                        <br>
                        <br>
                        <b>Video lecture </b>on data uncertainty and sensitivity of results in MFA system models. <b>Prerequisites:</b> Calculus. Random variables, discrete and continuous probability distributions. <b>Level of difficulty: (+++)</b>
                        <br>
                        <a href="https://youtu.be/VpK2NgY5FlQ" target="new">IEooc_Methods2_Lecture2</a>
                        <br>
                        <br>
                        <b>Reading material:</b><b> "Guidelines for Data Modeling and Data Integration for Material Flow Analysis and Socio-Metabolic Research"</b>, document with basic standards and best practice on data formats, system definition, indicator definition, use of common classifications, uncertainty treatment and sensitivity analysis, and data traceability and provenance. These guidelines were issued by the Board of the ISIE Section on Socioeconomic Metabolism (ISIE-SEM), and are a standard reference for all who are in the process of publishing, documenting, or archiving MFA research, either within a software such as STAN or in a custom modelling environment. <b>Level of difficulty: (++)</b>
                        <br>
                        <a href="http://www.blog.industrialecology.uni-freiburg.de/wp-content/uploads/2021/06/SEM_MFA_Guidelines_V1.0_June_2021.pdf" target="new">IEooc_Methods2_Reading1</a>
                        <br>
                        <br>
                        <b>Exercise: Cement production, efficiency strategies and related indicators:</b> The goal of this exercise is to consolidate your understanding of basic quantitative system analysis. Also, to get some detailed knowledge about energy use and greenhouse gas emissions of the cement industry. <b>Prerequisites:</b> No advanced math required. <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Methods2_Exercise1_Cement.pdf" target="new">IEooc_Methods2_Exercise1</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods2_Exercise1_Cement_Solution.pdf" target="new">IEooc_Methods2_Exercise1_Solution (pdf)</a><br>
                        <a href="/Content/IEooc_Methods2_Exercise1_Cement_Solution.xlsx" target="new">IEooc_Methods2_Exercise1_Solution (xlsx)</a>
                        <br>
                        <br>

                        <b>Exercise: Recycling systems: Efficiency strategies and uncertainty propagation:</b> from a systems perspective, you will gain basic insights into material cycles
and recycling systems using the example of beverage cans in Germany. You will conduct a sensitivity analysis, error propagation and calculation of result 
elasticities. <b>Prerequisites:</b> Calculus. Random variables and analytical error propagation. <b>Level of difficulty: (+++)</b>
                        <br>
                        <a href="/Content/IEooc_Methods2_Exercise2_Cycle.pdf" target="new">IEooc_Methods2_Exercise2</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods2_Exercise2_Cycle_Solution.pdf" target="new">IEooc_Methods2_Exercise2_Solution (pdf)</a>
                        <br>
                        <br>
                        Check also this <b>exercise from the application section, which contains a Monte-Carlo Simulation:</b> "Inclusion of Consumption of carbon intensive materials in emissions trading. You will gain a basic systems understanding  of  material  markets, learn about the material  content  of  merchandise  groups,  error propagation, and the application of Monte-Carlo-Simulation in material flow analysis." <b>Prerequisites:</b> Calculus. Random variables, discrete and continuous probability distributions, Monte-Carlo-Simulation. <b>Level of difficulty: (+++)</b><br>
                        <a href="/Content/IEooc_Application3_Exercise1_IoC.pdf" target="new">IEooc_Application3_Exercise1 (pdf)</a><br>
                        <a href="/Content/IEooc_Application3_Exercise1_IoC_Data.xlsx" target="new">IEooc_Application3_Exercise1 (data and workbook)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application3_Exercise1_IoC_Solution.pdf" target="new">IEooc_Application3_Exercise1_Solution (pdf)</a> and
                        <br>
                        <a href="/Content/IEooc_Application3_Exercise1_IoC_Solution.xlsx" target="new">IEooc_Application3_Exercise1_Solution (xlsx)</a>
                        <br>
                        <br>
                        <b>Video lecture</b> on the concept 'urban metabolism' and how it can be useful to local governments. Urban metabolism studies help cities and city regions assess current resource use and identify pathways for improvement. (from UN Environment):
                        <br>
                        <a href="https://www.youtube.com/watch?v=uu-a1hFEV7Q" target="new">IEooc_Methods2_Lecture3</a>
                        <br>
                        <br>
                        <b>Reading material:</b><b> "Concise description of application fields for different MFA approaches and indicators"</b>, deliverable D3.2 of the EU MinFuture project. This report describes the various methods of material flow analysis (MFA) that are applied to studying raw materials stocks and flows, and it lists the definitions of and reviews the major material system indicators. It also contains various case studies illustrating MFA methods and indicators.<b> Level of difficulty: (++)</b><br>
                        <a href="https://minfuture.eu/downloads/MinFuture_WP3_Task3.1%20_D3.2%20(Final%20incl.%20Annex)%20-%20Revised.pdf" target="new">IEooc_Methods2_Reading2</a>
                        <br>
                        <br>
                        <b>Reading material:</b><b> "Compilation of uncertainty approaches and recommendations for reporting data uncertainty"</b>, deliverable D3.3 of the EU MinFuture project. This report provides a systematic way to consider uncertainty in MFA and suggests a procedure for consistently communicating the uncertainty quantification approaches used in different MFA studies. <b>Level of difficulty: (++)</b><br>
                        <a href="https://minfuture.eu/downloads/D3.3_uncertainty.pdf" target="new">IEooc_Methods2_Reading3</a>
                        <br>
                        <br>
                        <b>Reading material:</b><b> "Visualising Material Systems"</b>, deliverable D3.4 of the EU MinFuture project. This report contains a detailed overview of the different visualisation principles for MFA systems. <b>Level of difficulty: (++)</b><br>
                        <a href="https://minfuture.eu/downloads/MinFuture_WP3_Visualisation_D3.4_final.pdf" target="new">IEooc_Methods2_Reading4</a>
                        <br>
                        <br>
                        <b>Reading material:</b><b> Blog entry on "Material flow acccounting and material footprint calculation"</b> This piece introduces the method of economy-wide material flow accounting and defines its central flows and indicators in the system description language of material flow analysis. <b>Level of difficulty: (++)</b><br>
                        <a href="http://www.blog.industrialecology.uni-freiburg.de/index.php/2022/04/20/material-flow-accounting-and-material-footprints-system-definition-and-data-sources/" target="new">IEooc_Methods2_Reading5</a>
                        <br>
                        <br>
                    </td>
                </tr>


                <tr colspan="2">
                    <td><b>Methodology 3: Dynamic Material Flow Analysis.</b></td>
                </tr>

                <tr>
                    <td width="30%"></td>
                    <td width="70%">
                        <b>Video lecture introducing the basic principles of dynamic material flow analysis,</b> the main data sources for dynamic MFA models, some examples of dynamic MFA, and the most important approaches to solving mathematical models of dynamic MFA systems:  <b>Prerequisites:</b> Calculus. Linear difference equations, simple differential equations. <b>Level of difficulty: (+++)</b><br>
                        <a href="https://youtu.be/ba7ykRIrih0" target="new">IEooc_Methods3_Lecture1</a>
                        <br>
                        NOTE: An update of the slides with minor fixes to the notation is available here:<br>
                        <a href="/Content/IEooc_Methods3_Lecture1_Corrected_Cencic.pdf" target="new">IEooc_Methods3_Lecture1_CorrectedSlides</a><br>
                        Thanks to Oliver Cencic (TU  Vienna) for the feedback!
                        <br>
                        <br>
                        <b>Video lecture on dynamic stock models.</b> The following concepts are introduced and explained: Population balance models, the leaching model, impulse response functions, age-cohorts, and the lifetime model. <b>Prerequisites:</b> Calculus. Simple differential equations. Discrete and continuous random variables. Convolution. <b>Level of difficulty: (+++)</b>
                        <br>
                        <a href="https://youtu.be/PfRCTW5U7dk" target="new">IEooc_Methods3_Lecture2</a>
                        <br>
                        NOTE: An update of the slides with minor fixes to the notation is available here:<br>
                        <a href="/Content/IEooc_Methods3_Lecture2_Corrected_Cencic.pdf" target="new">IEooc_Methods3_Lecture2_CorrectedSlides</a><br>
                        Thanks to Oliver Cencic (TU  Vienna) for the feedback!
                        <br>
                        <br>
                        <b>Video lecture on inflow-driven and stock-driven modelling:</b> With inflow-driven modelling stocks can be determined from historic inflows using a convolution operation. With stock-driven modelling the inflow can be determined from a given stock scenario using inverse convolution. <b>Prerequisites:</b> Calculus. Simple differential equations. Discrete and continuous random variables. Convolution. <b>Level of difficulty: (+++)</b><br>
                        <a href="https://youtu.be/dZamxAXDOtY" target="new">IEooc_Methods3_Lecture3</a>
                        <br>
                        NOTE: An update of the slides with minor fixes to the notation and a better distinction between discrete and continuous models is available here:<br>
                        <a href="/Content/IEooc_Methods3_Lecture3_Corrected_Cencic.pdf" target="new">IEooc_Methods3_Lecture3_CorrectedSlides</a><br>
                        Thanks to Oliver Cencic (TU  Vienna) for the feedback!
                        <br>
                        <br>
                        <b>Exercise: "Dynamic model of the German steel cycle, 1800-2008."</b> The goals of this exercise are twofold: first, to develop a systems understanding  regarding  the  development  of  flows  and  stocks  in  material cycles, using the example of the steel cycle in Germany. Second, to estimate steel stocks using dynamic stock modelling. <b>Prerequisites:</b> Calculus. Simple differential equations. Discrete and continuous random variables. Convolution. <b>Level of difficulty: (+++)</b><br>
                        <a href="/Content/IEooc_Methods3_Exercise1_Stockmodeling_Steel.pdf" target="new">IEooc_Methods3_Exercise1 (pdf)</a><br>
                        <a href="/Content/IEooc_Methods3_Exercise1_RawData.xlsx" target="new">IEooc_Methods3_Exercise1 (Data, xlsx)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods3_Exercise1_Stockmodelling_Steel_Solution.pdf" target="new">IEooc_Methods3_Exercise1_Solution (pdf)</a> and
                        <br>
                        <a href="/Content/IEooc_Methods3_Exercise1_Solution.xlsx" target="new">IEooc_Methods3_Exercise1_Solution (xlsx)</a>
                        <br>
                        <br>
                        <b>Blog entry: "The lifetime of materials in the technosphere"</b> introducing a simple dynamic MFA model of a material cycle to study the dispersion of materials in the technosphere. <b>Prerequisites:</b> Analytical solution of MFA systems, geometric series. <b>Level of difficulty: (++)</b><br>
                        <a href="http://www.blog.industrialecology.uni-freiburg.de/index.php/2017/10/29/the-lifetime-of-materials-in-the-technosphere/" target="new">IEooc_Methods3_Reading1</a>
                        <br>
                        <br>
                        <b>Exercise on estimating the number of life cycles of metals:</b> Goal of this exercise is to develop and solve a basic model of the recycling loop, to define and calculate the lifetime of a material in the technosphere and the average number of life cycles. <b>Prerequisites:</b> Analytical solution of MFA systems, geometric series. <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Methods3_Exercise2_Technical_Lifetime.pdf" target="new">IEooc_Methods3_Exercise2</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods3_Exercise2_Technical_Lifetime_Solution.pdf" target="new">IEooc_Methods3_Exercise2_Solution (pdf)</a>
                        <br>
                        <br>
                        <b>Jupyter notebook with a tutorial on basic data handling:</b> Reading and inspecting data, performing basic time series calculations, plotting and saving results. This Jupyter notebook contains explanations on how to use the Python programming language for calculating energy use and emissions of the vehicle fleet for a future scenario. The data handling and calculation steps are explained step by step. <b>Level of difficulty: (++)</b><br>
                        <script>jupyterLink("/Content/IEooc_Methods3_Software001.ipynb", "IEooc_Methods3_Software001 (ipynb)");</script><br/>
                        <a href="/Content/IEooc_Methods3_Software001_Data.xlsx" target="new">IEooc_Methods3_Software001_Data (data file)</a>
                        <br>
                        <br>
                        <b>Jupyter notebook on scenarios for the transformation of the vehicle fleet.</b> This workbook is a direct follow-up to IEooc_Methods3_Software001. It contains a number of additional tasks and calculations for the same topic and dataset. <b>Level of difficulty: (++)</b><br>
                        <script>jupyterLink("/Content/IEooc_Methods3_Software002.ipynb", "IEooc_Methods3_Software002 (ipynb)");</script><br/>
                        <a href="/Content/IEooc_Methods3_Software001_Data.xlsx" target="new">IEooc_Methods3_Software001_Data (data file, same as for IEooc_Methods3_Software001)</a>
			<br>
                        For this exercise a sample solution is available:<br>
                        <script>jupyterLink("/Content/IEooc_Methods3_Software002_SampleSolution.ipynb", "IEooc_Methods3_Software002_SampleSolution (ipynb)");</script><br/>
                        <br>
                        <br>
                        <b>Jupyter notebook on scenarios for the material flows for the transformation of the vehicle fleet.</b> This workbook is a direct follow-up to IEooc_Methods3_Software002. It contains the calculation of the material content of in-use stock and flows, the estimation of recycling flows and recycled content, and the estimation of GHG emissions and material footprint for vehicle production for the same topic and dataset. <b>Level of difficulty: (++)</b><br>
                        <script>jupyterLink("/Content/IEooc_Methods3_Software003.ipynb", "IEooc_Methods3_Software003 (ipynb)");</script><br/>
                        <a href="/Content/IEooc_Methods3_Software001_Data.xlsx" target="new">IEooc_Methods3_Software001_Data (data file, same as for IEooc_Methods3_Software001)</a>
			<br>
                        For this exercise a sample solution is available:<br>
			<script>jupyterLink("/Content/IEooc_Methods3_Software003_SampleSolution.ipynb", "IEooc_Methods3_Software003_SampleSolution (ipynb)");</script><br/>
                        <br>
                        <br>
                        <b>Jupyter notebook with a tutorial on inflow-driven and stock-driven modelling, using the dynamic_stock_model class in Python and the Chinese steel stock as an example:</b> In this workbook it is shown how inflow-driven and stock-driven modelling can be implemented in Python using the dynamic_stock_model class. <b>Prerequisites:</b> Calculus. Simple differential equations. Discrete and continuous random variables. Convolution. Basic programming and data visualisation in Python. <b>Level of difficulty: (+++)</b><br>
			    For this notebook, two versions exist: <br>
                        <script>jupyterLink("/Content/IEooc_Methods3_Software1_ODYM.ipynb", "IEooc_Methods3_Software1 (ODYM)");</script> for use together with the dynamic MFA library of the <a href="https://github.com/IndEcol/ODYM" target="new">ODYM MFA</a> software. <br/>
			<script>jupyterLink("/Content/IEooc_Methods3_Software1_old_dMFA_class.ipynb", "IEooc_Methods3_Software1 (old dynamid MFA class)");</script> for use together with the <a href="https://github.com/stefanpauliuk/dynamic_stock_model" target="new">stand-alone dynamic MFA library</a> that is no longer maintained. <br/>
                        <a href="/Content/IEooc_Methods3_Software1_Data.xlsx" target="new">IEooc_Methods3_Software1 (data file for both versions of the notebook)</a>
                        <br>
                        <br>
                        <b>Jupyter notebook with a tutorial on stock-driven modelling for material stocks in products, using the dynamic_stock_model class in Python and the global passenger vehicle fleet as an example:</b> In this workbook it is shown how stock-driven modelling can be implemented in Python using the dynamic_stock_model class and applied to calculate the material flows and stocks in the products that we use. <b>Prerequisites:</b> Calculus. Simple differential equations. Discrete and continuous random variables. Convolution. Basic programming and data visualisation in Python. <b>Level of difficulty: (+++)</b><br>
                        <script>jupyterLink("/Content/IEooc_Methods3_Software2.ipynb", "IEooc_Methods3_Software2");</script><br/>
                        <a href="/Content/IEooc_Methods3_Software2_GlobalCarFleetData.xlsx" target="new">IEooc_Methods3_Software2 (data file)</a>
                        <br>
                        <br>
                        <b>Jupyter notebooks containting tutorials and examples for conducting material flow analysis research with ODYM (Open Dynamic Material Systems Model),</b> which is an open software library for dynamic material flow analysis (MFA) that contains a framework for modeling biophysical stock-flow relations in socioeconomic metabolism. ODYM is available and documented in a <a href="https://github.com/IndEcol/ODYM" target="new">GitHub repo</a>. <b>Prerequisites:</b> Calculus. Simple differential equations. Discrete and continuous random variables. Convolution. Good programming and data visualisation skills in Python. Note that in order to run some of the tutorials, you need to download and extract the zip archive IEooc_Methods3_Software3-8_ODYM_Tutorial_1-6_Material.zip linked below. <b>Level of difficulty: (+++)</b><br>
                        <script>jupyterLink("/Content/IEooc_Methods3_Software3_ODYM_Tutorial_1.ipynb", "IEooc_Methods3_Software3");</script> System with two processes, two parameters, one material.<br>
                        <script>jupyterLink("/Content/IEooc_Methods3_Software4_ODYM_Tutorial_2.ipynb", "IEooc_Methods3_Software4");</script> Alloying elements in recycling.<br>
                        <script>jupyterLink("/Content/IEooc_Methods3_Software5_ODYM_Tutorial_3.ipynb", "IEooc_Methods3_Software5");</script> Dynamic stock modelling intro.<br>
                        <script>jupyterLink("/Content/IEooc_Methods3_Software6_ODYM_Tutorial_4.ipynb", "IEooc_Methods3_Software6");</script> ODYM classification and database<br>
                        <script>jupyterLink("/Content/IEooc_Methods3_Software7_ODYM_Tutorial_5.ipynb", "IEooc_Methods3_Software7");</script> Estimating the material content of the global vehicle fleet<br>
                        <script>jupyterLink("/Content/IEooc_Methods3_Software8_ODYM_Tutorial_6.ipynb", "IEooc_Methods3_Software8");</script> MaTrace - Tracing material flows through different product lifecycles<br>
                        <a href="/Content/IEooc_Methods3_Software3-8_ODYM_Tutorial_1-6_Material.zip" target="new">IEooc_Methods3_Software3-8 (data file)</a>
                        <br>
                        <br>
                        <b>Journal article: "A general framework for stock dynamics of populations and built and natural environments"</b> that introduces a general mathematical framework for dynamic stock models based on balance, intrinsic, and model-approach equations. The framework is used to classify a variety of stock models from different disciplines and discuss their applicability. The paper also introduces a matrix equation for solving stock-lifetime-driven models to determine inflows given the lifetime matrix and the evolution of the stock. <b>Level of difficulty: (++) </b>
                        <br>
                        <a href="https://doi.org/10.1111/jiec.13117" target="new">IEooc_Methods3_Reading2</a>
                        <br>
                        <br>
                        <b>Excel workbook with the matrix equation implementation of stock-driven modelling for material stocks in products presented by Lauinger et al. (see IEooc_Methods3_Reading2) </b>Full implementation is a 200x200 matrix with 200 model time steps (i.e., for a modelling period of 200 years, months, or days) for use in own case studies. <b>Prerequisites:</b> Dynamic stock modelling, stock-driven model, matrix algebra. <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Methods3_Software9.xlsx" target="new">IEooc_Methods3_Software9 (Excel workbook)</a><br>
                        <br>
                    </td>
                </tr>


                <tr colspan="2">
                    <td><a name="LCA"></a></a><b>Methodology 4: Life cycle assessment.</b></td>
                </tr>

                <tr>
                    <td width="30%"></td>
                    <td width="70%">For LCA some very good open teaching material exists. The list of <a href="https://ilca.es/teaching-materials/open-teaching-material/" target="new">open teaching material</a> of the International Life Cycle Academy (ILCA) provides an overview of the available open content. In particular, the LCA text book is highly recommendable. It is developed by colleagues from Carnegie Mellon University in Pittsburgh.
                        <br>
                        The UN Environment Life Cycle Initiative also provides LCA training material on its <a href="https://www.lifecycleinitiative.org/resources/training/" target="new">homepage</a>.<br>
                        To help you get started with openLCA, GreenDelta provides free resources, including case studies, for modeling your own LCA study on their <a href="https://www.openlca.org/learning/" target="new">homepage</a>.
                        <br>
                        <br>
                        <b>Video on the thinking behind LCA:</b> <b>Prerequisites:</b> None. <b>Level of difficulty: (+)</b><br>
                        <a href="https://www.youtube.com/watch?v=zFaG4QZpzIs" target="new">IEooc_Methods4_Video1</a>
                        <br>
                        <br>
                        <b>Video on the methodology of LCA:</b> <b>Prerequisites:</b> None. <b>Level of difficulty: (+)</b><br>
                        <a href="https://www.youtube.com/watch?v=tyZBfgIcacQ" target="new">IEooc_Methods4_Video2</a>
                        <br>
                        <br>
                        <b>Exercise (from application section): "Transport vs. cooling of apples: a simple life cycle perspective" </b>Objective: To quantify the energy requirements for transport and storage/cooling. Calculate greenhouse gas emissions from these processes. Comparative calculation of the CO_2 footprints of different value chains (simple comparative life cycle assessment).<b> Prerequisites:</b> Quantitative systems analysis. <b>Level of difficulty: (+)</b><br>
                        <a href="/Content/IEooc_Application3_Exercise1a.pdf" target="new">IEooc_Application3_Exercise1a (pdf)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application3_Exercise1a_SampleSolution.xlsx" target="new">IEooc_Application3_Exercise1a_SampleSolution (xlsx)</a>
                        <br>
                        <br>
                        <b>Video lecture from the application section:</b> Bioenergy and Biomaterials from a Life Cycle Perspective.
                        <br>
                        <a href="https://youtu.be/rhUVfkq_S8o" target="new">IEooc_Application4_Lecture9</a>
                        <br>
                        <br>
                        <b>Video lecture on the computational structure of LCA:</b> In this lecture the maths of LCA are explained, following the Leontief input-output model. First, the processes and flows that are modeled and calculated are defined and located in the system. Then, the different calculation steps are explained step by step. <b>Prerequisites:</b> Matrix algebra. <b>Level of difficulty: (+++)</b><br>
                        <a href="https://youtu.be/3GDfNksiY0s" target="new">IEooc_Methods4_Lecture1</a>
                        <br>
                        <br>
                        <b>Basic LCA exercises, no LCA software and database required:</b>
                        <br>
                        <br>
                        LCA basics: <b>Simple comparative LCA:</b> Practice systems thinking and quantitative systems analysis, work with system definitions, apply life cycle thinking to electric vehicles and electric transportation. <b>Prerequisites:</b> No advanced math required. <b>Level of difficulty: (+)</b>
                        <br>
                        <a href="/Content/IEooc_Methods4_Exercise1_ElectricVehicles.pdf" target="new">IEooc_Methods4_Exercise1</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods4_Exercise1_ElectricVehicles_Solution.pdf" target="new">IEooc_Methods4_Exercise1_Solution (pdf)</a>
                        <br>
                        <br>
                        LCA basics: <b>Process-based LCA:</b> Practice systems thinking and quantitative systems analysis, work with system definitions, apply life cycle thinking to  solar power by conducting a quick process-based LCA of PV module production. <b>Prerequisites:</b> No advanced math required. <b>Level of difficulty: (+)</b>
                        <br>
                        <a href="/Content/IEooc_Methods4_Exercise2_LifeCycle.pdf" target="new">IEooc_Methods4_Exercise2</a>.
                        <br>
                        <a href="/Content/IEooc_Methods4_Exercise2_LifeCycle_Data.xlsx" target="new">IEooc_Methods4_Exercise2 (data and workbook)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods4_Exercise2_LifeCycle_Solution.xlsx" target="new">IEooc_Methods4_Exercise2_Solution (xlsx)</a>
                        <br>
                        <br>
                        LCA basics: <b>Matrix algebra and the LCA master equation:</b> Apply the life cycle perspective, understand the computational structure of LCA, understand and implement basic matrix algebra operations on paper. <b>Prerequisites:</b> Matrix algebra. <b>Level of difficulty: (++)</b>
                        <br>
                        <a href="/Content/IEooc_Methods4_Exercise3_Matrices_Paper.pdf" target="new">IEooc_Methods4_Exercise3</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods4_Exercise3_Matrices_Paper_Solution.xlsx" target="new">IEooc_Methods4_Exercise3_Solution (xlsx)</a>
                        <br>
                        <br>
                        LCA basics: <b>LCA with matrix algebra in Excel:</b> Understand the computational structure of LCA, understand and implement basic matrix algebra operations in Excel. <b>Prerequisites:</b> Matrix algebra. <b>Level of difficulty: (++) </b>
                        <br>
                        <a href="/Content/IEooc_Methods4_Exercise4_LCA_Excel.pdf" target="new">IEooc_Methods4_Exercise4</a>.
                        <br>
                        <a href="/Content/IEooc_Methods4_Exercise4_LCA_Excel.xlsx" target="new">IEooc_Methods4_Exercise4 (data and workbook)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods4_Exercise4_LCA_Excel_Solution.xlsx" target="new">IEooc_Methods4_Exercise4_Solution (xlsx)</a>
                        <br>
                        <br>
                        LCA basics: <b>Life Cycle Impact Assessment:</b> Practice life cycle thinking, work with the LCIA method LC impact, calculate regional endpoint indicators, understand and implement basic matrix algebra operations. <b>Prerequisites:</b> Matrix algebra. <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Methods4_Exercise5_LCIA.pdf" target="new">IEooc_Methods4_Exercise5</a>.
                        <br>
                        <a href="/Content/IEooc_Methods4_Exercise5_LCIA.xlsx" target="new">IEooc_Methods4_Exercise5 (data and workbook)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods4_Exercise5_LCIA_Solution.pdf" target="new">IEooc_Methods4_Exercise5_Solution (pdf)</a><br>
                        <a href="/Content/IEooc_Methods4_Exercise5_LCIA_Solution.xlsx" target="new">IEooc_Methods4_Exercise5_Solution (xlsx)</a>
                        <br>
                        <br>
                        <b>Exercise from the application sectionon the concept of payback time in life cycle thinking and on how to take into account the timing of emissions and sequestration of carbon in the calculation of the global warming potential (GWP) </b>Goal: Get familiar with the carbon intensity of different energy carriers (orders of magnitude), understand the concept of distributing upfront emissions on the subsequently produced output, break-even emissions, and the computation of global warming impacts of emissions from a system at different times. (‘dynamic GHG accounting’). This exercise only considers GHG. Biodiversity and economic aspects of land conversion are highly relevant but are not studied here. <b>Level of difficulty: (+++)</b><br>
                        <a href="/Content/IEooc_Application4_Exercise6_LifeCycle_BioFuels_BioMaterials.pdf" target="new">IEooc_Application4_Exercise6 (pdf)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application4_Exercise6_LifeCycle_BioFuels_BioMaterials_SampleSolution.xlsx" target="new">IEooc_Application4_Exercise6 Sample Solution (xlsx)</a>
                        <br>
                        <br>
                        <b>Exercise from the application sectionon on applying material and energy flow analysis (MEFA) to wood use as material and as energy carrier.</b> Goal: Define and quantify climate-relevant metrics for wood use. Learn how to properly distinguish between actual carbon flows and counter-factual flows (avoided emissions). <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Application4_Exercise7_CarbonAccounting_WoodUse.pdf" target="new">IEooc_Application4_Exercise7 (pdf)</a><br>
			<a href="/Content/IEooc_Application4_Exercise7_CarbonAccounting_WoodUse_Woorkbook.xlsx" target="new">IEooc_Application4_Exercise7 (Excel workbook)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application4_Exercise7_CarbonAccounting_WoodUse_Sample_Solution.xlsx" target="new">IEooc_Application4_Exercise7 Sample Solution (xlsx)</a>
                        <br>
                        <br>
                        <b>Advanced LCA exercises with openLCA. An ecoinvent license is required:</b>
                        <br>
                        <br>
                        A <b>list of openLCA tutorials</b> and info videos can be found on GreenDelta's
                        <br>
                        <a href="https://www.youtube.com/channel/UCGiahq1YZWK4pRXDVXuIi6w" target="new">Youtube channel</a>. 
                        <br>
                        <br>
                        <b>Getting started with openLCA:</b> The goal of this tutorial is to install and learn how to use the openLCA software for life cycle assessments using ecoinvent v3.2 
and several impact assessment methods. The use of parameters, choice of electricity mix, sensitivity analysis, export of data, and a small test case are described. <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Methods4_Exercise6_openLCA.pdf" target="new">IEooc_Methods4_Exercise6</a>. 
                        <br>
                        <br>
                        <b>Modifying processes in openLCA:</b> Copy processes, modify processes, change the electricity source, and conduct a comparative LCA of different steel recycling routes. <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Methods4_Exercise7_Process_Modification.pdf" target="new">IEooc_Methods4_Exercise7</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods4_Exercise7_Process_Modification_Solution.pdf" target="new">IEooc_Methods4_Exercise7_Solution (pdf)</a>
                        <br>
                        <br>
                        <b>Allocation and recycling in ecoinvent:</b> Learn how waste treatment, recycling, and allocation are handled in ecoinvent and openLCA. <b>Level of difficulty: (+++)</b><br>
                        <a href="/Content/IEooc_Methods4_Exercise8_Recycling_Allocation.pdf" target="new">IEooc_Methods4_Exercise8</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods4_Exercise8_Recycling_Allocation_Solution.pdf" target="new">IEooc_Methods4_Exercise8_Solution (pdf)</a>
                        <br>
                        <br>
                        <b>Other advanced LCA exercises:</b>
                        <br>
                        <br>
                        <b>Reading exercise on a comparative LCA of electric and conventional passenger vehicles:</b> Understand the content and policy relevance of a recent LCA research article on electric transportation.
                        <br>
                        <a href="/Content/IEooc_Methods4_Exercise9_Reading.pdf" target="new">IEooc_Methods4_Exercise9</a>.<br>
                        Material for reading exercise:
                        <br>
                        <a href="https://doi.org/10.1111/j.1530-9290.2012.00532.x" target="new">IEooc_Methods4_Exercise9_Reading</a>.
                        <br>
                        <br>
                        <b>The matrix method for LCA: Equivalence of two approaches:</b> Learn more about the two matrix approaches to LCA: The Heijungs and Suh (2002) technology matrix and the Leontief input-output model. Show that both approaches are equivalent. <b>Level of difficulty: (+++)</b><br>
                        <a href="/Content/IEooc_Methods4_Exercise10_MatrixMethods.pdf" target="new">IEooc_Methods4_Exercise10</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods4_Exercise10_MatrixMethods_Solution.pdf" target="new">IEooc_Methods4_Exercise10_MatrixMethods_Solution (pdf)</a><br>
                        <a href="/Content/IEooc_Methods4_Exercise10_MatrixMethods_Solution.xlsx" target="new">IEooc_Methods4_Exercise10_MatrixMethods_Solution (xlsx)</a><br>
			<b> Related journal paper on the topic by Heijungs et al. (2022):</b> "A or I-A? Unifying the computational structures of process- and IO-based LCA for clarity and consistency.<br>
			<a href="https://doi.org/10.1111/jiec.13323" target="new">Link to paper (open access).</a>
			<br>
                        <br>
                        <b>Advanced Life Cycle Impact Assessment:</b> Considering time in life cycle inventories: dynamic characterization factors for greenhouse gases. Goal: Get familiar with the global warming potential of greenhouse gases and the computation of global warming impacts of emissions from a system at different times. (‘dynamic GHG accounting’). Apply dynamic GHG accounting to different test cases.<b> Prerequisites:</b> Calculus, global warming potential (see IEooc_Background2_Exercise2). <b>Level of difficulty: (+++)</b><br>
                        <a href="/Content/IEooc_Methods4_Exercise11_dynLCA.pdf" target="new">IEooc_Methods4_Exercise11</a>.
                        <br>
                        <a href="/Content/IEooc_Methods4_Exercise11_dynLCA_Workbook.xlsx" target="new">IEooc_Methods4_Exercise11 (data and workbook)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods4_Exercise11_dynLCA_Sample_Solution.xlsx" target="new">IEooc_Methods4_Exercise11_Solution (xlsx)</a>
                        <br>
                        <br>
                        <b>Advanced tutorials and LCA exercises with Brightway2LCA. An ecoinvent license is required:</b>
                        <br>
                        <br>
                        A <b>list of Brightway2LCA tutorials</b> and more info on this versatile and highly computationally efficient modular and open-source LCA software in Python can be found on the Brightway2LCA <a href=" https://2.docs.brightwaylca.org/notebooks.html#example-notebook" target="new">homepage</a>. Brightway2LCA is developed by Chris Mutel from PSI and other contributors.
                        <br>
                        <br>
                        <b>Brightway2LCA tutorial 1:</b> A basic tutorial for learning Brightway2LCA is available from a 2017 seminar. <b>Level of difficulty: (+++)</b><br>
                        <a href="https://github.com/PoutineandRosti/Brightway-Seminar-2017" target="new">Brightway2LCA seminar</a>. 
                        <br>
                        <br>
                        <b>Brightway2LCA tutorial 2:</b> A comprehensive introductory tutorial for learning Brightway2LCA was developed by Maximilian Koslowski from Uni Freiburg. <b>Level of difficulty: (+++)</b><br>
                        <a href="https://github.com/maxkoslowski/Brightway2_Intro/blob/master/BW2_tutorial.ipynb" download target="new">New Brightway2 tutorial</a> | <a href="https://github.com/maxkoslowski/Brightway2_Intro/blob/master/BW2_tutorial.ipynb">Run externally in nbviewer</a>. 
                        <br>
                        <br>
                        <br>
                    </td>
                </tr>


                <tr colspan="2">
                    <td><a name="MRIO"></a><b>Methodology 5: Input-output analysis.</b></td>
                </tr>

                <tr>
                    <td width="30%"></td>
                    <td width="70%">
                        <b>Lecture on the basics of input-output analysis</b>, IO tables and the Leontief IO model, part I: <b>Prerequisites:</b> Matrix algebra.  <b>Level of difficulty: (++)</b><br>
                        <a href="https://www.youtube.com/watch?v=G02IRkwmxXw" target="new">IEooc_Methods5_Lecture1_Part1</a>
                        <br>
                        <br>
                        <b>Lecture on the basics of input-output analysis</b>, IO tables and the Leontief IO model, part II: <b>Prerequisites:</b> Matrix algebra.  <b>Level of difficulty: (++)</b><br>
                        <a href="https://www.youtube.com/watch?v=0cbdLM73PAA" target="new">IEooc_Methods5_Lecture1_Part2</a>
                        <br>
                        <br>
                        <b>Lecture on the basics of input-output analysis</b>, IO tables and the Leontief IO model, part III:  <b>Prerequisites:</b> Matrix algebra. <b>Level of difficulty: (++)</b><br>
                        <a href="https://www.youtube.com/watch?v=DSXxpGQibtc" target="new">IEooc_Methods5_Lecture1_Part3</a>
                        <br>
                        <br>
                        <b>Lecture on the basics of input-output analysis</b>, IO tables and the Leontief IO model, part IV:  <b>Prerequisites:</b> Matrix algebra. <b>Level of difficulty: (++)</b><br>
                        <a href="https://www.youtube.com/watch?v=PaAMb9WXc30" target="new">IEooc_Methods5_Lecture1_Part4</a>
                        <br>
                        <br>
                        <b>Exercise on IO basics:</b> This is an introductory exercise to IO analysis, covering the mathematical basics of IO modelling and the system structure of IO models. <b>Prerequisites:</b> Matrix algebra on paper and Excel. <b>Level of difficulty: (+++)</b><br>
                        <a href="/Content/IEooc_Methods5_Exercise1_IO_Basics.pdf" target="new">IEooc_Methods5_Exercise1</a>.
                        <br>
                        <a href="/Content/IEooc_Methods5_Exercise1_IO_Basics.xlsx" target="new">IEooc_Methods5_Exercise1 (data and workbook)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods5_Exercise1_IO_Basics_Solution.pdf" target="new">IEooc_Methods5_Exercise1_Solution (pdf)</a><br>
                        <a href="/Content/IEooc_Methods5_Exercise1_IO_Basics_Solution.xlsx" target="new">IEooc_Methods5_Exercise1_Solution (xlsx)</a>
                        <br>
                        <br>
                        <b>Lecture on multiregional input-output analysis.</b>  <b>Prerequisites:</b> Matrix algebra on paper and Excel. <b>Level of difficulty: (+++)</b><br>
                        <a href="https://youtu.be/0-2GCs8ifOs" target="new">IEooc_Methods5_Lecture2</a>
                        <br>
                        <br>
                        <b>Exercise: "Multiregional input-output analysis (Excel-based)."</b> This exercise contains a simple application of the MRIO analysis: construction of supply chains, carbon footprint calculations of final consumers in the EU, investigation of fine particulate matter and mercury emissions along the supply chain.<b> Prerequisites:</b> Matrix algebra on paper and Excel. <b>Level of difficulty: (+++)</b><br>
                        <a href="/Content/IEooc_Methods5_Exercise2_MRIO.pdf" target="new">IEooc_Methods5_Exercise2 (pdf)</a><br>
                        <a href="/Content/IEooc_Methods5_Exercise2_MRIO_Data.xls" target="new">IEooc_Methods5_Exercise2 (data and workbook)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods5_Exercise2_MRIO_Solution.pdf" target="new">IEooc_Methods5_Exercise2_Solution (pdf)</a> and
                        <br>
                        <a href="/Content/IEooc_Methods5_Exercise2_MRIO_Solution.xls" target="new">IEooc_Methods5_Exercise2_Solution (xls)</a>
                        <br>
                        <br>
                        <b>Jupyter notebook with a tutorial for calculating consumption-based emissions </b>and breaking them down into products, region, and industry. <b>Prerequisites:</b> Matrix algebra, basic Python programming. <b>Level of difficulty: (+++)</b><br>
                        <script>jupyterLink("/Content/IEooc_Methods5_Software1.ipynb", "IEooc_Methods5_Software1");</script><br>
                        <a href="/Content/IEooc_Methods5_Software1_Data_EXIOBASEv3_3R_11P_ITC.mat" target="new">IEooc_Methods5_Software1 (data file)</a><br>
                        <br>
                        <b>Jupyter notebook with functions and a tutorial for aggregating MRIO results </b>along the products, region, and industry dimensions. A 163 products x 48 regions x 163 industries footprint result is aggregated to 11 product groups, six regions, and five industrial sectors. <b>Prerequisites:</b> Matrix algebra, Python programming. <b>Level of difficulty: (+++)</b><br>
                        <script>jupyterLink("/Content/IEooc_Methods5_Software2.ipynb", "IEooc_Methods5_Software2");</script><br>
                        <a href="/Content/IEooc_Methods5_Software2_MRIO_Results.zip" target="new">IEooc_Methods5_Software2 (data file (.mat) and aggregation table (.xlsx))</a>
                        <br>
                        <br>
                        <b>Software tutorial from the application section: Efficient calculation of consumption-based environmental accounts with MRIO. </b>This software tutorial has three goals: 1) Learn how to break down environmental footprints into subcategories: category of consumption, region WHERE emissions occur, industries WHERE emissions occur, etc. 2) Learn how to extract territorial and consumption-based emissions from footprint account, and 3) Learn how to use two of the most versatile Python functions for working with table data: numpy.reshape and numpy.einsum. This tutorial contains all the steps needed to extract footprint accounts from the EXIOBASE MRIO tables and produce overview graphs such as the ones shown in the related reading material IEooc_Application3_Reading5. <b>Prerequisites:</b> Good understanding of MRIO, sufficient experience in working with Python. <b>Level of difficulty: (+++)</b><br>
                        <script>jupyterLink("/Content/IEooc_Application3_Software1.ipynb", "IEooc_Application3_Software1");</script><br>
                        <a href="/Content/IEooc_Application3_Software1_EXIOBASE3.4_2011_ITC_Agg_10x10.zip" target="new">IEooc_Application3_Software1 (data file)</a><br>
                        <br>
                        <br>
                        <b>Exercise: "Determining Sector Impact in IO Models With the Hypothetical Extraction Method – Hypothetical Extraction Method with Projection Matrices"</b> This exercise shows how to determine the impact or contribution of individual industrial sectors to the total enviromental footprint, an analysis that is increasingly applied in the literature. Topics covered: Understand the power series expansion of the L-matrix. Understand how the contribution of an individual industrial sector to the supply chain of a good or service can be identified by filtering out certain paths in the A matrix power series. Understand how the impact of several industrial sectors in the supply chain of a good or service can be determined without double-counting contribution, using projection matrices.<b> Prerequisites:</b> Matrix algebra on paper and Excel. <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Methods5_Exercise3_HEM_IO.pdf" target="new">IEooc_Methods5_Exercise3 (pdf)</a><br>
                        <a href="/Content/IEooc_Methods5_Exercise3_HEM_IO_Workbook.xlsx" target="new">IEooc_Methods5_Exercise3 (data and workbook)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods5_Exercise3_HEM_IO_SampleSolution.xlsx" target="new">IEooc_Methods5_Exercise3_Solution (xlsx)</a>
                        <br>
                        <br>			    
                        <br>
                    </td>
                </tr>


                <tr colspan="2">
                    <td><b>Methodology 6: Method integration.</b></td>
                </tr>

                <tr>
                    <td width="30%"></td>
                    <td width="70%">
                        <b>Reading material (blog entry) on the differences between process-based LCA and monetary MRIO.</b> Knowing about these differences is important when comparing MRIO and LCA results and when combining the two methods.
                        <br>
                        <a href="http://www.blog.industrialecology.uni-freiburg.de/index.php/2018/01/24/a-note-on-the-differences-between-process-based-lca-and-mrio/" target="new">IEooc_Methods6_Reading1</a>
                        <br>
                        <br>
                        <b>Reading material (book chapter) on prospective (forward-looking) assessment of sustainable development strategies using industrial ecology tools.</b> In this text the general principles of prospective modeling are lined out and the current development status of two prospective model types is described: extended dynamic material flow analysis and THEMIS (Technology-Hybridized Environmental-Economic Model with Integrated Scenarios). These models combine the high level of technological detail known from life-cycle assessment (LCA) and material flow analysis (MFA) with the comprehensiveness of, respectively, dynamic stock models and input/output analysis (I/O). These models are dynamic; they build future scenarios with a time horizon until 2050 and beyond. They were applied to study the potential effect of a wide spectrum of sustainable development strategies, including renewable energy supply, home weatherization, material efficiency, and light-weighting.
                        <br>
                        <a href="https://link.springer.com/content/pdf/10.1007%2F978-3-319-20571-7_2.pdf" target="new">IEooc_Methods6_Reading2</a>
                        <br>
                        <br>
                        <b>Reading material:</b><b> "Linking economy-wide material flow accounting to product-level life cycle assessment." </b>This report first explains the methods of material flow acccounting and material footprint calculations and then defines these methods and their central flows and indicators in the system description language of material flow analysis. Finally and mainly, it explains and documents an implementation of the material footprint calculation methodology for life cycle assessment (LCA) studies. With this new characterisation method, all material inflows into LCA product systems can be converted to their respective raw material equivalents and added up to the total extracted or processed material in the supply chain of goods or services. <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Methods6_Reading3_Material_Footprint_LCIA_ecoinvent_3_7__3_8.pdf" target="new">IEooc_Methods6_Reading3</a>
                        <br>
                        <br>
                        <b>Exercise: "Passenger vehicle light-weighting. A quantitative analysis of the coupling between the transportation and material production sectors.</b> Application of material flow analysis and life cycle assessment in a common framework." Estimate the system-wide impact of a climate change mitigation strategy in a specific sector. Learn about light-weighting of vehicle as a strategy to reduce GHG emissions on the medium scale. <b>Prerequisites:</b> No advanced math required. <b>Level of difficulty: (+)</b><br>
                        <a href="/Content/IEooc_Methods6_Exercise1_CoupledSectors.pdf" target="new">IEooc_Methods6_Exercise1 (pdf)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods6_Exercise1_CoupledSectors_Solution.pdf" target="new">IEooc_Methods6_Exercise1_Solution (pdf)</a> and
                        <br>
                        <a href="/Content/IEooc_Methods6_Exercise1_CoupledSectors_Solution.xlsx" target="new">IEooc_Methods6_Exercise1_Solution (xlsx)</a>
                        <br>
                        <br>
			<b>Reading material: Resource tracing with input output (IO) models – an overview.</b> This reading material explains how to trace resources through input-output tables. First, the differences between Leontief input-output (IO), Leontief price, Ghosh IO and absorbing Markov Chain models are explained. Then, it is shown how they all can be used to determine the distribution of natural resource or value added input into different final demand sectors (so-called end-use shares). This reading material is the supplement of a review, conceptual work, and empirical analysis on estimating end-use shares for material flows (how many % of total steel production go into vehicles, etc.) with monetary input-output tables. 
		  	 This material is taken from a <a href="https://doi.org/10.1111/jiec.13380" target="new">2023 publication in the Journal of Industrial Ecology by Streeck et al</a>.  <br>
                        <a href="/Content/IEooc_Methods6_Reading4_Resource_Tracing_IO.pdf" target="new">IEooc_Methods6_Reading4_Resource_Tracing_IO</a>.
                        <br>
                        <br>
                        <b>Tracing resources through input-output tables.</b> Goal: Understand the differences between Leontief input-output (IO), Leontief price, Ghosh IO and absorbing Markov Chain models. Learn how they all can be used to determine the distribution of natural resource or value added input into different final demand sectors (so-called end-use shares). Apply the resulting equations to a test IO table.<b> Prerequisites:</b> Input-Output table and model equations, matrix algebra.  <b>Level of difficulty: (+++)</b><br>
                        <a href="/Content/IEooc_Methods6_Exercise2_Resource_tracing_IO.pdf" target="new">IEooc_Methods6_Exercise2</a>.
                        <br>
                        <a href="/Content/IEooc_Methods6_Exercise2_Resource_tracing_IO_Workbook.xlsx" target="new">IEooc_Methods6_Exercise2_Resource_tracing_IO_Workbook (data and workbook)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods6_Exercise2_Resource_tracing_IO_Solution.xlsx" target="new">IEooc_Methods6_Exercise2_Resource_tracing_IO_Solution (xlsx)</a>
                        <br>
                        <br>
                        <b>Reading material (blog entry) on the material implications of low-carbon energy supply and use.</b> The text explains the relation between the transition to low-carbon energy and what it means for material consumption. It argues that all forms of energy supply have major downsides, and that the high material consumption of renewables is one potential problem. It quantifies the material footprint of different technologies for the energy transition and shows that while the fossil component of the material footprint declines, the metal ore component sharply rises, largely driven by the increased copper demand of electrification of end-use sectors. See IEooc_Methods2_Reading5 for the methodology of the material footprint applied here.
                        <br>
                        <a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2022/10/30/material-footprint-implications-of-low-carbon-technologies/" target="new">IEooc_Methods6_Reading5</a>
                        <br>
                        <br>			    
                        <b>from the LCA section: Advanced Life Cycle Impact Assessment:</b> Considering time in life cycle inventories: dynamic characterization factors for greenhouse gases. Goal: Get familiar with the global warming potential of greenhouse gases and the computation of global warming impacts of emissions from a system at different times. (‘dynamic GHG accounting’). Apply dynamic GHG accounting to different test cases. <b>Prerequisites:</b> Calculus, global warming potential (see IEooc_Background2_Exercise2). <b>Level of difficulty: (+++)</b><br>
                        <a href="/Content/IEooc_Methods4_Exercise11_dynLCA.pdf" target="new">IEooc_Methods4_Exercise11</a>.
                        <br>
                        <a href="/Content/IEooc_Methods4_Exercise11_dynLCA_Workbook.xlsx" target="new">IEooc_Methods4_Exercise11 (data and workbook)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods4_Exercise11_dynLCA_Sample_Solution.xlsx" target="new">IEooc_Methods4_Exercise11_Solution (xlsx)</a>
                        <br>
                        <br>
                    </td>
                </tr>

            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <br>
            <br>
            <br>
            <a name="Applications"></a>
            <h3>Part III: Applications </h3>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <table border="0">

                <tr colspan="2">
                    <td><b>Application 1: Sociometabolic regimes and transitions</b></td>
                </tr>

                <tr>
                    <td width="30%"></td>
                    <td width="70%">
                        <b>Webinar about sociometabolic regimes,</b> from the ISIE webinar series on socioeconomic metabolism: 
                        <br>
                        <a href="https://www.youtube.com/watch?v=VV_bH8FRRtE" target="new">IEooc_Application1_Lecture1</a>
                        <br>
                        <br>
                        <b>Exercise on land constraints in agricultural societies:</b> Develop a simple engineering model, learn about the physical distance and population constraints 
in the agricultural society, and estimate the area yield of modern renewable energy technologies. <b>Prerequisites:</b> Calculus.  <b>Level of difficulty: (+++)</b><br>
                        <a href="/Content/IEooc_Application1_Exercise1_Area_Constraints.pdf" target="new">IEooc_Application1_Exercise1</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application1_Exercise1_Area_Constraints_Solution.pdf" target="new">IEooc_Application1_Exercise1_Solution (pdf)</a> and
                        <br>
                        <a href="/Content/IEooc_Application1_Exercise1_Area_Constraints_Solution.xlsx" target="new">IEooc_Application1_Exercise1_Solution (xlsx)</a>
                        <br>
                        <br>
                        <b>Exercise on decoupling emissions from societal development at the large scale - The IPAT equation:</b> Understand how population, affluence, and a cap for a certain emission to the environment determine how industry must decouple from that emission. Learn about and apply the IPAT equation and link it to global climate and development targets. <b>Prerequisites:</b> Exponential function.  <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Application1_Exercise2_IPAT_Equation.pdf" target="new">IEooc_Application1_Exercise2</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application1_Exercise2_IPAT_Equation_Solution.pdf" target="new">IEooc_Application1_Exercise2_Solution (pdf)</a>
                        <br>
                        Directly related to this exercise is the following reading material, WHERE the economist Michael Grubb criticises the simple assumption that rates of technological change remain constant over long periods of time, and suggests that more realistic growth and technology diffusion models can lead to temporarily very high rates of change that are needed to transform entire industrial sectors.
                        <a href="https://www.ineteconomics.org/perspectives/blog/growth-with-decarbonization-is-not-an-oxymoron" target="new">IEooc_Application1_Reading1</a>
                        <br>
                        <br>
                        <b>Exercise on current levels of energy taxation and the impact of a tax on CO2 emissions from combustion and material production on prices of energy carriers and bulk materials:</b> A tax on greenhouse gas emissions can establish a price signal for more efficient use and substitution of carbon-intensive energy carriers and materials. Some energy carriers, in particular, gasoline and diesel for road vehicles, have high tax levels already. The tasks here are to find out i) how different fuel types are currently taxed, ii) how current taxation levels translate to carbon prices, and iii) how an additional carbon tax would affect the prices of different energy carriers and bulk materials. <b>Prerequisites:</b> Basic math, working with Excel. <b>Level of difficulty: (+)</b><br>
                        <a href="/Content/IEooc_Application1_Exercise3_CO2_Tax.pdf" target="new">IEooc_Application1_Exercise3</a>.
                        <br>
                        <a href="/Content/IEooc_Application1_Exercise3_CO2_Tax.xlsx" target="new">IEooc_Application1_Exercise3_CO2_Tax (Data, xlsx)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application1_Exercise3_CO2_Tax_Solution.xlsx" target="new">IEooc_Application1_Exercise3_CO2_Tax_Solution (xlsx)</a>
                        <br>
                        <br>
                        <br>
                    </td>
                </tr>

                <tr colspan="2">
                    <td><b>Application 2: Circular economy</b></td>
                </tr>

                <tr>
                    <td width="30%"></td>
                    <td width="70%">
			<b>Introductory book: Sustainable Materials - with both eyes open</b>, by Julian M Allwood and Jonathan M Cullen. Available <a 			href="https://www.uselessgroup.org/publications/book/chapters" target="_blank">here</a> for download.
                        <br>
                        <br>
                        <b>Classical reading: "Design Through the 12 Principles of Green Engineering"</b>, by By Paul T. Anastas and Julie B. Zimmerman (2003, DOI: 10.1021/es032373g):
                        <br>
                        <a href="https://pubs.acs.org/doi/pdf/10.1021/es032373g" target="new">IEooc_Background1_Reading5</a> Alternative link with no access restrictions: <a href="http://www.precaution.org/lib/08/prn_green_engineering.htm" target="new">IEooc_Background1_Reading5</a>
                        <br>
                        <br>
                        <b>Introductory blog entry: Circular economy: Breakthrough or distraction?</b>
                        <br>
                        <a href="http://www.blog.industrialecology.uni-freiburg.de/index.php/2017/12/15/the-circular-economy-breakthrough-or-distraction/" target="new">IEooc_Application2_Reading1</a>
                        <br>
                        <br>
                        <b>Overview article: “The Resource-Energy Nexus as a Key Factor for Circular Economy”</b>, by Mario Schmidt, Pforzheim University, Germany.
                        <br>
                        <a href="https://doi.org/10.1002/cite.202100111" target="new">IEooc_Application2_Reading1a</a>
                        <br>
                        <br>
                        <b>Video on the next generation of recycling technologies.</b> <b>Level of difficulty: (+). </b>
                        <br>
                        <a href="https://www.youtube.com/watch?v=I_fUpP-hq3A" target="new">IEooc_Application2_Video1</a>
                        <br>
                        <br>
                        <b>Lecture on a comprehensive resource efficiency-climate change mitigation assessment:</b> Presentation of the methods and results of a systematic industrial ecology assessment of the link between resource efficiency and climate change mitigation in the passenger vehicle and residential building sectors. <b>Prerequisites:</b> Dynamic Material Flow Analysis.  <b>Level of difficulty: (++)</b><br>
                        <a href="https://youtu.be/Wkf72dUScV4" target="new">IEooc_Application2_Lecture1</a>
                        <br>
                        <br>
                        <b>Core reading:</b> "Critical appraisal of the circular economy standard BS 8001:2017 and a dashboard of quantitative system indicators for its implementation in organizations":
                        <br>
                        <a href="/Content/IEooc_Application2_Reading2_CE_Review.pdf" target="new">IEooc_Application2_Reading2</a>
                        <br>
                        <br>
                        <b>Lecture: Sustainability in the steel cycle </b>The steel industry is responsible for 7-9% of global CO2 emissions. Reducing these emissions is not the only sustainability challenge in the steel sector but the dominant one. Four different system analysis perspectives are introduced (process/process cluster/material cycle/entire system) and it is shown how future steel demand can be estimated and the entire steel cycle be modelled to describe different sustainable futures for the steel industry. An introduction to material efficiency in the steel cycle is also given.
                        <b>Prerequisites:</b> Dynamic Material Flow Analysis.  <b>Level of difficulty: (++)</b><br>
                        <a href="https://youtu.be/UcWF8UrjwEM" target="new">IEooc_Application2_Lecture2</a>
                        <br>
                        <br>
                        <b>Blog entry about circular economy and in-use stocks:</b> In this piece the role played by in-use stocks of products, buildings, and infrastructure in closing material cycles (or the 'circular economy transition') is highlighted.
                        <br>
                        <a href="http://www.blog.industrialecology.uni-freiburg.de/index.php/2017/11/13/growth-of-in-use-stocks-central-obstacle-to-closing-material-cycles/" target="new">IEooc_Application2_Reading3</a>
                        <br>
                        <br>
                        <b>Exercise on estimating the number of life cycles of metals (from methods section):</b> Goal of this exercise is to develop and solve a basic model of the recycling loop, to define and calculate the lifetime of a material in the technosphere and the average number of life cycles. <b>Prerequisites:</b> Analytical solution of MFA systems, geometric series. <b>Level of difficulty: (++)</b>
                        <br>
                        <a href="/Content/IEooc_Methods3_Exercise2_Technical_Lifetime.pdf" target="new">IEooc_Methods3_Exercise2</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods3_Exercise2_Technical_Lifetime_Solution.pdf" target="new">IEooc_Methods3_Exercise2_Solution (pdf)</a>
                        <br>
                        <br>
                        <b>Exercise on a basic circular economy scenario for buildings.</b> The goal of this exercise is to understand the legal CE definitions and indicator frameworks. Work with salient CE indicators and develop a simple CE scenario with material stocks and flows. Interpret the CE as part of the energy service cascade. <b>Prerequisites:</b> Stocks and flows, working with the system definition, energy service cascade. <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Application2_Exercise1.pdf" target="new">IEooc_Application2_Exercise1</a>.
                        <br>
                        For this exercise a data workbook is needed:<br>
                        <a href="/Content/IEooc_Application2_Exercise1_Data.xlsx" target="new">IEooc_Application2_Exercise1_Data (xlsx)</a>
                        <br>
                        <br>
                    </td>
                </tr>

                <tr colspan="2">
                    <td><b>Application 3: Supply chain studies</b></td>
                </tr>

                <tr>
                    <td width="30%"></td>
                    <td width="70%">


                        <b>Lecture on the current applications of Life Cycle Assessment.</b> This video gives a brief overview of the major current applications of LCA as well as some of the main research frontiers in that field. <b>Prerequisites:</b> Basic understanding of life cycle thinking and life cycle assessment.  <b>Level of difficulty: (++)</b><br>
                        <a href="https://youtu.be/ur4Uwtl2a8U" target="new">IEooc_Application3_Lecture1</a>
                        <br>
                        <br>
                        <b>Lecture on sustainable production and consumption.</b> The following topics are covered: i) Production-based and consumption-based accounting of environmental impacts and their applications ii) The difference between the environmental and the ecological footprint iii) System change for sustainable production and consumption. <b>Prerequisites:</b> life cycle thinking. <b>Level of difficulty: (++)</b><br>
                        <a href="https://youtu.be/JYeyj_5T228" target="new">IEooc Application3 Lecture2</a>
                        <br>
                        <br>
                        <b>Exercise: "Transport vs. cooling of apples: a simple life cycle perspective" </b>Objective: To quantify the energy requirements for transport and storage/cooling. Calculate greenhouse gas emissions from these processes. Comparative calculation of the CO_2 footprints of different value chains (simple comparative life cycle assessment). <b>Prerequisites:</b> Quantitative systems analysis. <b>Level of difficulty: (+)</b><br>
                        <a href="/Content/IEooc_Application3_Exercise1a.pdf" target="new">IEooc_Application3_Exercise1a (pdf)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application3_Exercise1a_TransportVsCooling_SampleSolution.xlsx" target="new">IEooc_Application3_Exercise1a_TransportVsCooling_SampleSolution (xlsx)</a>
                        <br>
                        <br>
                        <b>Research article about environmental footprints of households by regions:</b> This study develops an inventory of carbon footprints associated with household consumption for 177 regions in 27 EU countries, thus, making a key contribution for the incorporation of consumption-based accounting into local decision-making.
                        <br>
                        <a href="http://iopscience.iop.org/article/10.1088/1748-9326/aa6da9/meta" target="new">IEooc_Application3_Reading1</a>
                        <br>
                        <br>
                        <b>Blog entry about the current limits and possible extensions of emissions trading:</b> A new policy proposal recommends charging consumers of emissions intensive materials such as steel and aluminium for the carbon emissions of material production. The proposal was developed to be considered for implementation in Phase IV of the EU Emissions Trading System commencing in 2021. Material flow cost accounting was applied to quantify the distribution of the carbon charge across commodity groups and to estimate the resulting price changes.<br>
                        <a href="http://www.blog.industrialecology.uni-freiburg.de/index.php/2017/06/08/inclusion-of-consumption-as-a-way-to-fix-the-problem-of-free-allocations-in-emissions-trading-an-application-of-material-flow-cost-accounting-to-climate-policy/" target="new">IEooc_Application3_Reading2</a>
                        <br>
                        <br>
                        Related <b>Policy paper about "Inclusion of Consumption of carbon intensive materials in emissions trading":</b>
                        <br>
                        <a href="/Content/IEooc_Application3_Reading3_Neuhoff_et_al_ClimateStrategies_2016.pdf" target="new">IEooc_Application3_Reading3</a>
                        <br>
                        <br>
                        Related <b>assessment of "Inclusion of Consumption of carbon intensive materials in emissions trading" using material flow cost accounting:</b>
                        <br>
                        <a href="/Content/IEooc_Application3_Reading4_Pauliuk_Neuhoff_et_al_IoC_DP1570.pdf" target="new">IEooc_Application3_Reading4</a>
                        <br>
                        <br>
                        <b>Exercise: "Inclusion of Consumption of carbon intensive materials in emissions trading." </b>You will gain a basic systems understanding  of  material  markets, learn about the material  content  of  merchandise  groups,  error propagation, and the application of Monte-Carlo-Simulation in material flow analysis.<b>Prerequisites:</b> Calculus. Random variables, discrete and continuous probability distributions, Monte-Carlo-Simulation. <b>Level of difficulty: (+++)</b><br>
                        <a href="/Content/IEooc_Application3_Exercise1_IoC.pdf" target="new">IEooc_Application3_Exercise1 (pdf)</a><br>
                        <a href="/Content/IEooc_Application3_Exercise1_IoC_Data.xlsx" target="new">IEooc_Application3_Exercise1 (data and workbook)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application3_Exercise1_IoC_Solution.pdf" target="new">IEooc_Application3_Exercise1_Solution (pdf)</a> and
                        <br>
                        <a href="/Content/IEooc_Application3_Exercise1_IoC_Solution.xlsx" target="new">IEooc_Application3_Exercise1_Solution (xlsx)</a>
                        <br>
                        <br>
                        <b>Blog entry about the territorial and consumption-based emissions accounts of the EU:</b> Environmental footprints measure pressure indicators such as greenhouse gases (GHG), material, land, or water use in global supply chains. Here, you can learn how the GHG emissions and material use of the global supply chains of the entire final consumption in all 28 EU countries (almost half or them only joined the EU in 2004 or later) have changed over time. The related software tutorial IEooc_Application3_Software1 contains all the steps needed to extract footprint accounts from the EXIOBASE MRIO tables and produce overview graphs such as the ones shown in this blog entry.<br>
                        <a href="http://www.blog.industrialecology.uni-freiburg.de/index.php/2018/12/09/eu28-carbon-footprint-has-stayed-constant-over-the-period-1995-2011-material-footprint-increased-by-20/" target="new">IEooc_Application3_Reading5</a>
                        <br>
                        <br>

                        <b>Software tutorial: Efficient calculation of consumption-based environmental accounts with MRIO. </b>This software tutorial has three goals: 1) Learn how to break down environmental footprints into subcategories: category of consumption, region WHERE emissions occur, industries WHERE emissions occur, etc. 2) Learn how to extract territorial and consumption-based emissions from footprint account, and 
3) Learn how to use two of the most versatile Python functions for working with table data: numpy.reshape and numpy.einsum. This tutorial contains all the steps needed to extract footprint accounts from the EXIOBASE MRIO tables and produce overview graphs such as the ones shown in the related reading material IEooc_Application3_Reading5. <b>Prerequisites:</b> Good understanding of MRIO, cf. Methods section 5. Sufficient experience in working with Python. <b>Level of difficulty: (+++)</b><br>
                        <script>jupyterLink("/Content/IEooc_Application3_Software1.ipynb", "IEooc_Application3_Software1");</script>
                        <a href="/Content/IEooc_Application3_Software1_EXIOBASE3.4_2011_ITC_Agg_10x10.mat" target="new">IEooc_Application3_Software1 (data file)</a><br>
                        <br>

                        <b>Journal article about the unequal distribution of household carbon footprints in Europe and its link to sustainability:</b> The distribution of household carbon footprints is largely unequal within and across countries. Here, Diana Ivanova and Richard Wood explore household-level consumption data to illustrate the distribution of carbon footprints and consumption within 26 European Union countries, regions and social groups. The analysis further sheds light on the relationships between carbon footprints and socially desirable outcomes such as income, equality, education, nutrition, sanitation, employment and adequate living conditions.<br>
                        <a href="https://doi.org/10.1017/sus.2020.12" target="new">IEooc_Application3_Reading6</a>
                        <br>
                        <br>

                        <br>
                        <br>
                    </td>
                </tr>

                <tr colspan="2">
                    <td><b>Application 4: Energy and Sustainability</b></td>
                </tr>

                <tr>
                    <td width="30%"></td>
                    <td width="70%">

			<b>Introductory book: Sustainable Energy - without the hot air</b>, by David MacKay. Available <a href="https://www.withouthotair.com/download.html" target="_blank">here</a> for download.
                        <br>
                        <br>
                        <b>Lecture: Energy and Sustainability - an introduction.</b> <b>Level of difficulty: (++)</b><br>
                        <a href="https://youtu.be/BCeJto4cLCA" target="new">IEooc_Application4_Lecture1</a>
                        <br>
                        <br>

			<b>Exercise on energy and power definitions from the methods section M1</b> It covers salient measures/indicators in the energy supply chain. Learn about the different energy and power definitions, units, and measures/indicators,
			as well as the definitions of primary, final, and useful energy. Define and calculate energy measures based on the system definition. <b>Prerequisites:</b> Concepts of energy and power in physics. No advanced math is required at this stage. <b>Level of difficulty: (+)</b><br>
			<a href="/Content/IEooc_Methods1_Exercise1a_Energy_Conversion_Chain.pdf" target="new">IEooc_Methods1_Exercise1a</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods1_Exercise1a_Energy_Conversion_Chain_Solution.pdf" target="new">IEooc_Methods1_Exercise1a_Solution (pdf)</a>
                        <br>
                        <br>

                        <b>Exercise from the background sections: Systems thinking for renewable energy.</b> Learn about the main types of renewable energy, the main barriers for their implementation, and the system linkages that determine their future contribution to climate change mitigation by reading the relevant chapter of the IPCC 5th Assessment Report. <b>Prerequisites:</b> None. <b>Level of difficulty: (+)</b><br>
                        <a href="/Content/IEooc_Background2_Exercise1_RenewableEnergy_IPCC.pdf" target="new">IEooc_Background2_Exercise1</a>.
                        <br>
                        Chapter 7 of part III of the IPCC 4th Assessment report is the reading material for this exercise:<br>
                        <a href="http://www.ipcc.ch/pdf/assessment-report/ar5/wg3/ipcc_wg3_ar5_chapter7.pdf" target="new">Reading material: Chapter 7 of part III of the IPCC 4th assessment report (pdf)</a>
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Background2_Exercise1_RenewableEnergy_IPCC_Solution.pdf" target="new">IEooc_Background2_Exercise1_Solution (pdf)</a>
                        <br>
                        <br>

                        <b>Exercise on energy sufficiency </b>Objective: Understand energy sufficiency as a concept and compare it with energy efficiency; think about ideas to introduce energy sufficiency in households; work with numbers to calculate energy savings potential; think about how energy sufficiency can be implemented on a larger scale. <b>Prerequisites:</b> Quantitative systems analysis. <b>Level of difficulty: (+)</b><br>
                        <a href="/Content/IEooc_Application4_Exercise1_EnergySufficiency.pdf" target="new">IEooc_Application4_Exercise1 (pdf)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application4_Exercise1_EnergySufficiency_SampleSolution.pdf" target="new">IEooc_Application4_Exercise1_EnergySufficiency_SampleSolution (pdf)</a>
                        <br>
                        <br>

                        <b>Lecture: Energy history, energy supply, and energy indicators.</b> <b>Level of difficulty: (++)</b><br>
                        <a href="https://youtu.be/QOdFQH-iHE8" target="new">IEooc_Application4_Lecture2</a>
                        <br>
                        <br>

                        <b>Link to methodology video lecture on the basic principles of industrial ecology data modelling and accounting: material and energy flow analysis: </b>
                        <br>
                        <a href="https://youtu.be/wK_02bGTh1E" target="new">IEooc_Methods1_Lecture1</a>
                        <br>
                        In this lecture, the practicalities of quantitative systems analysis are explained: Definitions and basic methodology for material and energy flow accounting are presented, including the basic elements of the quantitative system definition, the process balancing equations, indicator elements, units of measurement, multi-layer system descriptions, and a number of examples. <b>Prerequisites:</b> No advanced math is required at this stage. <b>Level of difficulty: (+)</b>
                        <br>
                        <br>

                        <b>Video lecture:</b> Measuring sustainability and sustainable development:
                        <br>
                        <a href="https://youtu.be/vSRyT7PJ7Z8" target="new">IEooc_Background2_Lecture5</a>
                        <br>
                        <br>

                        <b>Link to methodology exercise on the practicalities of quantitative systems analysis: Locating data in a system definition and indicator development.</b> Learn how to establish a system definition to allocate quantitative information that is given as text. Define and calculate indicators based on the system definition. <b>Prerequisites:</b> No advanced math is required at this stage. <b>Level of difficulty: (+)</b><br>
                        <a href="/Content/IEooc_Methods1_Exercise1_Indicator_Definition.pdf" target="new">IEooc_Methods1_Exercise1</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods1_Exercise1_Indicator_Definition_Solution.pdf" target="new">IEooc_Methods1_Exercise1_Solution (pdf)</a>
                        <br>
                        <br>

                        <b>Video lecture:</b> Energy conversion.
                        <br>
                        <a href="https://youtu.be/RwORxAh6bNI" target="new">IEooc_Application4_Lecture3</a>
                        <br>
                        <br>

                        <b>Exercise on area density of renewable energy </b>Objective: Understand the issue of area need for RE conversion, learn about typical energy densities and make own simple scenario calculation. <b>Prerequisites:</b> Quantitative systems analysis. <b>Level of difficulty: (+)</b><br>
                        <a href="/Content/IEooc_Application4_Exercise2_Area_Density_Energy.pdf" target="new">IEooc_Application4_Exercise2 (pdf)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application4_Exercise2_Area_Density_Energy_SampleSolution.xlsx" target="new">IEooc_Application4_Exercise2_Area_Density_Energy_SampleSolution (xlsx)</a>
                        <br>
                        <br>

                        <b>Video lecture:</b> Energy indicators.
                        <br>
                        <a href="https://youtu.be/Iolnw2UUCms" target="new">IEooc_Application4_Lecture4</a>
                        <br>
                        <br>
                        <b>Video lecture:</b> Environmental impacts of energy supply.
                        <br>
                        <a href="https://youtu.be/RNeqWkviWHY" target="new">IEooc_Application4_Lecture5</a>
                        <br>
                        <br>

                        <b>Cross-link to exercise from the supply chain studies section: "Transport vs. cooling of apples: a simple life cycle perspective" </b>Objective: To quantify the energy requirements for transport and storage/cooling. Calculate greenhouse gas emissions from these processes. Comparative calculation of the CO_2 footprints of different value chains (simple comparative life cycle assessment). <b>Prerequisites:</b> Quantitative systems analysis. <b>Level of difficulty: (+)</b><br>
                        <a href="/Content/IEooc_Application3_Exercise1a.pdf" target="new">IEooc_Application3_Exercise1a (pdf)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application3_Exercise1a_SampleSolution.xlsx" target="new">IEooc_Application3_Exercise1a_SampleSolution (xlsx)</a>
                        <br>
                        <br>

                        <b>Video lecture:</b> Energy Efficiency.
                        <br>
                        <a href="https://youtu.be/HmLzaN2C8GI" target="new">IEooc_Application4_Lecture6</a>
                        <br>
                        <br>

                        <b>Cross-link to exercise from the material and energy flow analysis section: Cement production, efficiency strategies and related indicators:</b> The goal of this exercise is to consolidate your understanding of basic quantitative system analysis. Also, to get some detailed knowledge about energy use and greenhouse gas emissions of the cement industry. <b>Prerequisites:</b> No advanced math required. <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Methods2_Exercise1_Cement.pdf" target="new">IEooc_Methods2_Exercise1</a>.
                        <br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Methods2_Exercise1_Cement_Solution.pdf" target="new">IEooc_Methods2_Exercise1_Solution (pdf)</a><br>
                        <a href="/Content/IEooc_Methods2_Exercise1_Cement_Solution.xlsx" target="new">IEooc_Methods2_Exercise1_Solution (xlsx)</a>
                        <br>
                        <br>

                        <b>Exercise on energy efficiency </b>Objective: Imagine you are a team of energy efficiency consultants and you are being assigned the task of providing a set of expert recommendations to your client in order to improve the energy efficiency/ performance of his industrial/ commercial facility. TEAM EXERCISE (IDEALLY, FORM GROUPS OF 3 STUDENTS OR WORK IN ANOTHER FORM OF LEARNING GROUP). <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Application4_Exercise3_Energy_Efficiency.pdf" target="new">IEooc_Application4_Exercise3 (pdf)</a><br>
                        <a href="/Content/IEooc_Application4_Exercise3_Energy_Efficiency_ideas.zip" target="new">IEooc_Application4_Exercise3_Energy_Efficiency_ideas (zipped pptx)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application4_Exercise3_Energy_Efficiency_SampleSolution.xlsx" target="new">IEooc_Application4_Exercise3_Energy_Efficiency_SampleSolution (xlsx)</a>
                        <br>
                        <br>

                        <b>Video lecture:</b> Energy Technology Revolution.
                        <br>
                        <a href="https://youtu.be/U4PyLIhn9ZM" target="new">IEooc_Application4_Lecture7</a>
                        <br>
                        <br>

                        <b>Exercise on energy demand scenarios </b>Objective: Conduct back-of-the-envelope calculations, estimate energy demand by end-use sector, identify scenario drivers, become comfortable with dealing with very large numbers. <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Application4_Exercise4_Energy_Demand_Scenario.pdf" target="new">IEooc_Application4_Exercise4 (pdf)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application4_Exercise4_Energy_Demand_Scenario_SampleSolution.pdf" target="new">IEooc_Application4_Exercise4_Energy_Demand_Scenario_SampleSolution (pdf)</a><br>
                        <a href="/Content/IEooc_Application4_Exercise4_Energy_Demand_Scenario_SampleSolution.xlsx" target="new">IEooc_Application4_Exercise4_Energy_Demand_Scenario_SampleSolution (xlsx)</a>
                        <br>
                        <br>

                        <b>Exercise on energy supply scenarios </b>Objective: Estimate renewable energy (RE) potential and assess how a given energy demand can be met using different RE sources. Estimate the GHG mitigation potential and land use of a given RE scenario. <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Application4_Exercise5_Energy_Supply_Scenario.pdf" target="new">IEooc_Application4_Exercise5 (pdf)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application4_Exercise5_Energy_Supply_Scenario_SampleSolution.pdf" target="new">IEooc_Application4_Exercise5_Energy_Supply_Scenario_SampleSolution (pdf)</a><br>
                        <a href="/Content/IEooc_Application4_Exercise5_Energy_Supply_Scenario_SampleSolution.xlsx" target="new">IEooc_Application4_Exercise5_Energy_Supply_Scenario_SampleSolution (xlsx)</a>
                        <br>
                        <br>

                        <b>Video lecture:</b> The Hydrogen Economy, by Prof. Dierk Raabe.
                        <br>
                        <a href="https://www.youtube.com/watch?v=erYf_wNDhmE" target="new">IEooc_Application4_Lecture8</a>
                        <br>
                        <br>

                        <b>Video lecture:</b> Bioenergy and Biomaterials from a Life Cycle Perspective.
                        <br>
                        <a href="https://youtu.be/rhUVfkq_S8o" target="new">IEooc_Application4_Lecture9</a>
                        <br>
                        <br>

                        <b>Exercise on the concept of payback time in life cycle thinking and on how to take into account the timing of emissions and sequestration of carbon in the calculation of the global warming potential (GWP) </b>Goal: Get familiar with the carbon intensity of different energy carriers (orders of magnitude), understand the concept of distributing upfront emissions on the subsequently produced output, break-even emissions, and the computation of global warming impacts of emissions from a system at different times. (‘dynamic GHG accounting’). This exercise only considers GHG. Biodiversity and economic aspects of land conversion are highly relevant but are not studied here. <b>Level of difficulty: (+++)</b><br>
                        <a href="/Content/IEooc_Application4_Exercise6_LifeCycle_BioFuels_BioMaterials.pdf" target="new">IEooc_Application4_Exercise6 (pdf)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application4_Exercise6_LifeCycle_BioFuels_BioMaterials_SampleSolution.xlsx" target="new">IEooc_Application4_Exercise6 Sample Solution (xlsx)</a>
                        <br>
                        <br>
                        <b>Cross-link to reading material (blog entry) from the methods section on the material implications of low-carbon energy supply and use.</b> The text explains the relation between the transition to low-carbon energy and what it means for material consumption. It argues that all forms of energy supply have major downsides, and that the high material consumption of renewables is one potential problem. It quantifies the material footprint of different technologies for the energy transition and shows that while the fossil component of the material footprint declines, the metal ore component sharply rises, largely driven by the increased copper demand of electrification of end-use sectors. See IEooc_Methods2_Reading5 for the methodology of the material footprint applied here.
                        <br>
                        <a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2022/10/30/material-footprint-implications-of-low-carbon-technologies/" target="new">IEooc_Methods6_Reading5</a>
                        <br>
                        <br>		
                        <b>Exercise on applying material and energy flow analysis (MEFA) to wood use as material and as energy carrier.</b> Goal: Define and quantify climate-relevant metrics for wood use. Learn how to properly distinguish between actual carbon flows and counter-factual flows (avoided emissions). <b>Level of difficulty: (++)</b><br>
                        <a href="/Content/IEooc_Application4_Exercise7_CarbonAccounting_WoodUse.pdf" target="new">IEooc_Application4_Exercise7 (pdf)</a><br>
			<a href="/Content/IEooc_Application4_Exercise7_CarbonAccounting_WoodUse_Woorkbook.xlsx" target="new">IEooc_Application4_Exercise7 (Excel workbook)</a><br>
                        For this exercise a sample solution is available:<br>
                        <a href="/Content/IEooc_Application4_Exercise7_CarbonAccounting_WoodUse_Sample_Solution.xlsx" target="new">IEooc_Application4_Exercise7 Sample Solution (xlsx)</a>
                        <br>
                        <br>
                    </td>
                </tr>

            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <center>
                <br>
                <br>
                <br>
                <br>
                <img src="/Content/IEooc_Logo_V2.png" width="250">
            </center>

            <br>
            <br>
            <center>
                <b>Contact:</b> stefan.pauliuk[at]indecol.uni-freiburg.de<br>
                <b>International Society for Industrial Ecology:</b> <a href="https://is4ie.org" target="new">https://is4ie.org</a><br>
                <br>
                <b>Acknowledgements:</b><br>
		<b>Adakole Daniel Okwa</b>, for helping with the completion of the 200-year matrix version of the workbook for IEooc_Methods3_Software9.<br>
                <b>Oliver Cencic</b>, TU Vienna, provided detailed bug reports on the different lectures on dynamic MFA and the LCA exercises.<br>
		<b>Christina Madrid López </b>, Universitat Autònoma de Barcelona, provided feedback and corrections for the IO exercises.<br>
                <b>Niko Heeren</b>, ETH Zürich, provided detailed feedback on the SEM data model and related software routines.<br>
                <b>Tomer Fishman</b>, IDC Herzliya, provided detailed feedback and improvement options for dynamic stock model software, which is the basis of the dyn. MFA exercises.<br>
                <b>Steve Allen</b>, U Bath, provided feedback on IEooc_Methods4_Exercise6.<br>
                <b>Oskar Wood Hansen, </b> helped debug and update the IO-related exercises and workbooks.<br>
		<b>Martin Hillenbrand, </b> University of Bayreuth, Germany, helped debug and update the dynamic MFA-related exercises and workbooks. <br>
		<b>Julius Noah Jandl, </b>for spotting and correcting errors in IEooc_Methods3_Software1.<br>
		<b>Ofir Eriksen, </b>for helping improve the sample solution of IEooc_Application3_Exercise1a.<br>
                <br>
                <br>
                <br>
                <br>
            </center>

            <table>
                <tr>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>
                <tr>
                    <td>
                        <img src="/Content/440px-Global_Open_Educational_Resources_Logo.svg.png" width="200"></td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>The IEooc is an open educational resource (OER), which is a publicly accessible collection of teaching and study materials for any user to use, re-mix, improve, and redistribute. It is designed to reduce knowledge accessibility barriers, to implement best practices in teaching, and to be adapted to local contexts. </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td>
                        <img src="/Content/OER.png" width="250"></td>
                </tr>
            </table>

            <br>
            <br>
            <br>
            <h2>More online teaching resources for industrial ecology and related methods:</h2>
            <br>
            <br>
            + <a href="https://is4ie.org/resources/webinars" target="new">Webinar series</a> of the International Society for Industrial Ecology. Some of the webinars listed there are part of the IEooc syllabus.
            <br>
            <br>
            + <a href="https://is4ie.org/resources/videos" target="new">Video library</a> of the International Society for Industrial Ecology. 
            <br>
            <br>
            + <a href="http://www.columbia.edu/itc/eee/e4001y/index.html?client_edit/course_syllabus.html" target="new">Industrial Ecology of Earth Resources</a>, online course material from Columbia University. 
            <br>
            <br>
            + Massive Open Online Course <a href="https://www.universiteitleiden.nl/en/news/2018/01/learn-about-the-circular-economy-of-metals" target="new">’A Circular Economy of Metals: Towards a Sustainable Societal Metabolism’</a> by Ester van der Voet, CML Leiden.
            <br>
            <br>
            + <a href="https://ilca.es/teaching-materials/open-teaching-material/" target="new">Open teaching material</a> of the International Life Cycle Academy (ILCA). 
            <br>
            <br>
	    + Introduction to Life Cycle Assessment (LCA) by Jeroen Guinée, Bernhard Steubing, Reinout Heijungs, and other CML-LCA experts: <a href="https://rise.articulate.com/share/Gx0ZK3GHgAYU-BSaboqXRHN0f6SjC4de#/" target="new">The course (clicke here for access) </a> is based on the theoretical part of the LCA course that is taught in the joint TU Delft - Leiden University Master Programme on Industrial Ecology.
            <br>
            <br>
	    + Series of video-lectures on 'Consequential modelling in Life Cycle Inventory analysis' by LCA-NET.com, freely available via their  
		<a href="https://youtube.com/playlist?list=PLdeMRDEdKW1uf9sr83G9vweym_q7dg44q" target="_blank">Youtube channel</a>.
            <br>
            <br>
	    + Fundamentals of the ecoinvent Database: <a href="https://support.ecoinvent.org/e-learning-fundamentals-database" target="new">An e-learning course</a> that will help you understand how to use the database and to assess the environmental impacts of human activities. The course consists of four modules.
            <br>
            <br>
            + To help you get started with openLCA, GreenDelta provides <a href="https://www.openlca.org/learning/" target="new">free resources, including case studies</a>, for modeling your own LCA study.
            <br>
            <br>
            + The UN Environment Life Cycle Initiative provides <a href="https://www.lifecycleinitiative.org/resources/training/" target="new">LCA training material</a>.
            <br>
            <br>
            + Metabolism of Cities <a href="https://education.metabolismofcities.org/" target="new">Education Hub</a>.
            <br>
            <br>
            + CIRAIG (Montreal) has launched its first online course (MOOC) for the general public on its core expertise: life cycle assessment (LCA). This is a comprehensive online course, the first in the world *in French*, aimed at teaching LCA methodology. 
            The Introduction to Life Cycle Assessment <a href="https://ciraig.org/index.php/mooc-acv/" target="new">online course [link] </a>is designed for students and professionals who want to learn about life cycle thinking, embrace a systems view, and calculate and interpret the environmental footprint of a product, service or technology.
            <br>
            <br>


            <br>
            <br>
            <br>
            <b>PS:</b> The IEooc is not to be confused with the Idaho-Eastern Oregon Onion Committee (IEOOC).<br>
        </div>
</asp:Content>
