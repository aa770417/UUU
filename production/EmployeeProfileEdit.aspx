<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            Employee empSession = (Employee)Session["Employee"];
            if (Session["Employee"] != null)
            {
                YenEmployee emp = EmployeeUtility.GetEmployeeByID(empSession.EmployeeID);

                personalImg.ImageUrl = "images/Personal/" + emp.ImageFileName;
                HiddenField1.Value = emp.ImageFileName;
                txtDepartment.Text = emp.DepartmentName + "部";
                txtAutho.Text = emp.AuthorizationLevel;
                txtLastName.Text = emp.LastName;
                txtFirstName.Text = emp.FirstName;
                txtBirthday.Text = emp.BirthDate;
                txtMobile.Text = emp.Mobile;
                txtAddress.Text = emp.Address;
                txtEmail.Text = emp.Email;
                txtPassWord.Text = emp.Password;
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        Employee empSession = (Employee)Session["Employee"];

        //1.先取得上傳圖片路徑與檔名
        if (FileUpload1.HasFile)//如果有上傳圖片，才執行
        {
            //FileUpload1.FileName取得上傳的檔名
            //FileUpload1.SaveAs將上傳的檔案儲存
            FileUpload1.SaveAs(Server.MapPath($"~/production/images/Personal/{FileUpload1.FileName}"));
        }

        YenEmployee em = new YenEmployee()
        {
            EmployeeID = Convert.ToInt32(empSession.EmployeeID),
            Password = txtPassWord.Text,
            BirthDate = txtBirthday.Text is "" ? null : txtBirthday.Text,
            Mobile = txtMobile.Text is "" ? null : txtMobile.Text,
            Address = txtAddress.Text is "" ? null : txtAddress.Text,
            ImageFileName = FileUpload1.HasFile ? FileUpload1.FileName : HiddenField1.Value
        };

        EmployeeUtility.UpdateInfo(em);
        Response.Redirect("~/production/EmployeeProfile.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                            <h2>個人資料編輯<small>Personal Profile Edit</small></h2>
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
                                        <asp:FileUpload ID="FileUpload1" runat="server" accept=".jpg,.png" />
                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                    </div>
                                </div>
                                <%--大頭照 end--%>
                                <%--部門 start--%>
                                <div class="item form-group row justify-content-center">
                                    <div class="col-md-3 col-sm-3 form-group ">
                                        <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control" disabled="disabled"></asp:TextBox>
                                    </div>
                                    <div class="col-md-3 col-sm-3 form-group">
                                        <asp:TextBox ID="txtAutho" CssClass="form-control" runat="server" disabled="disabled"></asp:TextBox>
                                    </div>
                                </div>
                                <%--部門 end--%>
                                <%--姓名 start--%>
                                <div class="item form-group row justify-content-center">
                                    <div class="field item col-md-3 col-sm-3 form-group has-feedback">
                                        <asp:TextBox ID="txtLastName" CssClass="form-control" runat="server" PlaceHolder="姓" disabled="disabled"></asp:TextBox>
                                    </div>
                                    <div class="field item col-md-3 col-sm-3 form-group has-feedback">
                                        <asp:TextBox ID="txtFirstName" CssClass="form-control" runat="server" PlaceHolder="名" disabled="disabled"></asp:TextBox>
                                    </div>
                                </div>
                                <%--姓名 end--%>
                                <%--帳號 start--%>
                                <div class="item form-group row justify-content-center">
                                    <div class="field item col-md-3 col-sm-3 form-group">                                       
                                        <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" required="required" PlaceHolder="帳號" disabled="disabled"></asp:TextBox>
                                    </div>
                                    <div class="field item col-md-3 col-sm-3 form-group">                                        
                                        <asp:TextBox ID="txtPassWord" CssClass="form-control" runat="server" required="required" PlaceHolder="密碼"></asp:TextBox>
                                    </div>
                                </div>
                                <%--帳號 end--%>
                                <div class="ln_solid"></div>
                                <%--生日 & 手機 start--%>
                                <div class="item form-group row justify-content-center">
                                    <div class="col-md-3 col-sm-3 form-group">
                                        <asp:TextBox ID="txtBirthday" class="date-picker form-control" placeholder="yyyy-mm-dd" name="date" type="text" required="required" onfocus="this.type='date'" onclick="this.type = 'date'" onblur="this.type='text'" onmouseout="timeFunctionLong(this)" runat="server"></asp:TextBox>
                                        <script>
                                            function timeFunctionLong(input) {
                                                setTimeout(function () {
                                                    input.type = 'text';
                                                }, 60000);
                                            }
                                        </script>
                                    </div>
                                    <div class="col-md-3 col-sm-3 form-group">
                                        <asp:TextBox ID="txtMobile" CssClass="form-control " runat="server" PlaceHolder="手機"></asp:TextBox>
                                    </div>
                                </div>
                                <%--生日 & 手機 end--%>
                                <%--地址 start--%>
                                <div class="item form-group row justify-content-center">
                                    <div class="col-md-6 col-sm-6 form-group has-feedback">
                                        <asp:TextBox ID="txtAddress" CssClass="form-control" runat="server" PlaceHolder="地址: ex.新北市板橋區中山路一段161號"></asp:TextBox>
                                    </div>
                                </div>
                                <%--地址 end--%>
                                <div class="ln_solid"></div>
                                <%--按鈕 start--%>
                                <div class="item form-group row justify-content-center">
                                    <div class="col-md-6 col-sm-6 offset-md-3">
                                        <asp:Button ID="btnSave" runat="server" Text="存檔" CssClass="btn btn-success" OnClick="btnSave_Click" />
                                        <a href="EmployeeProfile.aspx" type="button" class="btn btn-danger">返回</a>
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
</asp:Content>

