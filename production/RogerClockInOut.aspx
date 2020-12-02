<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        //檢查登入  
        if (Session["Employee"] == null)
        {
            Response.Redirect("~/production/Login.aspx");
        }
        //取得使用者
        Employee emp = (Employee)Session["Employee"];

        HRCEID.Value = emp.EmployeeID.ToString();
        HRCEName.Value = emp.LastName+emp.FirstName;
        DepartmentID.Value = emp.DepartmentID.ToString();
        
        //HRCNowDate.Value = "2020/10/25";
        //HRCNowTime.Value = "18:33:20";

    }

    protected void HRtimer_Tick(object sender, EventArgs e)
    {
        HRCNowDate.Value = DateTime.Now.ToString("yyyy/MM/dd");
        HRCNowTime.Value = DateTime.Now.ToString("HH:mm:ss");
    }

    //protected void HRCButtonA1_Click(object sender, EventArgs e)
    //{
    //    ClockInOutRecord c = new ClockInOutRecord()
    //    {
    //        EmployeeID = int.Parse(HRCEID.Value),
    //        DepartmentID = int.Parse(DepartmentID.Value),
    //        Date = HRCNowDate.Value,
    //        ClockIn = HRCNowTime.Value,
    //        Passed = "否",
    //        Note1 = HRCNowDate.Value.Substring(0, 4),
    //        Note2 = HRCNowDate.Value.Substring(5, 2)
    //    };

    //    bool OK = HRUtility.InsertClockInRecord(c);
    //    if (OK)
    //    {
    //        //HRCButtonA1_1.Visible = true;
    //    }
    //    else
    //    {
    //        //HRCButtonA1_2.Visible = true;
    //    }

    //}

    //protected void HRCButtonA2_Click(object sender, EventArgs e)
    //{
    //    ClockInOutRecord c = new ClockInOutRecord()
    //    {
    //        EmployeeID = int.Parse(HRCEID.Value),
    //        DepartmentID = int.Parse(DepartmentID.Value),
    //        Date = HRCNowDate.Value,
    //        ClockOut = HRCNowTime.Value
    //    };

    //    bool OK = HRUtility.InsertClockOutRecord(c);
    //    Response.Write(OK);
    //}

    protected void DropDownList1and2_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
       
