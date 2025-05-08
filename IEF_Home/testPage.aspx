<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testPage.aspx.cs" EnableEventValidation="false" Inherits="IEF_Home.testPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager" runat="server" />
            <asp:UpdatePanel ID="UpdatePanel" runat="server" UpdateMode="Always">
                <ContentTemplate>
                    <div class="grid-item-data">
                        <div class="row">
                            <div class="grid-item-dataframe">
                                <asp:GridView ID="gvDataType" runat="server" AutoGenerateColumns="true" CssClass="table-style"
                                              OnSelectedIndexChanged="OnSelectedIndexChanged"
                                              OnRowDataBound="OnRowDataBound"
                                              DataKeyNames="Data Type">
                                </asp:GridView>
                            </div>

                            <div class="grid-item-dataset" id="gvAspectDiv" runat="server" visible="false" style="padding-left: 10px">
                                <asp:GridView ID="gvAspects" runat="server" AutoGenerateColumns="true" CssClass="table-style" />
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="gvDataType" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
