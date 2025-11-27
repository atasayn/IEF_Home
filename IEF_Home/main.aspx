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


    <script src="js/jquery-1.7.1.min.js" type="text/javascript"></script>

    <style>
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
            color: #333;  /* old IE */
            background-color: #333;  /* Modern Browsers */
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
            margin-top: 35px;           /* replaces the inline style */
            text-align: justify;
            font-size: 15px;
            line-height: 1.6;
            max-width: 800px;          /* keep same width as .grid-main layout if needed */
            margin-left: auto;
            margin-right: auto;
        }

        /* paragraph spacing */
        .grid-intro p {
            margin: 0 0 1em 0;         /* bottom margin defines spacing between paragraphs */
        }

        /* slightly larger bottom spacing before the strong call-to-action */
        .grid-intro p:last-of-type {
            margin-bottom: 0;          /* if you want no extra space after final paragraph */
        }

        /* accessible hidden heading used for SEO / screen readers */
        .visually-hidden {
            position: absolute !important;
            height: 1px; width: 1px;
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

        /* responsive tweak if needed */
        @media screen and (max-width: 768px) {
            .grid-intro {
                padding: 0 1rem;
                font-size: 15px;
            }
        }


        @media screen and (max-width: 768px) {
            .grid-container {
                display: block;
            }
        }

        .main-title {
            font-size: 23px;
            font-weight: 600;
            line-height: 1.4;
            margin-bottom: 1rem;
            text-align: left;
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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="grid-container">
        <div class="grid-main">
            <h1 class="main-title">Welcome to the open science portal of Industrial Ecology Freiburg (IEF)</h1>
            <section aria-labelledby="intro-title">
                <div class="grid-intro">
                    <p>
                        We are the research group for sustainable energy and material flow management
                        (Nachhaltiges Energie- und Stoffstrommanagement) at the Faculty of Environment and Natural Resources.
                    </p>

                    <p>
                        We study the link between human development and material and energy use and estimate
                        the environmental impacts of material production and energy supply.
                    </p>

                    <p>
                        We use material cycle and scenario models to quantify the impact on energy and material
                        demand of different resource efficiency strategies (circular economy), different urban forms,
                        different levels of societal inequality, and of sufficiency strategies.
                    </p>

                    <p>
                        With our research, we help identify the most effective policy levers for decoupling human
                        wellbeing from resource use and environmental destruction.
                    </p>

                    <p>
                        On these pages, we blog about our research and the projects we are involved in, host a database
                        with our research results, share model information and teaching material, and provide
                        visualisation tools.
                    </p>

                    <p>
                        <strong>
                            You can find out more about our group, our research approach, and our teaching on our
                            <a href="https://uni-freiburg.de/enr-indecol" target="_blank" rel="noopener noreferrer">
                                official homepage
                            </a>
                        </strong>
                    </p>
                </div>
            </section>

        </div>

        <div class="grid-photo">
            <img class="img-responsive center-block" src="resources/Opening_Pic_v3a.png" height="800px" width="800px" alt="Stacker at open pit lignite mine, Nochten, Germany">
            <div class="caption">
            </div>
        </div>

        <div class="grid-twitter">

            <div class="not-show-twitter">
             <h3 style="text-align: center"><b>+++ News +++</b></h3> 
                <h4><b>Delegation from Nagoya University visiting our research group</b></h4>
                <p> On November 18, 2025, we strengthened our ties to the research group around Profs. Hiroki Tanikawa and Hiroaki Shirakawa from Nagoya University, Japan. The work of our Japanese colleagues focusses on social and urban metabolism in terms of material input, stock, and output for sustainability. 
                    Material stocks of buildings and infrastructure provide numerous services such as dwelling, transport, and communication, and therefore need to be monitored. During the visit, we updated each other on the ongoing collaboration on scenarios for the low carbon transformation of the Japanese residential building sector, and we discussed new ideas and research questions for common projects.
                    <img style="padding-top: 10px;padding-bottom: 10px" class="img-responsive center-block" alt="Delegation from Nagoya"  src="resources/Nagoya_Delegation_Nov_2025_s.jpg"/>
                    Read more about the Tanikawa Lab at Nagoya University: <a href="https://www.civil.nagoya-u.ac.jp/ceeipo/research_lab/tanikawa_shirakawa-lab.html " target="_blank">https://www.civil.nagoya-u.ac.jp/ceeipo/research_lab/tanikawa_shirakawa-lab.html  </a>
                </p>
                <hr>
                <h4><b>Successful doctoral defense - congratulations Dr. Gilang Hardadi</b></h4>
                <p> On May 22, 2025, Gilang Hardadi successfully defended his doctoral thesis” Using Econometrics and Multi-Regional Input-Output (MRIO) Models to Simulate Short-Term Socio-Economic Impacts of a Just and Equitable Low-Carbon Transition.” In his work, Gilang demonstrates how Multi-Regional Input-Output (MRIO) Models can be used to assess the impact of climate economic instruments, such as carbon taxation, tax revenue recycling, or carbon border adjustments on the tax load of different income groups and on industrial transformation. The results of his work inform policy makers on the effectiveness and social implications of climate policy. Profs. Stefan Pauliuk and Yasushi Kondo were the thesis advisors, and Prof. Karsten Neuhoff wrote the second thesis review.
                    <img style="padding-top: 10px;padding-bottom: 10px" class="img-responsive center-block" alt="Successful doctoral defense" src="resources/20250522_111124s.jpg"/>
                    Read more about Gilang’s work here: <a href="https://doi.org/10.1111/jiec.13045  " target="_blank">https://doi.org/10.1111/jiec.13045 </a>
                </p>
                <hr>
                <h4><b>Critical Mass Sprint for the Industrial Ecology Community Database</b></h4>
                <p> 2025 is the year when we move the industrial ecology data commons prototype, launched in 2018, into a functional and helpful data archiving and retrieval tool for the entire industrial ecology community! 
                    We plan to collect, format, and upload a larger number of datasets on product material composition, energy intensity, and lifetimes of products, focussing on products and commodities including appliances, buildings, vehicles, infrastructure, industrial assets, and energy system technologies.
                    <img style="padding-top: 10px;padding-bottom: 10px" class="img-responsive center-block" alt="Critical Mass Sprint for the Industrial Ecology" src="resources/IEDC_CMS_2025.png"/>
                    Read more about the 2025 Critical Mass Sprint for industrial ecology data here:   <a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2025/03/03/2025-iedc-critical-mass-sprint/ " target="_blank">https://www.blog.industrialecology.uni-freiburg.de/index.php/2025/03/03/2025-iedc-critical-mass-sprint/  </a>
                </p>
                <hr>
                <h4 style="padding-top:5px "><b>Successful EU Horizon project meeting in Freiburg</b></h4>
                <p> In February 2025, more than 30 European researchers gathered at Industrial Ecology Freiburg for an annual project meeting to coordinate their research on estimating the impact of the circular economy (saving material resources by sufficiency, eco-design and better recycling) on the EU material industries and their climate impact.
                    <img style="padding-top: 10px;padding-bottom: 10px" class="img-responsive center-block" alt="EU Horizon project meeting" src="resources/Webinar.png">
                    Read more about the CIRCOMOD (Circular Economy Modelling for Climate Change Mitigation) project here: <a href="https://circomod.eu/" target="_blank">https://circomod.eu/ </a>
                </p>
                <hr>
                <h4><b>Material Requirements of Decent Living Standards – new publication by Johan Vélez and Stefan Pauliuk</b></h4>
                <p> Decent living standards are practical threshold for the energy, GHG, and material consumption required to alleviate poverty. 
                    We quantify the amount of materials in stocks and flows needed to provide a decent living standard to an individual: a material footprint (MF) of about \(6 \frac{t}{\text{cap} \cdot \text{yr}}\) and in-use stocks of about 43 \(\frac{t}{\text{cap}}\) are required. 
                    We also estimate which lifestyle and technology choices are effective in reducing material demand.
                    <img style="padding-top: 10px;padding-bottom: 10px" class="img-responsive center-block" alt="Material Requirements of Decent Living Standards" src="resources/Homepage_News_2.png"/>
                    Read the paper here:  <a href="https://doi.org/10.1021/acs.est.3c03957 " target="_blank">https://doi.org/10.1021/acs.est.3c03957 </a>
                </p>
                <hr>
                <h4><b>New paper linking the indicators for poverty fight, inequality, and growth</b></h4>
                <p> Decent living standards, economic inequality, and total economic output are not independent! A new paper by Stefan Pauliuk shows that per average capita service \( \text{pcs} \), 
                    the Gini coefficient of inequality \( G \), and the personal decent living standard \( 5 \, \text{dls} \) are coupled as below:
                    <img style="padding-top: 10px; padding-bottom: 10px;width:200px" class="img-responsive center-block" alt="Decent living standards" src="resources/Pauliuk_DLS_LorenzCurve_2024_pcs_1 (002).png"/>
                    The work concludes with calling upon the research community to assess the inequality of physical stock and flow indicators related to human wellbeing, identify suitable physical wellbeing measures, 
                    and extend the debate on desirable levels of inequality to physical socio-metabolic indicators.
                    Read the paper here:  <a href="https://doi.org/10.1016/j.ecolecon.2024.108161  " target="_blank">https://doi.org/10.1016/j.ecolecon.2024.108161 </a>
                </p>
            </div>




            <h4 style="color: white">Links:</h4>
            <span class="grid-link" style="color: white">International Society for Industrial Ecology (<a href="http://www.is4ie.org/" target="_blank">website</a>)</span>
            <span class="grid-link" style="color: white">Faculty of Environment and Natural Resources (<a href=" https://www.unr.uni-freiburg.de/de" target="_blank">website</a>)</span>

        </div>
    </div>

</asp:Content>
