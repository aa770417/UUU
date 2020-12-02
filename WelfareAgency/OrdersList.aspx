<%@ Page Title="" Language="C#" MasterPageFile="~/UUU.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        //要顯示該名員工的所有的訂單
        if (Page.IsPostBack == false)
        {
        Employee aa = (Employee)Session["Employee"];
        int   E_ID = aa.EmployeeID;
        Repeater1.DataSource = OrdersUtilty.DisplayOrdersInfoToOrdersList(E_ID);
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
                <h2 class="bg-warning text-center text-white">訂單列表</h2>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12">
                <asp:Repeater ID="Repeater1" runat="server">
                    <HeaderTemplate>
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr class="table-primary">
                                    <th>訂單編號</th>
                                    <th>訂單日期</th>
                                    <th>收貨人姓名</th>
                                    <th>收貨人電話</th>
                                    <th>收貨人手機</th>
                                    <th>收貨人E-mail</th>
                                    <th>收貨人住址</th>
                                    <th>訂單明細</th>
                                </tr>
                            </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tbody>
                            <tr class="table-warning">
                                <td><%# Eval("Ord_ID") %></td>
                                <td><%# Eval("Ord_Date") %></td>
                                <td><%# Eval("R_Name")%></td>
                                <td><%# Eval("R_Phone")%></td>
                                <td><%# Eval("R_Moblile")%></td>
                                <td><%# Eval("R_Email")%></td>
                                <td><%# Eval("R_Address")%></td>
                                <td><a href="<%# Eval("Ord_Id","OrdersDetailList.aspx?Ord_Id={0}") %>" target="_blank">商品明細</a> </td>
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

