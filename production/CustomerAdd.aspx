<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {
            //組成相對路徑 透過Server.MapPath組成絕對路徑 FileUpload1.SaveAs存入這個絕對路徑
            string uploadPath = "~/TomUpload/" + FileUpload1.FileName;
            FileUpload1.SaveAs(Server.MapPath(uploadPath));
            //測試用Label1.Text = Server.MapPath(uploadPath);
        }

        TomCustomer p = new TomCustomer()
        {

            CName = CustName.Text,
            Country = DropCountry.SelectedItem.Value,
            CompanyName = TextCompanyName.Text,
            CImg = FileUpload1.HasFile ? FileUpload1.FileName : HiddenField1.Value,
            EID = int.Parse(TextEID.Text),
            Gender = MRadio.Checked ? "M" : "F",
            Birthday = TextBirth.Text,
            Phone = TextPhone.Text,
            Email = TextMail.Text,

        };
        TomCustomUtility.AddProduct(p);

        Response.Redirect("~/production/Customer1.aspx");
    }



    protected void Page_Load(object sender, EventArgs e)
    {
        if (!FileUpload1.HasFile)
        {
            Image1.ImageUrl = "~/TomUpload/noimage.jpg";
        }
    }
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>客戶資料新增</h3>
                    <%--<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>--%>
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
                            <div id="demo-form2" class="col-md-6 form-horizontal form-label-left">
                                <%-- 客戶姓名 --%>
                                <div class="field item form-group">
                                    <asp:Label ID="Label2" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="客戶姓名*" AssociatedControlID="CustName"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="CustName" runat="server" CssClass="form-control" placeholder="ex. John " required="required"></asp:TextBox>
                                    </div>
                                </div>
                                <%-- 公司國別 --%>
                                <div class="field item form-group">
                                    <asp:Label ID="Label3" runat="server" CssClass="col-form-label col-md-3 col-sm-3 label-align" Text="公司國別*" AssociatedControlID="DropCountry"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:DropDownList ID="DropCountry" runat="server" CssClass="form-control" DataSourceID="SqlDataSource3" DataTextField="Country" DataValueField="Country">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:NW %>" SelectCommand="SELECT DISTINCT [Country] FROM [Customer]"></asp:SqlDataSource>
                                    </div>
                                </div>
                                <%-- 客戶公司 --%>
                                <div class="field item form-group">
                                    <%--<label for="Company" class="col-form-label col-md-3 col-sm-3 label-align">客戶公司</label>--%>
                                    <asp:Label ID="Label4" runat="server" Text="客戶公司*" CssClass="col-form-label col-md-3 col-sm-3 label-align" AssociatedControlID="TextCompanyName"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="TextCompanyName" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                                    </div>
                                </div>
                                <%-- 員工ID --%>
                                <div class="field item form-group">
                                    <asp:Label ID="Label6" runat="server" Text="員工ID" CssClass="col-form-label col-md-3 col-sm-3 label-align" AssociatedControlID="TextEID"></asp:Label>
                                    <%--<label for="Cust-Phone" class="col-form-label col-md-3 col-sm-3 label-align">客戶電話</label>--%>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="TextEID" runat="server" CssClass="form-control" type="number" class='number' name="number" data-validate-max="10,00" required='required'></asp:TextBox>
                                        <%--<input id="Cust-Phone" class="form-control" type="text" name="Cust-Phone">--%>
                                    </div>
                                </div>
                                <%-- 客戶性別 --%>
                                <div class="field item form-group">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align">客戶性別*</label>
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
                                <div class="field item form-group">
                                    <asp:Label ID="Label8" runat="server" Text="電話*" CssClass="col-form-label col-md-3 col-sm-3 label-align" AssociatedControlID="TextPhone"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="TextPhone" runat="server" CssClass="form-control" type="tel" class='tel' name="phone" required='required' data-validate-length-range="8,20"></asp:TextBox>
                                    </div>
                                </div>
                                <%-- Email --%>
                                <div class="field item form-group">
                                    <asp:Label ID="Label5" runat="server" Text="信箱*" CssClass="col-form-label col-md-3 col-sm-3 label-align" AssociatedControlID="TextMail"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="TextMail" runat="server" CssClass="form-control" name="email" class='email' required="required" type="email"></asp:TextBox>
                                    </div>
                                </div>
                                <%--Birthday  --%>
                                <div class="field item form-group">
                                    <asp:Label ID="Label7" runat="server" Text="生日*" CssClass="col-form-label col-md-3 col-sm-3 label-align" AssociatedControlID="TextBirth"></asp:Label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:TextBox ID="TextBirth" runat="server" CssClass="date-picker form-control" placeholder="dd-mm-yyyy" required="required" type="text" onfocus="this.type='date'" onmouseover="this.type='date'" onclick="this.type = 'date'" onblur="this.type='text'" onmouseout="timeFunctionLong(this)"></asp:TextBox>
                                        <script>
                                            function timeFunctionLong(input) {
                                                setTimeout(function () {
                                                    input.type = 'text';
                                                }, 60000);
                                            }
                                        </script>
                                    </div>
                                </div>
                                  <input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="" />
                                <div class="ln_solid"></div>
                                <div class="item form-group">
                                    <div class="col-md-6 col-sm-6 offset-md-3">
                                        <button type='reset' class="btn btn-success">重設</button>
                                        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="btn btn-primary" NavigateUrl="~/production/Customer1.aspx">取消</asp:HyperLink>
                                        <asp:Button ID="Button1" runat="server" Text="上傳" type="sumit" CssClass="btn btn-success" OnClick="Button1_Click"   />
                                       
                                        <input id="DemoButton" type="button" value="Demo" Class="btn btn-success" />
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
    <script src="../build/js/jquery-3.1.1.js"></script>
    <script src="../vendors/validator/multifield.js"></script>
    <script src="../vendors/validator/validator.js"></script>
        <script src="https://kit.fontawesome.com/9c5d4c272d.js" crossorigin="anonymous"></script>
    <script src="../build/js/Tomjs.js"></script>
    <%-- demo用 --%>
   <script>
       $(document).ready(function () {
           $("#DemoButton").click(function () {
               $("#ContentPlaceHolder1_CustName").val("科問哲");
               $("#ContentPlaceHolder1_TextCompanyName").val("北四府");
               $("#ContentPlaceHolder1_TextEID").val("56");
               $("#ContentPlaceHolder1_TextPhone").val("0988000000");
               $("#ContentPlaceHolder1_TextMail").val("bb@cc.ee");
               
           })

       })


   </script>
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
        // stuff related ONLY for this demo page:
        $('.toggleValidationTooltips').change(function () {
            validator.settings.alerts = !this.checked;
            if (this.checked)
                $('form .alert').remove();
        }).prop('checked', false);

    </script>
    <%-- 即時顯示圖片 --%>
    <script>
        $(document).ready(function () {

            $("body").on("change", "#ContentPlaceHolder1_FileUpload1", function () {
                preview(this);
            })
            function preview(input) {
                // 若有選取檔案
                if (input.files && input.files[0]) {
                    // 建立一個物件，使用 Web APIs 的檔案讀取器(FileReader 物件) 來讀取使用者選取電腦中的檔案
                    var reader = new FileReader();
                    // 事先定義好，當讀取成功後會觸發的事情
                    reader.onload = function (e) {
                        console.log(e);
                        // 這裡看到的 e.target.result 物件，是使用者的檔案被 FileReader 轉換成 base64 的字串格式，
                        // 在這裡我們選取圖檔，所以轉換出來的，會是如 『data:image/jpeg;base64,.....』這樣的字串樣式。
                        // 我們用它當作圖片路徑就對了。
                        $("#ContentPlaceHolder1_Image1").attr('src', e.target.result);
                    }

                    // 因為上面定義好讀取成功的事情，所以這裡可以放心讀取檔案
                    reader.readAsDataURL(input.files[0]);
                }
            }
        })
    </script>


</asp:Content>

