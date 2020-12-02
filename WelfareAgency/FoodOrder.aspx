<%@ Page Title="" Language="C#" MasterPageFile="~/WelfareAgency/UUU1.master" %>

<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="System.Net.Mail" %>


<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["foodall"] != null)
            {
                var sessionStr = Session["foodall"].ToString();
                var foods = JsonConvert.DeserializeObject<List<FoodOrders>>(sessionStr);
                foreach (FoodOrders food in foods)
                {
                    FoodClass.FoodOrderAdds(new FoodOrders
                    {
                        FID = food.FID,
                        FName = food.FName,
                        FPrice = food.FPrice,
                        FAmount = food.FAmount,
                        FTotal = food.FTotal,
                        FImg = food.FImg
                    });
                }
                var newFoods = FoodClass.GetFoodOrder();
                int SumTotal = 0;
                foreach (FoodOrders nfood in newFoods)
                {
                    SumTotal += nfood.FTotal;
                }
                newFoods.Add(new FoodOrders { FName = "總計", FTotal = SumTotal });
                Repeater1.DataSource = newFoods;
                Repeater1.DataBind();
                //foreach (FoodOrders food in foods)
                //{
                //    FoodClass.FoodOrder(food.FID, food.FAmount, food.FTotal);
                //}
                //string keyids = string.Join(",", foods.Select(x => x.FID).ToArray());
                //var newFoods = FoodClass.GetFood(keyids);
                //int SumTotal = 0;
                //foreach (FoodOrders nfood in newFoods)
                //{
                //    SumTotal += nfood.FTotal;
                //}
                //newFoods.Add(new FoodOrders { FName="總計" ,FTotal = SumTotal });
                //Repeater1.DataSource = newFoods;
                //Repeater1.DataBind();
            }
            else
            {
                Response.Redirect("~/WelfareAgency/FoodList.aspx");
            }
        }


    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        var sessionStr = Session["foodall"].ToString();
        var foods = JsonConvert.DeserializeObject<List<FoodOrders>>(sessionStr);
        List<string> Order = new List<string>();
        foreach (var item in foods)
        {
            Order.Add($"<h3>餐廳名稱：{item.FName}，價格：{item.FPrice}，數量：{item.FAmount}</h3>");
        }
        string Orders = string.Join("<br/>", Order);
        int SumTotal = 0;
        foreach (FoodOrders nfood in foods)
        {
            SumTotal += nfood.FTotal;
        }
        MailMessage msg = new MailMessage();
        //收件人的帳號
        msg.To.Add("uuu9045finalproject2@gmail.com");
        msg.From = new MailAddress("uuu9045finalproject1@gmail.com",
            "IT管理員", System.Text.Encoding.UTF8);
        msg.Subject = "UUU海運 員工福利-美味時光 ";
        //指定Subject的編碼  
        msg.SubjectEncoding = System.Text.Encoding.UTF8;
        msg.Body = $@"<h1>親愛的，您的訂購的項目為：</h1><br/>
                      {Orders}
                      <hr/>
                      <h1>合計：{SumTotal}</h1>";
        msg.IsBodyHtml = true;
        msg.BodyEncoding = System.Text.Encoding.UTF8;
        SmtpClient MySmtp = new SmtpClient("smtp.gmail.com", 587);
        //寄件者的帳號密碼
        MySmtp.Credentials = new System.Net.NetworkCredential(
            "uuu9045finalproject1@gmail.com", "9045finalproject");
        //啟用 SSL
        MySmtp.EnableSsl = true;
        MySmtp.Send(msg);

        Response.Redirect("~/WelfareAgency/FoodList.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
    <link href="js/sweetalert2/sweetalert2.min.css" rel="stylesheet" />

    <style>
        /*按鈕分散調整*/
        .row {
            margin-right: 0px;
            margin-left: 0px;
        }

        /*.fa {
          font-size:70px;
        }*/
        .nav > li > a {
            font-size: 32PX;
        }

        .isize {
            font-size: 20px;
        }
         .btn {
            font-size: 24px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:HiddenField ID="foodids" runat="server" />
    <div class="container">
        <hr />
        <div class="row ">
            <div class="col-10 align-self-start">
                <h1>購物車清單</h1>
            </div>
            <div class="col-2 align-self-end">
                <asp:Button ID="Button1" runat="server" CssClass="btn btn-danger" Text="確認訂單結帳" OnClick="Button1_Click" />
            </div>
        </div>

        <asp:Repeater ID="Repeater1" runat="server">
            <HeaderTemplate>
                <table class="w3-table-all w3-card-4 ">
                    <tr>
                        <th>餐廳名稱</th>
                        <th>價格</th>
                        <th>數量</th>
                        <th>總計</th>
                        <th></th>
                        <th></th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("FName") %></td>
                    <td class="tdprice<%# Eval("FID")%>"><%# Eval("FPrice") %></td>
                    <td class="tdamount<%# Eval("FID")%>"><%# Eval("FAmount") %></td>
                    <td><%# Eval("FTotal") %></td>
                    <td class="btnedit<%# Eval("FID")%>"><a href="<%# Eval("FID","/WelfareAgency/FoodEdit.aspx?FID={0}") %>">修改</a></td>
                    <td class="btndelete<%# Eval("FID")%>"><a onclick="checkDelete(<%# Eval("FID")%>)" href="#">刪除</a></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </div>
    <br />
    <br />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/sweetalert2/sweetalert2.js"></script>
    <script>

        $(document).ready(function () {
            var btneditTd = document.querySelector(".btnedit0");
            btneditTd.innerHTML = "";
            var btndeleteTd = document.querySelector(".btndelete0");
            btndeleteTd.innerHTML = "";
            var tdprice = document.querySelector(".tdprice0");
            tdprice.innerHTML = "";
            var tdamount = document.querySelector(".tdamount0");
            tdamount.innerHTML = "";
        });

        function checkDelete(id) {
            swal({
                title: '確認?',
                text: "檔案即將被刪除!",
                type: 'warning',
                showCancelButton: true,
            }).then(
                function () {
                    location.href = `/WelfareAgency/FoodDelete.aspx?FID=${id}`;
                });
        }
        //$("#button1").click(function () {
        //    $("#myDiv").empty();


        //    $.ajax({
        //        type: 'POST',
        //        url: '/MyWebService.asmx/ADDFood',
               //data: JSON.stringify({ id: fallid }),
        //        contentType: "application/json;charset=utf-8",
        //        success: function (data) {

        //            $(data.d).each(function (index, item) {

        //                $("#myDiv").append(
        //                    `<div class="row featured__filter">
        //                <div class="col-lg-3 col-md-4 col-sm-6 mix ${item.FCategory}">
        //                    <div class="featured__item">
        //                        <div class="featured__item__pic set-bg" data-setbg="img/food/${item.FImg}">
        //                            <ul class="featured__item__pic__hover">
        //                                <li><a name="addn" onclick="Add('txt' +${item.FID});"><i class="fa fa-plus"></i></a></li>
        //                                <input id="txt${item.FID}" name="txtt" type="text" value="0" style="width: 40px; height: 40px; text-align: center; border-radius: 60%" />
        //                                <li><a name="minn" onclick="Less('txt' +${item.FID})"><i class="fa fa-minus"></i></a></li>
        //                                <li><a onclick="carts('txt' +${item.FID});"><i class="fa fa-shopping-cart"></i></a></li>
        //                            </ul>
        //                        </div>
        //                        <div class="featured__item__text">
        //                            <h6><a href="#">${item.FName}</a></h6>
        //                            <h5>$${item.FPrice}</h5>
        //                        </div>
        //                    </div>
        //                </div>
        //            </div>`);
        //            });
        //        }
        //    });

//});
    </script>
</asp:Content>

