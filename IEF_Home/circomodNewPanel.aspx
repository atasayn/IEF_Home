<%@ Page Title="CIRCOMOD" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="circomodNewPanel.aspx.cs" Inherits="IEF_Home.Circomod" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script src="js/togglePassword.js"></script>
    <link rel="stylesheet" href="/css/all.min.css">
    <style>
        .grid-container {
            width: 100%;
            display: grid;
            grid-template-columns: 61.8% 38.2%;
            grid-template-rows: auto;
            grid-template-areas:
                "content login "
                "content login ";
        }

        main {
            padding: 0;
        }

        .item {
            padding: 1em;
            text-align: justify;
        }

            .item.titles {
                grid-area: content;
            }

            .item.login {
                grid-area: login;
                background: linear-gradient(90deg, hsla(149, 73%, 75%, 1) 0%, hsla(193, 76%, 69%, 1) 100%);
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%
            }

                .item.login div, .item.login table {
                    width: 100%
                }

                .item.login input {
                    margin: 5px 0;
                }

                    .item.login input:not(input[type=checkbox]) {
                        height: 2.3em;
                        border-radius: 4px;
                        border: 1px solid gray;
                        padding-left: 6px;
                        width: 100%
                    }

        #login-content, #register-content {
            max-width: 25em;
        }


        .item h2, .item h3, .item h4 {
            text-align: center;
        }

        #register-content {
            display: none;
        }

        .linkSpan {
            margin-top: 1em;
            height: 2.3em;
            line-height: 2.3em;
            width: 100%;
            display: inline-block;
            text-align: center;
        }

            .linkSpan a {
                color: #333;
                text-decoration: underline;
                font-weight: 700;
                cursor: pointer;
            }

        #passwordCell, #passwordCellRepeat {
            position: relative;
        }

        #eyePassword, #eyePasswordRepeat {
            right: 1em;
            top: 13px;
            position: absolute;
        }

        #passhint {
            padding: 0 7px;
            display: block;
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
        <div class="item titles">
            <h2>CIRCOMOD:</h2>
            <h3>Circular economy modelling for climate change mitigation</h3>
            <br>
            <p>A circular economic system that aims to reduce primary material use (in addition to energy efficiency and fuel shifts) can address both Greenhous Gas emissions (GHG)s and increase resource efficiency. However, current GHG mitigation models and scenarios that inform climate policymakers do not generally include circular economy (CE) options. They also do not cover the possible synergies of the CE with other societal goals such as the Sustainable Development Goals (SDGs), nor the challenges involved in rearranging value chains and consumer behaviour.</p>
            <br>
            <p>CIRCOMOD addresses these challenges by developing a new generation of advanced models and scenarios that will assess how CE can reduce future GHGs and material use. The project brings together a unique consortium of leading research teams from different disciplines, including industrial ecology and material flow modelling, process-oriented integrated assessment modelling, and macro-economic modelling. It aims for a breakthrough in integrating CE and GHG mitigation assessments by a) developing an analytical framework that maps circular economy strategies to existing influential climate scenarios; b) providing robust and timely CE data in an open repository; and c) improving the representation of the CE in leading models used by European and global institutions, while strengthening links between the models. It will provide input to international assessments such as the Intergovernmental Panel on Climate Change (IPCC) and the International Resource Panel (IRP).</p>
            <br>
            <p>The EU research fund Horizon Europe has awarded 5 million euros to the project. The consortium consists of twelve partners from different EU countries. </p>
            <br>
            <p>
                Here, we will show different visualization options for circular economy profiles for materials, products, and regions.
            <a href="https://www.tilburguniversity.edu/current/news/more-news/eu-funds-research-project-circomod-eu-modeling-circular-economy-mitigate-climate-change" target="_blank">Tilburg University</a>
            </p>
            <hr/>
        </div>

        <div class="item login ">
            <div id="login-content">
                <h4>Sign in</h4>

                <asp:TextBox required="true" placeholder="Email" runat="server"></asp:TextBox>

                <asp:TextBox required="true" placeholder="Password" runat="server"></asp:TextBox>

                <asp:CheckBox Text="&nbsp&nbsp&nbsp Remember Me" runat="server" />

                <asp:Button Text="Login" CssClass="btn btn-success" class="form-control" runat="server" />

                <span class="linkSpan"><a onclick="showRegister(true)">Register a new account</a></span>
            </div>
            <div id="register-content">
                <h4>Register</h4>

                <asp:TextBox required="false" placeholder="First Name (optional)" runat="server"></asp:TextBox>

                <asp:TextBox required="false" placeholder="Last Name (optional)" runat="server"></asp:TextBox>

                <asp:TextBox required="false" placeholder="Organization Name (optional)" runat="server"></asp:TextBox>

                <asp:TextBox required="true" placeholder="Username" runat="server"></asp:TextBox>

                <asp:TextBox required="true" placeholder="Email" runat="server"></asp:TextBox>

                <div id="passwordCell">
                    <asp:TextBox required="true" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$"
                        passwordrules="required: upper, lower; required: digit; required: [@$!%*#?&]; minlength: 8;"
                        ID="txtPassword" TextMode="Password" placeholder="Password " runat="server"></asp:TextBox>
                    <i id="eyePassword" onmousedown="showPassword(true)" onmouseup="showPassword(false)" class="fa fa-eye"></i>
                </div>

                <span id="passhint">Must contain at least 8 characters, including at least one special character and one number</span>

                <div id="passwordCellRepeat">
                    <asp:TextBox required="true" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$"
                        ID="txtPasswordRepeat" TextMode="Password" placeholder="Repeat Password " minlength="8" runat="server"></asp:TextBox>
                    <i id="eyePasswordRepeat" onmousedown="showPasswordRepeat(true)" onmouseup="showPasswordRepeat(false)" class="fa fa-eye"></i>
                </div>

                <asp:Button Text="Register" CssClass="btn btn-success" class="form-control" runat="server" />

                <span class="linkSpan"><a onclick="showRegister(false)">Back to login</a></span>
            </div>

        </div>
    </div>

</asp:Content>

