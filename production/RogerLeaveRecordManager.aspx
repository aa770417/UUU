<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

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

            if (emp.AuthorizationLevel == "Employee")
            {
                //導向權限不足
                Response.Redirect("~/production/PermissionDenied.aspx");
            }

            //HRCEID.Value = EmployeeSession[0];
            //HiddenField1.Value= EmployeeSession[0];
            //HRCEName.Value = HRUtility.GetLastName(int.Parse(EmployeeSession[0])) + EmployeeSession[1];
            //DepartmentID.Value = EmployeeSession[2];

            DDLDE.DataSource = HRUtility.GetDepartmentNameByDID(emp.DepartmentID);
            DDLDE.DataTextField = "Value";
            DDLDE.DataValueField = "Key";
            DDLDE.DataBind();
            DDLDE.SelectedIndex = 0;

            DDLYear.DataSource = HRUtility.GetYearFromLeaveByDID(emp.DepartmentID);
            DDLYear.DataTextField = "Value";
            DDLYear.DataValueField = "Key";
            DDLYear.DataBind();
            DDLYear.SelectedIndex = 0;

            DDLMonth.DataSource = HRUtility.GetMonthFromLeaveByDID(emp.DepartmentID);
            DDLMonth.DataTextField = "Value";
            DDLMonth.DataValueField = "Key";
            DDLMonth.DataBind();
            DDLMonth.SelectedIndex = 0;


            string now = DateTime.Now.ToShortDateString();
            DDLYear.SelectedValue = now.Substring(0, 4);
            DDLMonth.SelectedValue = now.Substring(5, 2);

            Repeater1.DataSource = HRUtility.GetDepartmentLeaveRecordWithTime(emp.DepartmentID, now.Substring(0, 4), now.Substring(5, 2), 0);
            Repeater1.DataBind();

        }



    }

    protected void DDLYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        Employee emp = (Employee)Session["Employee"];

        Repeater1.DataSource = HRUtility.GetDepartmentLeaveRecordWithTime(emp.DepartmentID, DDLYear.SelectedValue, DDLMonth.SelectedValue, int.Parse(DDLDE.SelectedValue));
        Repeater1.DataBind();
    }


    protected void DDLMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        Employee emp = (Employee)Session["Employee"];

        Repeater1.DataSource = HRUtility.GetDepartmentLeaveRecordWithTime(emp.DepartmentID, DDLYear.SelectedValue, DDLMonth.SelectedValue, int.Parse(DDLDE.SelectedValue));
        Repeater1.DataBind();

    }

    protected void DDLDE_SelectedIndexChanged(object sender, EventArgs e)
    {

        Employee emp = (Employee)Session["Employee"];

        Repeater1.DataSource = HRUtility.GetDepartmentLeaveRecordWithTime(emp.DepartmentID, DDLYear.SelectedValue, DDLMonth.SelectedValue, int.Parse(DDLDE.SelectedValue));
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
                    <h3>Leave Record Management</h3>
                    <h3><small>請假紀錄管理系統</small></h3>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Department Leave Record <small>部門請假紀錄</small></h2>
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

                                        <div class="col-sm-2 text-right">
                                            <label class="col-form-label label-align" for="DDLYear">紀錄月份</label>
                                        </div>
                                        <div class="col-sm-2 text-center">
                                            <asp:DropDownList ID="DDLMonth" runat="server" CssClass="form-control input-md" OnSelectedIndexChanged="DDLMonth_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                                        </div>

                                        <div class="col-sm-2 text-right">
                                            <label class="col-form-label label-align" for="DDLDE">員工姓名</label>
                                        </div>
                                        <div class="col-sm-2 text-center">
                                            <asp:DropDownList ID="DDLDE" runat="server" CssClass="form-control input-md" OnSelectedIndexChanged="DDLDE_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </div>

                                        <br />
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="card-box table-responsive">
                                        <table id="datatable-buttons" class="table table-hover table-bordered" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <th>假單編號</th>
                                                    <th>員工姓名</th>
                                                    <th>假別</th>
                                                    <th>日期</th>
                                                    <th>時數</th>
                                                    <th>審核</th>
                                                    <th>退件者</th>
                                                    <th>明細</th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="Repeater1" runat="server">
                                                    <ItemTemplate>

                                                        <tr>
                                                            <td><%# Eval("LeaveID") %></td>
                                                            <td><%# Eval("Note2") %></td>
                                                            <td><%# Eval("TypeOfLeave") %></td>
                                                            <td><%# Eval("Date") %></td>
                                                            <td><%# Eval("Hour") %></td>
                                                            <td><%# Eval("Passed") %></td>
                                                            <td><%# Eval("ModifiedBy") %></td>
                                                            <td><a href="<%# Eval("LeaveID","RogerLeaveDetail.aspx?LeaveId={0}") %>">
                                                                <input id="Button1" type="button" value="檢視" /></a></td>
                                                        </tr>

                                                    </ItemTemplate>

                                                </asp:Repeater>

                                            </tbody>
                                        </table>

                                        <a href="RogerLeaveAddManager.aspx">
                                            <input id="Button1" type="button" value="代請假" runat="server" /></a>
                                    </div>
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

