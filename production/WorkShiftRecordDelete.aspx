<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            string id = Request.QueryString["id"];

            WorkShiftRecord wsr = PeterHsuUtilities.GetWorkShiftRecordById(int.Parse(id));
            Employee emp = PeterHsuUtilities.GetEmployeeByEmpID(wsr.EmployeeID);

            txtWorkShiftRecordId.Text = wsr.WorkShiftRecordId.ToString();
            txtEmpID.Text = wsr.EmployeeID.ToString();
            txtEmpLastName.Text = emp.LastName;
            txtEmpFirstName.Text = emp.FirstName;
            txtWorkDate.Text = wsr.WorkDate.ToShortDateString();
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        WorkShiftRecord wsRecord = new WorkShiftRecord()
        {
            WorkShiftRecordId = Convert.ToInt32(txtWorkShiftRecordId.Text)
        };
        bool deleteOk = PeterHsuUtilities.DeleteWorkShiftRecord(wsRecord);

        if (deleteOk == true)
        {
            this.ClientScript.RegisterClientScriptBlock(this.GetType(), "Close",
                "alert('刪除成功'); if (window.parent == window.top) " +
                "{window.parent.location.reload();  " +
                "window.parent.$.magnificPopup.close(); }", true);
        }
        else
        {
            this.ClientScript.RegisterClientScriptBlock(this.GetType(), "Close", "alert('刪除失敗');", true);
        }
    }


</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />


    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet" />
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet" />
    <!-- bootstrap-wysiwyg -->
    <link href="../vendors/google-code-prettify/bin/prettify.min.css" rel="stylesheet" />
    <!-- Select2 -->
    <link href="../vendors/select2/dist/css/select2.min.css" rel="stylesheet" />
    <!-- Switchery -->
    <link href="../vendors/switchery/dist/switchery.min.css" rel="stylesheet" />
    <!-- starrr -->
    <link href="../vendors/starrr/dist/starrr.css" rel="stylesheet" />
    <!-- bootstrap-daterangepicker -->
    <link href="../vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" />

    <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet" />

</head>
<body class="nav-md">
    <div class="container body">
        <div class="main_container">
            <div class="row">
                <div class="col-sm-12 col-md-12  col-lg-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>排班資料刪除</h2>
                            <%--<ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <a class="dropdown-item" href="#">Settings 1</a>
                                        <a class="dropdown-item" href="#">Settings 2</a>
                                    </div>
                                </li>
                                <li><a class="close-link"><i class="fa fa-close"></i></a>
                                </li>
                            </ul>--%>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <br />
                            <form class="form-label-left input_mask" runat="server">
                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 text-right">
                                        資料編號
                                    </label>
                                    <div class="col-md-6 col-sm-6  form-group has-feedback">
                                        <asp:TextBox ID="txtWorkShiftRecordId" runat="server" Enabled="False" ReadOnly="True"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 text-right">
                                        員工編號
                                    </label>
                                    <div class="col-md-6 col-sm-6  form-group has-feedback">
                                        <asp:TextBox ID="txtEmpID" runat="server" Enabled="False" ReadOnly="True"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 text-right">
                                        員工姓氏
                                    </label>
                                    <div class="col-md-6 col-sm-6  form-group has-feedback">
                                        <asp:TextBox ID="txtEmpLastName" runat="server" Enabled="False" ReadOnly="True"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 text-right">
                                        員工名字
                                    </label>
                                    <div class="col-md-6 col-sm-6  form-group has-feedback">
                                        <asp:TextBox ID="txtEmpFirstName" runat="server" Enabled="False" ReadOnly="True"></asp:TextBox>
                                    </div>
                                </div>


                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 text-right">
                                        工作日 
                                        <%--<span class="required">*</span>--%>
                                    </label>
                                    <div class="col-md-6 col-sm-6  form-group has-feedback">
                                        <asp:TextBox ID="txtWorkDate" runat="server" Enabled="False" ReadOnly="True"></asp:TextBox>
                                        <%--<input id="txtWorkDate" class="date-picker form-control" required="required" type="text" onfocus="this.type='date'" onmouseover="this.type='date'" onclick="this.type = 'date'" onblur="this.type='text'" onmouseout="timeFunctionLong(this)" runat="server" />--%>
                                        <%--<script>
                                            function timeFunctionLong(input) {
                                                setTimeout(function () {
                                                    input.type = 'text';
                                                }, 60000);
                                            }
                                        </script>--%>
                                    </div>
                                </div>
                                <div class="ln_solid"></div>
                                <div class="form-group row">
                                    <div class="col-md-9 col-sm-9  offset-md-3">
                                        <%--<button type="button" class="btn btn-primary">Cancel</button>
                                        <button class="btn btn-primary" type="reset">Reset</button>--%>
                                        <%--                                        <button id="btnEdit" type="submit" class="btn btn-success" runat="server">修改資料</button>--%>
                                        <asp:Button ID="btnDelete" CssClass="btn btn-danger" runat="server" Text="刪除" OnClick="btnDelete_Click" />
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <!-- FastClick -->
    <script src="../vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../vendors/nprogress/nprogress.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="../vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- iCheck -->
    <script src="../vendors/iCheck/icheck.min.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="../vendors/moment/min/moment.min.js"></script>
    <script src="../vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    <!-- bootstrap-wysiwyg -->
    <script src="../vendors/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js"></script>
    <script src="../vendors/jquery.hotkeys/jquery.hotkeys.js"></script>
    <script src="../vendors/google-code-prettify/src/prettify.js"></script>
    <!-- jQuery Tags Input -->
    <script src="../vendors/jquery.tagsinput/src/jquery.tagsinput.js"></script>
    <!-- Switchery -->
    <script src="../vendors/switchery/dist/switchery.min.js"></script>
    <!-- Select2 -->
    <script src="../vendors/select2/dist/js/select2.full.min.js"></script>
    <!-- Parsley -->
    <script src="../vendors/parsleyjs/dist/parsley.min.js"></script>
    <!-- Autosize -->
    <script src="../vendors/autosize/dist/autosize.min.js"></script>
    <!-- jQuery autocomplete -->
    <script src="../vendors/devbridge-autocomplete/dist/jquery.autocomplete.min.js"></script>
    <!-- starrr -->
    <script src="../vendors/starrr/dist/starrr.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>
</body>
</html>
