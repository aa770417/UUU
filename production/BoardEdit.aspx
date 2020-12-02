<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" ValidateRequest="false" %>

<script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                string BID = Request.QueryString["BID"];
                //下拉選單綁定
                using (DBEntities db = new DBEntities())
                {
                    var category = (from b in db.Boards
                                    select new { b.Category }).Distinct().ToList();

                    textCategory.DataValueField = "Category";
                    textCategory.DataTextField = "Category";
                    textCategory.DataSource = category;
                    textCategory.DataBind();
                }

                Board B = TomBoardUtility.GetBoard(int.Parse(BID));
                textCategory.Text = B.Category;
                textSubj.Text = B.Title;
                textContent.Text = B.Context;
            }

            textTime.Text = DateTime.Now.ToShortDateString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string BID = Request.QueryString["BID"];
            Board b = new Board()
            {
                BID = int.Parse(BID),
                Category = textCategory.SelectedItem.Value,
                Time = textTime.Text,
                Context = Request.Form["ctl00$ContentPlaceHolder1$textContent"],
                EmployeeID = "4",
                Remark1 = "",
                Remark2 = "",
                Title = textSubj.Text

        };
        TomBoardUtility.UpdateBoard(b);
        Response.Redirect("~/production/TomDefault.aspx");
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
                                        <asp:DropDownList ID="textCategory" runat="server" CssClass="form-control" required="required"></asp:DropDownList>
                                    </div>
                                </div>
                                <%-- 時間 --%>
                                <div class="field item form-group">
                                    <asp:Label ID="Label2" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="發布時間*" AssociatedControlID="textTime"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <asp:TextBox ID="textTime" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>

                                    </div>
                                </div>
                                <%-- 標題 --%>
                                <div class="field item form-group">
                                    <asp:Label ID="Label3" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="標題*" AssociatedControlID="textSubj"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="textSubj" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                                    </div>
                                </div>

                                <%-- editor --%>
                                <div class="field item form-group">
                                    <asp:Label ID="Label5" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="文章內容*" AssociatedControlID="textContent"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="textContent" name="textContent" runat="server" TextMode="MultiLine" Width="400px" Height="800px"  ValidateRequestMode="Disabled"></asp:TextBox>

                                        <script>
                                            CKEDITOR.replace('ctl00$ContentPlaceHolder1$textContent',
                                                {
                                                    filebrowserBrowseUrl: '../Scripts/ckeditor/ckfinder/ckfinder.html',
                                                    filebrowserImageBrowseUrl: '../Scripts/ckeditor/ckfinder/ckfinder.html?type=Images',
                                                    filebrowserFlashBrowseUrl: '../Scripts/ckeditor/ckfinder/ckfinder.html?type=Flash',
                                                    filebrowserUploadUrl: '../Scripts/ckeditor/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Files',
                                                    filebrowserImageUploadUrl: '../Scripts/ckeditor/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Images',
                                                    filebrowserFlashUploadUrl: '../Scripts/ckeditor/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Flash'
                                                }

                                            );
                                        </script>

                                    </div>
                                </div>

                                <div class="ln_solid"></div>
                                <div class="item form-group">
                                    <div class="col-md-6 col-sm-6 offset-md-3">
                                        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="btn btn-primary" NavigateUrl="~/production/TomDefault.aspx">返回</asp:HyperLink>
                                        <button type='reset' class="btn btn-success">重設</button>
                                        <asp:Button ID="Button1" runat="server" Text="更新" type="submit" CssClass="btn btn-success" OnClick="Button1_Click" />
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

