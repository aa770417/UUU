<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">


    protected void Button1_Click(object sender, EventArgs e)
    {
        Order.EditOrder(new OrderProduct()
        {
            OrderId = int.Parse(Request.QueryString["OrderId"]),
            Client = TextBox1.Text,
            OrderDate = DateTime.Parse(TextBox2.Text),
            OrderNumber = TextBox3.Text,
            OrderSort = DropDownList2.SelectedValue,
            OrderAmount = int.Parse(TextBox4.Text),
            OrderIn = DateTime.Parse(TextBox5.Text),
            OrderOut = DateTime.Parse(TextBox6.Text),
            Country = TextBox7.Text,
            Position = DropDownList1.SelectedValue
        });

        Response.Redirect("~/production/Warehouse.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string OrderId = Request.QueryString["OrderId"];

            OrderProducts p = Order.GetOrder(int.Parse(OrderId));

            TextBox1.Text = p.Client;
            TextBox2.Text = p.OrderDate.ToString();
            TextBox3.Text = p.OrderNumber;
            DropDownList2.SelectedValue = p.OrderSort;
            TextBox4.Text = p.OrderAmount.ToString();
            TextBox5.Text = p.OrderIn.ToString();
            TextBox6.Text = p.OrderOut.ToString();
            TextBox7.Text = p.Country;
            DropDownList1.SelectedValue = p.Position;
        }
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- bootstrap-datetimepicker -->
    <link href="../vendors/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css" rel="stylesheet">

    <style>
        .fontStyles {
            font-size: 20px;
        }

        .input-group-addon {
            padding: 9px 12px;
            font-size: 20px;
            height: 38px;
            
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- form input mask -->
    <div class="right_col" role="main">
        <div class="col-md-10 col-sm-12 col-xs-2 ">
            <div class="x_panel">
                <div class="x_title">
                    <h2>修改訂單</h2>
                    <button type="button" data-dismiss="alert" class="close">&times; </button>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <%--內容--%>
                    <br />
                    <div class="form-horizontal form-label-left">
                        <div class="form-group row ">
                            <label class="control-label col-md-2 col-sm-2 col-xs-2 fontStyles">客戶名稱</label>
                            <div class="col-md-6 col-sm-6 col-xs-6 input-group date">
                                <asp:TextBox ID="TextBox1" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="control-label col-md-2 col-sm-2 col-xs-2 fontStyles">訂單日期</label>
                            <div class='col-md-6 col-sm-6 col-xs-6 input-group date' id='myDatepicker1'>
                                <asp:TextBox ID="TextBox2" CssClass="form-control" runat="server"></asp:TextBox>
                                <span class="input-group-addon">
                                    <i class="fa fa-table"></i>
                                </span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="control-label col-md-2 col-sm-2 col-xs-2 fontStyles">訂單編號</label>
                            <div class="col-md-6 col-sm-6 col-xs-6 col-xs-10 input-group date">
                                <asp:TextBox ID="TextBox3" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="control-label col-md-2 col-sm-2 col-xs-2 fontStyles">貨櫃數量</label>
                            <div class="col-md-6 col-sm-6 col-xs-6 input-group date">
                            <asp:TextBox ID="TextBox4" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="control-label col-md-2 col-sm-2 col-xs-2 fontStyles" for="DropDownList1">貨櫃型別</label>
                            <div class="col-md-6 col-sm-6 col-xs-6 input-group date">
                                <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">請選擇...</asp:ListItem>
                                    <asp:ListItem Value="普通櫃">普通櫃</asp:ListItem>
                                    <asp:ListItem Value="冷凍櫃">冷凍櫃</asp:ListItem>
                                    <asp:ListItem Value="急速冷凍櫃">急速冷凍櫃</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="control-label col-md-2 col-sm-2 col-xs-2 fontStyles">入庫日期</label>
                            <div class='col-md-6 col-sm-6 col-xs-6 input-group date' id='myDatepicker2'>
                                <asp:TextBox ID="TextBox5" CssClass="form-control" runat="server"></asp:TextBox>
                                <span class="input-group-addon">
                                    <i class="fa fa-table"></i>
                                </span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="control-label col-md-2 col-sm-2 col-xs-2 fontStyles">出貨日期</label>
                            <div class="col-md-6 col-sm-6 col-xs-6 input-group date" id='myDatepicker8'>
                                <asp:TextBox ID="TextBox6" CssClass="form-control" runat="server"></asp:TextBox>
                                <span class="input-group-addon">
                                    <i class="fa fa-table"></i>
                                </span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="control-label col-md-2 col-sm-2 col-xs-2 fontStyles">出口國家</label>
                            <div class="col-md-6 col-sm-6 col-xs-6 input-group date">
                                <asp:TextBox ID="TextBox7" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="control-label col-md-2 col-sm-2 col-xs-2 fontStyles" for="DropDownList1">倉庫位置</label>
                            <div class="col-md-6 col-sm-6 col-xs-6 input-group date">
                                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">請選擇...</asp:ListItem>
                                    <asp:ListItem Value="基隆港">基隆港</asp:ListItem>
                                    <asp:ListItem Value="觀音倉">觀音倉</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="ln_solid"></div>

                        <div class="form-group row">
                            <div class="col-md-9 offset-md-3">
                                <a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus"></i>修改</a>
                                 <a href="/production/Warehouse.aspx" class="btn btn-danger btn-xs">取消</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

     <!-- 彈跳:新增確定 -->
    <div class="modal" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Modal body -->
                <div class="modal-body">
                    <h1>確定修改的資料無誤？</h1>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                  <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary btn-xs" Text="確定"  OnClick="Button1_Click"/>
                     <a href="#" class="btn btn-danger btn-xs" data-dismiss="modal">取消</a>
                </div>

            </div>
        </div>
    </div>

    <!-- /form input mask -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">
    <script type="text/javascript">
        $(function () {
            $('#myDatepicker').datetimepicker();
            format: 'YYYY.DD.MM'
        });

        $('#myDatepicker2').datetimepicker({
            format: 'YYYY/MM/DD'
        });
        $('#myDatepicker1').datetimepicker({
            format: 'YYYY/MM/DD'
        });
        $('#myDatepicker8').datetimepicker({
            format: 'YYYY/MM/DD'
        });

        $('#myDatepicker3').datetimepicker({
            format: 'hh:mm A'
        });

        $('#myDatepicker4').datetimepicker({
            ignoreReadonly: true,
            allowInputToggle: true
        });

        $('#datetimepicker6').datetimepicker();

        $('#datetimepicker7').datetimepicker({
            useCurrent: false
        });

        $("#datetimepicker6").on("dp.change", function (e) {
            $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
        });

        $("#datetimepicker7").on("dp.change", function (e) {
            $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
        });
    </script>
</asp:Content>

