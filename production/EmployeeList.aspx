<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<%@ Import Namespace="GemBox.Spreadsheet" %>

<script runat="server">
    //驗證，非人事部門則無法進入頁面，非主管級則無法使用移除授權與刪除
    protected void Page_Load(object sender, EventArgs e)
    {
        Employee empSession = (Employee)Session["Employee"];

        if (Session["Employee"] != null)
        {
            //如果不是人事部門，且不是主管以上，就不能進入頁面
            if (empSession.DepartmentID != 2 && empSession.AuthorizationLevel == "Employee")
            {
                Response.Redirect("~/production/PermissionDenied.aspx");
            }
            else
            {
                if (Page.IsPostBack == false)
                {
                    //如果是CEO或人事部門，看全部員工，不是就就只能看到自己部門的員工名單
                    if (empSession.AuthorizationLevel == "Boss" || empSession.DepartmentID == 2)
                    {
                        Repeater1.DataSource = EmployeeUtility.GetAllEmployees();
                        Repeater1.DataBind();
                        if (empSession.AuthorizationLevel == "Employee")
                        {
                            btnDelete.Visible = false;
                            btnRemove.Visible = false;
                            Label1.Visible = false;
                        }
                    }
                    else
                    {
                        //自己部門的員工
                        Repeater1.DataSource = EmployeeUtility.GetEmployeesByDepartmentID(empSession.DepartmentID);
                        Repeater1.DataBind();
                        //沒有按鈕可以使用
                        labelDept.Visible = false;
                        DropDownList1.Visible = false;
                        btnDelete.Visible = false;
                        btnRemove.Visible = false;
                        btnInsert.Visible = false;
                        btnOutPut.Visible = false;
                        Label1.Visible = false;
                    }
                }
            }

        }
        else if (Session["Employee"] == null)
        {
            Response.Redirect("~/production/Login.aspx");
        }


    }

    //下拉選單
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        int id = Convert.ToInt32(DropDownList1.SelectedValue);
        Repeater1.DataSource = EmployeeUtility.DropDownList(id);
        Repeater1.DataBind();
    }

    //刪除資料
    protected void btnDConfirm_Click(object sender, EventArgs e)
    {
        if (hiddenCheck.Value != "")
        {
            string phrase = hiddenCheck.Value.ToString();
            string[] idList = phrase.Split(',');
            foreach (var id in idList)
            {
                EmployeeUtility.DeleteEmployeeByID(Convert.ToInt32(id));
            }
            Response.Redirect("~/production/EmployeeDelete.aspx");
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "closepup", "$('#remindModal').modal('show');", true);
        }
    }

    //移除授權，將帳號變成""
    protected void btnRConfirm_Click(object sender, EventArgs e)
    {
        if (hiddenCheck.Value != "")
        {
            string phrase = hiddenCheck.Value.ToString();
            string[] idList = phrase.Split(',');
            foreach (var id in idList)
            {
                EmployeeUtility.RemoveAuthorizational(Convert.ToInt32(id));
            }
            Response.Redirect("~/production/EmployeeList.aspx");
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "closepup", "$('#remindModal').modal('show');", true);
        }
    }

    public string show(object o)
    {
        Employee empSession = (Employee)Session["Employee"];

        if ( empSession.AuthorizationLevel   == "Boss" || (empSession.DepartmentID == 2 && empSession.AuthorizationLevel == "Manager"))
        {
            return "";
        }
        return "display:none;";
    }

    protected void btnInsert_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/production/EmployeeAdd.aspx");
    }

    //輸出excel
    protected void btnOutPut_Click(object sender, EventArgs e)
    {
        SpreadsheetInfo.SetLicense("FREE-LIMITED-KEY");
        ExcelFile file = new ExcelFile();
        ExcelWorksheet worksheet = file.Worksheets.Add("sheet1");
        worksheet.Cells[0, 0].Value = "員工ID";
        worksheet.Cells[0, 1].Value = "姓名";
        worksheet.Cells[0, 2].Value = "部門";
        worksheet.Cells[0, 3].Value = "職級";
        worksheet.Cells[0, 4].Value = "入職日";
        worksheet.Cells[0, 5].Value = "離職日";
        worksheet.Cells[0, 6].Value = "月薪";
        worksheet.Cells[0, 7].Value = "年資";
        worksheet.Cells[0, 8].Value = "性別";
        worksheet.Cells[0, 9].Value = "年齡";


        List<YenEmployee> emplist = EmployeeUtility.PrintAllEmployees();
        for (int i = 1; i < emplist.Count; i++)
        {
            worksheet.Cells[i, 0].Value = emplist[i - 1].EmployeeID;
            worksheet.Cells[i, 1].Value = emplist[i - 1].LastName + emplist[i - 1].FirstName;
            worksheet.Cells[i, 2].Value = emplist[i - 1].DepartmentName;
            worksheet.Cells[i, 3].Value = emplist[i - 1].AuthorizationLevel;
            worksheet.Cells[i, 4].Value = emplist[i - 1].HiredDate;
            worksheet.Cells[i, 5].Value = emplist[i - 1].ResignedDate;
            worksheet.Cells[i, 6].Value = emplist[i - 1].Salary;
            worksheet.Cells[i, 7].Value = emplist[i - 1].ServiceYear;
            worksheet.Cells[i, 8].Value = emplist[i - 1].Gender;
            worksheet.Cells[i, 9].Value = emplist[i - 1].Age;

        }
        //會存到伺服器電腦
        //file.Save(Server.MapPath("~/production/Output/Employee.xlsx"));
        //讓使用者下載
        file.Save(Response, "AllEmployee.xlsx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- Bootstrap -->
    <link href="cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">

    <!-- Datatables -->
    <link href="../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
    <style>
        .table-responsive{
            overflow-x: unset;
        }

        .modal-content {
            align-items: center;
            font-size: 16px
        }

        .close {
            display: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- page content -->
    <div class="right_col" role="main">
        <div class="">
            <div class="clearfix"></div>

            <div class="row">
                <%--Table Start--%>
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>全體員工列表 <small>All Employee List</small></h2>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="card-box table-responsive">
                                        <%--部門下拉及新增 start--%>
                                        <div class="form-group row">
                                            <div class="col-md-1 col-sm-1 ">
                                                <asp:Label ID="labelDept" runat="server" Text="選擇部門:" CssClass="col-form-label control-label float-right"></asp:Label>
                                            </div>
                                            <div class="col-md-2 col-sm-2 ">
                                                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" AppendDataBoundItems="True" DataSourceID="SqlDataSource1" DataTextField="DepartmentName" DataValueField="DepartmentID" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
                                                    <asp:ListItem Value="0">---選擇部門---</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DB %>" SelectCommand="SELECT DISTINCT [DepartmentID], [DepartmentName] FROM [Employee] ORDER BY [DepartmentID]"></asp:SqlDataSource>
                                            </div>
                                            <div class="col-md-1 col-sm-1 ">
                                                <asp:Button ID="btnOutPut" runat="server" Text="Excel" CssClass="btn btn-dark" OnClick="btnOutPut_Click" />
                                            </div>
                                            <div class="col-form-label fa-hover col-md-8 col-sm-8">
                                                <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-danger float-right " Text="刪除" data-toggle="modal" data-target="#deleteModal" OnClientClick="return false" Visible="True" />
                                                <asp:Button ID="btnRemove" runat="server" CssClass="btn btn-warning float-right" Text="移除權限" data-toggle="modal" data-target="#removeModal" OnClientClick="return false" />
                                                <asp:Button ID="btnInsert" runat="server" CssClass="float-right btn btn-primary" Text="新增" OnClick="btnInsert_Click" />
                                            </div>
                                        </div>
                                        <%--部門下拉及新增 end--%>

                                        <table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" style="width: 100%">
                                            <asp:HiddenField ID="hiddenCheck" runat="server" />
                                            <thead>
                                                <tr>
                                                    <th>
                                                        <asp:CheckBox ID="checkAll" runat="server" onclick="checkAll() " /></th>
                                                    <th>員工ID</th>
                                                    <th>姓名</th>
                                                    <th>部門</th>
                                                    <th>職級</th>
                                                    <th>入職日</th>
                                                    <th>離職日</th>
                                                    <th>月薪</th>
                                                    <th>年資</th>
                                                    <th>性別</th>
                                                    <th>年齡</th>
                                                    <th>
                                                        <asp:Label ID="Label1" runat="server" Text="修改"></asp:Label></th>
                                                </tr>
                                            </thead>
                                            <asp:Repeater ID="Repeater1" runat="server">
                                                <HeaderTemplate>
                                                    <tbody>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="checkBox1" runat="server" title='<%# Eval("EmployeeID") %>' /></td>
                                                        <td><%# Eval("EmployeeID") %></td>
                                                        <td><%# Eval("LastName") %><%# Eval("FirstName") %></td>
                                                        <td><%# Eval("DepartmentName") %></td>
                                                        <td><%# Eval("AuthorizationLevel") %></td>
                                                        <td><%# Eval("HiredDate") %></td>
                                                        <td><%# Eval("ResignedDate") %></td>
                                                        <td><%# Eval("Salary") %></td>
                                                        <td><%# Eval("ServiceYear") %></td>
                                                        <td><%# Eval("Gender") %></td>
                                                        <td><%# Eval("Age") %></td>
                                                        <td><a style='<%# show(Eval("Age")) %>' href="EmployeeEdit.aspx?id=<%# Eval("EmployeeID") %>" class="btn btn-round btn-info"></a></td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </tbody>                                             
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%--Table End  --%>
            </div>
        </div>
    </div>
    <!-- /page content -->

    <!-- 刪除 modal -->
    <div class="modal" id="deleteModal">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">溫馨提醒</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    刪除...就像是狠心刪掉和前女友的美好回憶，一旦做了，就不能回頭了，你真的確定要刪除這些資料了嗎?
                </div>
                <!-- Modal footer -->
                <div class="modal-footer ">
                    <asp:Button ID="btnDConfirm" runat="server" Text="確定" CssClass="btn btn-info" OnClick="btnDConfirm_Click" />
                    <asp:Button ID="btnDCancel" runat="server" Text="取消" CssClass="btn btn-danger" data-dismiss="modal" OnClientClick="return false" />
                </div>
            </div>
        </div>
    </div>
    <!-- 刪除 modal -->

    <!--刪除 remind modal -->
    <div class="modal" id="remindModal">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">溫馨提醒</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    看來...你似乎並沒有選取任何一筆資料呢...等你準備好了再來吧！
                </div>
                <!-- Modal footer -->
                <div class="modal-footer ">
                    <asp:Button ID="btnRemind" runat="server" Text="好吧..." CssClass="btn btn-warning" data-dismiss="modal" />
                </div>
            </div>
        </div>
    </div>
    <!--刪除 remind modal -->

    <!-- 移除 modal -->
    <div class="modal" id="removeModal">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">溫馨提醒</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    批量移除權限後，要再修改權限只能在個人頁面進行喔，準備好了就按下按鈕吧！
                </div>
                <!-- Modal footer -->
                <div class="modal-footer ">
                    <asp:Button ID="btnRConfirm" runat="server" Text="確定移除" CssClass="btn btn-info" OnClick="btnRConfirm_Click" />
                    <asp:Button ID="btnRCancel" runat="server" Text="取消移除" CssClass="btn btn-danger" data-dismiss="modal" OnClientClick="return false" />
                </div>
            </div>
        </div>
    </div>
    <!-- 移除 modal -->


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
    <script src="../src/js/YenJavaScript.js"></script>

    <script>
        function checkAll() {
            $("#datatable-responsive input").each(function () {
                if ($(this).attr("name").indexOf("checkBox1") > 0) {
                    this.checked = event.srcElement.checked;
                }
            });
        }

        $(function () {
            $("#ContentPlaceHolder1_btnRemove").click(function () {
                var ary = [];
                $("#datatable-responsive input").each(function () {
                    if ($(this).attr("name").indexOf("checkBox1") > 0) {
                        if (this.checked) {
                            //把這欄位的上一層(parentNode)
                            ary.push($(this)[0].parentNode.title);
                        }
                    }
                });
                $("#ContentPlaceHolder1_hiddenCheck").val(ary);
            });
        });

        $(function () {
            $("#ContentPlaceHolder1_btnDelete").click(function () {
                var ary = [];
                $("#datatable-responsive input").each(function () {
                    if ($(this).attr("name").indexOf("checkBox1") > 0) {
                        if (this.checked) {
                            //把這欄位的上一層(parentNode)
                            ary.push($(this)[0].parentNode.title);
                        }
                    }
                });
                $("#ContentPlaceHolder1_hiddenCheck").val(ary);
            });
        });

    </script>
</asp:Content>

