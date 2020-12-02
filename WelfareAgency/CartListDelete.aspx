<%@ Page Title="" Language="C#" MasterPageFile="~/UUU.master" %>

<script runat="server">
    //載入刪除購物車頁面，並刪除購物車內容

    protected void Page_Load(object sender, EventArgs e)
    {
        string P_ID = Request.QueryString["P_ID"];
        List<Cart> CurrentCarts = Session["Cart"] as List<Cart>;
        int index = 0;
        foreach (var item in CurrentCarts)
        {
            if (Convert.ToInt32(P_ID) == item.P_ID)
            {
                index = CurrentCarts.IndexOf(item);
            }
        }
        CurrentCarts.RemoveAt(index);
        Response.Redirect("~/WelfareAgency/CartList.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



</asp:Content>

