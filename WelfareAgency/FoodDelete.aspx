<%@ Page Title="" Language="C#" MasterPageFile="~/WelfareAgency/UUU1.master" %>

<%@ Import Namespace="Newtonsoft.Json" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string FId = Request.QueryString["FId"];
        FoodClass.DeleteFood(int.Parse(FId));
        var sessionStr = Session["foodall"].ToString();
        var foods = JsonConvert.DeserializeObject<List<FoodOrders>>(sessionStr);
        foreach (FoodOrders food in foods)
        {
            if (int.Parse(Request.QueryString["FID"]) == food.FID)
            {
                foods.Remove(food);
                break;
            }
        }
        Session["foodall"] = JsonConvert.SerializeObject(foods);

        Response.Redirect("~/WelfareAgency/FoodOrder.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
</asp:Content>
