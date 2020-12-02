<%@ Page Title="" Language="C#" MasterPageFile="~/UUU.master" %>

<script runat="server">
    //要顯示該名員工的所有的訂單
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            string Ord_ID = Request.QueryString["Ord_ID"];
            Repeater1.DataSource = OrdersDetailUtilty.DisplayOrdersDetailInfoToOrdersList(int.Parse(Ord_ID));
            Repeater1.DataBind();
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="bg-info text-center text-warning">UUUの福利社</h1>
                    <%--這是商場名稱--%>
                    <br />
                    <br />
                <h2 class="bg-warning text-center text-white">訂單明細列表</h2>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12">
                <br />
                <asp:Repeater ID="Repeater1" runat="server">
                    <HeaderTemplate>
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr class="table-primary">
                                    <th>商品名稱</th>
                                    <th>價格</th>
                                    <th>訂購數量</th>
                                    <th>總價</th>
                                </tr>
                            </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tbody>
                            <tr class="table-warning">
                                <td><%# Eval("P_Name") %></td>
                                <td><%# Eval("P_Price") %></td>
                                <td><%# Eval("P_Quantity")%></td>
                                <td><%# Eval("P_Amount")%></td>
                            </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
			</table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
</asp:Content>
