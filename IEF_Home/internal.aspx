<%@ Page Title="Internal" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="internal.aspx.cs" Inherits="IEF_Home._internal1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script>
        function download(filePath, text) {
            var link = document.createElement('a');
            link.href = filePath;
            link.download = filePath.substr(filePath.lastIndexOf('/') + 1);
            document.body.appendChild(link);
            link.click();
            link.parentNode.removeChild(link);
        }
    </script>

    <style type="text/css">
        .col-md-7 {
            float: left;
            background: none;
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

        .nav > li > input {
            padding: 8px 8px;
            margin: 5px 0 5px 5px;
        }

        .center_div {
            text-align: center;
        }

      
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMenu" runat="server">
    <li>
        <asp:Button ID="btnLogOut" runat="server" class="btn btn-info" Text="Log Out" OnClick="btnLoggOut_Click" /></li>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="row">

        <div class="col-md-7">
            <br />
            <p><a href="#">IEF Internal Database <span></span></a></p>
        </div>
        <div class="col-md-5">
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            The Industrial Ecology Freiburg Internal Database is available to all group members and associated students. The data and information supplied here are only to be used in concordance with the respective license agreements.

                    <br />
            <br />
            Below is a list of the available formatted datasets. The data come in different formats and for each data references and citation info are provided. Some of the data files are very large, please double-check whether you selected the right file before downloading.
         
                    <br />
            <br />
            <div class="table-responsive">

                <table class="table table-bordered table-dark">
                    <thead>
                        <tr>
                            <th>Item</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Dataset creation UUID // Datafile checksum</th>
                            <th>Reference, info</th>
                            <th>Citation info</th>
                            <th>Links</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>MRIO_1</td>
                            <td>EXIOBASEv2, 2007, ITC</td>
                            <td>Zip folder with a .mat file containing the complete EXIOBASE version 2 for 2007, in monetary units, for 48 regions, industry technology construct</td>
                            <td>37efd10f-88f0-45e8-<br />
                                829a-bf19496923a3 
                                        <br />
                                <br />
                                c2cb0bc0b875bf33cf1<br />
                                06b95462c4233</td>
                            <td><a href="https://github.com/stefanpauliuk/Tutorials/blob/master/MRIO_MSc_Tutorial.ipynb" target="_blank">Tutorial on Github</a></td>
                            <td><b>Wood, R. et al., 2014. </b>Global Sustainability Accounting—Developing EXIOBASE for Multi-Regional Footprint Analysis. Sustainability, 7(1),
            pp.138–163. Available at: http://www.mdpi.com/2071-1050/7/1/138/ [Accessed February 13, 2015].
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/EXIOBASE2_Mon_48R_2017_3_8_ITC.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="http://www.exiobase.eu/index.php/terms-of-use" target="_blank">License</a></td>
                        </tr>

                        <tr>
                            <td>MRIO_2</td>
                            <td>EXIOBASEv3, 2011, ITC</td>
                            <td>Zip folder with a .mat file containing the complete EXIOBASE version 3 for 2011, in monetary units, for 49 regions, industry technology construct</td>
                            <td>9519c34e-bf4d-49e1-<br />
                                abef-862d2cb27c68 
                                        <br />
                                <br />
                                0afdadb2-135c-e04d-<br />
                                0f2b-a80317dc4e77</td>
                            <td><a href="https://github.com/stefanpauliuk/Tutorials/blob/master/MRIO_MSc_Tutorial.ipynb" target="_blank">Tutorial on Github</a></td>
                            <td><b>Stadler K, Wood R, Bulavskaya T, Södersten C-J, Simas M, Schmidt S, et al., 2018.</b> EXIOBASE 3 - Developing a Time Series of Detailed Environmentally Extended Multi-Regional Input-Output Tables. Journal of Industrial Ecology, in press. Available at: http://onlinelibrary.wiley.com/doi/10.1111/jiec.12715/full [Accessed January 15th, 2018].
                            </td>

                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/EXIOBASEv3_2011_ITC.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="http://www.exiobase.eu/index.php/terms-of-use" target="_blank">License</a></td>
                        </tr>

                        <tr>
                            <td>MRIO_3</td>
                            <td>EXIOBASEv3, 2011, ITC, with capital closure</td>
                            <td>Zip folder with a .mat file containing the complete EXIOBASE version 3 for 2011, in monetary units, for 49 regions, industry technology construct, with capital closure following the augmentation method (the capital sector is the 164th sector).</td>
                            <td>be1a77da-c6aa-4f2c-<br />
                                b493-20ea525602ef 
                                        <br />
                                <br />
                                bd21eb07-6cb9-de59-<br />
                                a4a5-aac8149da994</td>
                            <td><a href="https://github.com/stefanpauliuk/Tutorials/blob/master/MRIO_MSc_Tutorial.ipynb" target="_blank">Tutorial on Github</a><br />
                                <br />
                                <b>Lenzen, M. & Treloar, G.J., 2005. </b>Endogenising Capital: A comparison of Two Methods. Journal of Applied Input-Output Analysis, 10, pp.1–11.</td>
                            <td><b>Stadler K, Wood R, Bulavskaya T, Södersten C-J, Simas M, Schmidt S, et al., 2018.</b> EXIOBASE 3 - Developing a Time Series of Detailed Environmentally Extended Multi-Regional Input-Output Tables. Journal of Industrial Ecology, in press. Available at: http://onlinelibrary.wiley.com/doi/10.1111/jiec.12715/full [Accessed January 15th, 2018].
                            </td>

                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/EXIOBASEv3_2011_ITC_Capital.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="http://www.exiobase.eu/index.php/terms-of-use" target="_blank">License</a></td>
                        </tr>
                        <tr>
                            <td><b></b></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>LCA_1</td>
                            <td>ecoinvent v3.3, cutoff</td>
                            <td>Zolca file with ecoinvent version 3.3, process database 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a.
                                        <br />
                                <br />
                                76dadf15414d83212<br />
                                e7ddc0a9bf26ec8</td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_3_3_cutoff.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/9401" target="_blank">License</a></td>
                        </tr>
                        <tr>
                            <td>LCA_2</td>
                            <td>ecoinvent v3.3, cutoff, LCI</td>
                            <td>Zolca file with ecoinvent version 3.3, LCI database 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a.
                                        <br />
                                <br />
                                08d1db5e0c86db1ad<br />
                                ba78f0f15632624</td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_3_3_cutoff_lci.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/9401" target="_blank">License</a></td>
                        </tr>
                        <tr>
                            <td>LCA_3</td>
                            <td>ecoinvent v3.3, LCIA characterization factors and methods</td>
                            <td>Zolca file with all available LCIA methods for ecoinvent version 3.3 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a.  
                                        <br />
                                <br />
                                79cb2c6caaa0165e27<br />
                                836f0e67c07587</td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.
                                        <br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_3_3_lcia_methods.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>
                        <tr>
                            <td>LCA_4</td>
                            <td>ecoinvent 3.4 cut-off, openLCA Nexus version 2</td>
                            <td>Zolca file with ecoinvent version 3.4, process database, cut-off system model 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a.
                                        <br />
                                <br />
                                168c249b35687b87<br />
                                2409acd2d25fec68</td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.
                                        <br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_34_cutoff_unit_20180314.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/9401" target="_blank">License</a></td>
                        </tr>
                        <tr>
                            <td>LCA_5</td>
                            <td>ecoinvent 3.4 cut-off - country-specific, openLCA Nexus version 1</td>
                            <td>Zolca file with ecoinvent version 3.4, cut-off system model - country-specific 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a.
                                        <br />
                                <br />
                                029cf932355d7586<br>
                                d803871a832a2b6a</td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_34_cutoff_unit_20180314_LCIA_final.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/9401" target="_blank">License</a></td>
                        </tr>
                        <tr>
                            <td>LCA_6</td>
                            <td>ecoinvent 3.4 cut-off LCI, openLCA Nexus version 2</td>
                            <td>Zolca file with LCI results of all products for ecoinvent version 3.4 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a.
                                        <br />
                                <br />
                                b51be76c8e1fc18e<br>
                                fe9b1ef6c320fb8b </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_34_cutoff_lci_20180314.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>
                        <tr>
                            <td>LCA_7</td>
                            <td>ecoinvent 3.4 cut-off unit processes, system processes, ecoinvent LCIA methods, openLCA Nexus version 2</td>
                            <td>Zolca file with all available data for ecoinvent version 3.4 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a.
                                        <br />
                                <br />
                                0c58c96f9601e444e<br>
                                a4f69da8a597f14 </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_34_cutoff_lci_up_lcia_20180314.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>
                        <tr>
                            <td>LCA_8</td>
                            <td>ecoinvent 3.4 consequential - country-specific, openLCA Nexus version 1</td>
                            <td>Zolca file with the consequential system model for ecoinvent version 3.4 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a.
                                        <br />
                                <br />
                                d3c187cb57b6e6058<br>
                                aaacec4a596bee3 </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_34_conseq_unit_20180314_LCIA_final.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>
                        <tr>
                            <td>LCA_9</td>
                            <td>ecoinvent 3.4 consequential long-term, openLCA Nexus version 2</td>
                            <td>Zolca file with consequential long-term system model for ecoinvent version 3.4 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a.
                                        <br />
                                <br />
                                b8fc5a659db46ac5<br>
                                9d514bdd09b80d50 </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_34_conseq_unit_20180314.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>

                        <tr>
                            <td>LCA_10</td>
                            <td>ecoinvent 3.5 CUT-OFF, regionalised, unit processes</td>
                            <td>Zolca file with cut-off unit process system model for ecoinvent version 3.5 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a. </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent35_Cut_Off_UP_Regionalised_20181210.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>

                        <tr>
                            <td>LCA_11</td>
                            <td>ecoinvent 3.5 CONSEQUENTIAL, regionalised, unit processes</td>
                            <td>Zolca file with consequential unit process system model for ecoinvent version 3.5 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a. </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent35_Consequential_UP_Regionalised_20181210.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>

                        <tr>
                            <td>LCA_12</td>
                            <td>ecoinvent 3.5 LCIA methods</td>
                            <td>Zolca file with LCIA methods for ecoinvent version 3.5 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a. </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_35_lcia_method_20181210.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>


                        <tr>
                            <td>LCA_13</td>
                            <td>ecoinvent 3.6 CUT-OFF, unit processes</td>
                            <td>Zolca file with cut-off unit process system model for ecoinvent version 3.6 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a. </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_36_cutoff_unit_20191212.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>

                        <tr>
                            <td>LCA_14</td>
                            <td>ecoinvent 3.6 CONSEQUENTIAL, unit processes</td>
                            <td>Zolca file with consequential unit process system model for ecoinvent version 3.6 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a. </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_36_consequential_unit_20191212.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>

                        <tr>
                            <td>LCA_15</td>
                            <td>ecoinvent 3.6 LCIA methods</td>
                            <td>Zolca file with LCIA methods for ecoinvent version 3.6 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a. </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_36_lcia_methods.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>


                        <tr>
                            <td>LCA_16</td>
                            <td>ecoinvent 3.7.1 CUT-OFF, unit processes</td>
                            <td>Zolca file with cut-off unit process system model for ecoinvent version 3.7.1 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a. </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_371_cutoff_unit_20210104.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>

                        <tr>
                            <td>LCA_17</td>
                            <td>ecoinvent 3.7.1 CONSEQUENTIAL, unit processes</td>
                            <td>Zolca file with consequential unit process system model for ecoinvent version 3.7.1 
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a. </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_371_consequential_unit_20210105.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>

                        <tr>
                            <td>LCA_18</td>
                            <td>ecoinvent 3.7.1 LCIA methods</td>
                            <td>Zolca file with LCIA methods for ecoinvent version 3.7.1 
                                        <br>
                                Note: Do NOT rename file extension from .zip to .zolca after downloading! Instead, import into openLCA via 'Linked Data (JSON-LD)' import option, WHERE you will be asked to provide a .zip file as input.</td>
                            <td>n.a. </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td><b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br>
                                <br>
                                <a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_37_lcia_methods.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>
                        <tr>    
                            <td> LCA_19</td>
                            <td> ecoinvent 3.8 CUT-OFF, unit processes</td>
                            <td> Zolca file with cut-off unit process system model for ecoinvent version 3.8  <br> Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td> n.a. </td>
                            <td> <a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td> <b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br><br><a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                                    </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_38_cutoff_3011_with_methods.zip', 'This is the content of my file :')" value="Download" />
                                <br /><br /><a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>

                        <tr>    
                            <td> LCA_20</td>
                            <td> ecoinvent 3.8 CONSEQUENTIAL, unit processes</td>
                            <td> Zolca file with consequential unit process system model for ecoinvent version 3.8  <br> Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td> n.a. </td>
                            <td> <a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td> <b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br><br><a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                                    </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_38_consequential_3011_with_methods.zip', 'This is the content of my file :')" value="Download" />
                                <br /><br /><a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>

                        <tr>    
                            <td> LCA_21</td>
                            <td> ecoinvent 3.8 LCIA methods</td>
                            <td> Zolca file with LCIA methods for ecoinvent version 3.8  <br> Note: Do NOT rename file extension from .zip to .zolca after downloading! Instead, import into openLCA via 'Linked Data (JSON-LD)' import option, WHERE you will be asked to provide a .zip file as input.</td>
                            <td> n.a. </td>
                            <td> <a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td> <b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br><br><a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                                    </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_38_LCIA_methods_30112021.zip', 'This is the content of my file :')" value="Download" />
                                <br /><br /><a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>
                        
                        <tr>
                            <td>LCA_22</td>
                            <td>Ökobaudat construction materials database, German version</td>
                            <td>Zolca file with Ökobaudat, German version.
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a. </td>
                            <td>Construction materials database, provided by the German Federal Ministry of Transport, Building and Urban Development as of October 2018.</td>
                            <td>Available at:
                                        <br>
                                <a href="https://nexus.openlca.org/ws/files/8502">https://nexus.openlca.org/ws/files/8502.</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/obd_import_de_20181015.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/database/%C3%96kobaudat#" target="_blank">License</a></td>
                        </tr>
                        <tr>
                            <td>LCA_23</td>
                            <td>Ökobaudat construction materials database, English version</td>
                            <td>Zolca file with Ökobaudat, English version.
                                        <br>
                                Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td>n.a. </td>
                            <td>Construction materials database, provided by the German Federal Ministry of Transport, Building and Urban Development as of October 2018.</td>
                            <td>Available at:
                                        <br>
                                <a href="https://nexus.openlca.org/ws/files/8502">https://nexus.openlca.org/ws/files/8502.</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/obd_import_en_20181015.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/database/%C3%96kobaudat#" target="_blank">License</a></td>
                        </tr>
                        <tr>
                            <td>LCA_24</td>
                            <td>Ökobaudat construction materials database, LCIA methods</td>
                            <td>Zolca file with Ökobaudat construction materials database, LCIA methods.
                                        <br>
                                Note: Unzip file after downloading!</td>
                            <td>n.a. </td>
                            <td>LCIA methods for Construction materials database, provided by the German Federal Ministry of Transport, Building and Urban Development as of October 2018.</td>
                            <td>Available at:
                                        <br>
                                <a href="https://nexus.openlca.org/ws/files/8502">https://nexus.openlca.org/ws/files/8502.</a>
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/oekobaudat_method_en_191115.zip', 'This is the content of my file :')" value="Download" />
                                <br />
                                <br />
                                <a href="https://nexus.openlca.org/database/%C3%96kobaudat#" target="_blank">License</a></td>
                        </tr>

                        <tr>
                            <td>LCA_25</td>
                            <td>Search_ecoinvent_3_2</td>
                            <td>Excel-based search tool for finding flows, activities, and emissions in ecoinvent 3.2.</td>
                            <td>n.a. </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td>Tool built by Paula Vollmer, MSc UW, HiWi in IEF group 2018.
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/search_ecoinvent_3_2.zip', 'This is the content of my file :')" value="Download" />
                        </tr>
                        <tr>
                            <td>LCA_26</td>
                            <td>Search_ecoinvent_3_3</td>
                            <td>Excel-based search tool for finding flows, activities, and emissions in ecoinvent 3.3.</td>
                            <td>n.a. </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td>Tool built by Paula Vollmer, MSc UW, HiWi in IEF group 2018.
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/search_ecoinvent_3_3.zip', 'This is the content of my file :')" value="Download" />
                        </tr>
                        <tr>
                            <td>LCA_27</td>
                            <td>Search_ecoinvent_3_4</td>
                            <td>Excel-based search tool for finding flows, activities, and emissions in ecoinvent 3.4.</td>
                            <td>n.a. </td>
                            <td><a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td>Tool built by Paula Vollmer, MSc UW, HiWi in IEF group 2018.
                            </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/search_ecoinvent_3_4.zip', 'This is the content of my file :')" value="Download" />
                        </tr>

      <tr>    
                            <td> LCA_28</td>
                            <td> ecoinvent 3.9.1 CUT-OFF, unit processes</td>
                            <td> Zolca file with cut-off unit process system model for ecoinvent version 3.9.1  <br> Note: Rename file extension from .zip to .zolca after downloading!</td>
                            <td> n.a. </td>
                            <td> <a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td> <b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br><br><a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                                    </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_391_cutoff_upr_n3_20230629.zip', 'This is the content of my file :')" value="Download" />
                                <br /><br /><a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>

                        <tr>    
                            <td> LCA_29</td>
                            <td> ecoinvent 3.9.1 LCIA methods</td>
                            <td> Zolca file with LCIA methods for ecoinvent version 3.9.1  <br> Note: Do NOT rename file extension from .zip to .zolca after downloading! Instead, import into openLCA via 'Linked Data (JSON-LD)' import option, WHERE you will be asked to provide a .zip file as input.</td>
                            <td> n.a. </td>
                            <td> <a href="http://www.teaching.industrialecology.uni-freiburg.de#LCA" target="_blank">Exercises with openLCA and ecoinvent</a></td>
                            <td> <b>Wernet, G. et al., 2015. </b>The ecoinvent database version 3 (part I): overview and methodology. The International Journal of Life Cycle Assessment, 3(part I). Available at: http://dx.doi.org/10.1007/s11367-016-1087-8.<br><br><a href="https://nexus.openlca.org/database/ecoinvent">Inventory of ecoinvent-related data on the openLCA nexus</a>
                                    </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/ecoinvent_3_9_1_LCIA_Methods_openLCA_2.zip', 'This is the content of my file :')" value="Download" />
                                <br /><br /><a href="https://nexus.openlca.org/ws/files/12232" target="_blank">License</a></td>
                        </tr>
                    </tbody>
                </table>


            </div>

            <br />
            <br />

            <div class="table-responsive">

                <a name="IEF Thesis archive"></a>
                <h3>IEF Thesis archive </h3>
                Below is a list of the archived theses at the BSc, MSc, and PhD levels conducted at Industrial Ecology Freiburg. 
For some of the works there is more research material available than what is available here. 
                        This material and the current author contact info can be obtained from your supervisor. 
                        If you use material and text from the works listed below for your own work you need to provide proper citation! Theses marked with (*) were conducted in other groups, with S.P. as second reviewer. Theses that are marked 'confidential' contain sensitive information or data and are available upon request only.

                        <br />
                <br />
                <table class="table table-bordered table-dark">
                    <thead>
                        <tr>
                            <th>Level</th>
                            <th>Programme</th>
                            <th>Student</th>
                            <th>Thesis title</th>
                            <th>Submission date</th>
                            <th>Status</th>
                            <th>Link</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Marcel Geller</td>
                            <td><b>Investigating Potential Effects of Economic Factors on the Circularity of Global Steel Flows by Applying a Material Flow Analysis (MFA)</b></td>
                            <td>08.07.2024</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Masterthesis_Marcel_Geller.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>Env. Sci.</td>
                            <td>Anja Haas</td>
                            <td><b>Future Scenario for the Material and Energy Demand of the German Railway until 2060</b></td>
                            <td>29.02.2024</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Masterthesis_Anja_Haas.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>Env. Sci.</td>
                            <td>Tim Weber</td>
                            <td><b>Urban Climate Protection in the Transport Sector: A Scenario Analysis for Freiburg</b></td>
                            <td>17.11.2023</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/TW_Master_Thesis.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>Env. Sci.</td>
                            <td>Nikola Basar</td>
                            <td><b>From Sustainability Imperatives to Corporate Eco-Innovation - Using PEF Calculations at Leuze electronic manufacturing company to translate Scientific LCA into Eco-Innovation</b></td>
                            <td>08.11.2023</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Nikola_Basar_Masterthesis.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Alejandro Pivaral</td>
                            <td><b>Environmental Footprint of Lifestyles for Food and Car Transportation in Germany</b></td>
                            <td>26.09.2023</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Master_Thesis_Alejandro_Pivaral.pdf', 'This is the content of my file :')" value="Download Thesis" />
                                <%--<a href="\xxx\Theses\xxx.pdf">Download supplement</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Master_Data_Thesis_Alejandro_Pivaral_Private.xlsx', 'This is the content of my file :')" value="Download supplement, Excel password: PivaralREM13" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>SSE</td>
                            <td>Gurugubelli Varun Bharadwaj</td>
                            <td><b>Sustainability Assessment of Startups: To support the impact measurement of Startup Accelerators</b></td>
                            <td>30.04.2023</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Master_Thesis_Varun.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Erick Paez Pena</td>
                            <td><b>A Comparison of Freiburg’s current (2021) and Future (2050) Passengers Vehicles and Tram Systems: A Life Cycle Assessment</b></td>
                            <td>07.02.2023</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Master Thesis_REM_Erick Paez.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>SSE</td>
                            <td>Alejandro (Alex) Arias Castillo</td>
                            <td><b>Life Cycle Assessment of an energy-autonomous sensor node</b></td>
                            <td>11.11.2022</td>
                            <td>Confidential, available on request</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Jose Joaquin Burbano de Lara Moncayo</td>
                            <td><b>Detailed Environmental Footprint Analysis of the Global Supply Chain of Textiles Consumed in Europe</b></td>
                            <td>26.09.2022</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Master_Thesis_Joaquin_Burbano.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Julian Lorenz Kolodziey </td>
                            <td><b>A Scope 3 Life Cycle Assessment to Reduce Environmental Impacts along a Company’s Value Chain</b></td>
                            <td>22.12.2022</td>
                            <td>Confidential</td>
                            <td></td>
                        </tr>                        
                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Jasmin Heinz</td>
                            <td><b>Beurteilung biodiversitätsrelevanter Aspekte in Ökobilanzen am Beispiel von Milchproduktionssystemen</b></td>
                            <td>September 2022</td>
                            <td>Available on request</td>
                            <td>                                
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>SSE</td>
                            <td>Aditya Chhatre</td>
                            <td><b>Techno-economic comparison of containerized and outdoor battery energy storage system (BESS) using life cycle costing and life cycle analysis approach</b></td>
                            <td>September 2022</td>
                            <td>Confidential</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>MEG</td>
                            <td>Sara Bejtullahu</td>
                            <td><b>Is Vertical Farming the Future of Food Production? A Comparative Life Cycle Assessment of Vertical Farming and Conventional Agriculture</b></td>
                            <td>07.11.2022</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/BEJTULLAHU_Sara_Master_Thesis.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>    
                            <td> <b>MSc</b></td>
                            <td>UW</td>
                            <td>Lennart Hoppe</td>
                            <td> <b>Emerging Energy Storage Technologies: Life Cycle Assessment of the Environmental Impact of different Application Scenarios for a Model of an Energy Storage Tower System</b></td>
                            <td> 20.11.2021</td>
                            <td> Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Master Thesis_Lennart Hoppe.pdf', 'This is the content of my file :')" value="Download Thesis" /><br>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download supplement</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Master Thesis_Lennart Hoppe_SI.zip', 'This is the content of my file :')" value="Download supplement" />
                            </td>
                        </tr>                        
                        <tr>    
                                <td> <b>MSc</b></td>
                                <td>UW</td>
                                <td>Leo Hoffmann</td>
                                <td> <b>Comparative Life Cycle Assessment of Novel Organic Redox Flow, Vanadium Redox Flow, and Lithium-ion Batteries</b></td>
                                <td> Jan 2022</td>
                                <td> Archived</td>
                                <td>
                                    <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                    <input type="button" onclick="download('data_indecol_205939343242/Masterthesis_LeoHoffmann.pdf', 'This is the content of my file :')" value="Download Thesis" />
                                </td>
                            </tr>                        
                            <tr>    
                                <td> <b>MSc</b></td>
                                <td>UW</td>
                                <td>Merle Timmermann</td>
                                <td> <b>Circularity improvement of solar panels in the EU - A quantitative analysis of photovoltaic material flows in Germany and Spain between 2008 and 2040</b></td>
                                <td> 12.11.2021</td>
                                <td> Archived</td>
                                <td>
                                    <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                    <input type="button" onclick="download('data_indecol_205939343242/Circularity Improvement of solar panels in the EU_Timmermann.pdf', 'This is the content of my file :')" value="Download Thesis" /><br>
                                    <%--<a href="\xxx\Theses\xxx.pdf">Download supplement</a>--%>
                                    <input type="button" onclick="download('data_indecol_205939343242/MA_Merle_Timmermann_SI.zip', 'This is the content of my file :')" value="Download supplement" />
                                </td>
                            </tr>                        
                            <tr>    
                                <td> <b>MSc</b></td>
                                <td>UW</td>
                                <td>Sören Lars Nungesser</td>
                                <td> <b>Modelling Hazard for Tailings Dam Failures at Copper Mines in Supply Chains of European Consumption</b></td>
                                <td> 10.11.2021</td>
                                <td> Archived</td>
                                <td>
                                    <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                    <input type="button" onclick="download('data_indecol_205939343242/MA_Thesis_Lars_Nungesser_final-geschützt_PW_ln_18112021.pdf', 'This is the content of my file :')" value="Download Thesis !Password! ln_18112021" />
                                </td>
                            </tr>
                            <tr>    
                                <td> <b>MSc</b></td>
                                <td>MEG</td>
                                <td>Nasir Uddin Akif</td>
                                <td> <b>An estimated Carbon, Land and Water footprint accounts of EU-Mercosur trade agreement</b></td>
                                <td> 02.11.2021</td>
                                <td> Archived</td>
                                <td>
                                    <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                    <input type="button" onclick="download('data_indecol_205939343242/Master Thesis Akif.pdf', 'This is the content of my file :')" value="Download Thesis" />
                                </td>
                            </tr>                        
                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Marie Fischer</td>
                            <td><b>Identifying the ecological implications of the Repowering of Photovoltaic systems – an LCA Approach</b></td>
                            <td>Oct 2021</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Master Thesis_Marie Fischer.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Leonid Krebs</td>
                            <td><b>Szenarioanalyse for die Indikatoren Materialverbrauch, Energiebedarf und Klimaauswirkungen des geplanten Stadtteils „Dietenbach“</b></td>
                            <td>September 2021</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Msc-Arbeit_Leonid_Krebs.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>                          
                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Denis Wheeler</td>
                            <td><b>Potential analysis of the e-scooter in sharing operation and in private use as a green mobility solution for cities</b></td>
                            <td>May 2021</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Master thesis Denis Wheeler.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>                        
                                                
                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Ehab Ahmad Ibrahim Al Atrash</td>
                            <td><b>Timeseries Analysis of Germany’s Ecological Exchange over time – an MRIO analysis</b></td>
                            <td>23.05.2021</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Alatrash_IEF_REM_Master_Thesis.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Swathi Gudivada</td>
                            <td><b>LCA for Mobility Concepts Considering Renewable Electricity and Renewable Carbon Utilization in the Supply Chain</b></td>
                            <td>15.05.2021</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/SGudivada_MasterThesis.pdf', 'This is the content of my file :')" value="Download Thesis" /><br>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download supplement</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/SGudivada_MasterThesis_Supporting Information.zip', 'This is the content of my file :')" value="Download supplement" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>SSE</td>
                            <td>Lukas Böhly (*)</td>
                            <td><b>Wärmerückführung und Exergienutzung im Eisenstrangguss</b></td>
                            <td>13.05.2021</td>
                            <td>Archived</td>
                            <td>Confidential!
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>SSE</td>
                            <td>Lucas Edenhofer</td>
                            <td><b>Assessing Environmental Impact Reduction and Local Supply Potentials for the Food Supply of the Freiburg Region</b></td>
                            <td>12.05.2021</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MT_Edenhofer.pdf', 'This is the content of my file :')" value="Download Thesis" />
                                <%--<a href="\xxx\Theses\xxx.pdf">Download supplement</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Digital Appendix MT Edenhofer.zip', 'This is the content of my file :')" value="Download supplement" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Yash Suneel Khandekar</td>
                            <td><b>Environmental Impact Analysis of Renewable Energy Sources in Australian Capital Territory (Canberra) using Life Cycle Assessment. A Case study of Sapphire Wind Farm.</b></td>
                            <td>27.04.2021</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Yash Thesis final 1.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Dmytro Demenchuk (*)</td>
                            <td><b>Recycling of Silicon from End-of-life PV Modules by Metallurgical Purification</b></td>
                            <td>16.04.2021</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Masterarbeit_Dmytro_Demenchuk.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>MEG</td>
                            <td>Sofie Amalie Søeberg Hovmand</td>
                            <td><b>Resource Efficient Management of Copper in Small Household Appliances placed on the market in the European Union</b></td>
                            <td>10.03.2021</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/4773626_hovmand_sofie.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Sophia Fehrenbach</td>
                            <td><b>Vergleichende Ökobilanz von Fruchtsaftgetränkeverpackungen</b></td>
                            <td>24.02.2021</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Master Thesis_Sophia_Fehrenbach.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Johannes Jung</td>
                            <td><b>Estimating the technical potential and life cycle impact of agrivoltaic systems and their deployment in the Freiburg region</b></td>
                            <td>07.12.2020</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Master Thesis_Johannes_Jung.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>


                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Kapish Dutta</td>
                            <td><b>Impacts of Carbon Tax on the German (automotive) manufacturing industry</b></td>
                            <td>29.10.2020</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Dutta_Kapish_MasterThesis_REM.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Kritesh Shridhar</td>
                            <td><b>Usefulness of Environmental Product Declaration for Life Cycle Analysis and Sustainability certification
