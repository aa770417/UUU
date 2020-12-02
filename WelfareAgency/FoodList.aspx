<%@ Page Title="" Language="C#" MasterPageFile="~/WelfareAgency/UUU1.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Repeater1.DataSource = FoodClass.FindFood();
            Repeater1.DataBind();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        var hiddenField1 = HiddenField1.Value;
        Session["foodall"] = hiddenField1;
        Response.Redirect("~/WelfareAgency/FoodOrder.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .featured__item__pic__hover li {
            margin-right: 3px;
        }
        .btn {
            font-size: 28px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <!-- Categories Section Begin -->
    <section class="categories">
        <div class="container">
            <div class="row ">
                    <div class="col-lg-12 col-md-12 col-sm-12 ">
                        <div class="banner__pic">
                            <img src="img/food/Foodall.png" />
                        </div>
                    </div>
            </div>
            <br />
            <br />
            <br />
            <!-- Categories Section End -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="featured__controls row ">
                        <div class="col-10 ">
                        <ul>
                            <li class="active" data-filter="*">
                                <h4>全部</h4>
                            </li>
                            <li data-filter=".Pizza">
                                <h4>披薩</h4>
                            </li>
                            <li data-filter=".Steak">
                                <h4>牛排類</h4>
                            </li>
                            <li data-filter=".CK">
                                <h4>中港類</h4>
                            </li>
                            <li data-filter=".McDonalds">
                                <h4>麥當勞</h4>
                            </li>
                            <li data-filter=".KFC">
                                <h4>肯德基</h4>
                            </li>
                        </ul>
                        </div>
                        <div class="col-2 align-self-end">
                            <asp:Button ID="Button1" runat="server" Text="前往購物車" OnClick="Button1_Click" CssClass="btn btn-info"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row featured__filter">
                <asp:Repeater ID="Repeater1" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-3 col-md-4 col-sm-6 mix <%# Eval("FCategory")%>">
                            <div class="featured__item">
                                <div class="featured__item__pic set-bg" data-setbg="img/food/<%# Eval("FImg")%>">
                                    <input type="hidden" id="i_hidden<%# Eval("FID")%>" value="<%# Eval("FImg")%>" />
                                    <ul class="featured__item__pic__hover">
                                        <li><a name="addn" onclick="Add('txt' +<%#Eval("FID")%>);"><i class="fa fa-plus"></i></a></li>
                                        <input id="txt<%# Eval("FID")%>" name="txtt" type="text" value="0" style="width: 40px; height: 40px; text-align: center; border-radius: 60%" />
                                        <li><a name="minn" onclick="Less('txt' +<%#Eval("FID")%>)"><i class="fa fa-minus"></i></a></li>
                                        <li><a onclick="carts('txt' +<%# Eval("FID")%>);"><i class="fa fa-shopping-cart"></i></a></li>
                                    </ul>
                                </div>
                                <div class="featured__item__text">
                                    <h4><%# Eval("FName")%></h4>
                                    <input type="hidden" id="n_hidden<%# Eval("FID")%>" value="<%# Eval("FName")%>" />
                                    <h5>$<%# Eval("FPrice")%></h5>
                                    <input type="hidden" id="p_hidden<%# Eval("FID")%>" value="<%# Eval("FPrice")%>" />
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">

    <script>

        function Add(txtid) {
            var i = parseInt($("#" + txtid).val());
            i = i + 1;
            $("#" + txtid).val(i);
        }
        function Less(txtid) {
            var i = parseInt($("#" + txtid).val());
            if (i > 0) {
                i = i - 1;
            } else {
                i = 0;
            }
            $("#" + txtid).val(i);
        }

        var cartData = [];
        function carts(txtid) {

            var fids = txtid;
            var fid = fids.replace("txt", "");
            var famount = $("#" + txtid).val();
            var fprice = $("#p_hidden" + fid).val();
            var fname = $("#n_hidden" + fid).val();
            var fimg = $("#i_hidden" + fid).val();
            var formData = {
                FID: fid,
                FName: fname,
                FPrice: fprice,
                FAmount: famount,
                FTotal: parseInt(famount) * parseInt(fprice),
                FImg:fimg
            };
            //var jsonData = JSON.stringify(formData);
            cartData.push(formData);
            var allJsonData = JSON.stringify(cartData);
            $("#ContentPlaceHolder1_HiddenField1").val(allJsonData);

            //fallid.push(`${fid}:${fa}`);
            //var result = Array.from(new Set(fallid));
            ////fallfa.push(fa);
            //sessionStorage.setItem('foodall', result);
            //document.getElementById("ContentPlaceHolder1_HiddenField1").value = `${sessionStorage.getItem("foodall")}`;

        }



    </script>
</asp:Content>

