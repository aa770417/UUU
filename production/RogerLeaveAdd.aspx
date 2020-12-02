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

            HRCEID.Value = emp.EmployeeID.ToString();
            HRCEName.Value = emp.LastName + emp.FirstName;
            DepartmentID.Value = emp.DepartmentID.ToString();

            //生理假 判斷
            if (emp.Gender == "F")
            {
                TypeOfLeave.Items.RemoveAt(3);
                //TypeOfLeaveF.Items[3].Attributes["disabled"] = "disabled";
                //TypeOfLeave.Items[3].Attributes["css"] = "";
                //DropDownList.Items.RemoveAt(index);
            }
            //else { TypeOfLeaveM.Visible = true; }

        }
    }

    protected void TimeStart_SelectedIndexChanged(object sender, EventArgs e)
    {
        int hour = 1;
        if (int.Parse(TimeStart.SelectedValue) < int.Parse(TimeOff.SelectedValue))
        {
            if (int.Parse(TimeStart.SelectedValue) < 12 && int.Parse(TimeOff.SelectedValue) > 12)
            {
                hour = int.Parse(TimeOff.SelectedValue) - int.Parse(TimeStart.SelectedValue) - 1;
            }
            else { hour = int.Parse(TimeOff.SelectedValue) - int.Parse(TimeStart.SelectedValue); }
            Hour.Value = hour.ToString();
        }
        Hour.Value = hour.ToString();
    }

    protected void HRLeaveBtn1_Click(object sender, EventArgs e)
    {
        if (ProofImg.HasFile)
        {            
            ProofImg.SaveAs(Server.MapPath($"~/production/Roger/Img/Proof/{ProofImg.FileName}"));
        }

        bool OK = HRUtility.AddLeave(
            new Leave()
            {
                EmployeeID = int.Parse(HRCEID.Value),
                DepartmentID = int.Parse(DepartmentID.Value),
                TypeOfLeave = TypeOfLeave.SelectedValue,
                Date = LeaveDate.Value,
                TimeStart = TimeStart.SelectedValue,
                TimeOff = TimeOff.SelectedValue,
                Hour = int.Parse(Hour.Value),
                Reason = Reason.Value,
                ProofImg = ProofImg.HasFile ?  ProofImg.FileName : "",
                Passed = "未審核"
            });

        if (OK)
        {
            Page.ClientScript.RegisterStartupScript(
            Page.GetType(),
            "MessageBox",
            "<script>$('#HRLeaveR1').modal('show')<" + "/script>");
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(
            Page.GetType(),
            "MessageBox",
            "<script>$('#HRLeaveR1').modal('show')<" + "/script>");
        }

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="right_col" role="main">

        <asp:HiddenField ID="DepartmentID" runat="server" />
        <asp:HiddenField ID="EID" runat="server" />

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
                                        <input runat="server" id="LeaveDate" class="date-picker form-control" placeholder="yyyy/mm/dd" type="text" onfocus="this.type='date'" onmouseover="this.type='date'" onclick="this.type = 'date'" onblur="this.type='text'" onmouseout="timeFunctionLong(this)">
                                        <script>
                                            function timeFunctionLong(input) {
                                                setTimeout(function () {
                                                    input.type = 'text';
                                                }, 60000);
                                            }
                                        </script>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="TypeOfLeave">假別:</label>
                                    <div class="col-md-6 col-sm-6 ">


                                        <asp:DropDownList ID="TypeOfLeave" runat="server" CssClass="select2_single form-control">
                                            <asp:ListItem Value="公假">公假</asp:ListItem>
                                            <asp:ListItem Value="事假">事假</asp:ListItem>
                                            <asp:ListItem Value="病假">病假</asp:ListItem>
                                            <asp:ListItem Value="生理假">生理假</asp:ListItem>
                                            <asp:ListItem Value="婚產假">婚產假</asp:ListItem>
                                            <asp:ListItem Value="喪假">喪假</asp:ListItem>
                                        </asp:DropDownList>


                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="TimeStart">起始時間:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:DropDownList ID="TimeStart" runat="server" CssClass="select2_single form-control">
                                            <asp:ListItem Value="9">9:00</asp:ListItem>
                                            <asp:ListItem Value="10">10:00</asp:ListItem>
                                            <asp:ListItem Value="11">11:00</asp:ListItem>
                                            <asp:ListItem Value="13">13:00</asp:ListItem>
                                            <asp:ListItem Value="14">14:00</asp:ListItem>
                                            <asp:ListItem Value="15">15:00</asp:ListItem>
                                            <asp:ListItem Value="16">16:00</asp:ListItem>
                                            <asp:ListItem Value="17">17:00</asp:ListItem>
                                        </asp:DropDownList>

                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="TimeOff">結束時間:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <asp:DropDownList ID="TimeOff" runat="server" class="select2_single form-control" OnSelectedIndexChanged="TimeStart_SelectedIndexChanged" AutoPostBack="True">
                                            <asp:ListItem Value="10">10:00</asp:ListItem>
                                            <asp:ListItem Value="11">11:00</asp:ListItem>
                                            <asp:ListItem Value="13">13:00</asp:ListItem>
                                            <asp:ListItem Value="14">14:00</asp:ListItem>
                                            <asp:ListItem Value="15">15:00</asp:ListItem>
                                            <asp:ListItem Value="16">16:00</asp:ListItem>
                                            <asp:ListItem Value="17">17:00</asp:ListItem>
                                            <asp:ListItem Value="18">18:00</asp:ListItem>
                                        </asp:DropDownList>

                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="Hour">時數:</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <input id="Hour" type="text" value="1" class="form-control" readonly="readonly" runat="server">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="Reason">事由:(0-300字)</label>
                                    <div class="col-md-6 col-sm-6 ">
                                        <textarea id="Reason" class="form-control" name="Reason" data-parsley-trigger="keyup" data-parsley-minlength="0" data-parsley-maxlength="300" data-parsley-minlength-message="最少需填入2個字" data-parsley-validation-threshold="10" runat="server"></textarea>

                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="ProofImg">請假證明:</label>
                                    <div class="col-md-6 col-sm-6 ">

                                        <asp:FileUpload ID="ProofImg" runat="server" accept=".jpg,.png,.jpeg" />
                                    </div>
                                </div>








                                <div class="ln_solid"></div>
                                <div class="form-group">
                                    <div class="col-md-6 col-sm-6 offset-md-3">
                                        <input id="LeaveSubmit" type="button" value="送出" class="btn btn-outline-success" data-toggle="modal" data-target="#HRLeave1" />
                                        <button class="btn btn-outline-danger" type="reset">Reset</button>

                                        <%--<asp:Button ID="HRCButtonA1" runat="server" Text="上班打卡" Cssclass="btn btn-success" OnClick="HRCButtonA1_Click" />--%>
                                        <%--<asp:Button ID="HRCButtonA2" runat="server" Text="下班打卡" Cssclass="btn btn-danger" OnClick="HRCButtonA2_Click" />--%>


                                        <!-- Modal -->
                                        <div class="modal fade" id="HRLeave1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="#HRLeave1Title">確認?</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        是否進行請假單送出作業?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <asp:Button ID="HRLeaveBtn1" CssClass="btn btn-outline-success" runat="server" Text="確認" OnClick="HRLeaveBtn1_Click" />
                                                        <%--<input id="HRLeaveBtn1" type="button" value="確認" class="btn btn-success" data-dismiss="modal" runat="server"/>--%>
                                                        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">取消</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <!-- Modal -->
                                        <div class="modal fade" id="HRLeaveR1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="#HRLeaveR1Title">完成</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        請假申請已完成
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-outline-primary" data-dismiss="modal">確認</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Modal -->
                                        <div class="modal fade" id="HRLeaveR2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="#HRLeaveR2Title">失敗</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <span style="color: red;">申請失敗，請檢查輸入格式及請假紀錄或聯繫管理人員</span>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-outline-primary" data-dismiss="modal">確認</button>
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
        </div>


    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">
    <script>
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

