<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">


    //    ProductUtility.DeleteProduct(int.Parse(id));

    //    Response.Redirect("~/ProductList.aspx");

    protected void Page_PreLoad(object sender, EventArgs e)
    {

        string CiorId = Request.QueryString["ciorId"];

        //檢查登入  
        if (Session["Employee"] == null)
        {
            Response.Redirect("~/production/Login.aspx");
        }

        
        //取得使用者
        Employee emp = (Employee)Session["Employee"];

        if (emp.AuthorizationLevel == "Employee")
        {
            //導向權限不足
            Response.Redirect("~/production/PermissionDenied.aspx");
        }
        else
        {
            HRUtility.CIORSinglePassed(int.Parse(CiorId));

            Response.Redirect("~/production/RogerClockInOutRecordManagement.aspx");
        }

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">
</asp:Content>

