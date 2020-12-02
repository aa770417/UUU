﻿<%@ Page Title="" Language="C#" MasterPageFile="~/UUU.master" %>

<script runat="server">
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/WelfareAgency/KnowledgeInfoAdd.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Repeater1.DataSource = KnowledgeUtilty.GetAllKnowledgeInfo();//DataSource的來源為GetAllTeamInfo方法
        Repeater1.DataBind(); //Repeater是一種逐筆讀取資料的標記
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">

        <div class="row">
            <div class="col-md-12">
                <h1 class="bg-info text-center text-warning">UUUの福利社</h1>
                    <%--這是商場名稱--%>
                    <br />
                    <br />
                <h2 class="bg-warning text-center text-white">特約課程編輯管理頁面</h2>
            </div>
            <br />
        </div>
        <br />
        <div class="row">
            <div class="col-md-12">
                <asp:Repeater ID="Repeater1" runat="server">
                    <HeaderTemplate>
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr class="table-primary">
                                    <th>課程名稱</th>
                                    <th>課程分類</th>
                                    <th>認證機構</th>
                                    <th>上課地點</th>
                                    <th>課程優惠價</th>
                                    <th>課程時數</th>
                                    <th>開課日期</th>
                                    <th>檢視</th>
                                    <th>編輯</th>
                                    <th>刪除</th>
                                </tr>
                            </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tbody>
                            <tr class="table-warning">
                                <td><%# Eval("K_Course") %></td>
                                <td><%# Eval("K_Category") %></td>
                                <td><%# Eval("K_Institution") %></td>
                                <td><%# Eval("K_Location") %></td>
                                <td><%# Eval("K_Price") %></td>
                                <td><%# Eval("K_Hour") %></td>
                                <td><%# Eval("K_Date") %></td>
                                <td><a href="<%# Eval("K_ID","KnowledgeInfoDetail.aspx?K_ID={0}") %>" target="_blank">檢視</a> </td>
                                <td><a href="<%# Eval("K_ID","KnowledgeInfoUpdate.aspx?K_ID={0}") %>" target="_blank">編輯</a> </td>
                                <td><a onclick="checkDelete()" href="<%# Eval("K_ID","KnowledgeInfoDelete.aspx?K_ID={0}") %>">刪除</a> </td>
                            </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
			</table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <p>
                <asp:Button ID="Button1" runat="server" Text="新增資料" OnClick="Button1_Click" class="btn btn-block btn-danger btn-lg" Height="50px" Font-Size="35PX" text-align="center" />                </p>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <script>
        function checkDelete() {
            if (confirm("delete?") == false) {
                event.preventDefault(); //如果delete沒被按下就不跳頁
            }
        }
    </script>
</asp:Content>



