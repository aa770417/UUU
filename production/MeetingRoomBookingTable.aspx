<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" EnableEventValidation="false" %>

<%--Page的屬性記得要加EnableEventValidation="false" 才能將FileUpload的檔案傳到伺服器--%>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        //string[] empStringArray = { "3", "軒華", "1", "主管" };
       //Session["Employee"] = empStringArray;

        //string[] empStringArray = (string[])Session["Employee"];

        //int empID = Convert.ToInt32(empStringArray[0]);

        Employee empSession = (Employee)Session["Employee"];

        if (Session["Employee"] != null)
        {
            //根據Session裡的員工編號，讀取該名已登入員工所預約的會議室紀錄
            Repeater1.DataSource = PeterHsuUtilities.GetMeetRoomBookingRecordsByEmpID(empSession.EmployeeID);
            Repeater1.DataBind();
        }
        else if (Session["Employee"] == null)
        {
            Response.Redirect("~/production/Login.aspx");
        }
    }

    protected void btnFileUpload_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        RepeaterItem ri = btn.NamingContainer as RepeaterItem;
        int index = ri.ItemIndex;

        RepeaterItem repItem = Repeater1.Items[index];
        FileUpload fu = repItem.FindControl("FileUpload1") as FileUpload;

        //試驗寫法：  // 除錯時，fu 為 null，但ClientID可取得，ri裡面的controls為non-public成員，因此FindControls方法無法取得物件
        //FileUpload fu = ri.FindControl($"{ri.Controls[1].ClientID}") as FileUpload; 

        if (fu.FileName != "")
        {
            // save to the server :
            string uploadpath = "~/production/PeterHsuUpload/" + fu.FileName;
            fu.SaveAs(Server.MapPath(uploadpath));

            HiddenField hf = ri.FindControl("HiddenField1") as HiddenField;
            int Id = Convert.ToInt32(hf.Value);

            bool saveOk = PeterHsuUtilities.SaveMeetingRecordFilePath(Id, uploadpath);

            if (saveOk == true)
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "AlertSuccess", "$('#saveSuccessModal').modal('show');", true);
            }
            else if (saveOk == false)
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "AlertFail", "$('#saveFailModal').modal('show');", true);
                //this.ClientScript.RegisterClientScriptBlock(this.GetType(), "AlertFail", "alert('上傳檔案失敗');", true);
            }
        }
        else if (fu.FileName == "")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "AlertNoFile", "$('#noFileModal').modal('show');", true);
            //this.ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", "alert('請選擇上傳檔案');", true);
        }

        //foreach (RepeaterItem item in Repeater1.Items)
        //{
        //    FileUpload fu = item.FindControl("FileUpload1") as FileUpload;
        //    if (fu.HasFile)
        //    {
        //        // save to the server :
        //        string uploadpath = "~/production/PeterHsuUpload/" + fu.FileName;
        //        fu.SaveAs(Server.MapPath(uploadpath));

        //        HiddenField hf = item.FindControl("HiddenField1") as HiddenField;
        //        int Id = Convert.ToInt32(hf.Value);
        //    }
        //}
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>會議室預約資料異動</title>

    <!-- Datatables -->

    <link href="../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
    
    <%--Popup--%>
    <link href="Magnific-Popup-master/dist/magnific-popup.css" rel="stylesheet" />
    <style>
        .mfp-iframe-scaler iframe {
            background: #fff;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container body">
        <div class="right_col" role="main">
            <div class="">
                <div class="page-title">
                    <div class="title_left">
                        <%-- 最上層 --%>
                        <%--<h3>
                            <asp:Label ID="lStatus" runat="server" Text="Label"></asp:Label>
                            <small>
                                <asp:Label ID="lName" runat="server" Text="Label"></asp:Label></small></h3>--%>
                    </div>
                    <%--<div class="title_right">
                        <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Search for...">
                                <span class="input-group-btn">
                                    <button class="btn btn-secondary" type="button">Go!</button>
                                </span>
                            </div>
                        </div>
                    </div>--%>
                </div>
                <div class="clearfix"></div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 ">
                        <div class="x_panel">
                            <div class="x_title">
                                <h2>會議室預約資料異動</h2>
                                <ul class="nav navbar-right panel_toolbox">
                                    <%--<li>
                                        <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                    </li>--%>
                                    <li class="dropdown">
                                        <%--  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                            <a class="dropdown-item" href="#">Settings 1</a>
                                            <a class="dropdown-item" href="#">Settings 2</a>
                                        </div>--%>
                                    </li>
                                    <li>
                                        <%--<a class="close-link"><i class="fa fa-close"></i></a>--%>
                                    </li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="card-box table-responsive">
                          
                                            <table id="datatable-buttons" class="table table-striped table-bordered" style="width: 100%">
                                                <thead>
                                                    <tr>
                                                        <%--<th>
                                                             全選按鈕 
                                                            <asp:CheckBox ID="CheckBox2" runat="server" onclick="checkAll()" Text="全選" />
                                                        </th>--%>
                                                        <th hidden="hidden">編號</th>
                                                        <th>員工編號</th>
                                                        <th>會議室編號</th>
                                                        <th>開始時間</th>
                                                        <th>開始時間</th>
                                                        <th>上傳會議記錄</th>
                                                        <th class="column-title" style="width: 20%">資料異動</th>
                                                    </tr>
                                                </thead>

                                                <asp:Repeater ID="Repeater1" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td hidden="hidden"><%# Eval ("Id") %></td>
                                                            <td><%# Eval ("EmployeeID") %></td>
                                                            <td><%# Eval ("RoomId") %></td>
                                                            <td><%# Eval ("StartDateTime") %></td>
                                                            <td><%# Eval ("EndDateTime") %></td>
                                                            <td>
                                                                <asp:FileUpload ID="FileUpload1" accept=".docx,.doc,.xlsx,.xls,.pdf" runat="server" />
                                                                <asp:Button CssClass="btn btn-info" ID="btnFileUpload" runat="server" Text="上傳" OnClick="btnFileUpload_Click" />
                                                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval ("Id") %>' />
                                                                <%--<asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Container.ItemIndex %>' />--%>
                                                            </td>
                                                            <td>
                                                                <%--<a class="btn btn-info" href="<%# Eval("Id","MeetingRoomRecordEdit.aspx?id={0}") %>">修改</a>--%>
                                                                <a class="btn btn-danger" href="<%# Eval("Id","MeetingRoomBookingRecordDelete.aspx?id={0}") %>">刪除</a>
                                                            </td>

                                                        </tr>

                                                    </ItemTemplate>

                                                </asp:Repeater>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /page content -->
        </div>
    </div>

    <div class="modal" id="saveSuccessModal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title"><i class="fa fa-comment"></i>成功！</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    檔案已成功上傳至伺服器。
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <asp:Button ID="btnSaveSucess" runat="server" Text="我知道了" class="btn btn-info" data-dismiss="modal" />

                </div>

            </div>
        </div>
    </div>

    <div class="modal" id="saveFailModal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title"><i class="fa fa-comment"></i>失敗！</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    檔案上傳至伺服器失敗。
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <asp:Button ID="btnSaveFail" runat="server" Text="我知道了" class="btn btn-danger" data-dismiss="modal" />

                </div>

            </div>
        </div>
    </div>

    <div class="modal" id="noFileModal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title"><i class="fa fa-comment"></i>失敗！</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    請先選擇檔案。
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <asp:Button ID="Button1" runat="server" Text="我知道了" class="btn btn-danger" data-dismiss="modal" />

                </div>

            </div>
        </div>
    </div>

    <%--<div class="modal" id="Deletemodal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title"><i class="fa fa-warning"></i>溫馨提示</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    您確定要刪除嗎?
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <asp:Button ID="Button4" runat="server" Text="確定" class="btn btn-primary" OnClick="Button4_Click" />
                    <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="remindModal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title"><i class="fa fa-comment"></i>提示訊息</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    請選取資料後再刪除
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <asp:Button ID="Button3" runat="server" Text="確定" class="btn btn-danger" data-dismiss="modal" />

                </div>

            </div>
        </div>
    </div>--%>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">
    <!-- Datatables -->
    <script src="../vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="../vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="../vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="../vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="../vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
    <script src="../vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
    <script src="../vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="../vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
    <script src="../vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
    <script src="../vendors/jszip/dist/jszip.min.js"></script>
    <script src="../vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="../vendors/pdfmake/build/vfs_fonts.js"></script>

    <%--<script src="js/PeterWorkShiftRecordsTable.js"></script>--%>

    <script src="Magnific-Popup-master/dist/jquery.magnific-popup.js"></script>

    <script>
        $(function () {
            $('table').magnificPopup({
                delegate: 'a',
                type: 'iframe',
                closeOnContentClick: false,
                closeOnBgClick: false,
                closeBtnInside: true,
            });
        });
    </script>

</asp:Content>

