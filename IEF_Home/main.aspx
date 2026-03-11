<%@ Page Title="Industrial Ecology Freiburg" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="IEF_Home.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <!-- Matomo -->
    <script type="text/javascript">
        var _paq = window._paq = window._paq || [];
        _paq.push(['setCookieDomain', '*.industrialecology.uni-freiburg.de']);
        _paq.push(['enableCrossDomainLinking']);
        _paq.push(['trackPageView']);
        _paq.push(['enableLinkTracking']);
        (function () {
            var u = "https://www.blog.industrialecology.uni-freiburg.de/matomo/";
            _paq.push(['setTrackerUrl', u + 'matomo.php']);
            _paq.push(['setSiteId', '1']);
            var d = document, g = d.createElement('script'), s = d.getElementsByTagName('script')[0];
            g.async = true; g.src = u + 'matomo.js'; s.parentNode.insertBefore(g, s);
        })();
    </script>
    <!-- End Matomo Code -->


    <script src="js/jquery-1.7.1.min.js" type="text/javascript" defer></script>

    <style>
        h1 {
            font-size: 30px;
        }

        h2 {
            font-size: 28px;
        }

        .grid-main {
            grid-area: main;
            max-width: 800px;
            text-align: justify;
            margin: 0 auto;
            font-size: 15px;
        }

            .grid-main h3 {
                margin-top: 0;
            }

        .grid-photo {
            grid-area: photo;
            margin-bottom: 0;
            margin-top: auto;
        }

        .grid-twitter {
            grid-area: twitter;
            background-color: #34499a;
            padding: 15px;
        }

        .grid-container {
            display: grid;
            grid-template-areas: 'main  twitter'
                'photo twitter';
            grid-template-rows: auto;
            grid-auto-columns: auto 500px;
            gap: 10px;
            padding: 10px;
        }

        .not-show-twitter {
            background-color: white;
            width: 470px;
            height: 740px;
            font-size: inherit;
            padding: 0.5em 1em;
            border-radius: 1em;
            display: block;
            overflow: scroll
        }

        .not-show-twitter-content {
            font-size: small;
            line-height: 1.6;
            text-align: center;
            margin: auto;
            padding-top: 20em;
        }

        .show-twitter {
            display: none;
        }

        hr {
            border: none;
            height: 2px;
            /* Set the hr color */
            color: #333; /* old IE */
            background-color: #333; /* Modern Browsers */
        }

        button {
            height: 2em;
            width: 20em;
            margin: auto;
        }

        input {
            margin: auto;
            vertical-align: middle;
            position: relative;
            top: -3px;
        }

        .grid-link {
            display: block;
        }

            .grid-link::before {
                content: "\1F517  ";
            }
        /* spacing and typography for the introduction text */
        .grid-intro {
            margin-top: 10px; /* replaces the inline style */
            text-align: justify;
            font-size: 15px;
            line-height: 1.6;
            max-width: 800px; /* keep same width as .grid-main layout if needed */
            margin-left: auto;
            margin-right: auto;
        }

            /* paragraph spacing */
            .grid-intro p {
                margin: 0 0 1em 0; /* bottom margin defines spacing between paragraphs */
            }

                /* slightly larger bottom spacing before the strong call-to-action */
                .grid-intro p:last-of-type {
                    margin-bottom: 0; /* if you want no extra space after final paragraph */
                }

        /* accessible hidden heading used for SEO / screen readers */
        .visually-hidden {
            position: absolute !important;
            height: 1px;
            width: 1px;
            overflow: hidden;
            clip: rect(1px, 1px, 1px, 1px);
            white-space: nowrap;
            border: 0;
            padding: 0;
            margin: -1px;
        }

        /* link emphasis */
        .grid-intro a {
            text-decoration: underline;
            font-weight: 600;
        }

        .main-title {
            font-weight: 600;
            line-height: 1.4;
            margin-bottom: 1rem;
            text-align: left;
        }

        .section-header {
            background-color: #d9d9d9;
            font-weight: bold;
            cursor: pointer;
            display: flex;
            align-items: center;
            border: 1px solid #bfbfbf;
            user-select: none;
        }

        /* Arrow style */
        .toggle-arrow {
            font-size: 14px;
            padding-left: 5px;
            transition: transform 0.3s ease;
        }

            /* Rotate arrow when expanded */
            .toggle-arrow.rotate {
                transform: rotate(180deg);
            }

        .collapsible-content {
            display: none;
            border-top: none;
            background-color: #fff;
        }
        /* responsive tweak if needed */
        @media screen and (max-width: 768px) {
            .grid-intro {
                padding: 0 1rem;
                font-size: 15px;
            }
        }


        @media screen and (max-width: 768px) {
            .grid-container {
                grid-template-areas:
                                   "main"
                                   "photo"
                                   "twitter";
                grid-auto-columns: 1fr;
            }
        }
    </style>
    <script type="text/javascript">

        window.onload = function () {

            if (getCookie('twitter-cookie') == 'true') {
                // cookies exist, show the div
                var scriptElement = document.createElement('script');
                scriptElement.type = 'text/javascript';
                scriptElement.src = "https://platform.twitter.com/widgets.js";
                document.head.appendChild(scriptElement);

                $('.show-twitter').css('display', 'block');


            }
        }

        function displayTwitter() {

            var scriptElement = document.createElement('script');
            scriptElement.type = 'text/javascript';
            scriptElement.src = "https://platform.twitter.com/widgets.js";
            document.head.appendChild(scriptElement);

            $('.show-twitter').css('display', 'block');
            $('.not-show-twitter').css('display', 'none');


        }

        function setCookie(cname, value, exdays) {
            var exdate = new Date();
            exdate.setDate(exdate.getDate() + exdays);
            var c_value = escape(value) + ((exdays == null) ?
                "" : "; expires=" + exdate.toUTCString());
            document.cookie = cname + "=" + c_value;
        }

        function getCookie(cname) {
            let name = cname + "=";
            let ca = document.cookie.split(';');
            for (let i = 0; i < ca.length; i++) {
                let c = ca[i];
                while (c.charAt(0) == ' ') {
                    c = c.substring(1);
                }
                if (c.indexOf(name) == 0) {
                    return c.substring(name.length, c.length);
                }


            }
            return cname;
        }

        function set_check(me) {
            setCookie(me.name, me.checked, 60 * 60 * 1);

        }

    </script>
    <script type="application/ld+json">
        {
         "@context": "https://schema.org",
         "@type": "ResearchOrganization",
         "name": "Industrial Ecology Research Group",
         "url": "https://industrialecology.uni-freiburg.de",
         "parentOrganization": {
           "@type": "CollegeOrUniversity",
           "name": "University of Freiburg"
         }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="grid-container">
        <div class="grid-main">
            <h1 class="main-title">Welcome to the open science portal of the industrial ecology research group (IEF), University of Freiburg</h1>
            <section aria-labelledby="intro-title">
                <div class="grid-intro">
                    <p>
                        On these pages, members of the industrial ecology research group at the Faculty of Environment and Natural Resources of the University of Freiburg, Germany offer a comprehensive open science environment for industrial ecology and socio-metabolic research. We blog about sustainable use of material and energy, our research, and the projects we are involved in. We host the IEDC, a database on social metabolism with global scope. We share information and material related to our research software, offer a large compilation of teaching material, and provide tools to visualise energy and material flows in society.
                    </p>

                    <p>
                        Open science is a global movement to make scientific research (including data, models, software, visualisation tools, and related teaching material) transparent and accessible to all levels of society. Open science is part of the DNA of our research group, and we use public funding to strengthen the research infrastructure, teaching material, and public knowledge base related to energy and material flows in society and their sustainable management.
                    </p>

                    <p>
                        <strong>You can find out more about our group, our research approach, and our teaching on our
                            <a href="https://uni-freiburg.de/enr-indecol" target="_blank" rel="noopener noreferrer">official homepage
                            </a>
                        </strong>
                    </p>
                </div>
            </section>

        </div>

        <div class="grid-photo">
            <img loading="lazy" class="img-responsive center-block" src="resources/FOSP_Homepage_1.png" height="800" width="800" alt="illustration of the content of this portal">
            <div class="caption">
            </div>
            <div class="w3-bar section-header grid-intro" style="background-color: #ffc000; margin-top: 10px" onclick="toggleSection()">
                <div class="w3-bar" style="margin-left: 10px; padding-right: 10px;"><b>Toggle section to know more about Industrial Ecology </b></div>
                <span id="arrow" class="toggle-arrow">▼</span>

            </div>
        </div>

        <div id="section-content" class="collapsible-content grid-intro" style="display: none">
            <h2><b>Industrial Ecology and Socio-Metabolic Research</b></h2>

            <h3><b>Challenge</b></h3>
            <p>
                Materials are at the basis of human society. Urbanization, industrialization, and growing consumption 
drive the demand for wood, concrete, steel, plastics, chemicals, and various technology materials. 
Providing adequate access to modern and low-carbon energy services and adapting to climate change 
further increase resource consumption, as new energy infrastructure and protective measures such as 
dams and dikes need to be built.
            </p>

            <p>
                The global use of natural resources has grown at an unprecedented rate, and the number of chemical 
elements and their combinations used in modern technologies have multiplied. Consequently, the natural 
resource endowment and the quality of the environment keep declining in most countries, especially in 
the Global South, which in turn fuels economic, social, and geopolitical conflicts.
            </p>

            <p>
                Currently, material production accounts for about 23% of global greenhouse gas emissions. This major 
contribution to global warming, plus the large impacts of mining on land use change and water 
consumption, highlight the need for research on how materials are linked to and can be decoupled from 
environmental impacts and service provision to people by establishing a circular economy of materials. 
Resilient and sustained supply of so-called critical materials and the large material requirements of 
the transition to low-carbon energy are major global concerns involving materials. On the social side, 
material extraction is often connected to struggles for environmental justice.
            </p>

            <h3><b>SEM Approach</b></h3>
            <p>
                Socio-economic metabolism (SEM) is a research paradigm that looks at material and energy turnover 
and processing at the societal level. SEM researchers study human-controlled stocks and flows of 
energy and materials and their links to social outcomes and environmental impacts.
            </p>

            <p>
                Under the SEM paradigm, researchers have developed methods and established accounting approaches to 
measure material use in the economy, model scenarios for transforming material cycles, and provide 
policy advice regarding resource use constraints of policy interventions. Material flow analysis (MFA), 
often combined with energy flow analysis (MEFA), is the basic accounting and modelling method of 
scientific analysis of socio-economic metabolism. In-use stocks, the material stocks in the built 
environment, are a key component of society’s metabolism, as they provide services such as shelter 
and mobility and also provide the resources for future recycling.
            </p>

            <p>
                Socio-economic metabolism is complex and includes many delays, like the lifetime of products in use, 
and couplings, such as the different materials contained in a single vehicle. For another example, 
many green technologies that reduce greenhouse gas emissions use critical minerals, making these 
industries vulnerable to supply disruptions.
            </p>

            <p>
                More detailed accounts of resource use and waste are needed to deepen the understanding of how 
materials flow through the economy, where losses occur, and where efficiency can be improved. 
Such detailed material flow accounts form the basis for assessing efficiency and circular economy 
improvements for businesses and governments at the company, city, regional, national, and global scales.
            </p>

            <p>
                The analysis may also focus on certain materials of concern because of their availability or toxic 
capacity and will identify the impact of regulatory and engineering solutions to metabolic problems.
            </p>

            <p>
                Dynamic MFA studies show how in-use stocks and material cycles evolve over time. They quantify the 
accumulation of stocks in our economy, such as the material demand for the energy transition. A focus 
of dynamic MFA is on industrial countries, such as Japan and China, which often depend on imports and 
have large production industries and consumption levels.
            </p>

            <p>
                Dynamic MFA helps identify future ‘urban mines’ (recycling potential) and allows us to estimate the 
decline of ore grades as a response to growing demand. Thus, such studies provide necessary information 
for assessing the potential of circular economy strategies, e.g., in the global building sector or 
for cement.
            </p>

            <h3><b>Practical Applications, Current Trends, and New Research Avenues in SEM Research</b></h3>
            <p>
                MFA studies are now linked to supply chain assessment, e.g., via MFA-LCA combinations, and to 
assessments of the economic implications of changed consumption and circular economy measures, 
e.g., to estimate rebound effects. Increasingly, MFA studies are linked to social and environmental 
impacts.
            </p>

            <p>
                To study the social and environmental aspects of material use more systematically, the energy and 
material service cascade offers a framework that combines the key elements of socio-economic metabolism 
(material services, stocks, and flows) to human well-being on the one hand and materials to environmental 
impacts on the other hand.
            </p>

            <p>
                Different social and environmental links of material can be studied, as well as different decoupling 
options along the cascade. The framework allows for coupling MFA studies to the assessment of legal 
instruments and economic incentives at the different stages of the cascade, as well as exploring the 
link between material stocks, product stocks, product functioning, service provision, and well-being.
            </p>

            <p>
                The multi-stage cascade and its link to culture, lifestyle, regulations, and economics enable us to 
systematically expand the traditional set of economic indicators to include well-being indicators 
beyond GDP that measure how effectively basic human needs are being met, alongside high-level 
information on material use, waste, energy use, emissions, and water use.
            </p>

            <p>
                This refined understanding of human material use in the energy and material service cascade leads 
to an expanded set of indicators that is critical to redesigning our provisioning systems to achieve 
a good life for all within planetary limits.
            </p>

            <p>
                <strong>Source:</strong> This text is part of an overview on socio-economic metabolism research written 
by Stefan Pauliuk in his role as ISIE-SEM board section chair and published at:
                <a href="https://is4ie.org/sections/metabolism/pages/40" target="_blank">https://is4ie.org/sections/metabolism/pages/40
</a>
            </p>
        </div>

        <div class="grid-twitter">

            <div class="not-show-twitter">
                <h3 style="text-align: center"><b>+++ News +++</b></h3>
                <br>

                <h4><b>IEDC Critical Mass Sprint completed</b></h4>
                <p>
                    [Winter 2026] During the 2025 critical mass sprint, in total 180 datasets were collected, formatted, and uploaded to the IEDC. These datasets cover service provision, in-use stocks, product material composition, energy intensity, and lifetimes of products, focussing on products and commodities including appliances, buildings, vehicles, infrastructure, industrial assets, and energy system technologies. They are now part of one of the largest openly available compilations of material stock and flow and product group data, and can be found via the IEDC’s multiple search functions.
                    <img loading="lazy" style="padding-top: 10px; padding-bottom: 10px" class="img-responsive center-block" alt="Gini illustration" src="resources/IEDC_CMS_Checked.png" />
                    Direct access to the IEDC and its multiple search functions: <a href="https://www.database.industrialecology.uni-freiburg.de/" target="_blank">https://www.database.industrialecology.uni-freiburg.de/ </a>
                </p>
                <hr>

                <h4><b>First datasets on socio-metabolic inequality – New tool to browse IEDC datasets by project</b></h4>
                <p>
                    [Winter 2026] Inequality is a major issue of our time, but data on inequality are still scarce. The new IEDC project “Socio_metabolic_inequality_SMI” offers to the community a compilation of around 20 datasets on Lorenz curves, Gini coefficients, and other inequality indicators from more than 50 literature sources. The data cover non-monetary socio-metabolic indicators (service provision, stocks, flows, energy, material, water, GHG/emissions, and land). The datasets can be found by using a new search tool that allows users to quickly find all IEDC datasets linked to a certain project. Submission of own datasets to the IEDC to this and other projects is welcome!
                    <img loading="lazy" style="padding-top: 10px; padding-bottom: 10px" class="img-responsive center-block" alt="Gini illustration" src="resources/SMI_Project_Gini.jpg" />
                    See all datasets in this and other projects:   <a href="https://www.database.industrialecology.uni-freiburg.de/projects.aspx?project=Socio_metabolic_inequality_SMI" target="_blank">https://www.database.industrialecology.uni-freiburg.de/projects.aspx?project=Socio_metabolic_inequality_SMI </a>
                </p>
                <hr>

                <h4><b>New tool to search the industrial ecology data commons by author and DOI</b></h4>
                <p>
                    [Winter 2026] Users of the industrial ecology data commons (IEDC) can now search for data by specific authors (by name) and publications (by DOI). The new search feature browses through both, the catalogue of datasets and the comment feature of each individual data point, so that data from specific authors or publication that are part of larger compilations can also be found.
                    <img loading="lazy" style="padding-top: 10px; padding-bottom: 10px" class="img-responsive center-block" alt="DOI icon" src="resources/doi-1.png" />
                    Access to the new search function:   <a href="https://www.database.industrialecology.uni-freiburg.de/iedc_author_DOI_search.aspx" target="_blank">https://www.database.industrialecology.uni-freiburg.de/iedc_author_DOI_search.aspx</a>
                </p>
                <hr>

                <h4><b>CIRCOMOD project input data now available on the Industrial Ecology Community Database</b></h4>
                <p>
                    [Summer 2025] During the first phase of the CIRCOMOD EU-Horizon project (Circular Economy Modelling for Climate Change Mitigation), about two dozen of researchers have collected, formatted, and validated a larger number of datasets on service provision, in-use stocks, product material composition, energy intensity, and lifetimes of products, focussing on appliances, buildings, vehicles, infrastructure, industrial assets, and energy system technologies. Many of these datasets are now available on the IEDC.
                    <img loading="lazy" style="padding-top: 10px; padding-bottom: 10px" class="img-responsive center-block" alt="CIRCOMOD project" src="resources/CIMO_1.png" />
                    Find the CIRCOMOD-related datasets on the IEDC, by searching for ‘CIRCOMOD’:   <a href="https://www.database.industrialecology.uni-freiburg.de/" target="_blank">https://www.database.industrialecology.uni-freiburg.de/</a>
                </p>
                <hr>

                <h4><b>Critical Mass Sprint for the Industrial Ecology Community Database</b></h4>
                <p>
                    [Spring 2025] 2025 is the year when we move the industrial ecology data commons prototype, launched in 2018, into a functional and helpful data archiving and retrieval tool for the entire industrial ecology community! 
                    We plan to collect, format, and upload a larger number of datasets on product material composition, energy intensity, and lifetimes of products, focussing on products and commodities including appliances, buildings, vehicles, infrastructure, industrial assets, and energy system technologies.
                    <img loading="lazy" style="padding-top: 10px; padding-bottom: 10px" class="img-responsive center-block" alt="Critical Mass Sprint for the Industrial Ecology" src="resources/IEDC_CMS_2025.png" />
                    Read more about the 2025 Critical Mass Sprint for industrial ecology data here:   <a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2025/03/03/2025-iedc-critical-mass-sprint/ " target="_blank">https://www.blog.industrialecology.uni-freiburg.de/index.php/2025/03/03/2025-iedc-critical-mass-sprint/  </a>
                </p>

            </div>




            <h4 style="color: white">Links:</h4>
            <span class="grid-link" style="color: white">Our research group's official <a href="https://uni-freiburg.de/enr-indecol" target="_blank">website</a></span>
            <span class="grid-link" style="color: white">Faculty of Environment and Natural Resources: <a href="https://uni-freiburg.de/unr/" target="_blank">website</a></span>
            <span class="grid-link" style="color: white">International Society for Industrial Ecology: <a href="http://www.is4ie.org/" target="_blank">website</a></span>

        </div>
    </div>

    <script>
        function toggleSection() {
            const content = document.getElementById('section-content');
            const arrow = document.getElementById('arrow');

            if (content.style.display === 'none' || content.style.display === '') {
                content.style.display = 'block';
                arrow.classList.add('rotate');
            } else {
                content.style.display = 'none';
                arrow.classList.remove('rotate');
            }
        }
    </script>
</asp:Content>
