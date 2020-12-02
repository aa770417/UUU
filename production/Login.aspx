<%@ Page Language="C#" %>

<%@ Import Namespace="System.Net.Mail" %>

<!DOCTYPE html>

<script runat="server">

    protected void btnSignIn_Click(object sender, EventArgs e)
    {
        //驗證員工帳號或密碼是否與資料庫相符
        Employee emp = PeterHsuUtilities.CheckEmployeeLogin(txtEMail.Text, txtPassword.Text);

        if (emp != null)
        {
            //string[] EmployeeSession = { emp.EmployeeID.ToString(), emp.FirstName, emp.DepartmentID.ToString(), emp.AuthorizationLevel };
            //Session["Employee"] = EmployeeSession;

            //login
            Session["Employee"] = emp;

            //Response.Redirect("~/production/WorkShiftScheduler2.aspx");
            Response.Redirect("~/production/Default.aspx");
          
        }
        else
        {
            //error
            Label1.Text = "帳號或密碼錯誤!";
        }
    }


    //亂數物件
    Random rnd = new Random(DateTime.Now.Millisecond);

    //smtp寄信要到下面網址把[Allow less secure apps]設定為ON
    //https://myaccount.google.com/lesssecureapps?pli=1

    protected void btnResetPW_Click(object sender, EventArgs e)
    {
        //檢查資料庫是否有此e-mail存在
        Employee emp = PeterHsuUtilities.CheckEmployeeEmail(txtEmail1.Text);

        if (emp != null)
        {
            //隨機生成8碼的password，e-mail發送
            string newPassword = PeterHsuUtilities.RenderNewPassword(rnd);

            emp.Password = newPassword;

            bool resetPasswordOk = PeterHsuUtilities.ResetEmployeePassword(emp);

            if (resetPasswordOk == true)
            {
                MailMessage msg = new MailMessage();

                msg.To.Add("uuu9045finalproject2@gmail.com");

                msg.From = new MailAddress("uuu9045finalproject1@gmail.com",
                    "IT管理員", System.Text.Encoding.UTF8);

                msg.Subject = "UUU海運 密碼重設";
                //指定Subject的編碼  
                msg.SubjectEncoding = System.Text.Encoding.UTF8;

                msg.Body = $"<h1>親愛的，您的新密碼為： {newPassword}</h1>";
                msg.IsBodyHtml = true;
                msg.BodyEncoding = System.Text.Encoding.UTF8;

                SmtpClient MySmtp = new SmtpClient("smtp.gmail.com", 587);

                //寄件者的帳號密碼
                MySmtp.Credentials = new System.Net.NetworkCredential(
                    "uuu9045finalproject1@gmail.com", "9045finalproject");

                //啟用 SSL
                MySmtp.EnableSsl = true;
                MySmtp.Send(msg);

                Label1.Text = "新密碼已寄送至您的e-mail。";
            }
        }
    }

    protected void btnHRManager_Click(object sender, EventArgs e)
    {
        txtEMail.Text = "3@uuu.com";
        txtPassword.Text = "123";
    }

    protected void btnHREmployee_Click(object sender, EventArgs e)
    {
        txtEMail.Text = "4@uuu.com";
        txtPassword.Text = "123";
    }

    protected void btnSalesManager_Click(object sender, EventArgs e)
    {
        txtEMail.Text = "7@uuu.com";
        txtPassword.Text = "123";
    }

    protected void btnSalesEmployee_Click(object sender, EventArgs e)
    {
        txtEMail.Text = "8@uuu.com";
        txtPassword.Text = "123";
    }

    protected void btnWarehouseManager_Click(object sender, EventArgs e)
    {
        txtEMail.Text = "14@uuu.com";
        txtPassword.Text = "123";
    }

    protected void btnWarehouseEmployee_Click(object sender, EventArgs e)
    {
        txtEMail.Text = "15@uuu.com";
        txtPassword.Text = "123";
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>UUU海運公司 | 員工登入首頁</title>

    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet" />
    <!-- Animate.css -->
    <link href="../vendors/animate.css/animate.min.css" rel="stylesheet" />

    <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet" />
</head>
<body class="login">
    <form runat="server">
        <a class="hiddenanchor" id="signup"></a>
        <a class="hiddenanchor" id="signin"></a>

        <div class="login_wrapper">
            <div class="animate form login_form">
                <section class="login_content">
                    <div>
                        <h1>UUU海運公司 員工登入首頁</h1>

                        <div>
                            <%--<input id="txtEMail" type="text" class="form-control" placeholder="E-mail帳號" runat="server"  required="required" validationgroup="Login" />--%>
                            <asp:TextBox ID="txtEMail" CssClass="form-control" runat="server" placeholder="E-mail帳號" ValidationGroup="Login"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*必填" ValidationGroup="Login" ControlToValidate="txtEMail" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <div>
                            <%--<input id="txtPassword" type="password" class="form-control" placeholder="密碼" runat="server" validationgroup="Login" required="required"/>--%>
                            <asp:TextBox ID="txtPassword" CssClass="form-control" runat="server" placeholder="密碼" ValidationGroup="Login"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*必填" ValidationGroup="Login" ControlToValidate="txtPassword" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <div>
                            <asp:Label ID="Label1" runat="server" Text="" ForeColor="Red" Font-Bold="True"></asp:Label>
                        </div>
                        <div>
                            <%--        <a class="btn btn-default submit" href="index.html">登入</a>
                            <a class="reset_pass" href="#">忘記密碼?</a>--%>
                            <%--<input id="btnSignIn" class="btn btn-default submit" type="submit" value="登入" runat="server" />--%>
                            <asp:Button ID="btnSignIn" CssClass="btn btn-default submit" runat="server" Text="登入" OnClick="btnSignIn_Click" ValidationGroup="Login" />

                            <p class="change_link">
                                <a href="#signup" class="to_register">忘記密碼?</a>
                            </p>
                        </div>
                        <div>
                            <asp:Button ID="btnHRManager" runat="server" Text="人事主管" CssClass="btn btn-primary" OnClick="btnHRManager_Click" />
                            <asp:Button ID="btnSalesManager" runat="server" Text="業務主管" CssClass="btn btn-danger" OnClick="btnSalesManager_Click" />
                            <asp:Button ID="btnWarehouseManager" runat="server" Text="倉儲主管" CssClass="btn btn-warning" OnClick="btnWarehouseManager_Click" />
                            <asp:Button ID="btnHREmployee" runat="server" Text="人事員工" CssClass="btn btn-outline-primary" OnClick="btnHREmployee_Click" />
                            <asp:Button ID="btnSalesEmployee" runat="server" Text="業務員工" CssClass="btn btn-outline-danger" OnClick="btnSalesEmployee_Click" />
                            <asp:Button ID="btnWarehouseEmployee" runat="server" Text="倉儲員工" CssClass="btn btn-outline-warning" OnClick="btnWarehouseEmployee_Click" />
                        </div>
                        <div class="clearfix"></div>

                        <div class="separator">
                            <%-- <p class="change_link">
                                New to site?
                 
                                <a href="#signup" class="to_register">Create Account </a>
                            </p>

                            <div class="clearfix"></div>
                            <br />--%>

                            <div>
                                <h1><i class="fa fa-ship"></i>UUU海運公司</h1>
                                <p>©2020 All Rights Reserved. Privacy and Terms 版權所有</p>
                            </div>
                        </div>
                    </div>
                </section>
            </div>

            <div id="register" class="animate form registration_form">
                <section class="login_content">
                    <div runat="server">
                        <h1>重設密碼申請</h1>
                        <%-- <div>
                            <input type="text" class="form-control" placeholder="Username" required="" />
                        </div>--%>
                        <div>
                            <%--<input type="email" class="form-control" placeholder="Email帳號" runat="server"/>--%>
                            <asp:TextBox ID="txtEmail1" TextMode="Email" runat="server" CssClass="form-control" placeholder="E-mail帳號">uuu9045finalproject2@gmail.com</asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*必填" ControlToValidate="txtEmail1" ValidationGroup="G1" Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <%--                        <div>
                            <input type="password" class="form-control" placeholder="Password" required="" />
                        </div>--%>
                        <div>
                            <%--<a class="btn btn-default submit" href="index.html">送出</a>--%>
                            <%--<input id="btnResetPW" class="btn btn-default submit" type="submit" value="送出" runat="server" />--%>
                            <asp:Button ID="btnResetPW" CssClass="btn btn-default submit" runat="server" Text="送出" OnClick="btnResetPW_Click" ValidationGroup="G1" />
                        </div>

                        <div class="clearfix"></div>

                        <div class="separator">
                            <p class="change_link">
                                <a href="#signin" class="to_register">重新登入</a>
                            </p>

                            <div class="clearfix"></div>
                            <br />

                            <div>
                                <h1><i class="fa fa-ship"></i>UUU海運公司 </h1>
                                <p>©2020 All Rights Reserved. Privacy and Terms 版權所有</p>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </form>


</body>
</html>
