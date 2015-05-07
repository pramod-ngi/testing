<%@ Page Language="C#" MasterPageFile="~/PA_master.Master" AutoEventWireup="true" CodeBehind="AddSocialNetwork.aspx.cs" Inherits="PureAnalyzer_WebApp.AddSocialNetwork" Title="Add Social Network-Pure Analyzer" %>


<%@ Register Assembly="Microsoft.Practices.EnterpriseLibrary.Validation.Integration.AspNet"
    Namespace="Microsoft.Practices.EnterpriseLibrary.Validation.Integration.AspNet"
    TagPrefix="cc1" %>

<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script src="js/PopUpMessage.js" type="text/javascript"></script>
        
        <link href="css/CommonGrid.css" rel="stylesheet" type="text/css" />
        

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">

   
    
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="radAjaxPanelAddSocialNetwork">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="radAjaxPanelAddSocialNetwork" LoadingPanelID="RadAjaxLoadingPanelSocialNetwork"
                        UpdatePanelRenderMode="Inline" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelSocialNetwork" runat="server" EnableEmbeddedScripts="true" />
    <telerik:RadAjaxPanel ID="radAjaxPanelAddSocialNetwork" runat="server">
            <telerik:RadPanelBar runat="server" ID="radPanelBarAddSocialNetwork" Width="100%" style=" padding-left:0px; background-color:inherit !important">
                <Items>
                    <telerik:RadPanelItem Expanded="True" Text="Added Social Network Details" runat="server">
                        <Items>
                            <telerik:RadPanelItem Expanded="True" runat="server" Selected="true" Value="socialGrid">
                                <ItemTemplate>
                                    <telerik:RadGrid ID="radGridViewSocialNetwork" runat="server" AllowPaging="True" AllowSorting="True"
                                        AutoGenerateColumns="False" GridLines="None" AllowMultiRowSelection="True" CssClass="GridDropDownColumn"
                                        AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AllowAutomaticDeletes="True"
                                        Width="99.7%" GroupingSettings-CaseSensitive="false" OnInit="radGridAddSocialNetwork_InIt" OnItemCommand="radGridAddSocialNetworkFilter_ItemCommand">
                                        <HeaderContextMenu>
                                        </HeaderContextMenu>
                                        <PagerStyle AlwaysVisible="True" />
                                        <MasterTableView CommandItemDisplay="Top" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"
                                            AllowAutomaticUpdates="True" AllowFilteringByColumn="True" FilterItemStyle-Height="10px"
                                            FilterItemStyle-Width="100%">
                                            <CommandItemTemplate>
                                             <%--   <div style="padding: 5px 5px;">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:LinkButton ID="btnInitInsert" runat="server" OnClick="btnAddUser_Click" CausesValidation="false"><img style="border:0px;vertical-align:middle;" alt="" src="images/AddRecord.gif" />Add New Social Network</asp:LinkButton>
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:LinkButton ID="btnDelete" runat="server" OnClick="btnRemoveUser_Click" CausesValidation="false"><img style="border:0px;vertical-align:middle;" alt="" src="images/Delete.png" />Delete Selected Network</asp:LinkButton>
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:LinkButton ID="btnRebind" runat="server" OnClick="Refresh" CausesValidation="false"><img style="border:0px;vertical-align:middle;" alt="" src="images/Refresh.gif" />Refresh Grid</asp:LinkButton>
                                                </div>--%>
                                            </CommandItemTemplate>
                                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                                            </ExpandCollapseColumn>
                                            <Columns>
                                            <telerik:GridClientSelectColumn UniqueName="columnSelect">
                                                <HeaderStyle width="25px" Height="15px"/>
                                                </telerik:GridClientSelectColumn>
                                                <telerik:GridBoundColumn DataField="SocialAccId" HeaderText="Social Acc Id"  UniqueName="columnSocialAccId" Visible="false" ><HeaderStyle />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SocialAccUserId" HeaderText="Social Acc UserId"  UniqueName="columnSocialAccUserId" Visible="false" ><HeaderStyle />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SocialAccountScreenName" FilterControlAltText="Filter columnSocialAccountDisplayName column"
                                                    HeaderText="Social Network Name" HeaderTooltip="SocialNetworkName" UniqueName="columnSocialAccountDisplayName" HeaderStyle-HorizontalAlign="Center" 
                                                    ItemStyle-HorizontalAlign="Center"  FilterControlWidth="80%"><HeaderStyle width="150px" Height="15px"/>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SocialAccountTypeId" HeaderText="Social Account TypeId"  UniqueName="columnSocialAccountTypeId" Visible="false" ><HeaderStyle />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SocialAccount" FilterControlAltText="Filter column SocialAccount column" HeaderStyle-HorizontalAlign="Center" 
                                                    ItemStyle-HorizontalAlign="Center" HeaderText="Social Account" HeaderTooltip=" Social Account Type" UniqueName="columnSocialAccount"
                                                    FilterControlWidth="80%"><HeaderStyle width="100px" Height="15px"/>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="IsActive" HeaderText="Is Active"  UniqueName="columnIsActive" Visible="false" ><HeaderStyle />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn  AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ><HeaderStyle Width="90px" Height="15px" />
                                                    <HeaderTemplate>
                                                        <asp:Label ID="lblHeaderStatus" runat="server" Text="Status"></asp:Label>
                                                    </HeaderTemplate>
                                                  <%--  <ItemTemplate>
                                                        <asp:CheckBox ID="columnStatus" runat="server" AutoPostBack="True" OnCheckedChanged ="columnStatus_CheckedChanged" />
                                                    </ItemTemplate>--%>
                                                 <ItemTemplate>
                                                    <telerik:RadComboBox ID="columnStatus" runat="server" AutoPostBack="true" Width="80px"
                                                        OnSelectedIndexChanged="columnStatus_SelectedIndexChanged">
                                                        <Items>
                                                            <telerik:RadComboBoxItem Text="Active" Value="1" />
                                                            <telerik:RadComboBoxItem Text="InActive" Value="0" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                             <%--   <telerik:GridBoundColumn DataField="ModifiedOn" HeaderText="Modified Date" HeaderTooltip="Modified On"
                                                    UniqueName="columnModifiedOn" FilterControlWidth="70%"><HeaderStyle width="50px" Height="15px"/>
                                                </telerik:GridBoundColumn>--%>
                                              <telerik:GridBoundColumn DataField="ModifiedOn" HeaderText="Modified On" HeaderTooltip="Modified On"
                                                UniqueName="columnModifiedOn" FilterControlWidth="150px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                <HeaderStyle Width="50px" Height="15px" />
                                                <FilterTemplate> &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                                    From
                                                    <telerik:RadDatePicker ID="FromDatePicker" runat="server" Width="95px" ClientEvents-OnDateSelected="FromDateSelected"
                                                        DbSelectedDate='<%# startDate %>' DateInput-DateFormat="MM/dd/yyyy" DateInput-Enabled="false" DateInput-ForeColor="Black" />
                                                    To
                                                    <telerik:RadDatePicker ID="ToDatePicker" runat="server" Width="95px" ClientEvents-OnDateSelected="ToDateSelected"
                                                         DbSelectedDate='<%# endDate %>' MaxDate='<%#DateTime.Now %>' DateInput-DateFormat="MM/dd/yyyy" DateInput-Enabled="false" DateInput-ForeColor="Black" />
                                                    <telerik:RadScriptBlock ID="RadScriptBlockDueDate" runat="server">
                                                        <script type="text/javascript">
                                                            var check = false;
                                                            function FromDateSelected(sender, args) {
                                                                var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                                                var ToPicker = $find('<%# ((GridItem)Container).FindControl("ToDatePicker").ClientID %>');
                                                                var fromDate = FormatSelectedDate(sender);
                                                                var toDate = FormatSelectedDate(ToPicker);
                                                                var dateOne = new Date(fromDate); //Year, Month, Date
                                                                var dateTwo = new Date(toDate); 
                                                                if (dateOne > dateTwo) {
                                                                    sender.set_selectedDate(args.get_oldDate());
                                                                    alert('From-date should not be greater than to-date.');
                                                                }
                                                                tableView.filter("columnModifiedOn", fromDate + " " + toDate, "Between");
                                                            }
                                                            function ToDateSelected(sender, args) {
                                                                var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                                                var FromPicker = $find('<%# ((GridItem)Container).FindControl("FromDatePicker").ClientID %>');
                                                                var fromDate = FormatSelectedDate(FromPicker);
                                                                var toDate = FormatSelectedDate(sender);
                                                                var dateOne = new Date(fromDate); //Year, Month, Date
                                                                var dateTwo = new Date(toDate);
                                                                if (dateOne > dateTwo) {
                                                                    sender.set_selectedDate(args.get_oldDate());
                                                                    alert('To-date should not be less than from-date.');
                                                                }
                                                                tableView.filter("columnModifiedOn", fromDate + " " + toDate, "Between");
                                                            }
                                                            function FormatSelectedDate(picker) {
                                                                var date = picker.get_selectedDate();
                                                                var dateInput = picker.get_dateInput();
                                                                var formattedDate = dateInput.get_dateFormatInfo().FormatDate(date, dateInput.get_displayDateFormat());
                                                                return formattedDate;
                                                            }
                                                        </script>
                                                    </telerik:RadScriptBlock>
                                                </FilterTemplate>
                                            </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn AllowFiltering="False" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"><HeaderStyle width="50px" Height="15px"/>
                                                    <HeaderTemplate>
                                                        <asp:Label ID="lblHeaderAction" runat="server" Text="Action"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Panel ID="editButtonPanel" runat="server" CssClass="custom-Action-column" Width="50px">
                                                            <asp:ImageButton ID="editAccountButton" runat="server" OnClick="editSocialAccount" ToolTip="Edit"
                                                                Width="15px" Height="15px" CausesValidation="false" />
                                                            <img alt="" src="images/menu_border-action.gif" />
                                                            <asp:ImageButton ID="deleteAccountButton" runat="server" OnClick="deleteSocialAccount" ToolTip="Delete"
                                                                Width="15px" Height="15px" CausesValidation="false" />
                                                        </asp:Panel>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                </Columns>
                                            <EditFormSettings>
                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                </EditColumn>
                                            </EditFormSettings>
                                            <PagerStyle AlwaysVisible="True"></PagerStyle>
                                        </MasterTableView>
                                        <ClientSettings AllowColumnsReorder="True" ReorderColumnsOnClient="True">
                                            <Scrolling EnableVirtualScrollPaging="true" />
                                            <Selecting AllowRowSelect="true" />
                                        </ClientSettings>
                                        <FilterMenu EnableImageSprites="False">
                                        </FilterMenu>
                                    </telerik:RadGrid>
                                </ItemTemplate>
                            </telerik:RadPanelItem>
                        </Items>
                    </telerik:RadPanelItem>
                    <telerik:RadPanelItem Enabled="True" Text="Edit Social Account" runat="server" Expanded="false"
                        Value="socialAccountMasterPanel" Width="99.8%">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <Items>
                            <telerik:RadPanelItem Enabled="True" runat="server" Value="socialPanel" Expanded="false">
                                <ItemTemplate>
                                    <div style="border: 1px solid threedshadow;" id="DivExternalForm" runat="server">
                                        <asp:Panel ID="pnlExternalForm" runat="server" Visible="true">
                                            <table border="0" style="margin-top: 20px; width: 100%;">
                                                <tr width="100%">
                                                    <td width="20%">
                                                        <asp:Label ID="lblTextboxSocialNetworkName" runat="server" Text="Social Network Name: " CssClass="custom-label"></asp:Label>
                                                    </td>
                                                    <td width="25%">
                                                        <telerik:RadTextBox ID="txtSocialNetworkName" runat="server" CssClass="custom-txtbox" MaxLength="50"
                                                            Rows="1" Width="175px"  TabIndex="1">
                                                        </telerik:RadTextBox>
                                                        
                                                         
                                                    </td>
                                                    <td  width="25%">
                                                        
                                                        <cc1:PropertyProxyValidator ID="PropertyProxyValidator1" runat="server" ControlToValidate="txtSocialNetworkName" PropertyName="SocialAccountScreenName" 
                                                                SourceTypeName="BusinessEntity.SocialNetwork,BusinessEntity"></cc1:PropertyProxyValidator>
                                                    </td> 
                                                    <td width"25%" >
                                                    </td>                                               
                                                </tr>
                                                <tr width="100%">
                                                    <td width="20%">
                                                        <asp:Label ID="lblTextboxSocialNetworkType" runat="server" Text="Social Network Type: " CssClass="custom-label"></asp:Label>
                                                    </td>
                                                    <td width="25%">
                                                        <telerik:RadTextBox ID="txtSocialNetworkType" runat="server" CssClass="custom-txtbox" MaxLength="50"
                                                            Rows="1" Width="175px"  TabIndex="2" Enabled="false">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td  width="25%">
                                                    </td> 
                                                    <td width"25%" >
                                                    </td>
                                                </tr>
                                                <tr width="100%">
                                                    <td width="20%">
                                                        <asp:Label ID="lblCheckboxStatus" runat="server" Text="Account Status: " CssClass="custom-label"></asp:Label>
                                                    </td>
                                                    <td width="25%">
                                                        <asp:CheckBox ID="chkStatus" runat="server" TabIndex="3" />
                                                    </td>
                                                    <td  width="25%">
                                                    </td> 
                                                    <td width"25%" >
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblModifiedDate" runat="server" Text="Modified Date:" CssClass="custom-label"></asp:Label>
                                                    </td>
                                                    <td width="25%">
                                                    <telerik:RadTextBox ID="radTextBoxModifiedDate" runat="server" CssClass="custom-txtbox" MaxLength="50"
                                                            Rows="1" Width="175px"  TabIndex="4" Enabled="false">
                                                    </telerik:RadTextBox>
                                                    </td>
                                                    <td  width="25%">
                                                    </td> 
                                                    <td width"25%" >
                                                    </td>     
                                                 </tr>
                                                 <tr width="100%">
                                                    <td width="20%">
                                                        <asp:Label ID="lblSocialAccId" runat="server" Text="Social Acc Id: " CssClass="custom-label" Visible="false"></asp:Label>
                                                    </td>
                                                    <td width="25%">
                                                        <telerik:RadTextBox ID="txtSocialAccId" runat="server" CssClass="custom-txtbox" MaxLength="50"
                                                            Rows="1" Width="175px"  TabIndex="5" Enabled="false">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td  width="25%">
                                                    </td> 
                                                    <td width"25%" >
                                                    </td>                                               
                                                </tr>
                                            </table>
                                            <br />
                                            <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel" CssClass="custon-save-group-button"
                                                OnClick="btnCancel_Click" AutoPostBack="true" CausesValidation="false">
                                            </telerik:RadButton>
                                            <telerik:RadButton ID="btnUpdate" runat="server" Text="Update" CssClass="custon-save-group-button"
                                                OnClick="btnUpdate_Click" AutoPostBack="true">
                                            </telerik:RadButton>
                                        </asp:Panel>
                                    </div>
                                </ItemTemplate>
                            </telerik:RadPanelItem>
                        </Items>
                    </telerik:RadPanelItem>
                </Items>
                <CollapseAnimation Duration="100" Type="None" />
                <ExpandAnimation Duration="100" Type="None" />
            </telerik:RadPanelBar>
        </telerik:RadAjaxPanel>
    
     
    
            <telerik:RadAjaxPanel ID="radAddSocialNetworkPanel" runat="server" >
                  
                    <telerik:RadPanelBar ID="radAddSocialNetworkPanelBar" runat="server" Width="100%" Skin="WebBlue" ExpandMode="MultipleExpandedItems" Height="400px" style="padding-left:0px; padding-top:0px;background-color:inherit !important" >
                       <Items>
                       <telerik:RadPanelItem Text ="Add Social Network" ToolTip="Add Social Network Type" Expanded="false">
                       <Items><telerik:RadPanelItem Expanded="false" runat="server" Selected="true" Value="Add_Social_Network" > 
                       <ItemTemplate><h1>
                       
                       Here add different type of social network which you want to add in your account.
                      </h1>
                       </ItemTemplate>
                       </telerik:RadPanelItem></Items>
                       </telerik:RadPanelItem>

                       <telerik:RadPanelItem Text="Add Twitter Account" ToolTip="Twitter" Expanded="False" ><Items>
                       <telerik:RadPanelItem Expanded="False" runat="server" Selected="true" Value="twitter">
                       <ItemTemplate>
                        <table><tr><td width ="30%"></td><td width ="40%"><table><tr><td></td></tr>
                       <tr><td><h1>Add Twitter Profile</h1></td></tr>
                       <tr><td><h2>To allow PureAnalyzer access to Your Twitter </br>account,you must first give authorization from the
                       Twitter website</br></br>
                       When Twitter asks you for permissions,please click </br>"Allow" to connect your Twitter account to PureAnalyzer.</br></br>
                       </h2></td></tr>
                       <tr><td>
                           
                              <asp:ImageButton ID="ImgTwitter" runat="server" ImageUrl="~/images/signin_with_twitter.png" Width="200px" Height="30px" OnClientClick="return TwitterAuthenthicate()" />
                       <script type="text/javascript">
                           function TwitterAuthenthicate() {
                               window.open('Twitter.aspx', '_blank', 'width=900,height=700,scrollbars=no');
                               return false;
                           }
    </script>
                          
                                       
          </td></tr></table>
                       </td><td width ="30%"></td></tr></table>
                      
                       </ItemTemplate></telerik:RadPanelItem>
                                </Items>
                       </telerik:RadPanelItem>
                       <telerik:RadPanelItem Text="Add FaceBook Account" ToolTip="Facebook Account" Expanded="false" Width="100%" >
                       <Items><telerik:RadPanelItem Expanded="false" runat="server" Selected="true" Value="facebook_account">
                       
                       <ItemTemplate><table><tr><td width ="30%"></td><td width ="40%"><table><tr><td></td></tr>
                       <tr><td><h1>Add Facebook Profile</h1></td></tr>
                       <tr><td><h2>To allow PureAnalyzer access to Your Facebook </br>account,you must first give authorization from the
                       Facebook website</br></br>
                       When facebook asks you for permissions,please click </br>"Allow" to connect your Facebook account to PureAnalyzer.</br></br>
                       </h2></td></tr>
                       <tr><td>
                       <%--<div class="fb-login-button" scope="email,user_checkins,read_stream,publish_stream,offline_access" >Login with Facebook</div>--%>
                           <asp:ImageButton ID="ImgFacebookbtn" runat="server" ImageUrl="~/images/facebook_login.png" Width="200px" Height="30px" OnClientClick="return FacebookAuthenthicate()" />
                       <script type="text/javascript">
                           function FacebookAuthenthicate() {
                               window.open('facebook_login.aspx','_blank', 'width=900,height=700,scrollbars=no');
                               return false;
                           }
    </script>
                      
                       </br>
                        </br><asp:CheckBox ID="facebook_chk" runat="server" Checked="true" Text="Automatically add a new tab." Enabled="true" />
                      
                          </td></tr></table>
                       </td><td width ="30%"></td></tr></table>
                       
                       
                       </ItemTemplate></telerik:RadPanelItem>
                                </Items>
                       </telerik:RadPanelItem>
                                  <telerik:RadPanelItem Text="Add FaceBook Page" ToolTip="Facebook Page" Expanded="False"  Width="100%">
                                  <Items><telerik:RadPanelItem Expanded="False" runat="server" Selected="true" Value="facebook_page">
                       
                       <ItemTemplate>
                       <table><tr><td width ="30%"></td><td width ="40%"><table><tr><td></td></tr>
                       <tr><td><h1>Add Facebook Profile</h1></td></tr>
                       <tr><td><h2>To allow PureAnalyzer access to Your Facebook </br>account,you must first give authorization from the
                       Facebook website</br></br>
                       When facebook asks you for permissions,please click </br>"Allow" to connect your Facebook account to PureAnalyzer.</br></br>
                       </h2></td></tr>
                       <tr><td></td></tr></table>
                       </td><td width ="30%"></td></tr></table>
                       <%--<button onclick="OpenWindow2();return false;" style="width: 190px">Add FaceBook Page</button>--%>
                                                  </ItemTemplate></telerik:RadPanelItem>
                                                    </Items>
                                </telerik:RadPanelItem>
          <%--                                  <telerik:RadPanelItem Text="Add Linkedin Account" ToolTip="Linkedin" Expanded="False" Width="100%" >
                                            <Items><telerik:RadPanelItem Expanded="False" runat="server" Selected="true" Value="linkedin">
                       
                       <ItemTemplate>
                        <table><tr><td width ="30%"></td><td width ="40%"><table><tr><td></td></tr>
                       <tr><td><h1>Add Linkedin Profile</h1></td></tr>
                       <tr><td><h2>To allow PureAnalyzer access to Your Linkedin </br>account,you must first give authorization from the
                       Linkedin website</br></br>
                       When Linkedin asks you for permissions,please click </br>"Allow" to connect your Linkedin account to PureAnalyzer.</br></br>
                       </h2></td></tr>
                       <tr><td><span id="follow-twitterapi"></span><%--<fb:login-button length="long" background="light" size="medium"

             onlogin="facebook_onlogin_ready();"></fb:login-button>--%>
 <%--<script type="text/javascript">

    twttr.anywhere(function (T) {
        T('#follow-twitterapi').followButton("twitterapi");
    });

</script></td></tr></table>
                       </td><td width ="30%"></td></tr></table>       
                       </ItemTemplate></telerik:RadPanelItem>
                                                    </Items>
                       </telerik:RadPanelItem>--%>
                       
                       </Items>
                       
                       </telerik:RadPanelBar></telerik:RadAjaxPanel>
    
    
<telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true" Skin="WebBlue" Font-Bold="true" IconUrl="images/Delete.png" BackColor="DeepSkyBlue"
 Font-Size="Medium" >
        </telerik:RadWindowManager>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder5" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
</asp:Content>
