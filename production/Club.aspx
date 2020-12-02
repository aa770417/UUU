<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            Employee empSession = (Employee)Session["Employee"];

            if (Session["Employee"] != null)
            {                
                hiddenID.Value = empSession.EmployeeID.ToString();

                Repeater1.DataSource = ClubUtility.GetAllClubs();
                Repeater1.DataBind();

                if (empSession.DepartmentID != 2)
                {
                    btnManageClub.Visible = false;
                }
            }
            else
            {
                Response.Redirect("~/production/Login.aspx");
            }
        }
    }

    protected void btnManageClub_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/production/ClubEdit.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .thumbnail {
            height: 400px;
            overflow: hidden;
        }

            .thumbnail .image {
                height: 260px;
                overflow: hidden;
            }

        .view .mask, .view .content {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            top: 0;
            left: 0;
        }

        .view .tools {
            text-transform: uppercase;
            color: #fff;
            text-align: center;
            position: relative;
            font-size: 17px;
            padding: 8px;
            background: rgba(0,0,0,0.35);
            margin: 170px 0 0 0;
        }

        .mask.no-caption .tools {
            margin: 215px 0 0 0;
        }

        a {
            color: cornflowerblue;
        }

        textarea#description {
            height: 200px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- page content -->
    <div class="right_col" role="main">
        <div class="clearfix"></div>
        <div class="row">
            <div class="col-md-12">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>公司社團一覽<small>Club Overview</small></h2>
                        <asp:HiddenField ID="hiddenID" runat="server" />
                        <asp:HiddenField ID="hiddenDeptID" runat="server" />
                        <asp:HiddenField ID="hiddenClubID" runat="server" />
                        <asp:Button ID="btnManageClub" runat="server" Text="管理" CssClass="float-right btn btn-outline-dark" OnClick="btnManageClub_Click" />
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <!--carousel start-->
                        <div class="row justify-content-center">
                            <div class="col-md-8 col-sm-8">
                                <div class="container">
                                    <div id="carousel1" class="carousel slide" data-interval="3000"
                                        data-ride="carousel">
                                        <!--底部指示器-->
                                        <ol class="carousel-indicators">
                                            <li data-target="#carousel1" data-slide-to="0" class="active"></li>
                                            <li data-target="#carousel1" data-slide-to="1"></li>
                                            <li data-target="#carousel1" data-slide-to="2"></li>
                                            <li data-target="#carousel1" data-slide-to="3"></li>
                                        </ol>

                                        <div class="carousel-inner">
                                            <div class="carousel-item active">
                                                <img class="d-block w-100" src="images/Clubs/01.jpg" alt="First slide">
                                            </div>
                                            <div class="carousel-item">
                                                <img class="d-block w-100" src="images/Clubs/02.jpg" alt="Second slide">
                                            </div>
                                            <div class="carousel-item">
                                                <img class="d-block w-100" src="images/Clubs/03.jpg" alt="Third slide">
                                            </div>
                                            <div class="carousel-item">
                                                <img class="d-block w-100" src="images/Clubs/04.jpg" alt="Third slide">
                                            </div>
                                        </div>
                                        <!--左右箭頭-->
                                        <a class="carousel-control-prev" href="#carousel1" data-slide="prev">
                                            <span class="carousel-control-prev-icon"></span>
                                        </a>
                                        <a class="carousel-control-next" href="#carousel1" data-slide="next">
                                            <span class="carousel-control-next-icon"></span>
                                        </a>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <!--carousel end-->
                        <div class="ln_solid"></div>
                        <asp:Repeater ID="Repeater1" runat="server">
                            <HeaderTemplate>
                                <div class="row">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div class="col-md-6">
                                    <div class="thumbnail">
                                        <div class="image view view-first">
                                            <img style="width: 100%; display: block;" src="<%# Eval("Img","images/Clubs/{0}") %>" alt="image" />
                                            <div class="mask no-caption">
                                                <div class="tools tools-bottom">
                                                    <label style="cursor: pointer" title="<%# Eval("ClubName") %>"><i class="fa fa-eye" data-toggle="modal" data-target="#detailModal" onclick='<%# Eval("Id" , "SetId({0})") %>'></i></label>
                                                    <label id="<%# Eval("Id") %>" style="cursor: pointer" title="<%# Eval("ClubName") %>"><i class="fa fa-plus-circle" data-toggle="modal" data-target="#applyModal" onclick='<%# Eval("Id" , "SetId({0})") %>'></i></label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="caption">
                                            <p>
                                                <h4><strong><%# Eval("ClubName") %></strong></h4>
                                            </p>
                                            <p><%# Eval("Description") %></a></p>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <FooterTemplate>
                                </div>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- /page content -->

    <!-- apply modal -->
    <div class="modal fade" id="applyModal" data-backdrop="static">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">申請加入社團</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="form-group">
                        <label for="club" class="col-form-label">社團:</label>
                        <input type="text" class="form-control" id="club" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-form-label">姓名:</label>
                        <input type="text" class="form-control" id="name" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label for="department" class="col-form-label">部門:</label>
                        <input type="text" class="form-control" id="department" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label for="message-text" class="col-form-label">理由:</label>
                        <textarea class="form-control" id="message-text"></textarea>
                    </div>

                </div>
                <!-- Modal footer -->
                <div class="modal-footer ">
                    <asp:Button ID="btnSubmit" runat="server" Text="下定決心送出" CssClass="btn btn-success" OnClientClick="return false" />
                    <asp:Button ID="btn1" runat="server" Text="想想還是算了" CssClass="btn btn-danger" data-dismiss="modal" />
                </div>
            </div>
        </div>
    </div>
    <!-- apply modal -->

    <!-- detail modal -->
    <div class="modal fade" id="detailModal" data-backdrop="static">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">社團內容</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="form-group">
                        <label for="members" class="col-form-label">成員數:</label>
                        <input type="text" class="form-control" id="members" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label for="description" class="col-form-label">簡介:</label>
                        <textarea class="form-control" id="description" readonly="readonly" style="min-width: 100%"></textarea>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer ">
                    <asp:Button ID="btn2" runat="server" Text="我了解了" CssClass="btn btn-round btn-dark" data-dismiss="modal" />
                </div>
            </div>
        </div>
    </div>
    <!-- detail modal -->

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">
    <script>       

        function SetId(id) {
            //alert($(`#${id}`).attr('title'));
            $("#club").val(
                $(`#${id}`).attr('title')
            );
            $("#ContentPlaceHolder1_hiddenClubID").val(id);
            var mydata = {
                id
            };
            //根據id執行AJAX取得相對應社團資料並放入欄位
            $.ajax({
                type: 'POST',
                url: '/production/YenWebService.asmx/GetClub',
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(mydata),
                success: function (data) {
                    $("#members").val(data.d.Members);
                    $("#description").val(data.d.Detail)
                }
            });
        }

        $(() => {
            $("h2").hover(hightlight, nohightlight);
            function hightlight() {
                $(this).css("color", "yellow");
            };
            function nohightlight() {
                $(this).css("color", "");
            };

            //登入時取得隱藏id傳回後台，取得員工資料。並將資料丟入欄位及隱藏欄位
            var mydata = {
                id: $("#ContentPlaceHolder1_hiddenID").val()
            };
            $.ajax({
                type: 'POST',
                url: '/production/YenWebService.asmx/GetEmployeeByID',
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(mydata),
                success: function (data) {
                    //console.log(data.d);
                    $("#name").val(data.d.LastName + data.d.FirstName);
                    $("#department").val(data.d.DepartmentName + "部");
                    $("#ContentPlaceHolder1_hiddenDeptID").val(data.d.DepartmentID)
                }
            });

            $("#ContentPlaceHolder1_btnSubmit").click(function () {

                var clubInfo = {
                    clubid: $("#ContentPlaceHolder1_hiddenClubID").val(),
                    clubName: $("#club").val(),
                    id: $("#ContentPlaceHolder1_hiddenID").val(),
                    deptId: $("#ContentPlaceHolder1_hiddenDeptID").val(),
                    reason: $("#message-text").val()
                };

                $.ajax({
                    type: 'POST',
                    url: '/production/YenWebService.asmx/ApplyMember',
                    data: JSON.stringify(clubInfo),
                    contentType: "application/json;charset=utf-8",
                }).done(
                    alert("申請成功"),
                    location.href = "/production/Club.aspx"
                );
            });

        });

    </script>
</asp:Content>

