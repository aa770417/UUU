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
            DepartmentID.Value = emp.DepartmentID.ToString();


            //下拉選單生成
            DDLDE.DataSource = HRUtility.GetDepartmentNameByDID(emp.DepartmentID);
            DDLDE.DataTextField = "Value";
            DDLDE.DataValueField = "Key";
            DDLDE.DataBind();
            DDLDE.SelectedIndex = 0;

            DDLYear.DataSource = HRUtility.GetYearFromCIORByDID(emp.DepartmentID);
            DDLYear.DataTextField = "Value";
            DDLYear.DataValueField = "Key";
            DDLYear.DataBind();
            DDLYear.SelectedIndex = 0;

            DDLMonth.DataSource = HRUtility.GetMonthFromCIORByDID(emp.DepartmentID);
            DDLMonth.DataTextField = "Value";
            DDLMonth.DataValueField = "Key";
            DDLMonth.DataBind();
            DDLMonth.SelectedIndex = 0;

            string now = DateTime.Now.ToShortDateString();
            DDLYear.SelectedValue = now.Substring(0, 4);
            DDLMonth.SelectedValue = now.Substring(5, 2);

            Repeater1.DataSource = HRUtility.GetDepartmentIDRecordWithTimeAndPerson(emp.DepartmentID, now.Substring(0, 4), now.Substring(5, 2), 0);
            Repeater1.DataBind();
        }
        
    }

    protected void DDLYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        //取得使用者
        Employee emp = (Employee)Session["Employee"];

        Repeater1.DataSource = HRUtility.GetDepartmentIDRecordWithTimeAndPerson(emp.DepartmentID, DDLYear.SelectedValue, DDLMonth.SelectedValue, int.Parse(DDLDE.SelectedValue));
        Repeater1.DataBind();
    }


    protected void DDLMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        //取得使用者
        Employee emp = (Employee)Session["Employee"];

        Repeater1.DataSource = HRUtility.GetDepartmentIDRecordWithTimeAndPerson(emp.DepartmentID, DDLYear.SelectedValue, DDLMonth.SelectedValue, int.Parse(DDLDE.SelectedValue));
        Repeater1.DataBind();

    }

    protected void DDLDE_SelectedIndexChanged(object sender, EventArgs e)
    {
        //取得使用者
        Employee emp = (Employee)Session["Employee"];

        Repeater1.DataSource = HRUtility.GetDepartmentIDRecordWithTimeAndPerson(emp.DepartmentID, DDLYear.SelectedValue, DDLMonth.SelectedValue, int.Parse(DDLDE.SelectedValue));
        Repeater1.DataBind();
    }

    protected void RecordModifyBtn_Click(object sender, EventArgs e)
    {
        //取得使用者
        Employee emp = (Employee)Session["Employee"];

        bool OK = HRUtility.ModifyClockInOutRecord(int.Parse(ModifyCIORID.Value), emp.EmployeeID, NewClockIn.Value, NewClockOut.Value);
        if (OK)
        {
            Repeater1.DataSource = HRUtility.GetDepartmentIDRecordWithTimeAndPerson(emp.DepartmentID, DDLYear.SelectedValue, DDLMonth.SelectedValue, int.Parse(DDLDE.SelectedValue));
            Repeater1.DataBind();

            Page.ClientScript.RegisterStartupScript(
            Page.GetType(),
            "MessageBox",
            "<script>$('#ModifyResultModal').modal('show')<" + "/script>");
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(
            Page.GetType(),
            "MessageBox",
            "<script>$('#ModifyResultModal1').modal('show')<" + "/script>");
        }
    }

    protected void BatchPass_Click(object sender, EventArgs e)
    {
        
        CheckBox checkbox = new CheckBox();                 //創建對象
        HiddenField id;                                     //創建對象
        for (int i = 0; i < Repeater1.Items.Count; i++)
        {
            checkbox = (CheckBox)Repeater1.Items[i].FindControl("CheckBox1");//取對象
            id = (HiddenField)Repeater1.Items[i].FindControl("HiddenField1");//取對象
            if (checkbox.Checked == true)                   //是否被選中
            {
                HRUtility.CIORSinglePassed(int.Parse(id.Value.ToString()));                   
            }
        }
        Employee emp = (Employee)Session["Employee"];
        Repeater1.DataSource = HRUtility.GetDepartmentIDRecordWithTimeAndPerson(emp.DepartmentID, DDLYear.SelectedValue, DDLMonth.SelectedValue, int.Parse(DDLDE.SelectedValue));
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

    <asp:HiddenField ID="DepartmentID" runat="server"></asp:HiddenField>


    <!-- page content -->
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left" style="width: 100%">
                    <h3>Clock In / Out Record Management </h3>
                    <h3><small>打卡紀錄管理系統</small></h3>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Clock In / Out Record By Department <small>部門打卡紀錄</small></h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <%--指定人年月DDL--%>
                            <div class="container">
                                <div class="row">
                                    <%--<div class="form-group row"></div>--%>

                                    <div class="col-12">
                                        <div class="col-sm-2 text-right">
                                            <label class="col-form-label label-align" for="DDLYear">紀錄年份</label>
                                        </div>
                                        <div class="col-sm-2 text-center">
                                            <asp:DropDownList ID="DDLYear" runat="server" CssClass="form-control input-md" OnSelectedIndexChanged="DDLYear_SelectedIndexChanged" AutoPostBack="True" Style="padding: 3px 30px"></asp:DropDownList>
                                        </div>

                                        <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT [Note1] FROM [ClockInOutRecord]"></asp:SqlDataSource> DataSourceID="SqlDataSource1" DataTextField="Note1" DataValueField="Note1" --%>

                                        <div class="col-sm-2 text-right">
                                            <label class="col-form-label label-align" for="DDLYear">月份</label>
                                        </div>
                                        <div class="col-sm-2 text-center">
                                            <asp:DropDownList ID="DDLMonth" runat="server" CssClass="form-control input-md" OnSelectedIndexChanged="DDLMonth_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                                        </div>

                                        <%--<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT [Note2] FROM [ClockInOutRecord]"></asp:SqlDataSource>--%>

                                        <div class="col-sm-2 text-right">
                                            <label class="col-form-label label-align" for="DDLDE">員工姓名</label>
                                        </div>
                                        <div class="col-sm-2 text-center">
                                            <asp:DropDownList ID="DDLDE" runat="server" CssClass="form-control input-md" OnSelectedIndexChanged="DDLDE_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </div>

                                        <%--<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT [EmployeeID], [FirstName] FROM [Employee] WHERE ([DepartmentID] = @DepartmentID)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="DepartmentID" Name="DepartmentID" PropertyName="Value" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>--%>

                                        <br />
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card-box table-responsive">
                                    <%--<table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">--%>
                                    <table id="datatable-buttons" class="table table-hover table-bordered" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th>打卡編號</th>
                                                <th>員工姓名</th>
                                                <th>日期</th>
                                                <th>上班時間</th>
                                                <th>下班時間</th>
                                                <th>審核</th>
                                                <th>修改者</th>
                                                <th></th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater ID="Repeater1" runat="server">
                                                <ItemTemplate>

                                                    <tr>
                                                        <td>
                                                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("CIORID") %>' />
                                                            <asp:CheckBox ID="CheckBox1" runat="server" /></td>
                                                        <td><%# Eval("CIORID") %></td>
                                                        <td><%# Eval("Note1") %></td>
                                                        <td><%# Eval("Date") %></td>
                                                        <td><%# Eval("ClockIn") %></td>
                                                        <td><%# Eval("ClockOut") %></td>
                                                        <td><%# Eval("Passed") %></td>
                                                        <td><%# Eval("ModifiedBy") %></td>
                                                        <td>
                                                            <input id="btnpass" type="button" value="Pass" onclick="SinglePass(<%# Eval("CIORID") %>);" <%# (Eval("Passed").ToString() == "通過" || Eval("ModifiedBy")!=null) ? "hidden='hidden'" : "" %> />
                                                        </td>
                                                        <td>
                                                            <input id="btnModify" type="button" value="Modify" onclick="CIORModified(<%# Eval("CIORID") %>);" data-toggle="modal" data-target="#CIORModifyModal" />
                                                        </td>
                                                    </tr>

                                                </ItemTemplate>

                                            </asp:Repeater>

                                        </tbody>
                                    </table>
                                    <hr />
                                    <asp:Button ID="BatchPass" runat="server" Text="批量審核" OnClick="BatchPass_Click" />

                                    <!-- Modal -->
                                    <div class="modal fade" id="CIORModifyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="CIORModifyModalTitle">打卡記錄修改</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">

                                                    <input id="ModifyCIORID" type="hidden" runat="server" />
                                                    員工姓名:<input id="ModifyName" type="text" readonly="readonly" /><br>
                                                    打卡日期:<input id="ModifyDate" type="text" readonly="readonly" /><hr>
                                                    原上班時間:<input id="ModifyClockIn" type="text" readonly="readonly" /><br>
                                                    修改下班時間:<input id="NewClockIn" type="text" runat="server" /><hr>
                                                    原下班時間:<input id="ModifyClockOut" type="text" readonly="readonly" /><br>
                                                    修改下班時間:<input id="NewClockOut" type="text" runat="server" />

                                                </div>
                                                <div class="modal-footer">
                                                    <%--<input id="RecordModifyBtn" type="button" value="修改" class="btn btn-outline-danger" data-dismiss="modal" runat="server"/>--%>
                                                    <asp:Button ID="RecordModifyBtn" runat="server" Text="修改" OnClick="RecordModifyBtn_Click" CssClass="btn btn-outline-danger" />
                                                    <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">取消</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Modal -->
                                    <div class="modal fade" id="ModifyResultModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="ModifyResultModalTitle">打卡記錄修改</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    修改成功
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">確認</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Modal -->
                                    <div class="modal fade" id="ModifyResultModal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="ModifyResultModal1Title">打卡記錄修改</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <span style="color: red;">修改失敗，請檢查輸入格式及請假紀錄或聯繫管理人員</span>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-outline-danger" data-dismiss="modal">確認</button>
                                                </div>
                                            </div>
                                        </div>
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
    <script>         
        function SinglePass(ciorId) {
            window.location.href = 'RogerCIORSinglePass.aspx?ciorId=' + ciorId;
        }
        function CIORModified(ciorId) {
            var A = String(ciorId);
            $.ajax({
                type: 'POST',
                url: '/production/HRWebService.asmx/GetClockInOutRecord',
                data: JSON.stringify({ CIORID: A }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $("#ContentPlaceHolder1_ModifyCIORID").val(data.d.CIORID);
                    $("#ModifyName").val(data.d.Note1);
                    $("#ModifyDate").val(data.d.Date);
                    $("#ModifyClockIn").val(data.d.ClockIn);
                    $("#ContentPlaceHolder1_NewClockIn").val(data.d.ClockIn);
                    $("#ModifyClockOut").val(data.d.ClockOut);
                    $("#ContentPlaceHolder1_NewClockOut").val(data.d.ClockOut);
                },
                error: function (err) {
                    alert(err);
                }
            });
        }
        //function launchModal() {$("#ModifyResultModal").modal('show')}
        //function launchModal1() {
        //    $("#ModifyResultModal1").modal('show')
        //}

    </script>





</asp:Content>

