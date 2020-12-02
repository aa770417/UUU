<%@ Page Title="" Language="C#" MasterPageFile="~/UUU.master" %>

<script runat="server">

    //將購物車資料載畫面中
    protected void Page_Load(object sender, EventArgs e)
    {   //顯示購物車清單資料
        List<Cart> CurrentCarts = Session["Cart"] as List<Cart>;

        Repeater1.DataSource = CurrentCarts;
        Repeater1.DataBind();

        //商品總額加總
        int Total = 0;
        foreach (var item in CurrentCarts)
        {
            Total += item.Amount;
        }
        Label7.Text = Total.ToString();
    }

    //確認送出按鈕
    protected void Button1_Click(object sender, EventArgs e)
    {

        Employee aa = (Employee)Session["Employee"];
        int E_ID = aa.EmployeeID;
        List<Cart> CurrentCarts = Session["Cart"] as List<Cart>;
        //將收件人存入Orders資料表

        DarrenOrders InfoForOrders = new  DarrenOrders()
        {
            E_ID = E_ID,
            R_Name = TextBox1.Text,
            R_Phone = TextBox2.Text,
            R_Moblile = TextBox3.Text,
            R_Email = TextBox4.Text,
            R_Address = TextBox5.Text,
            Ord_Date = DateTime.Now.ToShortDateString()
        };
        OrdersUtilty.InsertOrdersInfo(InfoForOrders);

        //從Orders資料表取出Ord_ID給OrdersDetail資料表作使用

        int Temp_Ord_ID = OrdersUtilty.SendOrdersIDToCartList();

        //將購物車的資料寫存入OrdersDetail資料表

        foreach (var item in CurrentCarts)
        {
            DarrenOrdersDetail InfoForOrdersDetail = new DarrenOrdersDetail()
            {
                Ord_ID = Temp_Ord_ID,
                P_ID = item.P_ID,
                P_Name = item.P_Name,
                P_Price = item.P_Price,
                P_Quantity = item.P_Quantity,
                P_Amount = item.Amount,
                E_ID = Convert.ToInt32(Session["E_ID"]),
            };
            OrdersDetailUtilty.InsertOrdersDetailInfo(InfoForOrdersDetail);
        }

        //存檔成功後清除購物車內容
        Session.Remove("Cart");

        //彈出一個訂購成功的頁面，
        //Page.ClientScript.RegisterStartupScript(
        //    Page.GetType(),
        //    "MessageBox",
        //    "<script>alert('您已完成訂購，訂購金額將於次月薪水扣款!');<" + "/script>");
        Page.ClientScript.RegisterStartupScript(
           Page.GetType(),
           "MessageBox",
           "<script>alert('您已完成訂購，訂購金額將於次月薪水扣款!');location.href='OrdersList.aspx';<" + "/script>"
        );

        //網頁轉向訂單資料列表頁面
        //Response.Redirect("~/WelfareAgency/OrdersList.aspx");
    }
    //Demo鈕
    protected void Button2_Click(object sender, EventArgs e)
    {
        TextBox1.Text = "Darren";
        TextBox2.Text = "02-28224433";
        TextBox3.Text = "0928-777-888";
        TextBox4.Text = "darrenlin0915@gmail.com";
        TextBox5.Text = "台北市北投區";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Scripts/sweetalert2.min.css" rel="stylesheet" />
    <script src="Scripts/sweetalert2.min.js"></script>

    <style>
        .td1 {
            width: 450px;
            height: 40PX;
            overflow: hidden;
            font-size: 16px
        }
    </style>

    <style>
        .td2 {
            width: 600px;
            height: 40PX;

            overflow: hidden
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="bg-info text-center text-warning">UUUの福利社</h1>
                <%--這是商場名稱--%>
                <br />
                <br />

                <h2 class="bg-warning text-center text-white">購物清單</h2>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col">
                <asp:Repeater ID="Repeater1" runat="server">
                    <HeaderTemplate>
                        <table class="table table-striped table-bordered" style="width: 760Px">
                            <thead>
                                <tr class="table-primary">
                                    <th>課程名稱</th>
                                    <th>課程優惠價</th>
                                    <th>訂購數量</th>
                                    <th>總價</th>
                                    <th>刪除</th>
                                </tr>
                            </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tbody>
                            <tr class="table-warning">
                                <td><%# Eval("P_Name")%></a></td>
                                <td><%# DataBinder.Eval(Container.DataItem, "P_Price")%></td>
                                <td><%# DataBinder.Eval(Container.DataItem, "P_Quantity")%></td>
                                <td><%# DataBinder.Eval(Container.DataItem, "Amount") %></td>
                                <td><a onclick="checkDelete()" href="<%# Eval("P_ID","/WelfareAgency/CartListDelete.aspx?P_ID={0}") %>">刪除</a> </td>
                            </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
			</table>

                    </FooterTemplate>
                </asp:Repeater>

                <div class="row">
                    <div class="col-6">
                    </div>
                    <div class="col-6">
                        <asp:Label ID="Label6" runat="server" Text="Label">總計：</asp:Label>
                        <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                 <h2 class="bg-warning text-center text-white">收貨人資訊</h2>
                <br />
            </div>
        </div>
        <div class="row">

<%--         <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <br />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>--%>
                    <div class="col-1">
                                   <table style="width:100Px">
                                <tr>
                                    <td class="td1">
                                        <asp:Label ID="Label1" runat="server" Text="Label">姓名：</asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">
                                        <asp:Label ID="Label2" runat="server" Text="Label">電話：</asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">
                                        <asp:Label ID="Label3" runat="server" Text="Label">手機：</asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">
                                        <asp:Label ID="Label4" runat="server" Text="Label">E-Mail：</asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">
                                        <asp:Label ID="Label5" runat="server" Text="Label" >住址：</asp:Label>
                                    </td>
                                </tr>
                            </table>
                
                    </div>

                    <div class="col-11">
                    <%--<div class="form-group">--%>
                             <table style="width: 940Px; float:left">
                                <tr>
                                    <td class="td2">
                                        <asp:TextBox ID="TextBox1" runat="server" placeholder="收貨人姓名" CssClass="form-control"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td2">
                                        <asp:TextBox ID="TextBox2" runat="server" placeholder="收貨人電話" CssClass="form-control"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td2">
                                        <asp:TextBox ID="TextBox3" runat="server" placeholder="收貨人手機" CssClass="form-control"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td2">
                                        <asp:TextBox ID="TextBox4" runat="server" placeholder="收貨人E-mail" CssClass="form-control"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td2">
                                        <asp:TextBox ID="TextBox5" runat="server" placeholder="請填寫收貨人住址" CssClass="form-control"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                             <br />
                  <%--  </div>--%>
      <br />
                    </div> 
                 
              <br />


        </div>
        <br />

        <div class="row">
            <div class="col-12">
                <asp:Button ID="Button1" runat="server" Text="確訂購買" OnClick="Button1_Click" class="btn btn-block btn-danger btn-lg" Height="50px" Font-Size="35PX" text-align="center" />
                <br />
           
            </div>
        <div class="col-12">
             <asp:Button ID="Button2" runat="server" Text="Demo鈕" OnClick="Button2_Click" class="btn btn-block btn-success btn-lg" Height="50px" Font-Size="35PX" text-align="center" />
           </div>
     
        </div>
           <br />
<%--                </ContentTemplate>
            </asp:UpdatePanel>--%>
    </div>

         <%-- 新增資料按鈕-End--%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <script>
        $(function () {
            //$("#ContentPlaceHolder1_Button1").click(function () {
            //    alert("您已完成訂購，訂購金額將於次月薪水扣款!")
            //    //    swal({
            //    //        title: '確認訂購?',
            //    //        text: "您已訂購完成，訂購金額將於次月薪水扣款!",
            //    //        type: 'question',
            //    //        showCancelButton: true,
            //    //        confirmButtonColor: '#3085d6',
            //    //        cancelButtonColor: '#d33',
            //    //        confirmButtonText: '確定',
            //    //        cancelButtonText: '取消'
            //    //    }).then()fuction(){

            //    //    };
            //});

        })

    </script>
</asp:Content>



