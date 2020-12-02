<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //檢查登入  
            if (Session["Employee"] == null)
            {
                Response.Redirect("~/production/Login.aspx");
            }
            //取得使用者
            Employee emp = (Employee)Session["Employee"];

            string lid = Request.QueryString["LeaveId"];

            if (emp.AuthorizationLevel == "Employee")
            {
                if (HRUtility.GetPersonalLeaveRecordByLID(int.Parse(lid)).EmployeeID != emp.EmployeeID)
                {
                    //導向權限不足
                    Response.Redirect("~/production/PermissionDenied.aspx");
                }
            }


            EID.Value = emp.EmployeeID.ToString();
            DepartmentID.Value = emp.DepartmentID.ToString();

            Leave leave = HRUtility.GetPersonalLeaveRecordByLID(int.Parse(lid));
            HRCEID.Value = leave.EmployeeID.ToString();
            HRCEName.Value = leave.Note2;
            LeaveDate.Value = leave.Date;
            TypeOfLeave.Value = leave.TypeOfLeave;
            TimeStart.Value = leave.TimeStart;
            TimeOff.Value = leave.TimeOff;
            Hour.Value = leave.Hour.ToString();
            Reason.Value = leave.Reason;
            if (leave.ProofImg != null)
            {
                ProofImg.ImageUrl = "Roger/Img/Proof/" + leave.ProofImg;
            }
            
            Note.Value = leave.Note1;
            LID.Value = leave.LeaveID.ToString();
            Pass.Value = leave.Passed;

            if (emp.AuthorizationLevel == "Employee")
            {
                ManagementBtnGroup.Style.Add("display", "none");
            }


        }
    }

    //protected void TimeStart_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    int hour = 1;
    //    if (int.Parse(TimeStart.SelectedValue) < int.Parse(TimeOff.SelectedValue))
    //    {
    //        if (int.Parse(TimeStart.SelectedValue) < 12 && int.Parse(TimeOff.SelectedValue) > 12)
    //        {
    //            hour = int.Parse(TimeOff.SelectedValue) - int.Parse(TimeStart.SelectedValue) - 1;
    //        }
    //        else { hour = int.Parse(TimeOff.SelectedValue) - int.Parse(TimeStart.SelectedValue); }
    //        Hour.Value = hour.ToString();
    //    }
    //    Hour.Value = hour.ToString();
    //}

    //protected void HRLeaveBtn1_Click(object sender, EventArgs e)
    //{
    //    if (ProofImg.HasFile)
    //    {
    //        ProofImg.SaveAs(Server.MapPath($"/HRLeaveProof/{ProofImg.FileName}"));
    //    }

    //    bool OK = HRUtility.AddLeave(
    //        new Leave()
    //        {
    //            EmployeeID = int.Parse(HRCEID.Value),
    //            DepartmentID = int.Parse(DepartmentID.Value),
    //            TypeOfLeave = TypeOfLeave.SelectedValue,
    //            Date = LeaveDate.Value,
    //            TimeStart = TimeStart.SelectedValue,
    //            TimeOff = TimeOff.SelectedValue,
    //            Hour = int.Parse(Hour.Value),
    //            Reason = Reason.Value,
    //            ProofImg = ProofImg.HasFile ? ProofImg.FileName : "",
    //            Passed = "未審核"
    //        });
    //    if (OK)
    //    {
    //        Page.ClientScript.RegisterStartupScript(
    //        Page.GetType(),
    //        "MessageBox",
    //        "<script>$('#HRLeaveR1').modal('show')<" + "/script>");
    //    }
    //    else
    //    {
    //        Page.ClientScript.RegisterStartupScript(
    //        Page.GetType(),
    //        "MessageBox",
    //        "<script>$('#HRLeaveR1').modal('show')<" + "/script>");
    //    }
    //}
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="right_col" role="main">

        <asp:HiddenField ID="DepartmentID" runat="server" />
        <asp:HiddenField ID="EID" runat="server" />
        <asp:HiddenField ID="LID" runat="server" />

        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>Leave<small>請假系統</small></h3>
                </div>

            </div>
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Personal Leave <small>個人請假系統</small></h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <%--請假系統--%>
                        <div class="x_content">
                            <br />
                            <div id="demo-form2" class="form-horizontal form-label-left">

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="HRCEID">員工編號:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input id="HRCEID" type="text" class="form-control" readonly="readonly" placeholder="Read-Only Input" runat="server">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="HRCEName">員工姓名:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input id="HRCEName" type="text" class="form-control" readonly="readonly" placeholder="Read-Only Input" runat="server">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="LeaveDate">請假日期:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input id="LeaveDate" type="text" class="form-control" readonly="readonly" placeholder="Read-Only Input" runat="server">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="TypeOfLeave">假別:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input id="TypeOfLeave" type="text" class="form-control" readonly="readonly" placeholder="Read-Only Input" runat="server">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="TimeStart">起始時間:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input id="TimeStart" type="text" class="form-control" readonly="readonly" placeholder="Read-Only Input" runat="server">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="TimeOff">結束時間:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input id="TimeOff" type="text" class="form-control" readonly="readonly" placeholder="Read-Only Input" runat="server">
                                    </div>
                                </div>


                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="Hour">時數:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input id="Hour" type="text" class="form-control" readonly="readonly" placeholder="Read-Only Input" runat="server">
                                    </div>
                                </div>


                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="Reason">事由:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <textarea id="Reason" class="form-control" name="Reason" readonly="readonly" data-parsley-trigger="keyup" data-parsley-minlength="0" data-parsley-maxlength="300" data-parsley-minlength-message="" data-parsley-validation-threshold="10" runat="server"></textarea>

                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="HRCEName">請假證明:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:Image ID="ProofImg" runat="server" />
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="Pass">審核狀態:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input id="Pass" type="text" class="form-control" readonly="readonly" placeholder="Read-Only Input" runat="server">
                                    </div>
                                </div>


                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="Reason">註解:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <textarea id="Note" class="form-control" name="Reason" readonly="readonly" data-parsley-trigger="keyup" data-parsley-minlength="0" data-parsley-maxlength="300" data-parsley-minlength-message="" data-parsley-validation-threshold="10" runat="server"></textarea>

                                    </div>
                                </div>


                                <div id="ManagementBtnGroup" class="col-md-6 offset-md-3" runat="server">
                                    <hr />
                                    <input id="LeavePassed" type="button" value="審核通過" class="btn btn-outline-success center" data-toggle="modal" data-target="#LeavePassModal" />
                                    <input id="LeaveReturned" type="button" value="退件" class="btn btn-outline-danger center" data-toggle="modal" data-target="#LeaveReturnModal" />
                                </div>




                                <%--<div class="ln_solid"></div>
                                <div class="form-group">
                                    <div class="col-md-6 col-sm-6 offset-md-3">
                                        <input id="LeaveSubmit" type="button" value="送出" class="btn btn-outline-success" data-toggle="modal" data-target="#HRLeave1" />
                                        <button class="btn btn-outline-danger" type="reset">Reset</button>--%>

                                <%--<asp:Button ID="HRCButtonA1" runat="server" Text="上班打卡" Cssclass="btn btn-success" OnClick="HRCButtonA1_Click" />--%>
                                <%--<asp:Button ID="HRCButtonA2" runat="server" Text="下班打卡" Cssclass="btn btn-danger" OnClick="HRCButtonA2_Click" />--%>


                                <!-- Modal -->
                                <div class="modal fade" id="LeavePassModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="LeavePassModalTitle">確認?</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                是否進行假單審核作業?
                                            </div>
                                            <div class="modal-footer">
                                                <%--<asp:Button ID="HRLeaveBtn1" CssClass="btn btn-outline-success" runat="server" Text="確認" OnClick="HRLeaveBtn1_Click" />--%>
                                                <input id="HRLeaveBtn1" type="button" value="確認" class="btn btn-outline-success" onclick="LeavePass()" data-dismiss="modal" />
                                                <button type="button" class="btn btn-outline-primary" data-dismiss="modal">取消</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <!-- Modal -->
                                <div class="modal fade" id="LeavePassResult" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="LeavePassResultTitle">完成</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                假單審核已完成
                                            </div>
                                            <div class="modal-footer">
                                                <a href="RogerLeaveRecordManager.aspx">
                                                    <input id="Button1" type="button" value="回列表" class="btn btn-outline-primary" /></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal -->
                                <div class="modal fade" id="LeaveReturnModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="LeaveReturnModalTitle">退件</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <span style="color: red;">是否進行退件作業</span>
                                                退件理由:<input id="ReturnReason" type="text" />
                                            </div>
                                            <div class="modal-footer">
                                                <input type="button" value="確認" class="btn btn-danger" onclick="LeaveReturn()" data-dismiss="modal" />
                                                <button type="button" class="btn btn-outline-primary" data-dismiss="modal">取消</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal -->
                                <div class="modal fade" id="LeaveReturnResult" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="LeaveReturnResultTitle">完成</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                退件程序已完成
                                            </div>
                                            <div class="modal-footer">
                                                <a href="RogerLeaveRecordManager.aspx">
                                                    <input id="Button2" type="button" value="回列表" class="btn btn-outline-primary" /></a>
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
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">
    <script>
        function LeavePass() {

            var A = $("#ContentPlaceHolder1_LID").val();
            $.ajax({
                type: 'POST',
                url: '/production/HRWebService.asmx/LeavePass',
                data: JSON.stringify({ LID: A }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == true) {
                        $('#LeavePassResult').modal('show');
                    }
                },
                error: function (err) {
                    alert(err);
                }
            });
        }

        function LeaveReturn() {
            alert("OK");
            var A = $("#ContentPlaceHolder1_LID").val();
            var B = $("#ReturnReason").val();
            var C = $("#ContentPlaceHolder1_EID").val();
            $.ajax({
                type: 'POST',
                url: '/production/HRWebService.asmx/LeaveReturn',
                data: JSON.stringify({ LID: A, reason: B, MID: C }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d == true) {
                        $('#LeaveReturnResult').modal('show');
                    }
                },
                error: function (err) {
                    alert(err);
                }
            });
        }





        $(function () {






            //$("#HRLeaveBtn1").click(function () {

            //    var HRLeaveData = {
            //        EID: $("#ContentPlaceHolder1_HRCEID").val(),
            //        DID: $("#ContentPlaceHolder1_DepartmentID").val(),
            //        type: $("#ContentPlaceHolder1_HRCNowTime").val(),
            //        date: $("#LeaveDate").val(),
            //        timeStart: $("#ContentPlaceHolder1_HRCNowTime").val(),
            //        timeOff: $("#ContentPlaceHolder1_HRCNowTime").val(),
            //        hour: $("#ContentPlaceHolder1_HRCNowTime").val(),
            //        reason: $("#ContentPlaceHolder1_HRCNowTime").val(),
            //        imgUrl: $("#ContentPlaceHolder1_HRCNowTime").val()
            //    };

            //    $.ajax({
            //        type: 'POST',
            //        url: '/production/HRWebService.asmx/AddClockInRecord',
            //        data: JSON.stringify(HRCIData),
            //        contentType: "application/json;charset=utf-8",
            //        dataType: "json",
            //        success: function (data) {
            //            if (data.d == true) {
            //                $('#HRCButtonA1_1').modal('show');
            //            }
            //            else {
            //                $('#HRCButtonA1_2').modal('show');
            //            }
            //        },
            //        error: function (err) {
            //            console.log(err);
            //        }
            //    });

            //});
        });

    </script>
</asp:Content>

