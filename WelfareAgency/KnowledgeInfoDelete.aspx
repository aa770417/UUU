<%@ Page Title="" Language="C#" MasterPageFile="~/UUU.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string K_ID = Request.QueryString["K_ID"];
         //根據K_ID刪除成功後會直接跳轉回KnowledgeEdit.aspx
       KnowledgeUtilty.DeleteKnowledgeInfo(int.Parse(K_ID));

       Response.Redirect("~/WelfareAgency/KnowledgeInfoManage.aspx");
     
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



</asp:Content>

