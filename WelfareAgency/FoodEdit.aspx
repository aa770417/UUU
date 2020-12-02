<%@ Page Title="" Language="C#" MasterPageFile="~/WelfareAgency/UUU1.master" %>

<%@ Import Namespace="Newtonsoft.Json" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string FID = Request.QueryString["FID"];

            FoodOrders f = FoodClass.GetFoodEdit(int.Parse(FID));

            Label1.Text = f.FName;
            Label2.Text = f.FPrice.ToString();
            TextBox1.Text = f.FAmount.ToString();
            Label3.Text = f.FTotal.ToString();
            Image1.ImageUrl = "~/WelfareAgency/img/food/" + f.FImg.ToString();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        var sessionStr = Session["foodall"].ToString();
        var foods = JsonConvert.DeserializeObject<List<FoodOrders>>(sessionStr);
        foreach (FoodOrders food in foods)
        {
            if (int.Parse(Request.QueryString["FID"]) == food.FID)
            {
                food.FAmount = Convert.ToInt32(TextBox1.Text);
                food.FTotal = (Convert.ToInt32(Label2.Text) * Convert.ToInt32(TextBox1.Text));
            }
        }
        Session["foodall"] = JsonConvert.SerializeObject(foods);
        Response.Redirect("~/WelfareAgency/FoodOrder.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
    <style>
        .nav > li > a {
            font-size: 32PX;
        }
        p{
            font-size: 24PX;
        }
        .h1fa{
            font-size: 48PX;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <hr />
    <div class="container">
        <div class="w3-container w3-blue-gray ">
            <div class="h1fa text-center">修 改 數 量</div>
        </div>
        <br />
        <div class="w3-row-padding">
            <div class="w3-col s6">
            <asp:Image ID="Image1" runat="server" />
        </div>

            <div class="w3-col s6 ">
                <div class="w3-container">
                    <p>
                        <label>餐廳名稱：</label>
                        <asp:Label ID="Label1" CssClass="w3-input" runat="server" Text="Label"></asp:Label>
                    </p>
                    <p>
                        <label>價格：</label>
                        <asp:Label ID="Label2" CssClass="w3-input" runat="server" Text="Label"></asp:Label>
                    </p>
                    <p>
                        <label>數量：</label>
                        <asp:TextBox ID="TextBox1" CssClass="w3-input" runat="server" onblur="ShowTotal()"></asp:TextBox>
                    </p>
                    <p>
                        <label>合計：</label>
                        <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
                    </p>
                </div>
                <div class="col ">
                    <asp:Button ID="Button1" runat="server" Text="送出" CssClass="w3-button w3-block w3-blue-gray" OnClick="Button1_Click" />
                </div>
            </div>
        </div>
    </div>
    <br />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <script>
        function ShowTotal() {
            var price = parseInt($("#ContentPlaceHolder1_Label2").text());
            var cnt = parseInt($("#ContentPlaceHolder1_TextBox1").val());
            var total = price * cnt;
            $("#ContentPlaceHolder1_Label3").text(total);
        }
    </script>
</asp:Content>
