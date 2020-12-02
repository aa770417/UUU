<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" MaintainScrollPositionOnPostback="true" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Employee empSession = (Employee)Session["Employee"];

        if (empSession == null)
        {
            //用RETURN 避免NULL 的執行
            //先導向 MASTER PAGE 
            return;
        }
        if (empSession.DepartmentID == 3 && empSession.AuthorizationLevel == "Manager")
        {
            lStatus.Text = "歡迎經理";
            lName.Text = empSession.LastName + empSession.FirstName + " 進入業務系統";
        }
        else if (empSession.DepartmentID == 3 && empSession.AuthorizationLevel == "Employee")
        {
            lStatus.Text = "歡迎職員";
            lName.Text = empSession.LastName + empSession.FirstName + " 進入業務系統";
            //職員看不到公佈欄新增 與刪除與編輯
            AddBoard.Visible = false;
            this.GridView1.Columns[5].Visible = false;
            this.GridView1.Columns[6].Visible = false;
        }



    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .carousel-inner > .item {
            height: 300px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- page content -->
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>
                        <i class="fas fa-vihara"></i>
                        <asp:Label ID="lStatus" runat="server" Text="Label"></asp:Label>
                        <small>
                            <asp:Label ID="lName" runat="server" Text="Label"></asp:Label></small>

                    </h3>

                </div>

                <div class="title_right">
                    <div class="col-md-5 col-sm-5   form-group pull-right top_search">
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
                <%-- 整個首頁卡 --%>
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <%-- 首頁標題 --%>
                        <div class="x_title">
                            <h2><span style="font-size: 1em; color: burlywood;"><i class="fas fa-sitemap"></i></span>   業務系統首頁</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <!--<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>-->
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <%-- 大內容區 --%>
                        <div class="x_content">

                            <%-- 輪播區小區 --%>
                            <%-- 三層都要裝 才有間距 --%>
                            <div class="col-md-12">
                                <div class="x-panel">
                                    <div class="x_content">
                                        <!-- 1.carousel圖片滑動效果 3秒一次 -->
                                        <div id="carousel1" class="carousel slide" data-interval="5000"
                                            data-ride="carousel">

                                            <ol class="carousel-indicators">
                                                <li data-target="#carousel1" data-slide-to="0" class="active"></li>
                                                <li data-target="#carousel1" data-slide-to="1"></li>
                                                <li data-target="#carousel1" data-slide-to="2"></li>
                                                <li data-target="#carousel1" data-slide-to="3"></li>
                                            </ol>
                                            <!-- 要播的圖片區 -->

                                            <div class="carousel-inner">
                                                <!-- 要播的圖片1 -->
                                                <div class="carousel-item active">
                                                    <img class="d-block w-100" style="height: 250px" src="../TomUpload/transport1.jpeg" alt="First slide" />
                                                    <div class="carousel-caption d-none d-md-block text-dark">
                                                    </div>
                                                </div>
                                                <div class="carousel-item">
                                                    <img class="d-block w-100" style="height: 250px" src="../TomUpload/transport2.jpg" alt="Second slide">
                                                </div>
                                                <div class="carousel-item">
                                                    <img class="d-block w-100" style="height: 250px" src="../TomUpload/transport3.jpg" alt="Third slide">
                                                </div>
                                                <div class="carousel-item">
                                                    <img class="d-block w-100" style="height: 250px" src="../TomUpload/transport4.jpg" alt="Third slide">
                                                </div>
                                            </div>
                                            <!--  -->
                                            <a class="carousel-control-prev" href="#carousel1" data-slide="prev">
                                                <span class="carousel-control-prev-icon"></span>
                                            </a>
                                            <a class="carousel-control-next" href="#carousel1" data-slide="next">
                                                <span class="carousel-control-next-icon"></span>
                                            </a>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <%-- 重大消息區小區 --%>
                            <div class="clearfix"></div>

                            <div class="col-md-12">
                                <div class="x_panel">

                                    <div class="x_title">
                                        <h2><span style="font-size: 1em; color: burlywood;"><i class="far fa-clipboard"></i></span> 業務部公佈欄 </h2>

                                        <div style="text-align-last: right">
                                            搜尋主題 :
                                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                            <asp:Button ID="Button1" runat="server" CssClass="btn btn-outline-info btn-xs" Text="查詢" />
                                            <asp:HyperLink ID="AddBoard" runat="server" CssClass="btn btn-outline-primary btn-xs" NavigateUrl="~/production/BoardAdd.aspx"><i class="fa fa-plus"></i>新增</asp:HyperLink>

                                        </div>
                                        <div class="clearfix"></div>
                                    </div>

                                    <div class="x_content">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="table-responsive">
                                                    <asp:GridView ID="GridView1" runat="server" CssClass="table " DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" PagerStyle-HorizontalAlign="Center" PagerStyle-ForeColor="#FF6666" PagerSettings-Mode="NumericFirstLast" CellPadding="4" ForeColor="#333333" GridLines="None" DataKeyNames="BID" PageSize="5" >
                                                        <AlternatingRowStyle BackColor="White" />
                                                        <Columns>
                                                            <asp:CommandField SelectText="--" ShowSelectButton="True" />
                                                            <asp:BoundField DataField="Category" HeaderText="類別" SortExpression="Category" />
                                                            <asp:BoundField DataField="BID" HeaderText="BID" SortExpression="BID" InsertVisible="False" ReadOnly="True" Visible="False" />
                                                            <asp:HyperLinkField DataNavigateUrlFields="BID" DataNavigateUrlFormatString="~/production/BoardDetail.aspx?BID={0}" DataTextField="Title" HeaderText="主題" />
                                                            <asp:BoundField DataField="Time" HeaderText="時間" SortExpression="Time" />
                                                            <asp:HyperLinkField DataNavigateUrlFields="BID" DataNavigateUrlFormatString="~/production/BoardEdit.aspx?BID={0}" HeaderText="編輯" Text="編輯" />
                                                           
                                                            <%-- DataNavigateUrlFields="BID" DataNavigateUrlFormatString="~/production/BoardDelete.aspx?BID={0}"  --%>
                                                            <asp:TemplateField HeaderText="刪除" ShowHeader="False">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="" Text='刪除' OnClientClick="if(confirm('確認要刪除嗎?')){return true;}else{ return false;}" PostBackUrl='<%# Eval("BID", "~/production/BoardDelete.aspx?BID={0}") %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <EditRowStyle BackColor="#2461BF" />
                                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />

                                                        <PagerSettings Mode="NumericFirstLast" />

                                                        <PagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#2461BF" BorderStyle="Solid"></PagerStyle>
                                                        <RowStyle BackColor="#EFF3FB" />
                                                        <SelectedRowStyle BackColor="#FFFFCC" Font-Bold="True" ForeColor="#333333" />
                                                        <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                                        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                                        <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                                        <SortedDescendingHeaderStyle BackColor="#4870BE" />
                                                    </asp:GridView>

                                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:NW %>" SelectCommand="SELECT [BID], [Time], [Title], [Category] FROM [Board] WHERE ([Context] LIKE '%' + @Context + '%')">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="TextBox1" DefaultValue="%" Name="Context" PropertyName="Text" Type="String" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </div>
                                            </div>
                                        </div>



                                    </div>
                                </div>
                            </div>

                            <%-- 會議資訊小區 --%>
                        </div>
                    </div>



                    <%--col12的div --%>
                </div>







                <%-- row的div --%>
            </div>
        </div>
    </div>



    <!-- /page content -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">
        <script src="https://kit.fontawesome.com/9c5d4c272d.js" crossorigin="anonymous"></script>
</asp:Content>

