using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using Telerik.Web.UI;
using BusinessLayer;
using BusinessEntity;
using TwitterVB2;
using System.Collections.Generic;
using Facebook;


namespace PureAnalyzer_WebApp
{
    public partial class AddSocialNetwork : System.Web.UI.Page
    {
        #region Instance Variable
        SocialNetworkBF objSocialNetworkBF;
        SocialNetwork objSocialNetwork;
        DataSet dsSocialGrid;
        int compId;
        string userId;
        //string userSocialEmailId;
        TwitterUser user = new TwitterUser();
        TwitterAPI tw = new TwitterAPI();
        string ConsumerKey = ConfigurationManager.AppSettings["consumerKey"];
        string ConsumerKeySecret = ConfigurationManager.AppSettings["consumerSecret"];
        public bool IsUserLoggedIn = false;
        FacebookApplication facebookApp = new FacebookApplication();
        #endregion

        #region Properties

        protected DateTime? startDate
        {
            set
            {
                ViewState[PureAnalyzer_WebApp.StrD] = value;
            }
            get
            {
                if (ViewState[PureAnalyzer_WebApp.StrD] != null)
                    return (DateTime)ViewState[PureAnalyzer_WebApp.StrD];
                else
                    return new DateTime(2000, 01, 01);
            }
        }
        protected DateTime? endDate
        {
            set
            {
                ViewState[PureAnalyzer_WebApp.EndD] = value;
            }
            get
            {
                if (ViewState[PureAnalyzer_WebApp.EndD] != null)
                    return (DateTime)ViewState[PureAnalyzer_WebApp.EndD];
                else
                    return new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            }
        }

        #endregion