Case Study of a Solar Photovoltaic Power Plant</b></td>
                            <td>29.10.2020</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Master Thesis_MSc_REM_Kritesh Shridhar.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>MEG</td>
                            <td>Marcel Eichler</td>
                            <td><b>Evaluating Environmental Impacts of University Procurements - An Environmentally Extended Multiregional Input Output Analysis of Albert-Ludwigs-Universität Freiburg</b></td>
                            <td>17.10.2020</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc._Thesis_2020_Eichler_MRIO_ALUF2017.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Izzatjon Asadov</td>
                            <td><b>Comparative Life Cycle Assessment of Heat Production from Wood Pellets in Uzbekistan</b></td>
                            <td>30.09.2020</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Master Thesis_Izzatjon_Asadov.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Dana Darwish and Mustafa Abunofal (joint thesis)</td>
                            <td><b>Water-Energy-Food Nexus in West Asia: Comparative Assessment within Nexus Approach - Jordan and United Arab Emirates as Case Studies</b></td>
                            <td>29.09.2020</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Darwish_Abunofal_Master_Thesis_REM_29.09.2020.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Muhanad Mousa Waleed Al-Lahham</td>
                            <td><b>Environmental Sustainability Assessment of the Transition from A Crop-based Biodiesel Sector to Biodiesel Production from Microalgal Biomass in a Closed-loop Biorefinery Model: Germany as a Case Study</b></td>
                            <td>30.08.2020</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/AlLahham_Muhanad_MasterThesis.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Benjamin Schmolck</td>
                            <td><b>Ethisch vertretbare und erforderliche Konsumreduktion nach dem Pariser Abkommen - Modellierung von bedürfnisorientierten Treibhausgas-Fußabdrücken in Deutschland</b></td>
                            <td>20.05.2020</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Masterarbeit_Schmolck_Suffizienz.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Okwa Daniel Adakole</td>
                            <td><b>Climate Impact of Urbanization in Nigeria: Database and First Estimations of Material Demand from 1960 to 2050</b></td>
                            <td>16.04.2020</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Okwa_Adakole_Daniel_Master_Thesis.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>MEG</td>
                            <td>Fabio Ballasina</td>
                            <td><b>Critical Raw Materials in smartphones: the potential for closing the loop for indium in Germany</b></td>
                            <td>13.03.2020</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MasterThesis_FabioBallasinaMEG13.pdf', 'This is the content of my file :')" value="Download Thesis" />
                                <input type="button" onclick="download('data_indecol_205939343242/Final sheets_MasterThesis_FabioBallasina.zip', 'This is the content of my file :')" value="Download Material" />

                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Paula Vollmer</td>
                            <td><b>Environmental performance of German consumption compared to planetary boundaries Potentials and limitations of a MRIO database to determine nitrogen, phosphorus and ozone depletion footprints
                            </b></td>
                            <td>08.01.2020</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Paula_Vollmer_Masterthesis.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Raphael Stuber-Rousselle</td>
                            <td><b>Comparative Life Cycle Assessment of a Reusable Stainless-Steel Washing Bowl and a Single-Use Synthetic Washing Bowl</b></td>
                            <td>19.12.2019</td>
                            <td>Archived</td>
                            <td>Confidential </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>MEG</td>
                            <td>Maximillian Vanry (*)</td>
                            <td><b>Sustainability of Shared Urban Mobility Systems in The City of Victoria</b></td>
                            <td>20.11.2019</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Vanry-Thesis-4561599.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Diego Torralva</td>
                            <td><b>Income-specific Environmental Footprints of Mexican Household Consumption</b></td>
                            <td>06.11.2019</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2019_Torralva_Diego.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>MEG</td>
                            <td>Lisa Bongartz (*)</td>
                            <td><b>Criticality Analysis of Lithium-ion Batteries</b></td>
                            <td>31.10.2019</td>
                            <td>Archived</td>
                            <td>Confidential </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>MEG</td>
                            <td>Luis Gallardo</td>
                            <td><b>Comparative Life Cycle Assessment of a Hydrothermal Carbonisation Organic Waste Management Plant in Mexico City</b></td>
                            <td>31.10.2019</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Luis_Thesis_Comparative LCA HTC Plant_LMGR.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>MEG</td>
                            <td>Aiko Utamaru</td>
                            <td><b>Material demand and climate impact of residential and commercial building in Indonesia from 1980 to 2050</b></td>
                            <td>29.10.2019</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Utamaru,A_Thesis.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>MEG</td>
                            <td>Benjamín Elizalde</td>
                            <td><b>Evaluating Environmental Impacts in University Campus Operations: An Organizational Life Cycle Assessment (O-LCA) of Albert-Ludwigs-Universität Freiburg</b></td>
                            <td>25.10.2019</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2019_Elizalde_OLCA_ALUF.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Megan Bowen</td>
                            <td><b>Comparative Life Cycle Analysis and Carbon Pricing of Renewable Ethanol Supply Chains in Canada</b></td>
                            <td>30.09.2019</td>
                            <td>Archived</td>
                            <td>Confidential </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Franziska Dollinger</td>
                            <td><b>Product Specific Recycling: Assessment of End-of-life vehicle (ELV) waste streams</b></td>
                            <td>20.09.2019</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Dollinger_MA_ELV.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Mariana Acosta</td>
                            <td><b>Environmental Impact Assessment on Sustainable Mobility Strategies Implementing Renewable Energy and Travel Efficiency Scenarios for Mexico City</b></td>
                            <td>20.05.2019</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc REMThesis_Mariana Acosta_4368510.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Katrina-Magdalena Lindemann</td>
                            <td><b>Life Cycle Assessment: Comparison of Laminate and Carpet Flooring in Freiburg and German Office Space</b></td>
                            <td>20.03.2019</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Lindemann_Katrina_LCA_Thesis.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>


                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Sumukha Dhathri</td>
                            <td><b>Environmental Impact Assessment of Direct Air Capture Technology</b></td>
                            <td>30.01.2019</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2019_Sumukha_Dhathri.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Anna Schmid</td>
                            <td><b>Machbarkeitsstudie für eine CO2-neutrale DAV Sektion Freiburg. Eine Analyse mit openLCA</b></td>
                            <td>24.01.2019</td>
                            <td>Archived</td>
                            <td>Confidential</td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Ina Helfrich</td>
                            <td><b>Prospective emission mitigation potential of using woodbased nanocellulose in vehicles</b></td>
                            <td>25.12.2018</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2018_Ina_Helfrich.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Christian Buschbeck</td>
                            <td><b>Assessing food security and environmental impacts for different regional food production systems within Baden-Wuerttemberg</b></td>
                            <td>21.12.2018</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2018_Christian_Buschbeck.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Eric Card</td>
                            <td><b>Comparative Life Cycle Analysis and Life Cycle Costing of Ethanol from Corn, Sugarcane, and Cellulosic Biomass for Use in the U.S. from a Land-use Perspective with the Purpose of Carbon Capture and Storage</b></td>
                            <td>18.12.2018</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2018_Eric_Card.pdf', 'This is the content of my file :')" value="Download Thesis" />
                                <br>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download supplementary material</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2018_Eric_Card_Supporting_Material.zip', 'This is the content of my file :')" value="Download supplementary material" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Moritz Bisch</td>
                            <td><b>Verwendung des Entscheidungskriteriums „Einsatz Grauer Energie“ bei Hochbaumaßnahmen im kommunalen Kontext</b></td>
                            <td>05.12.2018</td>
                            <td>Archived</td>
                            <td>Confidential</td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>CS</td>
                            <td>Mahadi Hasan (*)</td>
                            <td><b>Efficient Database Model to Represent Numerical Research Data of Material Flow Analysis</b></td>
                            <td>14.05.2018</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2018_Mahadi_Hasan.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Simon Schulte</td>
                            <td><b>Extrapolating the Environmentally-Extended Multi-Regional Input-Output Model EXIOBASE3 with the Optimal Reconciliation Approach: Case Study of the Greenhouse Gas Footprint of Germany</b></td>
                            <td>02.05.2018</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2018_Simon_Schulte.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Gizem Erdogmus (*)</td>
                            <td><b>Transforming Waste to Resource: Evaluating energy production possibilities from municipal solid waste in Chennai, India using Analytic Hierarchy Process</b></td>
                            <td>15.03.2018</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2018_Gizem_Erdogmus.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Kai Bekel</td>
                            <td><b>Cost and Environmental Impact Assessment of Battery and Fuel Cell Electric Vehicles – Consideration of the whole Life Cycle from Electricity Generation over the Fuel Supply Infrastructure and Vehicle Production to Recycling</b></td>
                            <td>10.02.2018</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2018_Kai_Bekel.pdf', 'This is the content of my file :')" value="Download Thesis" />
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_Kai_Bekel.zip', 'This is the content of my file :')" value="Download Material" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Larissa Bitterich</td>
                            <td><b>Can Regional and Organic Food be an Answer to Environmental Issues of Agriculture? A Case Study for Baden-Württemberg, Germany</b></td>
                            <td>20.01.2018</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2018_Larissa_Bitterich.pdf', 'This is the content of my file :')" value="Download Thesis" />
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_Larissa_LandClasses_25832.zip', 'This is the content of my file :')" value="Download Material" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Ombeni Ranzmeyer</td>
                            <td><b>Differences in Environmental Impacts between Organic and Conventional Farming. A Comparison of Food Baskets using Life Cycle Assessment</b></td>
                            <td>10.01.2018</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2018_Ombeni_Ranzmeyer.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Anabell Friedrich</td>
                            <td><b>Process inventories, scrap classification, and scenario analysis of electronic waste management in Germany</b></td>
                            <td>10.01.2018</td>
                            <td>Archived</td>
                            <td>

                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2018_Anabell Friedrich.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>MEG</td>
                            <td>Christian Hauenstein</td>
                            <td><b>Environmental impact reduction and regional supply potentials of agricultural food production in Baden-Wuerttemberg</b></td>
                            <td>14.12.2017</td>
                            <td>Archived</td>
                            <td><%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a><br /><a href="\xxx\Theses\xxx.pdf">Download material</a>--%>

                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2017_Christian_Hauenstein.pdf', 'This is the content of my file :')" value="Download thesis" />
                            </td>

                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Lara Wiechert</td>
                            <td><b>Identifikation der Ansatzpunkte für ein Konzept "Nachhaltige Gemeinschaftsverpflegung" für den Landesverband Baden-Württemberg des Deutschen Jugendherbergswerks</b></td>
                            <td>04.12.2017</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2017_Lara_Wiechert.pdf', 'This is the content of my file :')" value="Download Thesis" />
                                <br>
                                <br>
                                <input type="button" onclick="download('data_indecol_205939343242/2017_Masterarbeit_Lara_Wiechert_Digitaler_Anhang.zip', 'This is the content of my file :')" value="Download Material" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Kavya Madhu</td>
                            <td><b>Relationship between Environmental Impact Assessment and Life Cycle Assessment</b></td>
                            <td>01.12.2017</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2017_Kavya_Madhu.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>MEG</td>
                            <td>andrew Bonneau (*)</td>
                            <td><b>Carbon Accounting of Material and Energy Flows in Campus organizations: Case study of the University of Freiburg</b></td>
                            <td>14.11.2017</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2017_Bonneau_Carbon Accounting.pdf', 'This is the content of my file :')" value="Download Thesis" />
                                <br>
                                <input type="button" onclick="download('data_indecol_205939343242/2017_andrew_Bonneau_CarbonFootprint_Uni_Freiburg.zip', 'This is the content of my file :')" value="Download Material" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Pius Zähringer</td>
                            <td><b>Environmental footprints of services. An MRIO-Analysis</b></td>
                            <td>26.10.2017</td>
                            <td>Archived</td>
                            <td>
                                <%-- <a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Master_Thesis_Zaehringer_Pius.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Alexander Buchholz</td>
                            <td><b>Income-specific environmental footprints of German household consumption with MRIO</b></td>
                            <td>20.10.2017</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2017_Buchholz_Alexander.pdf', 'This is the content of my file :')" value="Download Thesis" />
                                <input type="button" onclick="download('data_indecol_205939343242/2017_Alex_Buchholz_Footprint_Germany.zip', 'This is the content of my file :')" value="Download Material" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Felix Mayer</td>
                            <td><b>Flächenoptimierte Energieerzeugung in Deutschland</b></td>
                            <td>08.06.2017</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2017_Felix_Mayer.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>MEG</td>
                            <td>Jan Streeck</td>
                            <td><b>Microbial Electrolysis Cell and Power to Methanol A perfect couple? Techno-economic and environmental assessment of a waste-to-chemical system</b></td>
                            <td>04.04.2017</td>
                            <td>Archived</td>
                            <td>
                                <%-- <a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2017_Jan_Streeck.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>

                        <tr>
                            <td><b>MSc</b></td>
                            <td>UW</td>
                            <td>Anja Kasper</td>
                            <td><b>Vergleichende Ökobilanz eines Elektrobusses mit einem Diesel- und einem Kompakthybridbus</b></td>
                            <td>12.02.2017</td>
                            <td>Archived</td>
                            <td>Confidential</td>
                        </tr>
                        <tr>
                            <td><b>MSc</b></td>
                            <td>REM</td>
                            <td>Canan Gümüsay</td>
                            <td><b>Quantitative Systems Analysis of the Sustainable Development Goals with a Focus on Sub-Saharan Africa</b></td>
                            <td>09.02.2017</td>
                            <td>Archived</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/MSc_Thesis_2017_Canan_GÜMÜSAY.pdf', 'This is the content of my file :')" value="Download Thesis" /></td>
                        </tr>

                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                         <tr>    
                                <td> <b>BSc</b></td>
                                <td> LAS</td>
                                <td> Woo Rim (Amy) Choi</td>
                                <td> <b>A comparative LCA of redox flow batteries to a lithium-ion battery for stationary residential use in Germany</b></td>
                                <td> 07.08.2021</td>
                                <td> Archived</td>
                                <td>
                                    <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                        <input type="button" onclick="download('data_indecol_205939343242/Woo Rim Choi Bachelor Thesis.pdf', 'This is the content of my file :')" value="Download Thesis" />
                                </td>
                            </tr>                        
                        <tr>
                            <td><b>BSc</b></td>
                            <td>LAS</td>
                            <td>Luka Marie Hilzendegen (*)</td>
                            <td><b>How sustainable are packaging-free dry food products? A life cycle assessment of traditionally packaged versus packaging-free pasta options offered at a local organic store</b></td>
                            <td>31.05.2021</td>
                            <td>Archived</td>
                            <td><%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/Bachelorarbeit Hilzendegen 4525471.pdf', 'This is the content of my file :')" value="Download Thesis" /></td>
                        </tr>
                        <tr>
                            <td><b>BSc</b></td>
                            <td>UNW</td>
                            <td>Leonhard-Alexander Lehnhoff</td>
                            <td><b>Holzstaub aus Alt- und Industrierestholz als Brennstoffalternative für Braunkohlestaubkraftwerke – Vergleichende Ökobilanz</b></td>
                            <td>15.05.2021</td>
                            <td>Archived</td>
                            <td>Confidential</td>
                        </tr>
                        <tr>
                            <td><b>BSc</b></td>
                            <td>LAS</td>
                            <td>Amelie Müller</td>
                            <td><b>A COMPARATIVE LIFE CYCLE ASSESSMENT OF MONO-SI PV MODULE PRODUCTION: IMPACT OF MODULE DESIGN and MANUFACTURING LOCATION</b></td>
                            <td>18.06.2020</td>
                            <td>Archived</td>
                            <td>Confidential</td>
                        </tr>
                        <tr>
                            <td><b>BSc</b></td>
                            <td>UWN</td>
                            <td>Alina Hilzinger (*)</td>
                            <td><b>Ökobilanzielle Bewertung der Verpackungsstrategie des Unverpacktladens Glaskiste Freiburg</b></td>
                            <td>21.06.2018</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/BSc_Thesis_2018_Alina_Hilzinger.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>BSc</b></td>
                            <td>UWN</td>
                            <td>Jessica Möhrsdorf</td>
                            <td><b>Tracing geographic and sectoral origins of German environmental footprints embodied in trade - a MRIO analysis</b></td>
                            <td>15.03.2018</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/BSc_Thesis_2018_Jessica_Moersdorf.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>
                        <tr>
                            <td><b>BSc</b></td>
                            <td>UWN</td>
                            <td>Martin Remler</td>
                            <td><b>Qualitative Systemanalyse der Dimethyletherproduktion aus Schwarzlauge in Deutschland</b></td>
                            <td>29.07.2016</td>
                            <td>Archived</td>
                            <td>
                                <%--<a href="\xxx\Theses\xxx.pdf">Download thesis</a>--%>
                                <input type="button" onclick="download('data_indecol_205939343242/BSc_Thesis_2016_Martin_Remler.pdf', 'This is the content of my file :')" value="Download Thesis" />
                            </td>
                        </tr>


                    </tbody>
                </table>

            </div>

            <br />
            <br />

            <div class="table-responsive">

                <a name="IEF thesis proposals"></a>
                <h3>IEF thesis proposals</h3>
                Below two sample thesis proposals.

                        <br />
                <br />
                <table class="table table-bordered table-dark">
                    <thead>
                        <tr>
                            <th>Proposal</th>
                            <th>Link</th>
                        </tr>
                    </thead>
                    <tbody>


                        <tr>
                            <td>Sample thesis proposal 1</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Proposal_MSc_thesis_Example_1.pdf', 'This is the content of my file :')" value="Download Proposal" />
                            </td>
                        </tr>
                        <tr>
                            <td>Sample thesis proposal 2</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Proposal_MSc_thesis_Example_2.pdf', 'This is the content of my file :')" value="Download Proposal" />
                            </td>
                        </tr>

                    </tbody>
                </table>

            </div>


            <br />
            <br />

            <div class="table-responsive">

                <a name="IEF standards archive"></a>
                <h3>IEF Standards archive </h3>
                Below is a list of international standards relevant for some of the core IEF applications and methods.

                        <br />
                <br />
                <table class="table table-bordered table-dark">
                    <thead>
                        <tr>
                            <th>Standard</th>
                            <th>Link</th>
                        </tr>
                    </thead>
                    <tbody>

                        <tr>
                            <td colspan="2">
                                <b>LCA</b>
                            </td>
                        </tr>

                        <tr>
                            <td>ISO 14040: Environmental management – Life cycle assessment – Principles and framework (ISO 14040:2006); for LCA.</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN EN ISO 14040.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>ISO 14044: Environmental management – Life cycle assessment – Requirements and guidelines (ISO 14044:2006); for LCA.</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN EN ISO 14044.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <b>Carbon Accounting</b>
                            </td>
                        </tr>

                        <tr>
                            <td>Greenhouse gases – Part 1: Specification with guidance at the organization level for quantification and reporting of greenhouse gas emissions and removals (ISO/DIS 14064-1:2017) [DRAFT]</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN_EN_ISO_14064-1.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>Greenhouse gases – Part 1: Specification with guidance at the organization level for quantification and reporting of greenhouse gas emissions and removals (ISO 14064-1:2006);</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN_EN_ISO_14064-1_2012.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>Greenhouse gases – Part 2: Specification with guidance at the project level for quantification, monitoring and  reporting of greenhouse gas emission reductions or removal enhancements (ISO 14064-2:2006);</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN_EN_ISO_14064-2.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>Greenhouse gases – Part 3: Specification with guidance for the verification and validation of greenhouse gas statements (ISO/DIS 14064-3:2017) [DRAFT]</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN_EN_ISO_14064-3.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>Greenhouse gases – Part 3: Specification with guidance for the validation and verification of greenhouse gas assertions (ISO 14064-3:2006)</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN_EN_ISO_14064-3_2012.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>Greenhouse gases – Requirements for greenhouse gas validation and verification bodies for use in accreditation or other forms of recognition (ISO 14065:2013);</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN_EN_ISO_14065.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>Greenhouse gases – Carbon footprint of products – Requirements and guidelines for quantification and communication (ISO/TS 14067:2013);</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN_CEN_ISO_TS_14067.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>


                        <tr>
                            <td>PAS 2060:2014: Specification for the demonstration of carbon neutrality</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/PAS 2060_2014.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>


                        <tr>
                            <td colspan="2">
                                <b>Environmental performance of buildings</b>
                            </td>
                        </tr>

                        <tr>
                            <td>VDI 4600: Cumulative Energy demand. Terms, definitions, methods of calculation 2015</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/VDI 4600.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>VDI 4600-1: Cumulative Energy demand, Examples. 2015</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/VDI 4600 Blatt 1 (2015-08-00) .pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>VDI 4605: Evaluation of sustainability. 2017</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/VDI 4605 (2017-10-00).pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>DIN EN 15643-1 Nachhaltigkeit von Bauwerken – Bewertung der Nachhaltigkeit von Gebäuden – Teil 1: Allgemeine Rahmenbedingungen. 2010</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN EN 15643-1 (2010-12-00).pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>DIN EN 15643-2 Nachhaltigkeit von Bauwerken – Bewertung der Nachhaltigkeit von Gebäuden – Teil 2: Rahmenbedingungen für die Bewertung der umweltbezogenen
