﻿<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //檢查登入  
            if (Session["Employee"] == null)
            {
                Response.Redirect("~/production/Login.aspx");
            }
            //取得使用者
            Employee emp = (Employee)Session["Employee"];

            //HRCEID.Value = EmployeeSession[0];
            //HiddenField1.Value= EmployeeSession[0];
            //HRCEName.Value = HRUtility.GetLastName(int.Parse(EmployeeSession[0])) + EmployeeSession[1];
            //DepartmentID.Value = EmployeeSession[2];

            DDLYear.DataSource = HRUtility.GetYearFromCIORByEID(emp.EmployeeID);
            DDLYear.DataTextField = "Value";
            DDLYear.DataValueField = "Key";
            DDLYear.DataBind();
            DDLYear.SelectedIndex = 0;

            DDLMonth.DataSource = HRUtility.GetMonthFromCIORByEID(emp.EmployeeID);
            DDLMonth.DataTextField = "Value";
            DDLMonth.DataValueField = "Key";
            DDLMonth.DataBind();
            DDLMonth.SelectedIndex = 0;


            string now = DateTime.Now.ToShortDateString();
            DDLYear.SelectedValue = now.Substring(0, 4);
            DDLMonth.SelectedValue = now.Substring(5, 2);

            Repeater1.DataSource = HRUtility.GetPersonalRecordWithTime(emp.EmployeeID, now.Substring(0, 4), now.Substring(5, 2));
            Repeater1.DataBind();

        }

    }

    protected void DDLYear_SelectedIndexChanged(object sender, EventArgs e)
    {

        //取得使用者
        Employee emp = (Employee)Session["Employee"];

        Repeater1.DataSource = HRUtility.GetPersonalRecordWithTime(emp.EmployeeID, DDLYear.SelectedValue, DDLMonth.SelectedValue);
        Repeater1.DataBind();
    }


    protected void DDLMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        //取得使用者
        Employee emp = (Employee)Session["Employee"];

        Repeater1.DataSource = HRUtility.GetPersonalRecordWithTime(emp.EmployeeID, DDLYear.SelectedValue, DDLMonth.SelectedValue);
        Repeater1.DataBind();

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <!-- Datatables -->

    <link href="../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- page content -->
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left" style="width: 100%">
                    <h3>Clock In / Out Record</h3>
                    <h3><small>打卡紀錄系統</small></h3>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Personal Clock In / Out Record <small>個人打卡紀錄</small></h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>

                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <%--年月DDL--%>
                            <div class="container">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="col-sm-2 text-right">
                                            <label class="col-form-label label-align" for="DDLYear">紀錄年份</label>
                                        </div>
                                        <div class="col-sm-2 text-center">
                                            <asp:DropDownList ID="DDLYear" runat="server" CssClass="form-control input-md" OnSelectedIndexChanged="DDLYear_SelectedIndexChanged" AutoPostBack="True" Style="padding: 3px 30px"></asp:DropDownList>
                                        </div>

                                        <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT [Note1] FROM [ClockInOutRecord]"></asp:SqlDataSource> DataSourceID="SqlDataSource1" DataTextField="Note1" DataValueField="Note1" --%>

                                        <div class="col-sm-2 text-right">
                                            <label class="col-form-label label-align" for="DDLYear">紀錄月份</label>
                                        </div>
                                        <div class="col-sm-2 text-center">
                                            <asp:DropDownList ID="DDLMonth" runat="server" CssClass="form-control input-md" OnSelectedIndexChanged="DDLMonth_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                                        </div>

                                        <%--<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT [Note2] FROM [ClockInOutRecord]"></asp:SqlDataSource>--%>

                                        <br />
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card-box table-responsive">
                                    <table id="datatable-buttons" class="table table-hover table-bordered" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th>打卡編號</th>
                                                <th>員工姓名</th>
                                                <th>日期</th>
                                                <th>上班時間</th>
                                                <th>下班時間</th>
                                                <th>審核</th>
                                                <th>修改者</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater ID="Repeater1" runat="server">
                                                <ItemTemplate>

                                                    <tr>
                                                        <td><%# Eval("CIORID") %></td>
                                                        <td><%# Eval("Note1") %></td>
                                                        <td><%# Eval("Date") %></td>
                                                        <td><%# Eval("ClockIn") %></td>
                                                        <td><%# Eval("ClockOut") %></td>
                                                        <td><%# Eval("Passed") %></td>
                                                        <td><%# Eval("ModifiedBy") %></td>
                                                    </tr>

                                                </ItemTemplate>

                                            </asp:Repeater>

                                        </tbody>
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

    <script src="Roger/Scrips/rogerTable.js"></script>
</asp:Content>
