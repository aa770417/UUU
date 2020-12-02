<%@ Page Title="" Language="C#" MasterPageFile="~/UUU.master" ValidateRequest="false" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            string K_ID = Request.QueryString["K_ID"];

            Repeater1.DataSource = KnowledgeUtilty.DisPlayKnowledgeInfoByK_ID(int.Parse(K_ID));
            Repeater1.DataBind();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)//這是加入購物車的按鈕
    {
        //建立Knowledge物件，並取出欄位資料作使用
        string K_ID = Request.QueryString["K_ID"];
        Knowledge Info = new Knowledge();

        string Temp_P_Name = CartUtilty.SendCourseNameToCart(int.Parse(K_ID));

        string Temp_P_Price = CartUtilty.SendCoursePriceToCart(int.Parse(K_ID));

        //---CartItem建立清單---
        Employee empID = (Employee)Session["Employee"];
        string E_ID = empID.EmployeeID.ToString();

        //判斷Session是否已存在
        if (Session["Cart"] == null)
        {
            Session["Cart"] = new List<Cart>();
        }

        List<Cart> Carts = Session["Cart"] as List<Cart>;

        //Response.Redirect("~/Index.aspx");

        int P_Quantity = Convert.ToInt32(DropDownList1.SelectedItem.Text);
        bool isFind = false;
        //很重要
        foreach (var item in Carts)
        {
            int Temp_P_ID = item.P_ID;
            if (Convert.ToInt32(K_ID) == item.P_ID)
            {
                item.P_Quantity += P_Quantity;
                //break;
                isFind = true;
            }
        }

        if (isFind == false)
        {
            Carts.Add(
            new Cart()
            {
                P_ID = Convert.ToInt32(K_ID),
                P_Name = Temp_P_Name,
                P_Price = Convert.ToInt32(Temp_P_Price),
                P_Quantity = Convert.ToInt32(DropDownList1.SelectedItem.Text),
                E_ID = Convert.ToInt32(E_ID)
            });
        }
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel ID="Panel1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div>
                        <h1 class="bg-info text-center text-warning">UUUの福利社</h1>
                        <br />
                        <br />
                        <h2 class="bg-warning text-center text-white">特約課程介紹</h2>
                        <br />
                    </div>
                </div>
            </div>
            <div class="row">
                <%-- 特約課程-基本資料顯示區-Start  --%>
                <div class="col ">
                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <div class="row">
                                <div class="col-auto">
                                    <img src="<%# Eval("K_ImgInfo","/WelfareAgency/upload/{0}") %>" style="width: 350Px; height: 350px" />
                                </div>
                                <div class="col align-items-start align-self-start align-item-start">
                                    <p>課程名稱：<%# Eval("K_Course") %></p>
                                    <p>課程分類：<%# Eval("K_Category")%></p>
                                    <p>認證機構：<%# Eval("K_Institution")%></p>
                                    <p>上課地點：<%# Eval("K_Location")%></p>
                                    <p>課程優惠價：<%# Eval("K_Price")%></p>
                                    <p>課程時數：<%# Eval("K_Hour")%></p>
                                    <p>開課日期：<%# Eval("K_Date")%></p>
                                    <p>認證機構窗口：<%# Eval("K_Contact")%></p>
                                    <p>
                                        窗口聯絡方式：<%# Eval("K_Phone")%>
                                    <p>
                                </div>
                            </div>
                            <%-- 特約課程-基本資料顯示區-End  --%>

                            <%-- 特約課程-詳細資料顯示區-Start  --%>
                            <br />
                            <br />
                            <%--  標題區2-Start--%>
                            <div class="row">
                                <div class="col align-items-end align-self-start align-item-end">
                                </div>
                                <div class="col-11">
                                    <%# Eval("K_DetailInfo") %>
                                </div>
                                <div class="col">
                                </div>
                            </div>
                            <%--  標題區2-End--%>
                            <%-- 知識補給-特約課程詳細資料顯示區-End  --%>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <div class="row">
                <%-- 特約課程-基本資料顯示區-Start  --%>
                <div class="col-4">
                </div>
                <div class="col-8 align-items-end align-self-start align-item-end form-group">
                    <asp:Button ID="Button1" runat="server" Text="加入購物車" OnClick="Button1_Click" class="btn btn-success" Height="45px" Font-Size="25PX" text-align="center" />
                    <br />
                    <br />
                    <asp:Label ID="Label1" runat="server" Text="Label" Font-Size="35PX" align="right">數量</asp:Label>
                    <asp:DropDownList ID="DropDownList1" runat="server">
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
                    <br />
                </div>
            </div>
        </div>
    </asp:Panel>
    <br />
</asp:Content>

