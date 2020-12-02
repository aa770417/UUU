<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        labelFemale.CssClass = "btn btn-outline-primary focus active";
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            YenEmployee em = new YenEmployee()
            {
                Email = txtUserName.Text + Label2.Text,
                Password = txtPassWord.Text,
                LastName = txtLastName.Text,
                FirstName = txtFirstName.Text,
                Gender = this.btnMale.Checked == true ? "M" : "F",
                DepartmentID = DropDownDept.SelectedItem.Selected ? Convert.ToInt32(DropDownDept.SelectedValue) : 1,
                DepartmentName = DropDownDept.SelectedItem.Text,
                Salary = Convert.ToInt32(txtSalary.Text),
                HiredDate = txtHiredate.Text == "" ? "1990-01-01" : txtHiredate.Text,
                //HireStatus = (DateTime.Now > DateTime.Parse(txtHiredate.Text)) == true ? "在職" : "未到職",
                AuthorizationLevel = DropDownAuth.SelectedValue
            };

            EmployeeUtility.InsertEmployee(em);
            Response.Redirect("~/production/EmployeeList.aspx");
        }
    }

    protected void Demo_Click(object sender, EventArgs e)
    {
        txtLastName.Text = "吳";
        txtFirstName.Text = "玉英";
        txtUserName.Text = "hahaha";
        txtHiredate.Text = "2020-05-20";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- bootstrap-wysiwyg -->
    <%--<link href="../vendors/google-code-prettify/bin/prettify.min.css" rel="stylesheet">--%>
    <!-- Select2 -->
    <link href="../vendors/select2/dist/css/select2.min.css" rel="stylesheet">
    <!-- Switchery -->
    <link href="../vendors/switchery/dist/switchery.min.css" rel="stylesheet">
    <!-- starrr -->
    <link href="../vendors/starrr/dist/starrr.css" rel="stylesheet">
    <!-- sweetalert2 -->
    <link href="Scripts/sweetalert2.min.css" rel="stylesheet" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- page content -->
    <div class="right_col" role="main">
        <div class="">
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>新增員工帳戶資料<small>Add New Employee</small></h2>

                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <br />
                            <div id="demo-form2" <%--data-parsley-validate--%> class="form-horizontal form-label-left">
                                <div class="field item form-group">
                                    <asp:Label ID="Label1" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="姓:" AssociatedControlID="txtLastName"></asp:Label>
                                    <div class="col-md-6 col-sm-6 form-group has-feedback">
                                        <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
                                        <asp:TextBox ID="txtLastName" CssClass="form-control has-feedback-left" runat="server" autofocus="autofocus" required="required" name="name" data-validate-length-range="6" data-validate-words="1"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="欄位不可空白" ControlToValidate="txtLastName" Visible="True" Display="None"></asp:RequiredFieldValidator>
                                </div>
                                <div class="field item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align">名:</label>
                                    <div class="col-md-6 col-sm-6 form-group has-feedback">
                                        <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
                                        <asp:TextBox ID="txtFirstName" CssClass="form-control has-feedback-left" runat="server" required="required" name="name" data-validate-length-range="6" data-validate-words="1"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="欄位不可空白" ControlToValidate="txtFirstName" Display="None"></asp:RequiredFieldValidator>
                                </div>
                                <%--性別按鈕 start--%>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align">性別:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <div class="btn-group" data-toggle="buttons">
                                            <label class="btn btn-outline-danger" data-toggle-class="btn-danger" data-toggle-passive-class="btn-default" aria-checked="true">
                                                <asp:RadioButton ID="btnMale" runat="server" CssClass="join-btn" Text="M" GroupName="gender" />
                                                男
                                            </label>
                                            <asp:Label ID="labelFemale" runat="server" CssClass="btn btn-outline-primary" data-toggle-class="btn-danger" data-toggle-passive-class="btn-default">
                                                <asp:RadioButton ID="btnFemale" runat="server" CssClass="join-btn" Text="F" GroupName="gender" />
                                                女												
                                            </asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <%--性別按鈕 end--%>
                                <%--部門下拉 start--%>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align">部門:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:DropDownList ID="DropDownDept" runat="server" DataSourceID="SqlDataSource1" DataTextField="DepartmentName" DataValueField="DepartmentID" CssClass="form-control"></asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DB %>" SelectCommand="SELECT DISTINCT [DepartmentName], [DepartmentID] FROM [Employee] ORDER BY [DepartmentID]"></asp:SqlDataSource>
                                    </div>
                                </div>
                                <%--部門下拉 end--%>
                                <%--薪資 start--%>
                                <div class="field item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align">薪資:</label>
                                    <div class="col-md-6 col-sm-6 form-group has-feedback">
                                        <span class="fa fa-dollar form-control-feedback left" aria-hidden="true"></span>
                                        <asp:TextBox ID="txtSalary" CssClass="form-control has-feedback-left" runat="server" type="number" name="salary" data-validate-minmax="24000,1000000" required='required' Text="24000"></asp:TextBox>
                                    </div>
                                </div>
                                <%--薪資 end--%>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align">
                                        入職日:<span class="required"></span>
                                    </label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="txtHiredate" class="date-picker form-control" placeholder="yyyy-mm-dd" name="date" type="text" required="required" onfocus="this.type='date'" onclick="this.type = 'date'" onblur="this.type='text'" onmouseout="timeFunctionLong(this)" runat="server"></asp:TextBox>
                                        <script>
                                            function timeFunctionLong(input) {
                                                setTimeout(function () {
                                                    input.type = 'text';
                                                }, 60000);
                                            }
                                        </script>
                                    </div>
                                </div>
                                <%--帳號 start--%>
                                <div class="field item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align">帳號:</label>
                                    <div class="col-md-3 col-sm-3 form-group has-feedback">
                                        <span class="fa fa-heart form-control-feedback left" aria-hidden="true"></span>
                                        <asp:TextBox ID="txtUserName" CssClass="form-control has-feedback-left" runat="server" required="required" name="name" data-validate-length-range="6" data-validate-words="1"></asp:TextBox>
                                    </div>
                                    <div class="col-form-label label-align">
                                        <asp:Label ID="Label2" runat="server" Text="@uuu.com"></asp:Label>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="欄位不可空白" ControlToValidate="txtUserName" Display="None"></asp:RequiredFieldValidator>
                                </div>
                                <%--帳號 end--%>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align">密碼:</label>
                                    <div class="col-md-6 col-sm-6 form-group has-feedback">
                                        <span class="fa fa-heart form-control-feedback left" aria-hidden="true"></span>
                                        <asp:TextBox ID="txtPassWord" CssClass="form-control has-feedback-left" runat="server" disabled="disabled" Text="123"></asp:TextBox>
                                    </div>
                                </div>
                                <%--授權下拉 start--%>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align">授權等級:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:DropDownList ID="DropDownAuth" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="None">0</asp:ListItem>
                                            <asp:ListItem Value="Employee">1</asp:ListItem>
                                            <asp:ListItem Value="Manager">2</asp:ListItem>
                                            <asp:ListItem Value="Boss">3</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <%--授權下拉 end--%>
                                <div class="ln_solid"></div>
                                <%--按鈕 start--%>
                                <div class="item form-group">
                                    <div class="col-md-6 col-sm-6 offset-md-3">
                                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="新增" OnClick="btnSubmit_Click" />
                                        <a href="EmployeeList.aspx" type="button" class="btn btn-danger">取消</a>
                                        <asp:Button ID="Demo" runat="server" Text="我是Demo" CssClass="btn btn-warning " OnClick="Demo_Click" />
                                    </div>
                                </div>
                                <%--按鈕 end--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /page content -->

    <!--remind modal -->
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
                    你有欄位沒有填喔...填了再來！
                </div>
                <!-- Modal footer -->
                <div class="modal-footer ">
                    <asp:Button ID="btnRemind" runat="server" Text="好吧..." CssClass="btn btn-warning" data-dismiss="modal" />
                </div>
            </div>
        </div>
    </div>
    <!--remind modal -->

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">
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
    <!-- validation -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="../vendors/validator/multifield.js"></script>
    <script src="../vendors/validator/validator.js"></script>
    <script src="../src/js/YenJavaScript.js"></script>

    <script>
        // initialize a validator instance from the "FormValidator" constructor.
        // A "<form>" element is optionally passed as an argument, but is not a must
        var validator = new FormValidator({
            "events": ['blur', 'input', 'change']
        }, document.forms[0]);
        // on form "submit" event
        document.forms[0].onsubmit = function (e) {
            var submit = true,
                validatorResult = validator.checkAll(this);
            console.log(validatorResult);
            return !!validatorResult.valid;
        };
        // on form "reset" event
        document.forms[0].onreset = function (e) {
            validator.reset();
        };

    </script>
</asp:Content>