<asp:HiddenField ID="DepartmentID" runat="server"></asp:HiddenField>

    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left style="width:100%"">
                    <h3>Clock In / Out</h3>
                    <h3><small>打卡系統</small></h3>
                </div>

            </div>
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Personal Clock In / Out <small>個人打卡系統</small></h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <%--打卡系統--%>
                        <div class="x_content">
                            <br />
                            <div id="demo-form2" class="form-horizontal form-label-left">


                                <div class="form-group row">
                                    <div class="col-md-6 col-sm-6" style=" margin:0 auto;">
                                                
                                    <iframe src="http://free.timeanddate.com/clock/i7jybbng/n241/szw300/szh300/hoc2a3f54/hbw2/cf100/hgr0/fas14/fac2a3f54/fdi76/mqc2a3f54/mqs3/mql13/mqw2/mqd98/mhc2a3f54/mhs3/mhl13/mhw2/mhd98/mmc2a3f54/mml5/mmw1/mmd94/hwm2/hhs2/hhb18/hms2/hml80/hmb18/hmr7/hsc2a3f54/hss1/hsl90/hsr3" frameborder="0" width="300" height="300"></iframe>
                                            </div>

                                </div>








                                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>

                                        <asp:Timer ID="HRtimer" runat="server" Interval="1000" OnTick="HRtimer_Tick"></asp:Timer>

                                        <div class="form-group row">
                                            <label class="col-form-label col-md-3 col-sm-3 label-align" for="HRCNowDate">日期:</label>
                                            <div class="col-md-6 col-sm-6 ">
                                                <input id="HRCNowDate" type="text" class="form-control" readonly="readonly" runat="server">
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-form-label col-md-3 col-sm-3 label-align" for="HRCNowTime">現在時間:</label>
                                            <div class="col-md-6 col-sm-6 ">
                                                <input id="HRCNowTime" type="text" class="form-control" readonly="readonly" runat="server">
                                            </div>
                                        </div>

                                    </ContentTemplate>
                                </asp:UpdatePanel>

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

                                <div class="ln_solid"></div>
                                <div class="item form-group">
                                    <div class="col-md-6 col-sm-6 offset-md-3">
                                        <input id="HRCButton1" type="button" value="上班打卡" class="btn btn-outline-success" data-toggle="modal" data-target="#HRCButton1_1" />
                                        <input id="HRCButton2" type="button" value="下班打卡" class="btn btn-outline-danger" data-toggle="modal" data-target="#HRCButton2_1"/>
                                        <%--<asp:Button ID="HRCButtonA1" runat="server" Text="上班打卡" Cssclass="btn btn-success" OnClick="HRCButtonA1_Click" />--%>
                                        <%--<asp:Button ID="HRCButtonA2" runat="server" Text="下班打卡" Cssclass="btn btn-danger" OnClick="HRCButtonA2_Click" />--%>
                                                                               

                                        <!-- Modal -->
                                        <div class="modal fade" id="HRCButton1_1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="HRCButton1_1Title">確認?</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        是否進行上班打卡?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <input id="HRCButtonA1" type="button" value="上班打卡" class="btn btn-success" data-dismiss="modal"/>                                                        
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Modal -->
                                        <div  class="modal fade" id="HRCButtonA1_1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="HRCButtonA1_1LongTitle">完成!</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        上班打卡成功!
                                                    </div>
                                                    <div class="modal-footer">                                                        
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Modal -->
                                        <div  class="modal fade" id="HRCButtonA1_2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="HRCButtonA1_2LongTitle">錯誤!</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <span style="color:red;">打卡失敗或重複打卡!</span>
                                                    </div>
                                                    <div class="modal-footer">                                                        
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="modal fade" id="HRCButton2_1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="HRCButton2_1Title">確認?</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        是否進行下班打卡?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <input id="HRCButtonA2" type="button" value="下班打卡" class="btn btn-success" data-dismiss="modal"/>                                                        
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Modal -->
                                        <div  class="modal fade" id="HRCButtonA2_1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="HRCButtonA2_1LongTitle">完成!</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        下班打卡成功!
                                                    </div>
                                                    <div class="modal-footer">                                                        
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
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

            $("#HRCButtonA1").click(function () {
                
                        var HRCIData = {
                            EID: $("#ContentPlaceHolder1_HRCEID").val(),
                            DID: $("#ContentPlaceHolder1_DepartmentID").val(),
                            date: $("#ContentPlaceHolder1_HRCNowDate").val(),
                            CIn: $("#ContentPlaceHolder1_HRCNowTime").val()
                        };

                        $.ajax({
                            type: 'POST',
                            url: '/production/HRWebService.asmx/AddClockInRecord',
                            data: JSON.stringify(HRCIData),
                            contentType: "application/json;charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                if (data.d == true) {
                                    $('#HRCButtonA1_1').modal('show');
                                }
                                else {
                                    $('#HRCButtonA1_2').modal('show');
                                }
                            },
                            error: function (err) {
                                console.log(err);
                            }
                        });
                    
            });


            $("#HRCButtonA2").click(function () {
                
                        var HRCOData = {
                            EID: $("#ContentPlaceHolder1_HRCEID").val(),
                            DID: $("#ContentPlaceHolder1_DepartmentID").val(),
                            date: $("#ContentPlaceHolder1_HRCNowDate").val(),
                            COut: $("#ContentPlaceHolder1_HRCNowTime").val()
                        };

                        $.ajax({
                            type: 'POST',
                            url: '/production/HRWebService.asmx/AddClockOutRecord',
                            data: JSON.stringify(HRCOData),
                            contentType: "application/json;charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                if (data.d == true) {
                                    $('#HRCButtonA2_1').modal('show');
                                }
                                else {
                                    $('#HRCButtonA1_2').modal('show');
                                }
                            },
                            error: function (err) {                                
                                console.log(err);
                            }
                        });
                    

            });


        });

    </script>




</asp:Content>

