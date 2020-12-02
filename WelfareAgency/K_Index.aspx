<%@ Page Title="" Language="C#" MasterPageFile="~/UUU.master" %>

<script runat="server">

    //導向美味時光總覽頁面
    protected void Button1_Click(object sender, EventArgs e)
    {
       Response.Redirect("~/WelfareAgency/FoodList.aspx");
    }

    //導向特約課程總覽頁面
    protected void Button3_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/WelfareAgency/KnowledgeInfoOverview.aspx");
    }

    //導向特別企劃總覽頁面
    protected void Button4_Click(object sender, EventArgs e)
    {
        //Response.Redirect("~/SpecialPlanInfoOverview.aspx");
    }
    //導向後臺編輯管理頁面
    protected void Button5_Click(object sender, EventArgs e)
    {

        //int E_ID = 0;
         Response.Redirect("~/WelfareAgency/KnowledgeInfoManage.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Employee"] == null)

        {
            Response.Redirect("~/production/Login.aspx");
        }
     
        Employee aa = (Employee)Session["Employee"];
        int   E_ID = aa.EmployeeID;

        //Response.Write(E_ID);

        if (E_ID == 52)
        {
            Button5.Visible = true;
        }
        else
        {
            Button5.Visible = false;
        }

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <%--應景圖片區-Start--%>
        <div class="row">
            <div class="col-12">
                <img class="d-block w-100" src="Image/Index/Banner3.jpg" />
            </div>
        </div>
        <br />
        <br />
        <%--應景圖片區-End--%>

        <%--主題標題與圖片區-Start--%>
        <div class="row">
            <div class="col-3">
                <h3 style="text-align: center; background: yellow; color:blue">美味時光</h3>
                <br />
                <img src="Image/Index/Delicious01.png" style="display: block; margin: auto; width: 250px; height: 250px" />
            </div>
            <div class="col-3">
                <h3 style="text-align: center; background: yellow; color:blue">休閒時光</h3>
                <br />
                <img src="Image/Index/Sport.jpg" style="display: block; margin: auto; width: 250px; height: 250px" />
            </div>
            <div class="col-3">
                <h3 style="text-align: center; background: yellow; color:blue">特約課程</h3>
                <br />
                <img src="Image/Index/Knowledge.jpg" style="display: block; margin: auto; width: 250px; height: 250px" />
            </div>
            <div class="col-3">
                <h3 style="text-align: center; background: yellow; color:blue">特別企劃</h3>
                <br />
                <img src="Image/Index/SpecialPlan00.jpg" style="display: block; margin: auto; width: 250px; height: 250px" />
            </div>
        </div>
        <br />
        <%--主題標題與圖片區-End--%>

        <%--主題內容介紹區-Start--%>
        <div class="row">
            <div class="col-3 ">
                <p style="font-size: 25px; color: Background; line-height: 40px">
                      還在整天想著 ...<br />
                    餐餐要吃些什麼嗎?<br />
                    福利社為您提供!<br />
                    準備好開點了嗎?
                </p>
            </div>
            <div class="col-3">
                <p style="font-size: 25px; color: Background; line-height: 40px">
                    下班後無所事事？<br />
                    周末不想宅在家裡？<br />
                    <strong>UUUの福利社沒有極限</strong><br />
                    豐富有趣的休閒活動<br />
                    全都在休閒時光!!<br />
                </p>
            </div>
            <div class="col-3">
                <p style="font-size: 25px; color: Background; line-height: 40px">
                    想培養第二專長？<br />
                    想說一口流利的外語？<br />
                    <strong>UUUの福利社沒有極限</strong><br />
                    多元優質的課程<br />
                    全都在特約課程!!<br />
                </p>
            </div>
            <div class="col-3">
                 <p style="font-size: 25px; color: Background; line-height: 40px">
                    聖誕節要幹嘛？。<br />
                    當然是交換禮物阿!!<br />
                    <strong>UUUの福利社沒有極限</strong><br />
                    新奇趣味的聖誕禮物<br />
                    全都在特別企劃!!<br />
                </p>
            </div>
        </div>
        <%--主題內容介紹區-End--%>

 
        <%--前往主題按鈕區-Start--%>
        <div class="row">
            <div class="col-md-3">
                <asp:Button ID="Button1" runat="server" Text="立即前往" class="btn btn-success btn-block btn-lg" OnClick="Button1_Click" Height="45px" Font-Size="25PX" text-align="center" Font-Italic="True" />
            </div>
            <div class="col-md-3">
                <asp:Button ID="Button2" runat="server" Text="立即前往" class="btn btn-success btn-block btn-lg" OnClick="Button3_Click" Height="45px" Font-Size="25PX" text-align="center" Font-Italic="True" />
            </div>
            <div class="col-md-3">
                <asp:Button ID="Button3" runat="server" Text="立即前往" class="btn btn-success btn-block btn-lg" OnClick="Button3_Click" Height="45px" Font-Size="25PX" text-align="center" Font-Italic="True" />
            </div>
            <div class="col-md-3">
                <asp:Button ID="Button4" runat="server" Text="立即前往" class="btn btn-success btn-block btn-lg" OnClick="Button4_Click" Height="45px" Font-Size="25PX" text-align="center" Font-Italic="True" />
            </div>

        </div>
            <br />

        <%--前往主題按鈕區-End--%>
        <div class="row">
            <div class="col-md-12">
                <asp:Button ID="Button5" runat="server" Text="前往後臺編輯管理" OnClick="Button5_Click" class="btn btn-block btn-danger btn-lg" Height="50px" Font-Size="35PX" text-align="center" />
            </div>
       </div>
    </div>
    <br />
    <br />

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
</asp:Content>
