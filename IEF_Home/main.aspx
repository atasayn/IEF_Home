<%@ Page Title="Industrial Ecology Freiburg" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="IEF_Home.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
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
            height: auto;
            font-weight: bold;
            font-size: large;
            padding: 0.5em 1em;
            border-radius: 1em;
            display: block;
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
                You can find out more about our group, our research approach, and our teaching on our <a href="http://www.indecol.uni-freiburg.de/en" target="_blank">official homepage</a>
            </p>
        </div>

        <div class="grid-photo">
            <img class="img-responsive center-block" src="resources/Opening_Pic_v3a.png" height="800px" width="800px" alt="Stacker at open pit lignite mine, Nochten, Germany">
            <div class="caption">
            </div>
        </div>

        <div class="grid-twitter">

            <div class="not-show-twitter">
                Tweets from @StefanPauliuk
           <img class="img-responsive center-block" src="resources/Gini_Paper_Link.png" height="">
            </div>




            <h4 style="color: white">Links:</h4>
            <span class="grid-link" style="color: white">International Society for Industrial Ecology (<a href="http://www.is4ie.org/" target="_blank">website</a>)</span>
            <span class="grid-link" style="color: white">Faculty of Environment and Natural Resources (<a href=" https://www.unr.uni-freiburg.de/de" target="_blank">website</a>)</span>

        </div>
    </div>

</asp:Content>
