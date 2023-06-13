<%@ Page Title="Internal - Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="internal_login.aspx.cs" Inherits="IEF_Home.Internal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <style type="text/css">
        .col-md-7 {
            background-color: transparent;
            padding-bottom: 20px;
        }

            .col-md-7 p a, p a:hover {
                color: darkgreen;
                font-weight: bold;
                font-size: 24px;
                text-decoration: none;
            }

            .col-md-7 p span {
                color: lightgreen;
            }
  
     

    </style>

    <script src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.6.2.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="row">

        <div class="col-md-7">
            <br />
            <p><a href="#">Industrial Ecology Freiburg <span>Internal Database</span></a></p>
        </div>
        <div class="col-md-5">
        </div>
    </div>

    <div class="row">
        <div class="col-md-7">
            The Industrial Ecology Freiburg Internal Database is available to all group members and associated students. The data and information supplied here are for applications
                    in concordance with the respective license agreements only.
                      
                  <br />
            <br />

            When preparing your work, please check the university’s guidelines for <a href="https://uni-freiburg.de/forschung/redlichkeit-in-der-wissenschaft/" target="new">academic integrity</a>
            and the group's <a href="https://www.indecol.uni-freiburg.de/de/supervision-scheme" target="new">guidelines for good scientific practice and supervision</a>.
                    <br />
            <br />
            &nbsp;<img class="img-responsive center-block" src="resources/pexels-photo-209137.jpeg" style="align-self: center; width: 500px;" alt="Industrial Ecology Freiburg Internal Database" />







            <br />

        </div>

        <div class="col-md-5">

            <div id="loginbox" style="" class="col-md-10 col-md-offset-2 col-sm-8 col-sm-offset-2">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <div class="panel-title">Sign In</div>
                    </div>
                    <div style="padding-top: 30px" class="panel-body">
                        <div style="display: none" id="login-alert" class="alert alert-danger col-sm-12"></div>
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnLogin">
                           
                            <table class="table table-responsive">
                                <tr>
                                    <td>User Name:</td>
                                    <td>
                                        <asp:TextBox ID="txtUserName" runat="server" class="form-control" placeholder="username"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td>Enter Password:</td>
                                    <td>
                                        <asp:TextBox ID="txtPassword" runat="server" type="text" TextMode="Password" class="form-control" placeholder="password"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>

                                    <td colspan="2" class="centered">
                                        <asp:Button ID="btnLogin" runat="server" class="btn btn-success" Text="Login" OnClick="BtnLogin_Click" UseSubmitBehavior="false"></asp:Button>
                                    </td>
                                </tr>
                            </table>
                            <div class="centered login-warning"><asp:Label ID="login_warning" runat="server"></asp:Label></div>
                        </asp:Panel>


                    </div>
                 
                </div>
            </div>
            
        </div>
<%--        <iframe id="iframeContent" src="https://localhost:44346/circomodiFrame.aspx" width="100%" scrolling="no"   ></iframe>--%>
    </div>

    <br />
    <br />
    <br />
 

    <script >

        const iframe = document.getElementById("iframeContent");
        const iframeH = document.getElementById("iframeContainer");
        iframe.addEventListener("load", function () {
            this.style.height = (iframe.contentWindow.document.body.scrollHeight) + "px";
          
        });

    </script>


</asp:Content>
