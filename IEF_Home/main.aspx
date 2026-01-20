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
            <img class="img-responsive center-block" src="resources/FOSP_Homepage_1.png" height="800px" width="800px" alt="illustration of the content of this portal">
            <div class="caption">
            </div>
        </div>

        <div class="grid-twitter">

            <div class="not-show-twitter">
             <h3 style="text-align: center"><b>+++ News +++</b></h3> 

                <h4><b>New tool to search the industrial ecology data commons by author and DOI</b></h4>
                <p> [Winter 2026] Users of the industrial ecology data commons (IEDC) can now search for data by specific authors (by name) and publications (by DOI). The new search feature browses through both, the catalogue of datasets and the comment feature of each individual data point, so that data from specific authors or publication that are part of larger compilations can also be found.
                    <img style="padding-top: 10px;padding-bottom: 10px" class="img-responsive center-block" alt="DOI icon" src="resources/doi-1.png"/>
                    Access to the new search function:   <a href="https://www.database.industrialecology.uni-freiburg.de/iedc_author_DOI_search.aspx" target="_blank">https://www.database.industrialecology.uni-freiburg.de/iedc_author_DOI_search.aspx</a>
                </p>
                <hr>

                <h4><b>CIRCOMOD project input data now available on the Industrial Ecology Community Database</b></h4>
                <p> [Summer 2025] During the first phase of the CIRCOMOD EU-Horizon project (Circular Economy Modelling for Climate Change Mitigation), about two dozen of researchers have collected, formatted, and validated a larger number of datasets on service provision, in-use stocks, product material composition, energy intensity, and lifetimes of products, focussing on appliances, buildings, vehicles, infrastructure, industrial assets, and energy system technologies. Many of these datasets are now available on the IEDC.
                    <img style="padding-top: 10px;padding-bottom: 10px" class="img-responsive center-block" alt="CIRCOMOD project" src="resources/CIMO_1.png"/>
                    Find the CIRCOMOD-related datasets on the IEDC, by searching for ‘CIRCOMOD’:   <a href="https://www.database.industrialecology.uni-freiburg.de/" target="_blank">https://www.database.industrialecology.uni-freiburg.de/</a>
                </p>
                <hr>

                <h4><b>Critical Mass Sprint for the Industrial Ecology Community Database</b></h4>
                <p> [Spring 2025] 2025 is the year when we move the industrial ecology data commons prototype, launched in 2018, into a functional and helpful data archiving and retrieval tool for the entire industrial ecology community! 
                    We plan to collect, format, and upload a larger number of datasets on product material composition, energy intensity, and lifetimes of products, focussing on products and commodities including appliances, buildings, vehicles, infrastructure, industrial assets, and energy system technologies.
                    <img style="padding-top: 10px;padding-bottom: 10px" class="img-responsive center-block" alt="Critical Mass Sprint for the Industrial Ecology" src="resources/IEDC_CMS_2025.png"/>
                    Read more about the 2025 Critical Mass Sprint for industrial ecology data here:   <a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2025/03/03/2025-iedc-critical-mass-sprint/ " target="_blank">https://www.blog.industrialecology.uni-freiburg.de/index.php/2025/03/03/2025-iedc-critical-mass-sprint/  </a>
                </p>

            </div>




            <h4 style="color: white">Links:</h4>
            <span class="grid-link" style="color: white">Our research group's official (<a href="https://uni-freiburg.de/enr-indecol" target="_blank">website</a>)</span>
            <span class="grid-link" style="color: white">Faculty of Environment and Natural Resources (<a href="https://uni-freiburg.de/unr/" target="_blank">website</a>)</span>
            <span class="grid-link" style="color: white">International Society for Industrial Ecology (<a href="http://www.is4ie.org/" target="_blank">website</a>)</span>

        </div>
    </div>

</asp:Content>
