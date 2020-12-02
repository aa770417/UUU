<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">


    protected void Button1_Click(object sender, EventArgs e)
    {
        Order.AddOrder(new OrderProducts()
        {
            Client = TextBox1.Text,
            OrderDate = TextBox2.Text,
            OrderNumber = TextBox3.Text,
             OrderSort = DropDownList2.SelectedValue,
            OrderAmount = int.Parse(TextBox4.Text),
            OrderIn = TextBox5.Text,
            OrderOut = TextBox6.Text,
            Country = TextBox7.Text,
            Position = DropDownList1.SelectedValue
        });

        Response.Redirect("~/production/Warehouse.aspx");
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/production/Warehouse.aspx");
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
        <div class="col-md-12 col-sm-12" title="">
            <div class="x_panel alert">
                <div class="x_title ">
                    <h2>新增訂單</h2>
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
                                    <i class="fa fa-table"></i></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="control-label col-md-2 col-sm-2 col-xs-2 fontStyles">訂單編號</label>
                            <div class="col-md-6 col-sm-6 col-xs-6 input-group date">
                                <asp:TextBox ID="TextBox3" CssClass="form-control" runat="server"></asp:TextBox>
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
                            <label class="control-label col-md-2 col-sm-2 col-xs-2 fontStyles">貨櫃數量</label>
                            <div class="col-md-6 col-sm-6 col-xs-6 input-group date">
                                <asp:TextBox ID="TextBox4" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row align-items-center">
                            <label class="control-label col-md-2 col-sm-2 col-xs-2 fontStyles">入庫日期</label>
                            <div class='col-md-6 col-sm-6 col-xs-6 input-group date' id='myDatepicker2'>
                                <asp:TextBox ID="TextBox5" CssClass="form-control" runat="server" ></asp:TextBox>
                                <span class="input-group-addon" >
                                    <span class="fa fa-table "></span>
                                </span>
                            </div>
                        </div>

                        <div class="form-group row ">
                            <label class="control-label col-md-2 col-sm-2 col-xs-2 fontStyles">出貨日期</label>
                            <div class="col-md-6 col-sm-6 col-xs-6 input-group date" id='myDatepicker8'>
                                <asp:TextBox ID="TextBox6" CssClass="date-picker form-control" runat="server"></asp:TextBox>
                                <span class="input-group-addon">
                                    <span class="fa fa-table "></span>
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
                            <div class="col-md-7 offset-md-4">
                                <a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus"></i>新增</a>
                                <asp:Button ID="Button2" CssClass="btn btn-danger btn-xs" runat="server" Text="返回" OnClick="Button2_Click" />
                            </div>
                            <div>
                                <input type="button" id="demnoadd" value="Demo" class="btn btn-info" onclick="demoadd();"/>
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

               <%-- <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">刪除</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>--%>

                <!-- Modal body -->
                <div class="modal-body" >
                    <h1>確定新增的資料無誤？</h1>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                     <%--<button type="button" class="btn btn-primary" data-dismiss="modal">確定</button>--%>
                  <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary btn-xs" Text="確定"  OnClick="Button1_Click"/>
                    <a href="/production/Warehouse.aspx" class="btn btn-danger btn-xs">取消</a>
                </div>

            </div>
        </div>
    </div>

    <!-- /form input mask -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">
    <script type="text/javascript">
        function demoadd(){
            $("#ContentPlaceHolder1_TextBox1").val("恆逸");
            $("#ContentPlaceHolder1_TextBox2").val("11/20/2020");
            $("#ContentPlaceHolder1_TextBox3").val("TW202011230");
             $("#ContentPlaceHolder1_DropDownList2").val("急速冷凍櫃");
            $("#ContentPlaceHolder1_TextBox4").val("5000");
            $("#ContentPlaceHolder1_TextBox5").val("11/23/2020");
            $("#ContentPlaceHolder1_TextBox6").val("11/28/2020");
            $("#ContentPlaceHolder1_TextBox7").val("美國");
             $("#ContentPlaceHolder1_DropDownList1").val("基隆港");
        };
        $(function () {
            $('#myDatepicker').datetimepicker();
            format: 'YYYY.DD.MM'
        });
        $('#myDatepicker1').datetimepicker({
            format: 'MM/DD/YYYY'
        });
        $('#myDatepicker2').datetimepicker({
            format: 'MM/DD/YYYY'
        });
        $('#myDatepicker8').datetimepicker({
            format: 'MM/DD/YYYY'
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

