<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Repeater1.DataSource = Order.FindOrder();
            Repeater1.DataBind();
        }

    }
    // this is query button // for me33333
    protected void Button1_Click(object sender, EventArgs e)
    {
        Repeater1.DataSource = Order.FindOrder(TextBox1.Text);
        Repeater1.DataBind();
    }


    protected void Button2_Click(object sender, EventArgs e)
    {
        string OrderId = Request.Form["table_records111"];
        if (OrderId != null)
        {
            string[] Id = OrderId.Split(',');
            foreach (var item in Id)
            {
                Order.DeleteOrder(int.Parse(item.ToString()));
            }
            Response.Redirect("~/production/Warehouse.aspx");
        };
    }


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .text {
            font-size: 20px;
        }

        .dropdown-item {
            text-align: center;
        }

        .modal-content {
            align-items: center;
        }

        .modal-dialog {
            margin: 350px auto;
        }

        #btndel {
            color: whitesmoke;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- page content -->
    <div class="right_col" role="main">
        <%--<div class="">--%>
        <div class="page-title">
            <!--標題頁-->
            <div class="title_left">
                <h3 style="font-size: 48px">倉庫管理系統</h3>
            </div>
            <%--空間剩餘表--%>
            <div class="project_progress title_right">
                <span>基隆港：</span><span id="bar1Text">0% Complete</span>
                <div class="progress progress_sm">
                    <div id="bar1" class="progress-bar bg-green " data-transitiongoal=""></div>
                </div>
                <span>觀音倉：</span><span id="bar2Text">0% Complete</span>
                <div class="progress progress_sm">
                    <div id="bar2" class="progress-bar bg-green " data-transitiongoal=""></div>
                </div>

            </div>
        </div>

        <div class="clearfix"></div>
        <%--內容業--%>
        <div class="col-md-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Warehouse Management System</h2>
                    <div class="input-group-btn" style="text-align-last: right">
                        <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                            倉庫位置 <span class="caret"></span>
                        </button>
                        <div style="text-align-last: center">
                            <ul class="dropdown-menu dropdown-menu-left" role="menu">
                                <li><a class="dropdown-item close" href="/production/WarehouseKeelung.aspx">基隆港</a></li>
                                <li><a class="dropdown-item close" href="/production/WarehouseGuanyin.aspx">觀音倉</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <%--搜尋--%>
                <div class="title_right ">
                    <div class="col-md-5 col-sm-5 form-group pull-right top_search">
                        <div class="input-group">
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder="訂單編號..."></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="Button1" runat="server" Text="查詢" CssClass="btn btn-secondary" OnClick="Button1_Click" />
                                <%--OnClientClick="return false"--%>
                            </span>
                        </div>
                    </div>
                </div>
                <div style="text-align-last: right">
                    <a href="/production/WarehouseAdd.aspx" class="btn btn-primary btn-xs"><i class="fa fa-folder"></i>新增</a>
                    <a id="btndel" class="btn btn-danger btn-xs" onclick="ifcheck();" data-toggle="modal" data-target="#myModal"><i class="fa fa-trash"></i>出倉</a>
                </div>

                <!--數據呈現-->
                <table class=" table table-striped projects jambo_table bulk_action" id="myDiv">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="check-all111" class="flat">
                            </th>
                            <th class="column-title">客戶名稱</th>
                            <th class="column-title">訂單日期</th>
                            <th class="column-title">訂單編號</th>
                            <th class="column-title">貨櫃型別</th>
                            <th class="column-title">貨櫃數量</th>
                            <th class="column-title">入庫日期</th>
                            <th class="column-title">出貨日期</th>
                            <th class="column-title">出口國家</th>
                            <th class="column-title">倉庫位置</th>
                            <th class="column-title" style="width: 10%">編輯</th>
                            <th class="bulk-actions" colspan="9">
                                <a class="antoo" style="color: #fff; font-weight: 500;">多選功能：( <span class="action-cnt"></span>) <i class="fa fa-chevron-down"></i></a>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="Repeater1" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <input id="w3s" type="checkbox" class="flat" name="table_records111" value='<%# Eval("OrderId")%>'>
                                    </td>
                                   <td><%--客戶名稱--%>
                                        <p class="text"><%# Eval("Client")%></p>
                                    </td>
                                    <td> <%--訂單日期--%>
                                        <p class="text"><%# Eval("OrderDate","{0:d}")%></p>
                                    </td>
                                    <td> <%--訂單編號--%>
                                        <p class="text"><%# Eval("OrderNumber") %></p>
                                    </td>
                                     <td> <%--貨櫃型別--%>
                                        <p class="text"><%# Eval("Ordersort") %></p>
                                    </td>
                                    <td> <%--貨櫃數量--%>
                                        <p class="text"><%# Eval("OrderAmount") %></p>
                                    </td>
                                    <td>  <%--入庫日期--%>
                                        <p class="text"><%# Eval("OrderIn","{0:d}") %></p>
                                    </td>
                                    <td> <%--出貨日期--%>
                                        <p class="text"><%# Eval("OrderOut","{0:d}") %></p>
                                    </td>
                                    <td>  <%--國家--%>
                                        <p class="text"><%# Eval("Country") %></p>
                                    </td>
                                    <td> <%--狀態--%>
                                        <p class="text"><%# Eval("Position") %></p>
                                    </td>
                                    <td class="column-title"> <%-- 按鈕--%>
                                        <a href="<%# Eval("OrderId","WarehouseEdit.aspx?OrderId={0}") %>" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i>修改</a>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- 彈跳:刪除確定 -->
    <div class="modal" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Modal body -->
                <div class="modal-body">
                    <h1>確定訂單要出倉？</h1>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <%--<button type="button" class="btn btn-primary" data-dismiss="modal">確定</button>--%>
                    <asp:Button ID="Button2" runat="server" CssClass="btn btn-primary btn-xs" Text="確定" OnClick="Button2_Click" />
                    <button type="button" class="btn btn-danger " data-dismiss="modal">取消</button>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="server">
    <script>
        $(document).ready(function () {
            $.ajax({
                type: "GET",
                url: "/production/OrderHandlerK.ashx",
                dataType: "json",
                success: function (response) {
                    var x = response * 0.01;
                    $("#bar1").css("width", x + "%");
                    $("#bar1Text").text(x + "% ");
                    if (response > 5999 && response < 7999) { $("#bar1").addClass("progress-bar bg-orange"); }
                    if (response > 8000) { $("#bar1").addClass("progress-bar bg-red"); }
                }
            }),
                $.ajax({
                    type: "GET",
                    url: "/production/OrderHandlerG.ashx",
                    dataType: "json",
                    success: function (response) {
                        var x = response * 0.01;
                        $("#bar2").css("width", x + "%");
                        $("#bar2Text").text(x + "% ");
                        if (response > 5999 && response < 7999) { $("#bar2").addClass("progress-bar bg-orange"); }
                        if (response > 8000) { $("#bar2").addClass("progress-bar bg-red"); }
                    }
                });
        });

        function ifcheck() {
            var y = 0;
            $(".bulk_action input[name='table_records111']:checked").each(function () {
                y = y + 1;
            });
            if (y <= 0) {

                $('div h1').text("最少選取一筆資料");
                return false;
            }
            else {
                $('div h1').text("確定訂單要出倉？");
            }
        };

        $('table input').on('ifChecked', function () {
            checkState = '';
            $(this).parent().parent().parent().addClass('selected');
            countChecked();
        });
        $('table input').on('ifUnchecked', function () {
            checkState = '';
            $(this).parent().parent().parent().removeClass('selected');
            countChecked();
        });

        var checkState = '';

        $('.bulk_action input').on('ifChecked', function () {
            checkState = '';
            $(this).parent().parent().parent().addClass('selected');
            countChecked();
        });
        $('.bulk_action input').on('ifUnchecked', function () {
            checkState = '';
            $(this).parent().parent().parent().removeClass('selected');
            countChecked();
        });
        $('.bulk_action input#check-all111').on('ifChecked', function () {
            checkState = 'all111';
            countChecked();
        });
        $('.bulk_action input#check-all111').on('ifUnchecked', function () {
            checkState = 'none111';
            countChecked();
        });
        function countChecked() {
            if (checkState === 'all111') {
                $(".bulk_action input[name='table_records111']").iCheck('check');
            }
            if (checkState === 'none111') {
                $(".bulk_action input[name='table_records111']").iCheck('uncheck');
            }

            var checkCount = $(".bulk_action input[name='table_records111']:checked").length;

            if (checkCount) {
                $('.column-title').hide();
                $('.bulk-actions').show();
                $('.action-cnt').html('有  ' + checkCount + '  筆選擇資料');
            } else {
                $('.column-title').show();
                $('.bulk-actions').hide();
            }
        }
    </script>
</asp:Content>