        #region Page Load
        protected void Page_Load(object sender, EventArgs e)
        {
            #region This region is used to valid the screen
             UserBL userBLObj = new UserBL();
             DataSet dsSuperAdmin = userBLObj.GetSuperAdmin(Session[PureAnalyzer_WebApp.CurrentUserEmailID].ToString());
             if (dsSuperAdmin != null && dsSuperAdmin.Tables.Count > 0 && dsSuperAdmin.Tables[0].Rows.Count > 0)
             {

             }
             else
             {
                 DataSet ds = userBLObj.GetCurrentScreen(Session[PureAnalyzer_WebApp.CurrentUserEmailID].ToString(), PureAnalyzer_WebApp.AddSocialNetwork);
                 if (ds != null && ds.Tables.Count > 0)
                 {

                 }
                 else
                 {
                     Response.Redirect(PureAnalyzer_WebApp.LandingPageAspx);
                 }
             }
            #endregion
             string[] roles = new string[1];
            roles[0] = Session[PureAnalyzer_WebApp.UserRole].ToString();
            //if (!SecurityHelper.Authorized(Session[PureAnalyzer_WebApp.UserEmail].ToString(), PureAnalyzer_WebApp.ViewPage, roles))
            //{
            //    Response.Redirect(PureAnalyzer_WebApp.LandingPageAspx);
            //}

            //if (!IsPostBack)
            //{
            //    ViewState[PureAnalyzer_WebApp.AdhocUpdate] = 0;


            //}
            
        }
        #endregion

        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);
        }

        ///        Required method for Designer support - do not modify
        ///        the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            if (Session[PureAnalyzer_WebApp.LoggedStatus] == null)
            {
                Response.Redirect(PureAnalyzer_WebApp.DefaultAspx);
            }
            if (!Convert.ToBoolean(Session[PureAnalyzer_WebApp.LoggedStatus]))
            {
                Response.Redirect(PureAnalyzer_WebApp.DefaultAspx);
            }
            compId = int.Parse(Session[PureAnalyzer_WebApp.UserCompId].ToString());
            userId = Session[PureAnalyzer_WebApp.UserName].ToString();
            RadGrid radGrid = (RadGrid)this.radPanelBarAddSocialNetwork.FindItemByValue("socialGrid").FindControl("radGridViewSocialNetwork");
            radGrid.NeedDataSource += new Telerik.Web.UI.GridNeedDataSourceEventHandler(this.radGridViewSocialNetwork_NeedDataSource);
            radGrid.ItemDataBound += new GridItemEventHandler(this.radGridViewSocialNetwork_ItemDataBound);
            //radGrid.ItemCreated += new GridItemEventHandler(this.radGridAddSocialNetwork_ItemCreated);
            ((RadPanelItem)radPanelBarAddSocialNetwork.FindItemByValue("socialAccountMasterPanel")).Visible = false;
            //RadButton radButtonCancel = (RadButton)this.radPanelBarAddSocialNetwork.FindItemByValue("socialPanel").FindControl("pnlExternalForm").FindControl("btnCancel");
            //RadButton radButtonUpdate = (RadButton)this.radPanelBarAddSocialNetwork.FindItemByValue("socialPanel").FindControl("pnlExternalForm").FindControl("btnUpdate");
            //radButtonCancel.Click += new EventHandler(this.btnCancel_Click);
            //radButtonUpdate.Click += new EventHandler(this.btnUpdate_Click);
        }
        #endregion

        #region Fill the Grid

        protected void radGridAddSocialNetwork_InIt(object sender, EventArgs e)
        {
            RadGrid radGrid = sender as RadGrid;
            GridFilterMenu menu = radGrid.FilterMenu;
            int i = 0;
            while (i < menu.Items.Count)
            {
                if (menu.Items[i].Text == PureAnalyzer_WebApp.GreaterThanOrEqualTo || menu.Items[i].Text == PureAnalyzer_WebApp.LessThanOrEqualTo ||
                    menu.Items[i].Text == PureAnalyzer_WebApp.GreaterThan || menu.Items[i].Text == PureAnalyzer_WebApp.LessThan ||
                    menu.Items[i].Text == PureAnalyzer_WebApp.Between || menu.Items[i].Text == PureAnalyzer_WebApp.NotBetween)
                {
                    menu.Items.RemoveAt(i);
                }
                else
                {
                    i++;
                }
            }
        }

        protected void radGridAddSocialNetworkFilter_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == RadGrid.FilterCommandName)
            {
                RadGrid radGrid = sender as RadGrid;
                Pair filterPair = e.CommandArgument as Pair;
                string columnModifiedOn = Convert.ToString(filterPair.Second);
                if (columnModifiedOn == PureAnalyzer_WebApp.ColumnModifiedOn)
                {
                    this.startDate = ((e.Item as GridFilteringItem)[columnModifiedOn].FindControl(PureAnalyzer_WebApp.FromDatePicker) as RadDatePicker).SelectedDate;
                    this.endDate = ((e.Item as GridFilteringItem)[columnModifiedOn].FindControl(PureAnalyzer_WebApp.ToDatePicker) as RadDatePicker).SelectedDate;
                }
            }
        }

        protected void radGridViewSocialNetwork_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            objSocialNetworkBF = new SocialNetworkBF();
            dsSocialGrid = objSocialNetworkBF.ListSocialNetwork(compId);
            ((RadGrid)this.radPanelBarAddSocialNetwork.FindItemByValue("socialGrid").FindControl("radGridViewSocialNetwork")).DataSource = dsSocialGrid.Tables[0];
        }

        protected void radGridViewSocialNetwork_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {

                GridDataItem item = (GridDataItem)e.Item;
                string socialAccountDisplayName = item["columnSocialAccountDisplayName"].Text;
                string socialAccount = item["columnSocialAccount"].Text;
                string columnStatus = item["columnIsActive"].Text;
                socialAccountDisplayName = socialAccountDisplayName + "(" + socialAccount + ")";
                item["columnSocialAccountDisplayName"].Text = socialAccountDisplayName;
                //CheckBox chkStatus = (CheckBox)item.FindControl("columnStatus");
                //if (columnStatus == "1")
                //{
                //    chkStatus.Checked = true;
                //    chkStatus.Text = "Active";
                //}
                //else
                //{
                //    chkStatus.Checked = false;
                //    chkStatus.Text = "InActive";
                //}
                RadComboBox cmbStatus = (RadComboBox)item.FindControl(PureAnalyzer_WebApp.ColumnStatus);
                if (columnStatus == "1")
                {
                    //cmbStatus.SelectedItem.Text = PureAnalyzer_WebApp.Active;
                    cmbStatus.SelectedIndex = 0;
                }
                else
                {
                    //cmbStatus.SelectedItem.Text = PureAnalyzer_WebApp.InActive;
                    cmbStatus.SelectedIndex = 1;
                }
                ImageButton editButton = (ImageButton)item.FindControl("editAccountButton");
                editButton.ImageUrl = PureAnalyzer_WebApp.ImagesEditPng;
                editButton.Click += new ImageClickEventHandler(this.editSocialAccount);

                ImageButton deleteButton = (ImageButton)item.FindControl("deleteAccountButton");
                deleteButton.ImageUrl = "~/images/delete.png";
                deleteButton.Click += new ImageClickEventHandler(this.deleteSocialAccount);
                deleteButton.OnClientClick += PureAnalyzer_WebApp.DeleteSingleSocialNetworkConfirmationMessage;
                //string modifiedOn = item["columnModifiedOn"].Text;
                //char[] splitter = { '/', '-' };
                //modifiedOn = modifiedOn.Split(' ')[0];
                //string[] date = modifiedOn.Split(splitter);
                //if (date[0].Length == 1)
                //{
                //    modifiedOn = "0" + date[0];
                //}
                //else
                //{
                //    modifiedOn = date[0];
                //}
                //if (date[1].Length == 1)
                //{
                //    modifiedOn += "/0" + date[1];
                //}
                //else
                //{
                //    modifiedOn += "/" + date[1];
                //}
                //modifiedOn += "/" + date[2];
                //item["columnModifiedOn"].Text = modifiedOn;
            }
        }
        #endregion

        #region Combobox Selected index change Event
        public void columnStatus_CheckedChanged(Object sender, EventArgs e)
        {
            CheckBox chkStatus = sender as CheckBox;
            GridDataItem dataItem = (GridDataItem)chkStatus.Parent.NamingContainer;
            //int socialAccId=int.Parse(dataItem["columnSocialAccId"].Text);
            objSocialNetwork = new SocialNetwork();
            objSocialNetworkBF = new SocialNetworkBF();
            chkStatus = (CheckBox)dataItem.FindControl("columnStatus");
            objSocialNetwork.SocialAccId = int.Parse(dataItem["columnSocialAccId"].Text);
            objSocialNetwork.ModifiedBy = Session[PureAnalyzer_WebApp.UserEmail].ToString();
            if (chkStatus.Checked == true)
            {
                objSocialNetwork.IsActive = 1;
                if (objSocialNetworkBF.UpdateStatus(objSocialNetwork.SocialAccId,objSocialNetwork.IsActive))
                {

                    ((RadGrid)this.radPanelBarAddSocialNetwork.FindItemByValue("socialGrid").FindControl("radGridViewSocialNetwork")).Rebind();
                }
                //else
                //    Response.Write("<scriprt type='text/javascript' language='javascript'>alert('not succeded');</script>");
            }
            else
            {
                objSocialNetwork.IsActive = 0;
                if (objSocialNetworkBF.UpdateStatus(objSocialNetwork.SocialAccId, objSocialNetwork.IsActive))
                {
                    //chkStatus.Text = "Active";
                    //Response.Write("<scriprt type='text/javascript' language='javascript'>document.write(' succeded');</script>");
                    ((RadGrid)this.radPanelBarAddSocialNetwork.FindItemByValue("socialGrid").FindControl("radGridViewSocialNetwork")).Rebind();
                }
                //else
                //    Response.Write("<scriprt type='text/javascript' language='javascript'>alert('not succeded');</script>");
            }
        }
        protected void columnStatus_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

            RadComboBox cmbStatus = sender as RadComboBox;
            GridDataItem dataItem = (GridDataItem)cmbStatus.Parent.NamingContainer;
            int socialAccId = int.Parse(dataItem["columnSocialAccId"].Text);
            //objSocialNetwork = new SocialNetwork();
            objSocialNetworkBF = new SocialNetworkBF();
            cmbStatus = (RadComboBox)dataItem.FindControl("columnStatus");
            string status = cmbStatus.SelectedItem.Text;
            if (status == PureAnalyzer_WebApp.Active)
            {
                //objSocialNetwork.IsActive = 1;
                if (objSocialNetworkBF.UpdateStatus(socialAccId,1))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), PureAnalyzer_WebApp.Message, PureAnalyzer_WebApp.AlertPopUp + "Successfully Updated Staus." + PureAnalyzer_WebApp.ClosingPopUp, true);
                    ((RadGrid)this.radPanelBarAddSocialNetwork.FindItemByValue("socialGrid").FindControl("radGridViewSocialNetwork")).Rebind();
                }
            }
            else
            {
                //objSocialNetwork.IsActive = 0;
                if (objSocialNetworkBF.UpdateStatus(socialAccId,0))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), PureAnalyzer_WebApp.Message, PureAnalyzer_WebApp.AlertPopUp + "Successfully Updated Staus." + PureAnalyzer_WebApp.ClosingPopUp, true);
                    ((RadGrid)this.radPanelBarAddSocialNetwork.FindItemByValue("socialGrid").FindControl("radGridViewSocialNetwork")).Rebind();
                }
            }
        }
        #endregion

        #region Method for Edit Social Account Details
        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="arg"></param>
        public void editSocialAccount(Object sender, ImageClickEventArgs arg)
        {

            ViewState[PureAnalyzer_WebApp.AdhocUpdate] = 1;
            ImageButton editButton = (ImageButton)sender;
            Panel selectdPanel = (Panel)editButton.Parent;
            GridDataItem dataItem = (GridDataItem)selectdPanel.NamingContainer;
            int socialAccId = int.Parse(dataItem["columnSocialAccId"].Text);
            //int socialAccUserId = int.Parse(dataItem["columnSocialAccUserId"].Text);
            //int socialAccountTypeId = int.Parse(dataItem["columnSocialAccountTypeId"].Text);
            int isActive = int.Parse(dataItem["columnIsActive"].Text);
            string socialAccountDisplayName = dataItem["columnSocialAccountDisplayName"].Text;
            socialAccountDisplayName = socialAccountDisplayName.Split('(')[0];

            ((RadTextBox)radPanelBarAddSocialNetwork.FindItemByValue("socialPanel").FindControl("txtSocialAccId")).Text = socialAccId.ToString();
            ((RadTextBox)radPanelBarAddSocialNetwork.FindItemByValue("socialPanel").FindControl("txtSocialAccId")).Visible = false;
            ((RadTextBox)radPanelBarAddSocialNetwork.FindItemByValue("socialPanel").FindControl("txtSocialNetworkName")).Text = socialAccountDisplayName.Replace("&nbsp;", "");
            ((RadTextBox)radPanelBarAddSocialNetwork.FindItemByValue("socialPanel").FindControl("txtSocialNetworkType")).Text = dataItem["columnSocialAccount"].Text;
            ((RadTextBox)radPanelBarAddSocialNetwork.FindItemByValue("socialPanel").FindControl("radTextBoxModifiedDate")).Text = DateTime.Now.Date.ToString();
            CheckBox chkStatus = ((CheckBox)radPanelBarAddSocialNetwork.FindItemByValue("socialPanel").FindControl("chkStatus"));
            if (isActive == 1)
            {
                chkStatus.Checked = true;
            }
            else
            {
                chkStatus.Checked = false;
            }

            RadPanelItem radPanelItem = ((RadPanelItem)radPanelBarAddSocialNetwork.FindItemByValue("socialAccountMasterPanel"));
            radPanelItem.Expanded = true;
            radPanelItem.Visible = true;
        }
        #endregion

        #region Method for Delete Social Account Details
        /// <summary>
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="arg"></param>
        public void deleteSocialAccount(Object sender, ImageClickEventArgs arg)
        {
            objSocialNetwork = new SocialNetwork();
            objSocialNetworkBF = new SocialNetworkBF();
            ImageButton deleteButton = (ImageButton)sender;
            Panel selectdPanel = (Panel)deleteButton.Parent;
            GridDataItem dataItem = (GridDataItem)selectdPanel.NamingContainer;
            int socialAccId = int.Parse(dataItem["columnSocialAccId"].Text);
            objSocialNetwork.SocialAccId = socialAccId;
            objSocialNetwork.IsActive = 0;
            objSocialNetwork.ModifiedBy = Session[PureAnalyzer_WebApp.UserEmail].ToString();
            if (objSocialNetworkBF.DeleteSocialAccount(objSocialNetwork))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), PureAnalyzer_WebApp.Message, PureAnalyzer_WebApp.AlertPopUp + PureAnalyzer_WebApp.SuccessfullyRemovedSocialNetwork + PureAnalyzer_WebApp.ClosingPopUp, true);
                ((RadGrid)this.radPanelBarAddSocialNetwork.FindItemByValue("socialGrid").FindControl("radGridViewSocialNetwork")).Rebind();
            }
            
        }
        #endregion

        #region Method for Update Social Account Details
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!this.IsValid)
                return;
            else
            {
                objSocialNetwork = new SocialNetwork();
                objSocialNetworkBF = new SocialNetworkBF();
                objSocialNetwork.SocialAccId = int.Parse(((RadTextBox)radPanelBarAddSocialNetwork.FindItemByValue("socialPanel").FindControl("txtSocialAccId")).Text.Trim());
                objSocialNetwork.SocialAccountScreenName = ((RadTextBox)radPanelBarAddSocialNetwork.FindItemByValue("socialPanel").FindControl("txtSocialNetworkName")).Text.Trim();
                CheckBox chkStatus = ((CheckBox)radPanelBarAddSocialNetwork.FindItemByValue("socialPanel").FindControl("chkStatus"));
                objSocialNetwork.ModifiedBy = Session[PureAnalyzer_WebApp.UserEmail].ToString();
                if (chkStatus.Checked == true)
                {
                    objSocialNetwork.IsActive = 1;
                }
                else
                {
                    objSocialNetwork.IsActive = 0;
                }
                //if (this.IsValid)
                //{
                //    return;
                //}
                if (objSocialNetworkBF.UpdateSocialAccount(objSocialNetwork))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), PureAnalyzer_WebApp.Message, PureAnalyzer_WebApp.AlertPopUp + "Social Network Successfully Updated.!!" + PureAnalyzer_WebApp.ClosingPopUp, true);
                    //Response.Write("<script type='text/javascript' language='javascript'> alert('Social Account Details is SuccessFully Updated!!!')</script>");
                    RadPanelItem radPanelItem = ((RadPanelItem)radPanelBarAddSocialNetwork.FindItemByValue("socialAccountMasterPanel"));
                    radPanelItem.Expanded = false;
                    radPanelItem.Visible = false;
                    ((RadGrid)this.radPanelBarAddSocialNetwork.FindItemByValue("socialGrid").FindControl("radGridViewSocialNetwork")).Rebind();
                }
            }
        }
        #endregion

        #region Method for Cancel
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ViewState[PureAnalyzer_WebApp.AdhocUpdate] = 0;
            RadPanelItem radPanelItem = ((RadPanelItem)radPanelBarAddSocialNetwork.FindItemByValue("socialAccountMasterPanel"));
            radPanelItem.Expanded = false;
            radPanelItem.Visible = false;
        }
        #endregion

       
       
    }
}
