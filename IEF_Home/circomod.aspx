<%@ Page Title="CIRCOMOD" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="circomod.aspx.cs" Inherits="IEF_Home.circomod" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <!-- css -->
    <link rel="stylesheet" href="/css/all.min.css"  >
    
    <!-- javascript -->
    <script src="js/togglePassword.js"></script>

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

            #login-content {
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

            #passwordCell {
                position: relative;
            }

            #eyePassword {
                right: 1em;
                top: 13px;
                position: absolute;
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
        </div>

        <div class="item login ">
            <div id="login-content">
                <h4>Sign in</h4>
                <table id="table-login">
                    <tr>
                        <td>
                            <asp:TextBox required="true" placeholder="Email" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox required="true" placeholder="Password" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>
                                <asp:CheckBox Text="&nbsp&nbsp&nbsp Remember Me" runat="server" />
                            </p>
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <asp:Button Text="LOGIN" CssClass="btn btn-success" class="form-control" runat="server" />
                            <span class="linkSpan"><a onclick="showRegister(true)">Register a new account</a></span>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="register-content">
                <h4>Register</h4>
                <table id="table-register">
                    <tr>
                        <td>
                            <asp:TextBox required="true" placeholder="First Name" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox required="true" placeholder="Last Name" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox required="true" placeholder="Organization Name" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox required="true" placeholder="Username" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox required="true" placeholder="Email" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td id="passwordCell">
                            <asp:TextBox required="true" ID="txtPassword" TextMode="Password" placeholder="Password" runat="server"></asp:TextBox>
                            <i id="eyePassword" onmousedown="showPassword(true)" onmouseup="showPassword(false)" class="fa fa-eye"></i>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox required="true" ID="txtPasswordRepeat" TextMode="Password" placeholder="Repeat Password" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button Text="Register" CssClass="btn btn-success" class="form-control" runat="server" />
                            <span class="linkSpan"><a onclick="showRegister(false)">Back to login</a></span>
                        </td>
                    </tr>
                </table>
            </div>

        </div>
    </div>

</asp:Content>