Qualität. 2011</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN EN 15643-2 (2011-05-00).pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>DIN EN 15643-3 Nachhaltigkeit von Bauwerken – Bewertung der Nachhaltigkeit von Gebäuden – Teil 3: Rahmenbedingungen für die Bewertung der sozialen Qualität. 2012</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN EN 15643-3 (2012-04-00).pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>DIN EN 15643-4 Nachhaltigkeit von Bauwerken – Bewertung der Nachhaltigkeit von Gebäuden – Teil 4: Rahmenbedingungen für die Bewertung der ökonomischen Qualität. 2012</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN EN 15643-4 (2012-04-00).pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>DIN EN 15804 Nachhaltigkeit von Bauwerken – Umweltproduktdeklarationen – Grundregeln für die Produktkategorie Bauprodukte. 2013</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN EN 15804 (2014-07-00).pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>DIN EN 15978 Nachhaltigkeit von Bauwerken – Bewertung der umweltbezogenen Qualität von Gebäuden – Berechnungsmethode. 2011</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN EN 15978 (2012-10-00).pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>SIA 2032: Graue Energie von Gebäuden. 2010. In German </td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/SIA 2032.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td>SIA 2040: SIA Effizienzpfad Energie. 2010. In German</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/SIA 2040.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <b>Circular Economy</b>
                            </td>
                        </tr>

                        <tr>
                            <td>BS 8001:2017: Framework for implementing the principles of the circular economy in organizations – Guide</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/BS_8001_2017.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <b>Environmental Management Systems</b>
                            </td>
                        </tr>

                        <tr>
                            <td>Environmental management systems – Requirements with guidance for use (ISO 14001:2004 + Cor 1:2009)</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN EN ISO 14001.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <b>Quality Management Systems</b>
                            </td>
                        </tr>

                        <tr>
                            <td>Quality management systems – Requirements (ISO 9001:2008); Trilingual version EN ISO 9001:2008</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Standards/DIN EN ISO 9001.pdf', 'This is the content of my file :')" value="Download Standard" />
                            </td>
                        </tr>

                    </tbody>
                </table>

            </div>

            <br />
            <br />

            <div class="table-responsive">

                <a name="IEF literature list"></a>
                <h3>IEF literature list </h3>
                Below is a list of seminal literature for the core IEF applications and methods.

                        <br />
                <br />
                <table class="table table-bordered table-dark">
                    <thead>
                        <tr>
                            <th>Reference</th>
                            <th>Link</th>
                        </tr>
                    </thead>
                    <tbody>

                        <tr>
                            <td colspan="2">
                                <b>General</b>
                            </td>
                        </tr>

                        <tr>
                            <td>The Economics of the Coming Spaceship Earth, by Kenneth E. Boulding (1966)</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/IEooc_Background1__Reading2_Boulding_SpaceshipEarth.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>Strategies for Manufacturing - Waste from one industrial process can serve as the raw materials for another, thereby reducing the impact of industry on the environment, by Robert A. Frosch and Nicholas E. Gallopoulos. Copyright 1989 by Scientific American.</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/IEooc_Background1__Reading3_Strategies_For_Manufacturing_Sci_American_1989.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>Quantitative Analysis of Industrial Systems: Intellectual Framing. By Stefan Pauliuk, 2018.</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/IEooc_Background1_Reading1_Framing.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>Society’s Metabolism - The Intellectual History of Materials Flow Analysis, Part I, 1860-1970. By Marina Fischer-Kowalski (1998).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/Fischer-Kowalski_1998_Society’s Metabolism The Intellectual History of Materials Flow Analysis, Part I, I 860- I 970.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>Sustainable Development: socio-economic metabolism and colonisation of nature. By Marina Fischer-Kowalski and Helmut Haberl (1998).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/Fischer-Kowalski, Haberl_1998_Sustainable development socio-economic metabolism and colonization of nature.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <b>Material flow analysis</b>
                            </td>
                        </tr>

                        <tr>
                            <td>The Planet Remade: How Geoengineering Could Change the World. By Oliver Morton. Chapter 7: Nitrogen.</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/Morton_Chapter7_Nitrogen.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>What Do We Know About Metal Recycling Rates, by Graedel et al. (2011).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/Graedel et al._2011_What Do We Know About Metal Recycling Rates.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>The role of in-use stocks in the social metabolism and in climate change mitigation, by Pauliuk and Müller. (2014).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/Pauliuk_2014_Role_of_Stocks.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>Global socioeconomic material stocks rise 23-fold over the 20th century and require half of annual resource use, by Krausmann et al. (2017).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/PNAS-2017-Krausmann-1880-5.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>How Circular is the Global Economy? An Assessment of Material Flows, Waste Production, and Recycling in the European Union and the World in 2005, by Haas et al. (2015).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/Haas et al_2015.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <b>Life Cycle Assessment</b>
                            </td>
                        </tr>

                        <tr>
                            <td>Emerging approaches, challenges and opportunities in life cycle assessment, by Stefanie Hellweg and Llorenç Milà i Canals. Science (2014).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/Hellweg, Mila i Canals_2014_Emerging approaches, challenges and opportunities in life cycle assessment.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>Comparative Environmental Life Cycle Assessment of Conventional and Electric Vehicles. By Hawkins et al. (2013).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/Hawkins et al._2013_Comparative Environmental Life Cycle Assessment of Conventional and Electric Vehicles.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>Integrated life-cycle assessment of electricity-supply scenarios confirms global environmental benefit of low-carbon technologies, by Hertwich et al. (2015).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/Hertwich et al._2015_Integrated life-cycle assessment of electricity-supply scenarios confirms global environmental benefit of low-carbo.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>Developing a systematic framework for consistent allocation in LCA, by Schrijvers et al. (2016).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/LCA_Allocation_Schrijvers_2016.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>ReCiPe 2008 - A life cycle impact assessment method which comprises harmonised category indicators at the midpoint and the endpoint level, by Goedkoop et al. (2013).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/Goedkoop, Huijbregts_2013_ReCiPe 2008.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>


                        <tr>
                            <td colspan="2">
                                <b>Input-output analysis</b>
                            </td>
                        </tr>

                        <tr>
                            <td>Carbon footprint of nations - a global, trade-linked analysis. By Hertwich et al. (2009).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/Hertwich, Peters_2009_Carbon footprint of nations a global, trade-linked analysis.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>from production-based to consumption-based national emission inventories. By Glen Peters. (2008).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/Peters_2008_from production-based to consumption-based national emission inventories.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>Environmental impact assessment of household consumption. By Ivanova et al. (2014).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/Ivanova et al._2014_Environmental impact assessment of household consumption.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>A “Carbonizing Dragon”: China’s Fast Growing CO2 Emissions Revisited. By Minx et al. (2011).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/Minx et al._2011_A “Carbonizing Dragon” China’s Fast Growing CO2 Emissions Revisited.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>

                        <tr>
                            <td>Input-Output Analysis of Waste Management. By Nakamura and Kondo (2002).</td>
                            <td>
                                <input type="button" onclick="download('data_indecol_205939343242/Literature/Nakamura, Kondo_2002_Input-Output Analysis of Waste Management.pdf', 'This is the content of my file :')" value="Download Paper" />
                            </td>
                        </tr>






                    </tbody>
                </table>

            </div>

        </div>
        <br />
        <br />
        <div class="center_div">
            <span style="font-weight: bold">Contact:</span>
            stefan.pauliuk[at]indecol.uni-freiburg.de<br />
            <span style="font-weight: bold">International Society for Industrial Ecology:</span>
            <a href="https://is4ie.org" target="_blank">https://is4ie.org</a>

        </div>



    </div>
    </div>

        <br />
    <br />
    <br />
</asp:Content>
