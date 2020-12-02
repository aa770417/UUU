<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master"   ValidateRequest="false"  %>
<%-- 用ck 要加 1.ValidateRequest="false" 2.<httpRuntime targetFramework="4.6.1" requestValidationMode="2.0" /> --%>
<%@ Import Namespace="System.Net.Mail" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            string CID = Request.QueryString["CID"];

            TomCustomer c = TomCustomUtility.GetCustomer(int.Parse(CID));

            CustName.Text = c.CName;
            CustEmail.Text = c.Email;

        }
        //if (IsPostBack) {
        //    Label6.Text += HttpUtility.HtmlEncode(Request.Form["ctl00$ContentPlaceHolder1$tbContent"].ToString());
        //}

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        MailMessage msg = new MailMessage();
        //寄給誰
        msg.To.Add(CustEmail.Text);
        //發件人地址 發件人姓名 編碼
        msg.From = new MailAddress(CustEmail.Text,
            "tom", System.Text.Encoding.UTF8);
        //郵件標題
        msg.Subject = CustSubj.Text;
        //指定Subject的編碼  
        msg.SubjectEncoding = System.Text.Encoding.UTF8;
        //郵件內容
        msg.Body =Request.Form["ctl00$ContentPlaceHolder1$tbContent"];
        ////是否是HTML郵件 
        msg.IsBodyHtml = true;
        msg.BodyEncoding = System.Text.Encoding.UTF8;
        //msg.Attachments.Add(new Attachment(@"D:\test2.docx")); 

        SmtpClient MySmtp = new SmtpClient("smtp.gmail.com", 587);

        //寄件者的帳號密碼
        MySmtp.Credentials = new System.Net.NetworkCredential(
            "bblackhhurt@gmail.com", "a24220774");

        //啟用 SSL
        MySmtp.EnableSsl = true;
        MySmtp.Send(msg);

        Response.Redirect("~/production/Customer1.aspx");

    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        CustSubj.Text = "祝郭台銘 先生 七十大壽生日快樂 ";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3><span style="font-size: 1em; color: blue;"><i class="far fa-envelope"></i></span>業務寄信系統</h3>
                </div>

                <div class="title_right">
                    <div class="col-md-5 col-sm-5  form-group pull-right top_search">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search for...">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">Go!</button>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>寄信內容</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>

                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <br />
                            <div id="demo-form2" class="form-horizontal form-label-left">

                                <div class="field item form-group">
                                    <asp:Label ID="Label1" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="客戶姓名*" AssociatedControlID="CustName"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="CustName" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="field item form-group">
                                    <asp:Label ID="Label2" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="email*" AssociatedControlID="CustEmail"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="CustEmail" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="field item form-group">
                                    <asp:Label ID="Label3" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="主旨*" AssociatedControlID="CustSubj"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="CustSubj" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                                    </div>
                                </div>

                                <%--<div class="field item form-group">
                                    <asp:Label ID="Label4" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="內容*" AssociatedControlID="CustContext"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="CustContext" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                                    </div>
                                </div>--%>

                                <div class="field item form-group">
                                    <asp:Label ID="Label5" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="內容*" AssociatedControlID="tbContent"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="tbContent" name="tbContent" runat="server" TextMode="MultiLine"></asp:TextBox>
                                        <script src="https://cdn.ckeditor.com/ckeditor5/11.0.1/classic/ckeditor.js"></script>
                                        <script>
                                            ClassicEditor
                                                .create(document.querySelector('#ContentPlaceHolder1_tbContent'), {
                                                     toolbar: [ 'heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', 'blockQuote' ],

                                                })
                                                .catch(error => {
                                                    console.error(error);
                                                });
                                        </script>
                                        
                                    </div>

                                </div>

                                <div class="ln_solid"></div>
                                <div class="item form-group">
                                    <div class="col-md-6 col-sm-6 offset-md-3">
                                       <asp:HyperLink ID="HyperLink1" runat="server" CssClass="btn btn-primary" NavigateUrl="~/production/Customer1.aspx">取消</asp:HyperLink>
                                        <button class="btn btn-primary" type="reset">重設</button>
                                        <asp:Button ID="Button1" runat="server" Text="寄送" type="submit" CssClass="btn btn-success" OnClick="Button1_Click" />
                                         <asp:Button ID="Button2" runat="server" Text="Demo"  CssClass="btn btn-info" OnClick="Button2_Click" />
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">
    
    <script src="../vendors/validator/validator.js"></script>
     <script src="https://kit.fontawesome.com/9c5d4c272d.js" crossorigin="anonymous"></script>


</asp:Content>

