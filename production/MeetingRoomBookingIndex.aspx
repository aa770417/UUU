<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
            Repeater1.DataSource = PeterHsuUtilities.GetMeetRoomBookingRecords();
            Repeater1.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- Datatables -->

    <link href="../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">

    <!-- PNotify -->
    <link href="../vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="../vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="../vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="right_col" role="main">
        <div class="">
            <div class="">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2><%--<i class="fa fa-bars"></i>--%>會議室預約管理系統 </h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <a class="dropdown-item" href="#">Settings 1</a>
                                        <a class="dropdown-item" href="#">Settings 2</a>
                                    </div>
                                </li>
                                <%--<li><a class="close-link"><i class="fa fa-close"></i></a>
                                </li>--%>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">

                            <div class="col-xs-3">
                                <!-- required for floating -->
                                <!-- Nav tabs -->
                                <div class="nav nav-tabs flex-column  bar_tabs" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                                    <a class="nav-link active" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">會議室1</a>
                                    <a class="nav-link" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false">會議室2</a>
                                    <a class="nav-link" id="v-pills-messages-tab" data-toggle="pill" href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false">會議室3</a>
                                    <a class="nav-link" id="v-pills-settings-tab" data-toggle="pill" href="#v-pills-settings" role="tab" aria-controls="v-pills-settings" aria-selected="false">會議室4</a>
                                    <a class="nav-link" id="v-pills-settings5-tab" data-toggle="pill" href="#v-pills-settings5" role="tab" aria-controls="v-pills-settings5" aria-selected="false">會議室5</a>
                                </div>
                            </div>

                            <div class="col-xs-9">
                                <!-- Tab panes -->

                                <div class="tab-content" id="v-pills-tabContent">
                                    <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
                                        <h2>
                                            <a class="btn btn-round btn-success" href="MeetingRoomBookingAdd.aspx?id=1">預約</a>
                                            <%--<asp:Button ID="Button1" CssClass="btn btn-round btn-success" runat="server" Text="預約" />--%>
                                            編號：1，可容納人數：300，地點：12A</h2>
                                        <img class="img-fluid rounded" src="PeterHsuImages/MeetingRoomStandard1.jpg" />
                                    </div>

                                    <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
                                        <h2>
                                            <a class="btn btn-round btn-success" href="MeetingRoomBookingAdd.aspx?id=2">預約</a>
                                            <%--<asp:Button ID="Button2" CssClass="btn btn-round btn-success" runat="server" Text="預約" />--%>
                                            編號：2，可容納人數：300，地點：12B</h2>
                                        <img class="img-fluid rounded" src="PeterHsuImages/MeetingRoomStandard2.jpg" />
                                    </div>

                                    <div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
                                        <h2>
                                            <a class="btn btn-round btn-success" href="MeetingRoomBookingAdd.aspx?id=3">預約</a>
                                            <%--<asp:Button ID="Button3" CssClass="btn btn-round btn-success" runat="server" Text="預約" />--%>
                                            編號：3，可容納人數：300，地點：12C</h2>
                                        <img class="img-fluid rounded" src="PeterHsuImages/MeetingRoomStandard3.jpg" />
                                    </div>

                                    <div class="tab-pane fade" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
                                        <h2>
                                            <a class="btn btn-round btn-success" href="MeetingRoomBookingAdd.aspx?id=4">預約</a>
                                            <%--<asp:Button ID="Button4" CssClass="btn btn-round btn-success" runat="server" Text="預約" />--%>
                                            編號：4，可容納人數：300，地點：12D</h2>
                                        <img class="img-fluid rounded" src="PeterHsuImages/MeetingRoomStandard4.jpg" />
                                    </div>

                                    <div class="tab-pane fade" id="v-pills-settings5" role="tabpanel" aria-labelledby="v-pills-settings5-tab">
                                        <h2>
                                            <a class="btn btn-round btn-success" href="MeetingRoomBookingAdd.aspx?id=5">預約</a>
                                            <%--<asp:Button ID="Button5" CssClass="btn btn-round btn-success" runat="server" Text="預約" />--%>
                                            編號：5，可容納人數：300，地點：12E</h2>
                                        <img class="img-fluid rounded" src="PeterHsuImages/MeetingRoomStandard5.jpg" />
                                    </div>
                                </div>
                            </div>

                            <div class="clearfix"></div>

                        </div>
                    </div>
                </div>

                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>會議室預約紀錄表</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <a class="dropdown-item" href="#">Settings 1</a>
                                        <a class="dropdown-item" href="#">Settings 2</a>
                                    </div>
                                </li>
                                <%--<li><a class="close-link"><i class="fa fa-close"></i></a>
                                </li>--%>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="card-box table-responsive">
                                        <%--                                        <p class="text-muted font-13 m-b-30">
                                            The Buttons extension for DataTables provides a common set of options, API methods and styling to display buttons on a page that will interact with a DataTable. The core library provides the based framework upon which plug-ins can built.
                   
                                        </p>--%>
                                        <asp:Repeater ID="Repeater1" runat="server">
                                            <HeaderTemplate>
                                                <table id="datatable-buttons" class="table table-striped table-bordered" style="width: 100%">
                                                    <thead>
                                                        <tr>
                                                            <th hidden="hidden">編號</th>
                                                            <th>會議室編號</th>
                                                            <th>員工編號</th>
                                                            <th>開始日期時間</th>
                                                            <th>結束日期時間</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                            </HeaderTemplate>

                                            <ItemTemplate>
                                                <tr>
                                                    <td hidden="hidden"><%# Eval("Id") %></td>
                                                    <td><%# Eval("RoomId") %></td>
                                                    <td><%# Eval("EmployeeID") %></td>
                                                    <td><%# Eval("StartDateTime", "{0:yyyy/MM/dd HH:mm}") %></td>
                                                    <td><%# Eval("EndDateTime", "{0:yyyy/MM/dd HH:mm}") %></td>
                                                    <%--<td><a href="<%# Eval("Id","ProductEdit.aspx?id={0}") %>">修改</a>  </td>--%>
                                                    <%--<td><a onclick="checkDelete()" href="<%# Eval("Id","ProductDelete.aspx?id={0}") %>">刪除</a>  </td>--%>
                                                </tr>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                                </tbody>
                                        </table>
                                            </FooterTemplate>

                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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

    <!-- PNotify -->
    <script src="../vendors/pnotify/dist/pnotify.js"></script>
    <script src="../vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="../vendors/pnotify/dist/pnotify.nonblock.js"></script>
</asp:Content>

