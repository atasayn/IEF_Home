<%@ Page Title="Industrial Ecology Freiburg" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="IEF_Home.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script src="js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" async
            src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
    </script>
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

        @media screen and (max-width: 768px) {
            .grid-container {
                display: block;
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
            //console.log(me.name);
            //console.log(me.checked);
            //console.log(document.cookie);
        }


    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="grid-container">
        <div class="grid-main">
            <h3>Welcome to the research portal of Industrial Ecology Freiburg (IEF)!</h3>
            <p style="margin-top:35px">
                We are the research group for sustainable energy and material flow management (Nachhaltiges Energie- und Stoffstrommanagement) at the Faculty of Environment and Natural Resources.
                <br>
                <br>
                We study the link between human development and material and energy use and estimate the environmental impacts of material production and energy supply. 
                <br>
                We use material cycle and scenario models to quantify the impact on energy and material demand of different resource efficiency strategies (circular economy), different urban forms, different levels of societal inequality, and of sufficiency strategies. 
                <br>
                With our research, we help identify the most effective policy levers for decoupling human wellbeing from resource use and environmental destruction.
                <br>
                <br>
                On these pages, we blog about our research and the projects we are involved in, host a database with our research results, share model information and teaching material, and provide visualisation tools.
                <br>
                <br>
                <b> You can find out more about our group, our research approach, and our teaching on our <a href="http://www.indecol.uni-freiburg.de/en" target="_blank">official homepage</a></b>
            </p>
        </div>

        <div class="grid-photo">
            <img class="img-responsive center-block" src="resources/Opening_Pic_v3a.png" height="800px" width="800px" alt="Stacker at open pit lignite mine, Nochten, Germany">
            <div class="caption">
            </div>
        </div>

        <div class="grid-twitter">

            <div class="not-show-twitter">
             <h3><b>Indecol News</b></h3> 
     <%--      <img class="img-responsive center-block" src="resources/Gini_Paper_Link.png" height="">--%>
                <h5><b>Successful EU Horizon project meeting in Freiburg</b></h5>
                <p> In February 2025, more than 30 European researchers gathered at Industrial Ecology Freiburg for an annual project meeting to coordinate their research on estimating the impact of the circular economy (saving material resources by sufficiency, eco-design and better recycling) on the EU material industries and their climate impact.
                    <img style="padding-top: 10px;padding-bottom: 10px" class="img-responsive center-block" src="resources/Webinar.png">
                    Read more about the CIRCOMOD (Circular Economy Modelling for Climate Change Mitigation) project here: <a href="https://circomod.eu/" target="_blank">https://circomod.eu/ </a>
                </p>
                <hr>
                <h5><b>Material Requirements of Decent Living Standards – new publication by Johan Vélez and Stefan Pauliuk</b></h5>
                <p> Decent living standards are practical threshold for the energy, GHG, and material consumption required to alleviate poverty. 
                    We quantify the amount of materials in stocks and flows needed to provide a decent living standard to an individual: a material footprint (MF) of about \(6 \frac{t}{\text{cap} \cdot \text{yr}}\) and in-use stocks of about 43 \(\frac{t}{\text{cap}}\) are required. 
                    We also estimate which lifestyle and technology choices are effective in reducing material demand.
                    <img style="padding-top: 10px;padding-bottom: 10px" class="img-responsive center-block"  src="resources/Homepage_News_2.png"/>
                    Read the paper here:  <a href="https://doi.org/10.1021/acs.est.3c03957 " target="_blank">https://doi.org/10.1021/acs.est.3c03957 </a>
                </p>
                <hr>
                <h5><b>New paper linking the indicators for poverty fight, inequality, and growth</b></h5>
                <p> Decent living standards, economic inequality, and total economic output are not independent! A new paper by Stefan Pauliuk shows that per average capita service \( \text{pcs} \), 
                    the Gini coefficient of inequality \( G \), and the personal decent living standard \( 5 \, \text{dls} \) are coupled as below:
                    <img style="padding-top: 10px; padding-bottom: 10px;width:200px" class="img-responsive center-block"  src="resources/Pauliuk_DLS_LorenzCurve_2024_pcs_1 (002).png"/>
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
