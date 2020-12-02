<%@ Page Title="" Language="C#" MasterPageFile="~/UUU.master" ValidateRequest="false" %>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {
            string Path = "/WelfareAgency/Upload/" + FileUpload1.FileName;
            FileUpload1.SaveAs(Server.MapPath(Path));
        }
        Knowledge k = new Knowledge()
        {
            K_Course = TextBox1.Text,
            K_Category = DropDownList1.SelectedItem.Text,
            K_Institution = TextBox2.Text,
            K_Location = TextBox3.Text,
            K_Price = Convert.ToInt32(TextBox4.Text),
            K_Hour = Convert.ToInt32(TextBox5.Text),
            K_Date = TextBox6.Text,
            K_Contact = TextBox7.Text,
            K_Phone = TextBox8.Text,
            K_ImgInfo = FileUpload1.HasFile ? FileUpload1.FileName : "",
            K_DetailInfo = TextArea1.Value
        };
        KnowledgeUtilty.InsertKnowledgeInfo(k);
        Response.Redirect("~/WelfareAgency/KnowledgeInfoManage.aspx");
    }
    //Demo紐
    protected void Button2_Click(object sender, EventArgs e)
    {
        //        if (FileUpload1.HasFile)
        //{
        //    string Path = "/WelfareAgency/Upload/" + FileUpload1.FileName;
        //    FileUpload1.SaveAs(Server.MapPath(Path));
        //}
        TextBox1.Text = "Java程式設計入門班";
        DropDownList1.Text = "資訊科技類";
        TextBox2.Text ="恆逸資訊";
        TextBox3.Text= "台北恆逸教育訓練中心";
        TextBox4.Text ="9000";
        TextBox5.Text = "96";
        TextBox6.Text = "2020/12/12";
        TextBox7.Text = "Lillia Kuo";
        TextBox8.Text = "02-2823666";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
        <style>
        .td1 {
            width: 45px;
            height: 40PX;
            overflow: hidden;
            font-size: 16px
        }
    </style>

    <style>
        .td2 {
            width: 250px;
            height: 40PX;
            overflow: hidden
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <%-- 特約課程-基本資料更新區-Start  --%>

        <%-- 標題區1-Start  --%>
        <div class="row">
            <div class="col-md-12">
                <div>
                    <h1 class="bg-info text-center text-warning">UUUの福利社</h1>
                    <%--這是商場名稱--%>
                    <br />
                    <br />
                    <h2 class="bg-warning text-center text-white">特約課程-基本資料新增區</h2>
                    <br />
                </div>
            </div>
        </div>
        <%-- 標題區1-End  --%>
        <div class="row">

            <%--基本資料上半部-Start--%>

            <%-- 基本資料左半部圖片區-Start  --%>
            <div class="col-auto align-items-start align-self-start">
                <div>
                    <img src="Image/Other/CoursePic.png" style="width: 350Px; height: 350Px" />
                </div>
                <div>
                    <br />
                    <asp:FileUpload ID="FileUpload1" runat="server" accept=".jpg,.png" />
                </div>
            </div>
            <br />

            <%-- 基本資料左半部圖片區-End  --%>

            <%-- 基本資料右半部填寫區-Start  --%>
            <div class="col align-items-start align-self-start">
                <div class="form-group">
                    <table style="width: 760Px">
                        <tr>
                            <td class="td1">
                                <asp:Label ID="Label1" runat="server" Text="Label">課程名稱</asp:Label>
                            </td>
                            <td class="td2">
                                <asp:TextBox ID="TextBox1" runat="server" placeholder="請更新課程名稱資料" CssClass="form-control"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1">
                                <asp:Label ID="Label2" runat="server" Text="Label">課程分類</asp:Label>
                            </td>
                            <td class="td2">
                                <asp:DropDownList ID="DropDownList1" runat="server">
                                    <asp:ListItem Value="0">請更新課程分類資料</asp:ListItem>
                                    <asp:ListItem Value="1">資訊科技</asp:ListItem>
                                    <asp:ListItem Value="2">運動休閒</asp:ListItem>
                                    <asp:ListItem Value="3">語言學習</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1">
                                <asp:Label ID="Label3" runat="server" Text="Label"> 認證機構</asp:Label>
                            </td>
                            <td class="td2">
                                <asp:TextBox ID="TextBox2" runat="server" placeholder="請更新認證機構資料" CssClass="form-control"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1">
                                <asp:Label ID="Label4" runat="server" Text="Label">上課地點</asp:Label>
                            </td>
                            <td class="td2">
                                <asp:TextBox ID="TextBox3" runat="server" placeholder="請更新增上課地點資料" CssClass="form-control"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1">
                                <asp:Label ID="Label5" runat="server" Text="Label">課程優惠價</asp:Label>
                            </td>
                            <td class="td2">
                                <asp:TextBox ID="TextBox4" runat="server" placeholder="請更新課程優惠價資料" CssClass="form-control"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1">
                                <asp:Label ID="Label6" runat="server" Text="Label">課程時數</asp:Label>
                            </td>
                            <td class="td2">
                                <asp:TextBox ID="TextBox5" runat="server" placeholder="請更新課程時數資料" CssClass="form-control"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1">
                                <asp:Label ID="Label7" runat="server" Text="Label">開課日期</asp:Label>
                            </td>
                            <td class="td2">
                                <asp:TextBox ID="TextBox6" runat="server" class="datepicker"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1">
                                <asp:Label ID="Label8" runat="server" Text="Label">認證機構窗口</asp:Label>
                            </td>
                            <td class="td2">
                                <asp:TextBox ID="TextBox7" runat="server" placeholder="請更新認證機構企業窗口資料" CssClass="form-control"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="td1">
                                <asp:Label ID="Label9" runat="server" Text="Label">窗口聯絡方式</asp:Label>
                            </td>
                            <td class="td2">
                                <asp:TextBox ID="TextBox8" runat="server" placeholder="請更新認證機構窗口聯絡資料" CssClass="form-control"></asp:TextBox>
                            </td>
                        </tr>
                    </table>

                </div>
            </div>
            <%-- 基本資料右半部填寫區-End  --%>
        </div>
        <%-- 基本資料上半部-End--%>
        <%--  標題區2-Start--%>
        <div class="row">
            <div class="col-md-12 align-self-center">
                <div>
                    <br />
                    <h2 class="bg-warning text-center text-white">特約課程-進階資料新增區</h2>
                    <br />
                </div>
            </div>
        </div>
        <%--  標題區2-End--%>

        <%--  CK_Editor編輯區-Start--%>
        <div class="row">
            <div class="col-md-12">
                <textarea id="TextArea1" class="ckeditor" name="K_ID" runat="server"  style="width:1120px;height:350px"></textarea>
            </div>
        </div>
        <br />
        <%--  CK_Editor編輯區-End--%>

        <%--  新增資料按鈕-Start--%>
        <div class="row">
            <div class="col-md-12">
                <asp:Button ID="Button1" runat="server" Text="新增資料" OnClick="Button1_Click" class="btn btn-block btn-danger btn-lg" Height="50px" Font-Size="35PX" text-align="center" />
          
                <br />
                
            </div>

        <div class="col-md-12">
                <asp:Button ID="Button2" runat="server" Text="Demo鈕" OnClick="Button2_Click" class="btn btn-block btn-success btn-lg" Height="50px" Font-Size="35PX" text-align="center" />
        </div>

            <%-- 新增資料按鈕-End--%>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">

    <script>
        $(".datepicker").datepicker({
            format: "yyyy-mm-dd",
            autoclose: true,
            startDate: "today",
            clearBtn: true,
            calendarWeeks: true,
            todayHighlight: true,
            language: 'zh-TW'
        });
    </script>

</asp:Content>



