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

          
        EID.Value = emp.EmployeeID.ToString();
        DID.Value = emp.DepartmentID.ToString();

        //RepeaterReceive.DataSource = MessageUtility.GetPersonalReceiveMessage(int.Parse(EmployeeSession[0]));
        //RepeaterReceive.DataBind();

        //RepeaterSend.DataSource = MessageUtility.GetPersonalSendMessage(int.Parse(EmployeeSession[0]));
        //RepeaterSend.DataBind();

        
        RepeaterNew.DataSource = MessageUtility.GetNewReceiveWhosMsg(int.Parse(EID.Value));
        RepeaterNew.DataBind();

        RepeaterPerson.DataSource = MessageUtility.ShowEmployee();
        RepeaterPerson.DataBind();

        

    }


    protected void MsgTimer_Tick(object sender, EventArgs e)
    {
        if (WhoID.Value != null && WhoID.Value != "")
        {
            RepeaterReceive.DataSource = MessageUtility.GetPersonalReceiveMessage(int.Parse(EID.Value), int.Parse(WhoID.Value));
            RepeaterReceive.DataBind();
        }


        TimeNow.Value = DateTime.Now.ToString("yyyy/MM/dd HH:mm");
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <%--<link href="https://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css" />--%>
    <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/4.5.2/darkly/bootstrap.min.css" />--%>
    <link href="Roger/Scrips/jquery.flipster.min.css" rel="stylesheet" />
    <style>
        .flipster__nav {
            background-color: #ffc107;
            color: #007bff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:HiddenField ID="DID" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="EID" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="WhoID" runat="server"></asp:HiddenField>

    <input id="ReturnWho" type="hidden" />

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>





    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>Message</h3>
                </div>

                <div class="title_right">
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>NEW <small>新對話</small></h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>


                        <div class="x_content">

                            <asp:Repeater ID="RepeaterNew" runat="server">
                                <ItemTemplate>
                                    <a onclick='SendByImg(<%# Eval("EmployeeID")%>,"<%#Eval("LastName") %><%#Eval("FirstName") %>","<%#Eval("ImageFileName") %>")' href="#">
                                        <img style="width:100px;" onerror="this.src='images/user.png'" src='images/Personal/<%#Eval("ImageFileName") %>' /></a>
                                </ItemTemplate>
                            </asp:Repeater>
                            
                        </div>

                    </div>

                </div>
            </div>

            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Message To <small>對話</small></h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i id="CloseChoose" class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>


                        <div class="x_content">




                            <div id="carousel">
                                <ul class="flip-items">

                                    <asp:Repeater ID="RepeaterPerson" runat="server">
                                        <ItemTemplate>

                                            <li data-flip-title="<%#Eval("LastName") %><%#Eval("FirstName") %>" data-flip-category="<%#Eval("DepartmentName") %>">
                                                <a onclick='SendByImg(<%# Eval("EmployeeID")%>,"<%#Eval("LastName") %><%#Eval("FirstName") %>","<%#Eval("ImageFileName") %>")' href="#">
                                                    <img  onerror="this.src='images/user.png'" src='images/Personal/<%#Eval("ImageFileName") %>' %> ' /></a>
                                            </li>


                                        </ItemTemplate>
                                    </asp:Repeater>

                                </ul>
                            </div>





                        </div>








                    </div>




                </div>
            </div>


            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Message Box<small>對話視窗</small></h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>


                        <div class="x_content">

                            <img id="WhoImg" src="images/img.jpg"  onerror="this.src='images/user.png'"  style="width: 60px" alt="img" /><span style="font-size: 24px;" id="WithWho"></span>

                            <hr />

                            <ul style="list-style: none;">


                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>

                                        <asp:Timer ID="MsgTimer" runat="server" Interval="2000" OnTick="MsgTimer_Tick"></asp:Timer>
                                        <asp:HiddenField ID="TimeNow" runat="server" />

                                        <asp:Repeater ID="RepeaterReceive" runat="server">
                                            <ItemTemplate>
                                                <li style='width: 100%;'>
                                                    <br />
                                                </li>
                                                <li style='width: 100%;'>

                                                    <div style="position: relative; width: 100%;">
                                                        <br />

                                                        <div <%# (Eval("Note1").ToString()!="送出")?"style='width:70%; background-color: lightgray; '": "style=' position: absolute; right: 0; background-color: lightgreen; width:70%; '"%>>

                                                            <span style="float: right;">
                                                                <span><%# Eval("SendTime") %><%# Eval("HaveRead") %>
                                                                </span>
                                                            </span>
                                                            <br />

                                                            <span><%# Eval("MessageSubject") %></span>

                                                            <br />
                                                        </div>

                                                    </div>

                                                </li>
                                                <li style='width: 100%;'>
                                                    <br />
                                                </li>


                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ContentTemplate>
                                </asp:UpdatePanel>

                                <li style='width: 100%;'>
                                    <br />
                                </li>
                            </ul>

                            <hr />
                            <div class="form-inline">
                            <input id="MsgText" type="text" class="form-control" style="width:80%; margin-right:15px" />
                            <input id="Button1" type="button" value="發送" onclick="SendMsgByID()" class="btn btn-info "  />
                                </div>
                        </div>








                    </div>




                </div>
            </div>

        </div>
        <div class="clearfix"></div>








    </div>


    <div class="modal fade bs-example-modal-lg" id="ReceiveDetail" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title" id="ReceiveDetailTitle">收到訊息檢視</h4>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input id="MID" type="hidden" />
                    <h6><span id="ReceiveFrom"></span></h6>
                    <span id="ReceiveTime"></span>
                    <span id="ReceiveRead"></span>
                    <br />
                    <span id="ReceiveSubject"></span>
                    <br />
                    <span id="ReceiveContent"></span>
                    <br />
                    <span id="ReceiveRe"></span>
                    <br />
                    <span id="ReceiveAttachment"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#SendBack" onclick="ReMsg()">回覆</button>
                </div>

            </div>
        </div>
    </div>


    <div class="modal fade bs-example-modal-lg" id="SendDetail" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h6 class="modal-title" id="SendDetailTitle">送出訊息檢視</h6>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h6><span id="SendTo"></span></h6>
                    <span id="SendTime"></span>
                    <span id="SendRead"></span>
                    <br />
                    <span id="SendSubject"></span>
                    <br />
                    <span id="SendContent"></span>
                    <br />
                    <span id="SendRe"></span>
                    <br />
                    <span id="SendAttachment"></span>



                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>


    <div class="modal fade bs-example-modal-lg" id="SendBack" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">回覆訊息</h4>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h4><span id="ReTo"></span></h4>
                    <span id="ReWhichSubject"></span>
                    <br />
                    <span>主旨:</span><input id="RESubject" type="text" /><br />
                    <span>內容:</span><input id="REContent" type="text" /><br />
                    <span>附件:</span><input id="REAttachment" type="text" /><br />


                    <p>Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.</p>
                    <p>Aenean lacinia bibendum nulla sed consectetur. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Donec sed odio dui. Donec ullamcorper nulla non metus auctor fringilla.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">發送</button>
                </div>

            </div>
        </div>
    </div>









</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">


    <script src="Roger/Scrips/jquery.flipster.min.js"></script>

    <script>

        $(function () {
            var carousel = $("#carousel").flipster({
                style: 'carousel',
                spacing: -0.5,
                nav: true,
                buttons: true,
            });
        });


        function ReceiveDetail(mid) {
            var A = String(mid);
            $.ajax({
                type: 'POST',
                url: '/production/HRWebService.asmx/GetReceiveDetail',
                data: JSON.stringify({ MID: A }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (data) {


                    $("#ReceiveFrom").html(data.d.Note1);
                    $("#ReceiveTime").html(data.d.SendTime);
                    $("#ReceiveRead").html(data.d.HaveRead);
                    $("#ReceiveSubject").html(data.d.MessageSubject);
                    $("#ReceiveContent").html(data.d.MessageContent);
                    $("#ReceiveRe").html(data.d.ReMessage);
                    $("#ReceiveAttachment").html(data.d.MessageAttachment);
                    //$("#img").html(data.d.Note3);

                    $("#ReceiveDetail").modal('show');
                },
                error: function (err) {
                    alert(err);
                }
            });
        }

        function SendDetail(mid) {
            var A = String(mid);
            $.ajax({
                type: 'POST',
                url: '/production/HRWebService.asmx/GetSendDetail',
                data: JSON.stringify({ MID: A }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (data) {
                    //alert(data.d.Note1);

                    $("#SendTo").html(data.d.Note1);
                    $("#SendTime").html(data.d.SendTime);
                    $("#SendRead").html(data.d.HaveRead);
                    $("#SendSubject").html(data.d.MessageSubject);
                    $("#SendContent").html(data.d.MessageContent);
                    $("#SendRe").html(data.d.ReMessage);
                    $("#SendAttachment").html(data.d.MessageAttachment);
                    //$("#img").html(data.d.Note3);

                    $("#ReturnWho").val(data.d.SenderEID);

                    $("#SendDetail").modal('show');


                },
                error: function (err) {
                    alert(456);
                }
            });
        }

        function SendMsgByID() {
            if ($("#MsgText").val() != null) {
                var MSgData = {

                    EID: $("#ContentPlaceHolder1_EID").val(),
                    ToEID: $("#ContentPlaceHolder1_WhoID").val(),
                    Time: $("#ContentPlaceHolder1_TimeNow").val(),
                    MsgSubject: $("#MsgText").val()

                };

                $.ajax({
                    type: 'POST',
                    url: '/production/HRWebService.asmx/SendMsg',
                    data: JSON.stringify(MSgData),
                    contentType: "application/json;charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == true) {
                            
                        }
                        else {
                            
                        }
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });
            }


        }

        function ReMsg() {

            $("#ReTo").html($("#ReceiveFrom").html());
            $("#ReSubject").html('RE:' + $("#ReceiveSubject").html());
            $("#SendBack").modal('show');

        }

        function SendByImg(id, name, img) {
            $("#ContentPlaceHolder1_WhoID").val(id);
            $("#WhoImg").attr("src", "images/Personal/" + img);
            $("#WithWho").html(name);
            $("#CloseChoose").click();
            //$("#ReTo").html($("#ReceiveFrom").html());
            //$("#ReSubject").html('RE:' + $("#ReceiveSubject").html());
            //$("#SendBack").modal('show');
        }





    </script>


</asp:Content>

