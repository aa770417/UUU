<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Label1.Visible = false;
        Label1.Text = "";

        if (myDatepickerInput.Value == "" || myDatepickerInput.Value == null || myDatepickerInput1.Value == "" || myDatepickerInput1.Value == null)
        {
            Label1.Visible = true;
            Label1.ForeColor = System.Drawing.Color.Red;
            Label1.Text = "請輸入時間。";
        }
        else if (Convert.ToDateTime(myDatepickerInput.Value) >= Convert.ToDateTime(myDatepickerInput1.Value))
        {
            Label1.Visible = true;
            Label1.ForeColor = System.Drawing.Color.Red;
            Label1.Text = "開始時間必須在結束時間以前，請重新輸入";
        }
        else
        {
            MeetingRoomBookingRecord mrbRecord = new MeetingRoomBookingRecord()
            {
                RoomId = Convert.ToInt32(txtMeetRoomId.Text),
                EmployeeID = Convert.ToInt32(txtEmpID.Text),
                StartDateTime = Convert.ToDateTime(myDatepickerInput.Value),
                EndDateTime = Convert.ToDateTime(myDatepickerInput1.Value)
            };

            bool AddSuccess = PeterHsuUtilities.AddMeetRoomBookingRecord(mrbRecord);

            if (AddSuccess == true)
            {

                Response.Redirect("~/production/MeetingRoomBookingIndex.aspx");
            }
            else
            {
                //this.ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", "alert('此時段已有預約，請重新輸入');", true);

                Label1.Visible = true;
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "此時段已有預約，請重新輸入。";
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {

            //string id = Request.QueryString["id"];
            //string[] empsession = { "3", "軒華", "1", "主管" };
            //Session["Employee"] = empsession;

            //txtMeetRoomId.Text = id;
            //txtEmpID.Text = empsession[0];


            Employee empSession = (Employee)Session["Employee"];
            string id = Request.QueryString["id"];
            Session["Employee"] = empSession;

            txtMeetRoomId.Text = id;
            txtEmpID.Text = empSession.EmployeeID.ToString();
        }
    }

    protected void btnReturnToIndex_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/production/MeetingRoomBookingIndex.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- bootstrap-wysiwyg -->
    <link href="../vendors/google-code-prettify/bin/prettify.min.css" rel="stylesheet" />
    <!-- Select2 -->
    <link href="../vendors/select2/dist/css/select2.min.css" rel="stylesheet" />
    <!-- Switchery -->
    <link href="../vendors/switchery/dist/switchery.min.css" rel="stylesheet" />
    <!-- bootstrap-datetimepicker -->
    <link href="../vendors/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="right_col" role="main">
        <div class="">
            <div class="">
                <div class="row">
                    <div class="col-sm-12 col-md-12  col-lg-12">
                        <div class="x_panel">
                            <div class="x_title">
                                <h2>預約會議室</h2>
                                <%--<ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <a class="dropdown-item" href="#">Settings 1</a>
                                        <a class="dropdown-item" href="#">Settings 2</a>
                                    </div>
                                </li>
                                <li><a class="close-link"><i class="fa fa-close"></i></a>
                                </li>
                            </ul>--%>
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <br />
                                <div class="form-label-left input_mask" runat="server">

                                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

                                    <div class="form-group row">
                                        <label class="col-form-label col-md-3 col-sm-3 text-right">
                                            會議室編號
                                        </label>
                                        <div class="col-md-6 col-sm-6  form-group has-feedback">
                                            <asp:TextBox ID="txtMeetRoomId" runat="server" Enabled="False" ReadOnly="True"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-form-label col-md-3 col-sm-3 text-right">
                                            員工編號
                                        </label>
                                        <div class="col-md-6 col-sm-6  form-group has-feedback">
                                            <asp:TextBox ID="txtEmpID" runat="server" Enabled="False" ReadOnly="True"></asp:TextBox>
                                        </div>
                                    </div>

                                    <%--<div class="form-group row">
                                        <label class="col-form-label col-md-3 col-sm-3 text-right">
                                            員工姓氏
                                        </label>
                                        <div class="col-md-6 col-sm-6  form-group has-feedback">
                                            <asp:TextBox ID="txtEmpLastName" runat="server" Enabled="False" ReadOnly="True"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-form-label col-md-3 col-sm-3 text-right">
                                            員工名字
                                        </label>
                                        <div class="col-md-6 col-sm-6  form-group has-feedback">
                                            <asp:TextBox ID="txtEmpFirstName" runat="server" Enabled="False" ReadOnly="True"></asp:TextBox>
                                        </div>
                                    </div>--%>


                                    <div class="form-group row">
                                        <label class="col-form-label col-md-3 col-sm-3 text-right">
                                            開始日期時間 <span class="required">*</span>
                                        </label>
                                        <div class='col-sm-4'>
                                            <div class="form-group">
                                                <div class='input-group date' id='myDatepicker'>
                                                    <input id='myDatepickerInput' type='text' class="form-control" required="required" runat="server" />
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-form-label col-md-3 col-sm-3 text-right">
                                            結束日期時間 <span class="required">*</span>
                                        </label>
                                        <div class='col-sm-4'>
                                            <div class="form-group">
                                                <div class='input-group date' id='myDatepicker1'>
                                                    <input id='myDatepickerInput1' type='text' class="form-control" required="required" runat="server" />
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-form-label col-md-3 col-sm-3 text-right">
                                        </label>
                                        <asp:Label ID="Label1" CssClass="col-form-label col-md-3 col-sm-3 text-right" runat="server" Text="" Visible="false"></asp:Label>
                                    </div>

                                    <div class="ln_solid"></div>
                                    <div class="form-group row">
                                        <div class="col-md-9 col-sm-9  offset-md-3">
                                            <%--<button id="btnEdit" type="submit" class="btn btn-success" runat="server">修改</button>--%>
                                            <asp:Button ID="btnAdd" CssClass="btn btn-success" runat="server" Text="預約" OnClick="btnAdd_Click" />
                                            <asp:Button ID="btnReturnToIndex" CssClass="btn btn-success" runat="server" Text="返回" OnClick="btnReturnToIndex_Click" />
                                        </div>
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
    <!-- bootstrap-wysiwyg -->
    <script src="../vendors/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js"></script>
    <script src="../vendors/jquery.hotkeys/jquery.hotkeys.js"></script>
    <script src="../vendors/google-code-prettify/src/prettify.js"></script>
    <!-- bootstrap-datetimepicker -->
    <script src="../vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
    <!-- jQuery Tags Input -->
    <script src="../vendors/jquery.tagsinput/src/jquery.tagsinput.js"></script>
    <!-- Switchery -->
    <script src="../vendors/switchery/dist/switchery.min.js"></script>
    <!-- Select2 -->
    <script src="../vendors/select2/dist/js/select2.full.min.js"></script>
    <!-- Parsley -->
    <script src="../vendors/parsleyjs/dist/parsley.min.js"></script>
    <!-- Autosize -->
    <script src="../vendors/autosize/dist/autosize.min.js"></script>
    <!-- jQuery autocomplete -->
    <script src="../vendors/devbridge-autocomplete/dist/jquery.autocomplete.min.js"></script>

    <script>
        $(function () {
            $('#myDatepicker').datetimepicker({
                format: 'YYYY/MM/DD HH:mm'
            });

            $('#myDatepicker1').datetimepicker({
                format: 'YYYY/MM/DD HH:mm'
            });
       
        });
    </script>
</asp:Content>

