<%@ Page Title="Industrial Ecology Freiburg" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="IEF_Home.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <style>
        .grid-main {
            grid-area: main;
            max-width: 800px;
            text-align: justify;
            margin: 0 auto;
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
            background-color: #CCDFF5;
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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="grid-container">
        <div class="grid-main">
            <h3>Welcome to the research portal of Industrial Ecology Freiburg (IEF)!</h3>
            <p>
                We are the group for sustainable energy and material flow management (Nachhaltiges Energie- und Stoffstrommanagement) at the Faculty of Environment and Natural Resources.
                <br>
                <br>
                We study the global and future consequences of sustainable development strategies, including renewable energy, material efficiency, biomass use, and many more.
                <br>
                We quantify the material and energy basis of our society to assist evidence-based policy development.
                <br>
                We contribute to the development of methodology for the sustainability assessment of products and lifestyles.
                <br>
                <br>
                On these pages, we blog about our research and the projects we are involved in, host a database with our research results, share teaching material, and provide visualisation tools.

                <br>
                <br>
                You can find out more about our group on our <a href="http://www.indecol.uni-freiburg.de/en" target="_blank">official homepage</a>
            </p>
        </div>

        <div class="grid-photo">
            <img class="img-responsive center-block" src="resources/HP_Main_V1.png" height="800px" width="800px" alt="Stacker at open pit lignite mine, Nochten, Germany">
            <div class="caption">
            </div>
        </div>

        <div class="grid-twitter">
            <!--<h3>Twitter Timeline</h3>-->
            <a class="twitter-timeline" data-dnt="true" data-height="650" href="https://twitter.com/StefanPauliuk">Tweets by StefanPauliuk</a>
            <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


            <h4>Links:</h4>
            <span class="grid-link">International Society for Industrial Ecology (<a href="http://www.is4ie.org/" target= "_blank" >website</a>)</span>
            <span class="grid-link">Faculty of Environment and Natural Resources (<a href=" https://www.unr.uni-freiburg.de/de" target= "_blank" >website</a>)</span>
            
        </div>
    </div>

</asp:Content>