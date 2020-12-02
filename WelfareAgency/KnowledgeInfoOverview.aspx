<%@ Page Title="" Language="C#" MasterPageFile="~/UUU.master" EnableEventValidation="true" %>


<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Repeater1.DataSource = KnowledgeUtilty.GetKnowledgeInfoForIT();//逐筆讀取資訊科技類課程的資料
        Repeater1.DataBind();         //綁定資訊科技類課程的資料 
        //Session["Quantity"] = Convert.ToInt32(DropDownList1.SelectedItem.Text);
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Repeater1.DataSource = KnowledgeUtilty.GetKnowledgeInfoForIT();//逐筆讀取資訊科技類課程的資料
        Repeater1.DataBind();         //綁定資訊科技類課程的資料 
    }

    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        Repeater1.DataSource = KnowledgeUtilty.GetKnowledgeInfoForSL();//逐筆讀取資訊科技類課程的資料
        Repeater1.DataBind();         //綁定資訊科技類課程的資料 
    }

    protected void LinkButton3_Click(object sender, EventArgs e)
    {
        Repeater1.DataSource = KnowledgeUtilty.GetKnowledgeInfoForLL();//逐筆讀取運動休閒類課程的資料
        Repeater1.DataBind();         //綁定運動休閒類課程的資料                       
    }

    //protected void Button1_Click(object sender, EventArgs e)
    //{



    //}

    protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
    {

    }
</script>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- Featured Section Begin -->
    <section class="featured spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h1 class="bg-info text-warning">UUUの福利社</h1>
                        <%--這是商場名稱--%>
                        <br />
                        <br />
                        <h2 class="bg-warning text-white">特約課程總覽</h2>
                        <br />
                    </div>
                    <br />
                    <div class="featured__controls">
                        <ul>
                            <li data-filter=".Information-Technology">
                                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click" Font-Size="25Px">資訊科技類</asp:LinkButton>
                            </li>
                            <li data-filter=".Sports-Leisure">
                                <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" Font-Size="25Px">運動休閒類</asp:LinkButton>
                            </li>
                            <li data-filter=".Language-Learning">
                                <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click" Font-Size="25Px">語言學習類</asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <%-- ----資料繫細節區-Start-----%>
            <asp:Panel ID="Panel1" runat="server">
                <div class="row featured__filter">
                    <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                        <ItemTemplate>
                            <div class="col-lg-3 col-md-4 col-sm-6 mix Information-Technology Sports-Leisure Language-Learning">
                                <div class="featured__item">
                                    <div class="featured__item__pic set-bg" data-setbg="<%# Eval("K_ID") %>">
<%--                                        <img src="<%# Eval("K_ImgInfo","/upload/{0}") %>" style="width: 270Px; height: 270px" />--%>
                     
                                        
                                         <img src="<%# Eval("K_ImgInfo","/WelfareAgency/upload/{0}") %>" style="width: 270Px; height: 270Px" />

<%--                                        <asp:Image ID="Image1" runat="server" ImageUrl="#Eval(K_ImgInfo)" Width="450px" Height="450px" />--%>
                                    </div>
                                    <div class="featured__item__text">
                                        <td>
                                            <p style="font-size: 20Px; line-height: 25px">
                                                <%# Eval("K_Course") %>
                                            </p>
                                        </td>
                                        <td style="font-size: 20Px; line-height: 25px">
                                            <p style="font-size: 20Px; line-height: 35px">
                                                NTD <%# Eval("K_Price") %>
                                        </td>
                                        </p>
                                        <td style="font-size: 20Px; line-height: 25px"><a href="<%# Eval("K_ID","KnowledgeInfoDetail.aspx?K_ID={0}") %>" target="_blank">
                                            <p style="font-size: 20Px; line-height: 35px">
                                                詳細資訊
                                            </p>
                                        </a></td>
                                        <br />
                                        <%--                                        <td>
                                            <asp:Label ID="Label1" runat="server" Text="數量："></asp:Label>
                                            <asp:DropDownList ID="DropDownList1" runat="server" Width="100PX">
                                                <asp:ListItem Value="0">---</asp:ListItem>
                                                <asp:ListItem Value="1">1</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem>
                                                <asp:ListItem Value="3">3</asp:ListItem>
                                                <asp:ListItem Value="4">4</asp:ListItem>
                                                <asp:ListItem Value="5">5</asp:ListItem>
                                                <asp:ListItem Value="6">6</asp:ListItem>
                                                <asp:ListItem Value="7">7</asp:ListItem>
                                                <asp:ListItem Value="8">8</asp:ListItem>
                                                <asp:ListItem Value="9">9</asp:ListItem>
                                                <asp:ListItem Value="11">10</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>--%>
                                        <%--  <td><a href="<%# Eval("K_ID","KnowledgeInfoOverviewCart.aspx?K_ID={0}")%>">加入購物車 </a> </td>--%>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </asp:Panel>
            <%-- ----資訊科技類-end-----%>
        </div>
    </section>
    <!-- Featured Section End -->
    <script>

        //$(function () {
        //    $("#Panel2").css("display", "none");
        //    $("#ImageButton1").click(function () {
        //        $("#Panel1").css("display", "block");
        //        $("#Panel2").css("display", "none");
        //        event.preventDefault();
        //    });
        //    $("#ImageButton2").click(function () {
        //        $("#Panel1").css("display", "none");
        //        $("#Panel2").css("display", "block");
        //        event.preventDefault();
        //    });

        //});

    </script>
</asp:Content>

<%--
    參考網站：
http://www.1111edu.com.tw/search_result_course.php?cate1=5&zone=&cha=&keyword=&searchKey=1&q=keyword

上課地點可以考慮
1.搭配google地圖
2.交通資訊
    
--%>