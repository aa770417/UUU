<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">
    protected void Page_PreLoad(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string BID = Request.QueryString["BID"];
            TomBoardUtility.DeleteBoard(int.Parse(BID));
            Response.Redirect("~/production/TomDefault.aspx");
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" Runat="Server">
</asp:Content>

