<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        //string[] empStringArray = { "3", "軒華", "1", "主管" };
        //Session["Employee"] = empStringArray;

        ////string[] empStringArray = (string[])Session["Employee"];

        //int depID = Convert.ToInt32(empStringArray[2]);


        Employee empSession = (Employee)Session["Employee"];

        if (Session["Employee"] != null)
        {
            //根據Session裡的部門編號，讀取該部門員工的上班日
            Repeater1.DataSource = PeterHsuUtilities.GetWorkShiftRecordsByDepId(empSession.DepartmentID);
            Repeater1.DataBind();
        }
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>員工排班表</title>

    <!-- Datatables -->

    <link href="../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">

    <%--Popup--%>
    <link href="Magnific-Popup-master/dist/magnific-popup.css" rel="stylesheet" />
    <style>
        .mfp-iframe-scaler iframe {
            background: #fff;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container body">
        <div class="right_col" role="main">
            <div class="">
                <div class="page-title">
                    <div class="title_left">
                        <%-- 最上層 --%>
                        <%--<h3>
                            <asp:Label ID="lStatus" runat="server" Text="Label"></asp:Label>
                            <small>
                                <asp:Label ID="lName" runat="server" Text="Label"></asp:Label></small></h3>
                    </div>--%>
                        <%--<div class="title_right">
                        <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Search for...">
                                <span class="input-group-btn">
                                    <button class="btn btn-secondary" type="button">Go!</button>
                                </span>
                            </div>
                        </div>
                    </div>--%>
                    </div>
                    <div class="clearfix"></div>
                    <div class="row">
                        <div class="col-md-12 col-sm-12 ">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>員工排班表</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <%--<li>
                                        <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                    </li>--%>
                                        <li class="dropdown">
                                            <%--  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                            <a class="dropdown-item" href="#">Settings 1</a>
                                            <a class="dropdown-item" href="#">Settings 2</a>
                                        </div>--%>
                                        </li>
                                        <li>
                                            <%--<a class="close-link"><i class="fa fa-close"></i></a>--%>
                                        </li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="card-box table-responsive">
                                                <%-- 新增刪除鈕 --%>

                                                <asp:HiddenField ID="HiddenField1" runat="server" />

                                                <table id="datatable-buttons" class="table table-striped table-bordered" style="width: 100%">
                                                    <thead>
                                                        <tr>
                                                            <%--<th>
                                                             全選按鈕 
                                                            <asp:CheckBox ID="CheckBox2" runat="server" onclick="checkAll()" Text="全選" />
                                                        </th>--%>
                                                            <th hidden="hidden">編號</th>
                                                            <th>部門編號</th>
                                                            <th>員工編號</th>
                                                            <th>員工姓名</th>
                                                            <th>工作日</th>
                                                            <th class="column-title" style="width: 20%">資料異動</th>
                                                        </tr>
                                                    </thead>

                                                    <asp:Repeater ID="Repeater1" runat="server">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td hidden="hidden"><%# Eval ("WorkShiftRecordId") %></td>
                                                                <td><%# Eval ("DepartmentID") %></td>
                                                                <td><%# Eval ("EmployeeID") %></td>
                                                                <td><%# PeterHsuUtilities.GetEmployeeNameByEmpID(Convert.ToInt32(Eval ("EmployeeID"))) %></td>
                                                                <td><%# Convert.ToDateTime(Eval ("WorkDate")).ToShortDateString() %></td>
                                                                <td>
                                                                    <%--<a href="/production/WorkShiftRecordEdit.aspx">修改</a>--%>
                                                                    <a class="btn btn-info" href="<%# Eval("WorkShiftRecordId","WorkShiftRecordEdit.aspx?id={0}") %>">修改</a>
                                                                    <a class="btn btn-danger" href="<%# Eval("WorkShiftRecordId","WorkShiftRecordDelete.aspx?id={0}") %>">刪除</a>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /page content -->
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">
    <!-- Datatables -->
    <script src="../vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="../vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="../vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="../vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
    <script src="../vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
    <script src="../vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="../vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
    <script src="../vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
    <script src="../vendors/jszip/dist/jszip.min.js"></script>
    <script src="../vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="../vendors/pdfmake/build/vfs_fonts.js"></script>

    <%--<script src="js/PeterWorkShiftRecordsTable.js"></script>--%>

    <script src="Magnific-Popup-master/dist/jquery.magnific-popup.js"></script>

    <script>
        $(function () {
            $('table').magnificPopup({
                delegate: 'a',
                type: 'iframe',
                closeOnContentClick: false,
                closeOnBgClick: false,
                closeBtnInside: true,
            });
        });
    </script>

</asp:Content>

