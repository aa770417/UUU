<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            string BID = Request.QueryString["BID"];
            Board b = TomBoardUtility.GetBoard(int.Parse(BID));
            textCategory.Text = b.Category;
            textSubj.Text = b.Title;
            textTime.Text = b.Time;
            Label4.Text = b.Context;


        }


    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Scripts/ckeditor/ckeditor.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>佈告欄系統</h3>
                </div>

                <div class="title_right">
                    <div class="col-md-5 col-sm-5  form-group pull-right top_search">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search for...">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">Go!</button>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2><span style="font-size: 1em; color: blue;"><i class="fas fa-chalkboard-teacher"></i></span>佈告欄內容</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>

                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <br />
                            <div id="demo-form2" class="form-horizontal form-label-left">
                                <%-- 類別 --%>
                                <div class="field item form-group">
                                    <asp:Label ID="Label1" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="文章類別*" AssociatedControlID="textCategory"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:Label ID="textCategory" runat="server" Text="Label" CssClass="form-control"></asp:Label>
                                    </div>
                                </div>
                                <%-- 時間 --%>
                                <div class="field item form-group">
                                    <asp:Label ID="Label2" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="發布時間*" AssociatedControlID="textTime"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:Label ID="textTime" runat="server" Text="Label" CssClass="form-control"></asp:Label>
                                    </div>
                                </div>
                                <%-- 標題 --%>
                                <div class="field item form-group">
                                    <asp:Label ID="Label3" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="標題*" AssociatedControlID="textSubj"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:Label ID="textSubj" runat="server" Text="Label" CssClass="form-control"></asp:Label>
                                    </div>
                                </div>

                                <%-- editor --%>
                                <div class="field item form-group">
                                    <asp:Label ID="Label5" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="文章內容*" AssociatedControlID="Label4"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">

                                        <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>

                                    </div>

                                </div>

                                <div class="ln_solid"></div>
                                <div class="item form-group">
                                    <div class="col-md-6 col-sm-6 offset-md-3">
                                        <asp:HyperLink ID="HyperLink1"  CssClass="btn btn-outline-primary" runat="server" Text="返回" NavigateUrl="~/production/TomDefault.aspx"></asp:HyperLink>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">
        <script src="https://kit.fontawesome.com/9c5d4c272d.js" crossorigin="anonymous"></script>
</asp:Content>

