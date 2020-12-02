<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_PreLoad(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("~/production/Login.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
