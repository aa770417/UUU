<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Employee empSession = (Employee)Session["Employee"];

        if (Session["Employee"] != null)
        {
            YenEmployee emp = EmployeeUtility.GetEmployeeByID(empSession.EmployeeID);

            personalImg.ImageUrl = "images/Personal/" + emp.ImageFileName;
            labelName.Text = emp.LastName + "" + emp.FirstName;
            labelDept.Text = emp.DepartmentName + "部";
            labelPosition.Text = emp.AuthorizationLevel;
            labelBD.Text = emp.BirthDate;
            labelMobile.Text = emp.Mobile;
            labelAddress.Text = emp.Address;
        }
        else
        {
            Response.Redirect("~/production/Login.aspx");
        }
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- page content -->
    <div class="right_col" role="main">
        <div class="">
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>個人檔案 <small>Personal Profile</small></h2>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="form-horizontal">
                                <%--<div class="col-md-6 col-sm-6 ">--%>
                                <div class="">
                                    <div id="crop-avatar">
                                        <!-- Current avatar -->
                                        <asp:Image ID="personalImg" runat="server" onerror="this.src='images/user.png'" BorderColor="Black" Width="220px" />
                                    </div>
                                </div>
                                <h3>
                                    <asp:Label ID="labelName" runat="server" Text="Label"></asp:Label></h3>

                                <ul class="list-unstyled user_data">
                                    <li><i class="fa fa-bug"></i>
                                        <asp:Label ID="labelDept" runat="server" Text="Label"></asp:Label>
                                    </li>
                                    <li>
                                        <i class="fa fa-briefcase user-profile-icon"></i>
                                        <asp:Label ID="labelPosition" runat="server" Text="Label"></asp:Label>
                                    </li>
                                </ul>

                                <a href="EmployeeProfileEdit.aspx" class="btn btn-success"><i class="fa fa-edit m-right-xs"></i>編輯</a>
                                <br />

                                <!-- start skills -->
                                <h4>個人資料</h4>
                                <ul class="list-unstyled user_data">
                                    <li>
                                        <h6>生日</h6>
                                        <asp:Label ID="labelBD" runat="server" Text="Label"></asp:Label>
                                    </li>
                                    <li>
                                        <h6>手機</h6>
                                        <asp:Label ID="labelMobile" runat="server" Text="Label"></asp:Label>
                                    </li>
                                    <%--<li>
                                        <h6>E-mail</h6>
                                        <asp:Label ID="labelEmail" runat="server" Text="Label"></asp:Label>
                                    </li>--%>
                                    <li>
                                        <h6>地址</h6>
                                        <asp:Label ID="labelAddress" runat="server" Text="Label"></asp:Label>
                                    </li>
                                </ul>
                                <!-- end of skills -->
                                <%--</div>--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /page content -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">
</asp:Content>

