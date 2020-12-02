<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            DropDownDept.DataSource = SqlDataSource1;
            DropDownDept.DataValueField = "DepartmentID";
            DropDownDept.DataTextField = "DepartmentName";
            DropDownDept.DataBind();

            //取得參數
            string id = Request.QueryString["id"];

            YenEmployee emp = EmployeeUtility.GetEmployeeByID(Int32.Parse(id));
            //取得資料後填入textbox
            txtLastName.Text = emp.LastName;
            txtFirstName.Text = emp.FirstName;
            txtUserName.Text = emp.Email;
            txtPassWord.Text = emp.Password;
            if (emp.Gender == "M")
                labelMale.CssClass = "btn btn-outline-danger focus active";
            else
                labelFemale.CssClass = "btn btn-outline-primary focus active";
            this.DropDownDept.Items.FindByValue(emp.DepartmentID.ToString()).Selected = true;
            this.DropDownAuth.Items.FindByValue(emp.AuthorizationLevel).Selected = true;
            //只要不是CEO，就看不到授權等級3
            if (emp.AuthorizationLevel != "Boss")
            {
                DropDownAuth.Items.FindByValue("Boss").Enabled = false;
            }
            txtSalary.Text = emp.Salary.ToString("#,0");
            txtServiceYear.Text = emp.ServiceYear + " 年";
            txtHiredDate.Text = "入職:" + emp.HiredDate;
            txtResignedDate.Text = emp.ResignedDate;
            hiddenResigned.Value = emp.ResignedDate;
            txtBirthDay.Text = emp.BirthDate is null ? "" : "生日: " + emp.BirthDate;
            txtAge.Text = emp.Age is null ? "年齡" : emp.Age + " 歲";
            personalImg.ImageUrl = "images/Personal/" + emp.ImageFileName;
            txtAddress.Text = emp.Address;
            txtMobile.Text = emp.Mobile;
        }
    }

    protected void DropDownDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownDept.Items[0].Enabled = false;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        YenEmployee em = new YenEmployee()
        {
            EmployeeID = Int32.Parse(Request.QueryString["id"]),
            //Email = txtUserName.Text,
            Password = txtPassWord.Text,
            LastName = txtLastName.Text,
            FirstName = txtFirstName.Text,
            Gender = this.btnMale.Checked == true ? "M" : "F",
            DepartmentID = Int32.Parse(DropDownDept.SelectedItem.Value),
            DepartmentName = DropDownDept.SelectedItem.Text,
            AuthorizationLevel = DropDownAuth.SelectedValue,
            Salary = Convert.ToInt32(txtSalary.Text.Replace(",", "")),
            ResignedDate = txtResignedDate.Text is "" ? null : txtResignedDate.Text,
            Mobile = txtMobile.Text is "" ? null : txtMobile.Text,
            Address = txtAddress.Text is "" ? null : txtAddress.Text
        };

        EmployeeUtility.UpdateEmployeeByID(em);
        Response.Redirect("~/production/EmployeeList.aspx");

    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- bootstrap-wysiwyg -->
    <link href="../vendors/google-code-prettify/bin/prettify.min.css" rel="stylesheet">
    <!-- Select2 -->
    <link href="../vendors/select2/dist/css/select2.min.css" rel="stylesheet">
    <!-- Switchery -->
    <link href="../vendors/switchery/dist/switchery.min.css" rel="stylesheet">
    <!-- starrr -->
    <link href="../vendors/starrr/dist/starrr.css" rel="stylesheet">
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
                            <h2>員工檔案編輯<small>Edit Employee Profile</small></h2>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <br />
                            <div id="demo-form2" class="form-horizontal form-label-left">
                                <%--大頭照 start--%>
                                <div class="item form-group row justify-content-center">
                                    <asp:Label ID="Label2" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align"></asp:Label>
                                    <div class="col-md-6 col-sm-6  form-group has-feedback">
                                        <asp:Image ID="personalImg" runat="server" onerror="this.src='images/user.png'" Width="220px" />
                                    </div>
                                </div>
                                <%--大頭照 end--%>
                                <%--姓名 start--%>
                                <div class="item form-group row justify-content-center">
                                    <div class="field item col-md-3 col-sm-3 form-group has-feedback">
                                        <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
                                        <asp:TextBox ID="txtLastName" CssClass="form-control has-feedback-left" runat="server" autofocus="autofocus" required="required" PlaceHolder="姓"></asp:TextBox>
                                    </div>
                                    <div class="field item col-md-3 col-sm-3 form-group has-feedback">
                                        <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
                                        <asp:TextBox ID="txtFirstName" CssClass="form-control has-feedback-left" runat="server" required="required" PlaceHolder="名"></asp:TextBox>
                                    </div>
                                </div>
                                <%--姓名 end--%>
                                <%--帳號 start--%>
                                <div class="item form-group row justify-content-center">
                                    <div class="field item col-md-3 col-sm-3 form-group has-feedback">
                                        <span class="fa fa-heart form-control-feedback left" aria-hidden="true"></span>
                                        <asp:TextBox ID="txtUserName" CssClass="form-control has-feedback-left" runat="server" required="required" PlaceHolder="帳號" disabled="disabled"></asp:TextBox>
                                    </div>
                                    <div class="field item col-md-3 col-sm-3 form-group has-feedback">
                                        <span class="fa fa-heart form-control-feedback left" aria-hidden="true"></span>
                                        <asp:TextBox ID="txtPassWord" CssClass="form-control has-feedback-left" runat="server" required="required" PlaceHolder="密碼"></asp:TextBox>
                                    </div>
                                </div>
                                <%--帳號 end--%>
                                <%--性別按鈕 start--%>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align"></label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <div class="btn-group" data-toggle="buttons">
                                            <asp:Label ID="labelMale" runat="server" CssClass="btn btn-outline-danger" data-toggle-class="btn-danger" data-toggle-passive-class="btn-default">
                                                <asp:RadioButton ID="btnMale" runat="server" CssClass="join-btn" Text="M" GroupName="gender" />
                                                男
                                            </asp:Label>
                                            <asp:Label ID="labelFemale" runat="server" CssClass="btn btn-outline-primary" data-toggle-class="btn-danger" data-toggle-passive-class="btn-default">
                                                <asp:RadioButton ID="btnFemale" runat="server" CssClass="join-btn" Text="F" GroupName="gender" />
                                                女												
                                            </asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <%--性別按鈕 end--%>
                                <%--部門 & 授權 start--%>
                                <div class="item form-group row justify-content-center">
                                    <div class="col-md-3 col-sm-3 form-group ">
                                        <asp:DropDownList ID="DropDownDept" runat="server" CssClass="form-control" AppendDataBoundItems="False" OnSelectedIndexChanged="DropDownDept_SelectedIndexChanged" AutoPostBack="False">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DB %>" SelectCommand="SELECT DISTINCT [DepartmentID], [DepartmentName] FROM [Employee] ORDER BY [DepartmentID]"></asp:SqlDataSource>
                                    </div>
                                    <div class="col-md-3 col-sm-3 form-group">
                                        <asp:DropDownList ID="DropDownAuth" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="None">授權等級 : 0</asp:ListItem>
                                            <asp:ListItem Value="Employee">授權等級 : 1</asp:ListItem>
                                            <asp:ListItem Value="Manager">授權等級 : 2</asp:ListItem>
                                            <asp:ListItem Value="Boss" id="boss">授權等級 : 3</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <%--部門 & 授權 end--%>
                                <%--薪資 & 年資 start--%>
                                <div class="item form-group row justify-content-center">
                                    <div class="field item col-md-3 col-sm-3 form-group has-feedback">
                                        <span class="fa fa-dollar form-control-feedback left" aria-hidden="true"></span>
                                        <asp:TextBox ID="txtSalary" CssClass="form-control has-feedback-left" runat="server" PlaceHolder="薪資" Text="number" required="required"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 col-sm-3 form-group has-feedback">
                                        <span class="fa fa-dollar form-control-feedback left" aria-hidden="true"></span>
                                        <asp:TextBox ID="txtServiceYear" CssClass="form-control has-feedback-left" runat="server" PlaceHolder="年資" disabled="disabled"></asp:TextBox>
                                    </div>
                                </div>
                                <%--薪資 & 年資 end--%>
                                <%--入職日 & 離職日 start--%>
                                <div class="item form-group row justify-content-center">
                                    <div class="col-md-3 col-sm-3 ">
                                        <asp:TextBox ID="txtHiredDate" CssClass="date-picker form-control" placeholder="入職日:yyyy-mm-dd" type="text" required="required" onfocus="this.type='date'" onclick="this.type = 'date'" onblur="this.type='text'" onmouseout="timeFunctionLong(this)" runat="server" disabled="disabled"></asp:TextBox>
                                        <script>
                                            function timeFunctionLong(input) {
                                                setTimeout(function () {
                                                    input.type = 'text';
                                                }, 60000);
                                            }
                                        </script>
                                    </div>
                                    <div class="col-md-3 col-sm-3 ">
                                        <asp:TextBox ID="txtResignedDate" CssClass="date-picker form-control" placeholder="離職: yyyy-mm-dd" type="text" onfocus="this.type='date'" onclick="this.type = 'date'" onblur="this.type='text'" onmouseout="timeFunctionLong(this)" runat="server"></asp:TextBox>
                                        <script>
                                            function timeFunctionLong(input) {
                                                setTimeout(function () {
                                                    input.type = 'text';
                                                }, 60000);
                                            }
                                        </script>
                                    </div>
                                    <asp:HiddenField ID="hiddenResigned" runat="server" />
                                </div>
                                <%--入職日 & 離職日 end--%>
                                <div class="ln_solid"></div>
                                <%--生日 & 年齡 start--%>
                                <div class="item form-group row justify-content-center">
                                    <div class="col-md-3 col-sm-3 form-group ">
                                        <asp:TextBox ID="txtBirthDay" runat="server" CssClass="form-control" disabled="disabled"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 col-sm-3 form-group has-feedback">
                                        <span class="fa fa-question form-control-feedback left" aria-hidden="true"></span>
                                        <asp:TextBox ID="txtAge" CssClass="form-control has-feedback-left" runat="server" PlaceHolder="年齡" disabled="disabled"></asp:TextBox>
                                    </div>
                                </div>
                                <%--生日 & 年齡 end--%>
                                <%--通訊 start--%>
                                <div class="item form-group row justify-content-center">
                                    <div class="col-md-3 col-sm-3 form-group has-feedback">
                                        <span class="fa fa-phone form-control-feedback left" aria-hidden="true"></span>
                                        <asp:TextBox ID="txtMobile" CssClass="form-control has-feedback-left" runat="server" PlaceHolder="手機"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 col-sm-3 form-group has-feedback">
                                    </div>
                                </div>
                                <div class="item form-group row justify-content-center">
                                    <div class="col-md-6 col-sm-6 form-group has-feedback">
                                        <span class="fa fa-home form-control-feedback left" aria-hidden="true"></span>
                                        <asp:TextBox ID="txtAddress" CssClass="form-control has-feedback-left" runat="server" PlaceHolder="地址: ex.新北市板橋區中山路一段161號"></asp:TextBox>
                                    </div>
                                </div>
                                <%--通訊 end--%>
                                <div class="ln_solid"></div>
                                <%--按鈕 start--%>
                                <div class="item form-group row justify-content-center">
                                    <div class="col-md-6 col-sm-6 offset-md-3">
                                        <asp:Button ID="btnSubmit" runat="server" class="btn btn-primary" Text="修改" OnClick="btnSubmit_Click" />
                                        <a href="EmployeeList.aspx" type="button" class="btn btn-danger">取消</a>
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
    <!-- sweetalert2 -->
    <script src="Scripts/sweetalert2.min.js"></script>

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

