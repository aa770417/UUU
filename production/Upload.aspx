<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        //防止沒有圖片時會出現錯誤
        if (Request.Files.Count == 1)
        {
            HttpPostedFile file = Request.Files[0];

            file.SaveAs(Server.MapPath(@"~\production\images\Clubs\") + file.FileName);
        }
    }
</script>

