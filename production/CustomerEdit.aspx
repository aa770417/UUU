<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            string CID = Request.QueryString["CID"];

            TomCustomer c = TomCustomUtility.GetCustomer(int.Parse(CID));

            DropCountry.DataSource = SqlDataSource1;
            DropCountry.DataTextField = "Country";
            DropCountry.DataValueField = "Country";
            DropCountry.DataBind();

            CustID.Text = (c.CID).ToString();
            CustName.Text = c.CName;
            TextEID.Text = TomCustomUtility.getEName(c.EID);
            TextCompanyName.Text = c.CompanyName;
            this.DropCountry.Items.FindByText(c.Country).Selected = true;

            if (c.Gender == "M")
            {
                Mlabel.CssClass = "btn btn-secondary focus active";
            }
            else
            {
                Flabel.CssClass = "btn btn-secondary focus active ";
            }
            TextMail.Text = c.Email;
            //存照片
            Image1.ImageUrl = "~/TomUpload/" + c.CImg;

            HiddenField1.Value = c.CImg;
            TextBirth.Text = c.Birthday;
            TextPhone.Text = c.Phone;

        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        //為了EID 要再讀回來
        string CID = Request.QueryString["CID"];
        TomCustomer c = TomCustomUtility.GetCustomer(int.Parse(CID));
        //圖片1.使用者上傳檔案 可以先看到檔案預覽 2.按下上傳資料 將檔案送入資料庫做更新 
        if (FileUpload1.HasFile)
        {
            string uploadPath = "~/TomUpload/" + FileUpload1.FileName;
            FileUpload1.SaveAs(Server.MapPath(uploadPath));
        }
        TomCustomer p = new TomCustomer()
        {
            CID = int.Parse(CustID.Text),
            CName = CustName.Text,
            Country = DropCountry.SelectedItem.Value,
            CompanyName = TextCompanyName.Text,
            CImg = FileUpload1.HasFile ? FileUpload1.FileName : HiddenField1.Value,
            //直接放入載入時的EID
            EID = c.EID,
            Gender = MRadio.Checked ? "M" : "F",
            Birthday = TextBirth.Text,
            Phone = TextPhone.Text,
            Email = TextMail.Text,

        };
        TomCustomUtility.UpdateCustomer(p);

        Response.Redirect("~/production/Customer1.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>客戶資料修改</h3>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">

                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                            <br />
                            <%--照片 與上傳區--%>
                             <div class="col-md-6">
                                <div class="row">
                                    <div class="col-12 offset-2">
                                        <asp:Image ID="Image1" runat="server" CssClass="img-fluid  d-block w-75  rounded-circle " />
                                    </div>
                                    <div class="col  offset-2">
                                        <asp:FileUpload ID="FileUpload1" runat="server" />
                                    </div>
                                </div>
                            </div>
                            <%-- 表單內容 --%>
                            <div id="demo-form2" data-parsley-validate class="col-md-6 form-horizontal form-label-left">
                                <%-- 客戶ID --%>
                                <div class="item form-group">
                                    <asp:Label ID="Label1" required="required" CssClass="col-form-label col-md-3 col-sm-3 label-align" runat="server" Text="Label" AssociatedControlID="CustID"> 客戶ID</asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="CustID" runat="server" required="required" CssClass="form-control " Enabled="false"></asp:TextBox>
                                    </div>
                                </div>
                                <%-- 客戶姓名 --%>
                                <div class="item form-group">
                                    <asp:Label ID="Label2" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="客戶姓名" AssociatedControlID="CustName"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="CustName" runat="server" CssClass="form-control"></asp:TextBox>
            <br />
                                    </div>
                                </div>
                                <%-- 公司國別 --%>
                                <div class="item form-group">
                                    <asp:Label ID="Label3" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="公司國別" AssociatedControlID="DropCountry"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:DropDownList ID="DropCountry" runat="server" CssClass="form-control">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:NW %>" SelectCommand="SELECT DISTINCT [Country] FROM [Customer]"></asp:SqlDataSource>
                                    </div>
                                </div>
                                <%-- 客戶公司 --%>
                                <div class="item form-group">
                                    <%--<label for="Company" class="col-form-label col-md-3 col-sm-3 label-align">客戶公司</label>--%>
                                    <asp:Label ID="Label4" runat="server" Text="客戶公司" CssClass="col-form-label col-md-3 col-sm-3 label-align" AssociatedControlID="TextCompanyName"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="TextCompanyName" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <%-- 員工ID --%>
                                <div class="item form-group">
                                    <asp:Label ID="Label6" runat="server" Text="負責員工" CssClass="col-form-label col-md-3 col-sm-3 label-align" AssociatedControlID="TextEID"></asp:Label>
                                    <%--<label for="Cust-Phone" class="col-form-label col-md-3 col-sm-3 label-align">客戶電話</label>--%>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="TextEID" runat="server" CssClass="form-control" Enabled="False"></asp:TextBox>
                                        <%--<input id="Cust-Phone" class="form-control" type="text" name="Cust-Phone">--%>
                                    </div>
                                </div>
                                <%-- 客戶性別 --%>
                                <div class="item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align">客戶性別</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <div id="gender" class="btn-group" data-toggle="buttons">
                                            <asp:Label ID="Mlabel" runat="server" CssClass="btn btn-secondary" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default">
                                                <asp:RadioButton ID="MRadio" runat="server" CssClass="join-btn" GroupName="gender" />男</asp:Label>
                                            <asp:Label ID="Flabel" runat="server" CssClass="btn btn-primary" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default">
                                                <asp:RadioButton ID="FRadio" runat="server" CssClass="join-btn" GroupName="gender" />女</asp:Label>

                                        </div>
                                    </div>
                                </div>
                                <%-- phone --%>
                                <div class="item form-group">
                                    <asp:Label ID="Label8" runat="server" Text="Phone" CssClass="col-form-label col-md-3 col-sm-3 label-align" AssociatedControlID="TextPhone"></asp:Label>
                                    <%--             <label for="Email" class="col-form-label col-md-3 col-sm-3 label-align">Email</label>--%>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="TextPhone" runat="server" CssClass="form-control"></asp:TextBox>
                                        <%-- <input id="Email" class="form-control" type="text" name="Email">--%>
                                    </div>
                                </div>

                                <%-- Email --%>
                                <div class="item form-group">
                                    <asp:Label ID="Label5" runat="server" Text="Email" CssClass="col-form-label col-md-3 col-sm-3 label-align" AssociatedControlID="TextMail"></asp:Label>
                                    <%--             <label for="Email" class="col-form-label col-md-3 col-sm-3 label-align">Email</label>--%>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="TextMail" runat="server" CssClass="form-control"></asp:TextBox>
                                        <%-- <input id="Email" class="form-control" type="text" name="Email">--%>
                                    </div>
                                </div>
                                <%--Birthday  --%>
                                <div class="item form-group">
                                    <asp:Label ID="Label7" runat="server" Text="Birthday" CssClass="col-form-label col-md-3 col-sm-3 label-align" AssociatedControlID="TextBirth"></asp:Label>
                                    <%--<label class="col-form-label col-md-3 col-sm-3 label-align">
                                       
                                        Date Of Birth <span class="required">*</span>
                                    </label>--%>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="TextBirth" runat="server" CssClass="date-picker form-control" placeholder="dd-mm-yyyy" required="required" type="text" onfocus="this.type='date'" onmouseover="this.type='date'" onclick="this.type = 'date'" onblur="this.type='text'" onmouseout="timeFunctionLong(this)"></asp:TextBox>
                                        <%--<input id="birthday" class="date-picker form-control" placeholder="dd-mm-yyyy" type="text" required="required" type="text" onfocus="this.type='date'" onmouseover="this.type='date'" onclick="this.type = 'date'" onblur="this.type='text'" onmouseout="timeFunctionLong(this)">--%>
                                        <script>
                                            function timeFunctionLong(input) {
                                                setTimeout(function () {
                                                    input.type = 'text';
                                                }, 60000);
                                            }
                                        </script>
                                    </div>
                                </div>
                                <div class="ln_solid"></div>
                                <div class="item form-group">
                                    <div class="col-md-6 col-sm-6 offset-md-3">
                                        <%--     <button class="btn btn-primary" type="button">取消</button>
                                        <button class="btn btn-primary" type="reset">重設</button>--%>
                                        <%--     <button type="submit" class="btn btn-success">上傳</button>--%>
                                        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="btn btn-primary" NavigateUrl="~/production/Customer1.aspx">取消</asp:HyperLink>
                                        <button type='reset' class="btn btn-success">重設</button>
                                        <asp:Button ID="Button1" runat="server" Text="上傳" CssClass="btn btn-success" OnClick="Button1_Click" />
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
        <script src="https://kit.fontawesome.com/9c5d4c272d.js" crossorigin="anonymous"></script>
    <script>
        $(document).ready(function () {

            $("body").on("change", "#ContentPlaceHolder1_FileUpload1", function () {
                preview(this);
            })
            function preview(input) {
                
                if (input.files && input.files[0]) {
                    // 建立一個物件，使用 Web APIs 的檔案讀取器(FileReader 物件) 來讀取使用者選取電腦中的檔案
                    var reader = new FileReader();
                    // 事先定義好，當讀取成功後會觸發的事情
                    reader.onload = function (e) {
                        $("#ContentPlaceHolder1_Image1").attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
        })
    </script>
</asp:Content>

