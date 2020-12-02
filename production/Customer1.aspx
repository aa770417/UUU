<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="GemBox.Spreadsheet" %>

<script runat="server">

    protected void Page_PreLoad(object sender, EventArgs e)
    {
        Employee empSession = (Employee)Session["Employee"];

        if (empSession == null)
        {
            //用RETURN 避免NULL 的執行
            //先導向 MASTER PAGE 
            return;
        }
        if (empSession.DepartmentID == 3 && empSession.AuthorizationLevel == "Manager")
        {
            lStatus.Text = "歡迎經理";
            lName.Text = empSession.LastName + empSession.FirstName + " 使用客戶管理系統";
        }
        else if (empSession.DepartmentID == 3 && empSession.AuthorizationLevel == "Employee")
        {
            lStatus.Text = "歡迎職員";
            lName.Text = empSession.LastName + empSession.FirstName + " 使用客戶管理系統";
            //職員看不到公佈欄新增 與刪除與編輯
            lDeleteCustomer.Visible = false;
        }

    }
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Repeater1.DataSource = TomCustomUtility.FindAllCustomer();
            Repeater1.DataBind();
        }
    }

    protected void Button4_Click(object sender, EventArgs e)
    {

        if (HiddenField1.Value != "")
        {
            string str = HiddenField1.Value;
            string[] strary = str.Split(',');
            foreach (var item in strary)
            {
                TomCustomUtility.DeleteCustomer(Convert.ToInt32(item));
            }
            Response.Redirect("~/production/CustomerDelete.aspx");
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "closepup", "$('#remindModal').modal('show');", true);
        }
    }

    protected void UploadXml_Click(object sender, EventArgs e)
    {
        //1.將資料讀進資料夾中
        if (OpenFile.FileName != "")
        {
            string path = "~/UploadFile/" + OpenFile.FileName;

            OpenFile.SaveAs(Server.MapPath(path));


            //2.將excel檔讀進資料庫
            SpreadsheetInfo.SetLicense("FREE-LIMITED-KEY");
            ExcelFile xlsx = ExcelFile.Load(Server.MapPath(path));
            //確定要讀哪一個工作表
            ExcelWorksheet mySheet = xlsx.Worksheets["sheet1"];

            List<TomCustomer> T_List = new List<TomCustomer>();
            foreach (ExcelRow item in mySheet.Rows)
            {
                if (item.Cells[0].Value == null)
                {
                    continue;
                }
                if (item.Cells[0].Value.ToString() == "客戶姓名" || item.Cells[0].Value.ToString() == "\n\n" || item.Cells[0].Value.ToString() == null)
                {
                    continue;
                };
                T_List.Add(new TomCustomer()
                {
                    CName = item.Cells[0].Value.ToString(),
                    Country = item.Cells[1].Value.ToString(),
                    CompanyName = item.Cells[2].Value.ToString(),
                    EID = TomCustomUtility.getEID(item.Cells[3].Value.ToString()),
                    Phone = item.Cells[4].Value.ToString(),
                    Gender = item.Cells[5].Value.ToString(),
                    Email = item.Cells[6].Value.ToString(),
                    Birthday = item.Cells[7].Value.ToString(),
                    CImg = null
                });
            }

            foreach (var item in T_List)
            {
                TomCustomUtility.AddProduct(item);
            }
            Response.Redirect("~/production/Customer1.aspx");
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "closepup", "$('#remindUploadModal').modal('show');", true);
        }

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- Bootstrap -->
    <link href="cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
    <!-- Datatables -->

    <link href="../vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="../vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
    <style>
        input[type="file"] {
            display: none;
            z-index: 0;
            visibility: hidden;
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
                        <h3>
                            <i class="fas fa-people-carry"></i>
                            <asp:Label ID="lStatus" runat="server" Text="Label"></asp:Label>
                            <small>
                                <asp:Label ID="lName" runat="server" Text="Label"></asp:Label></small></h3>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 ">
                        <div class="x_panel">
                            <div class="x_title">
                                <h2><span style="font-size: 1em; color: burlywood;"><i class="fas fa-users-cog"></i></span> 客戶管理系統 </h2>
                                <div class="clearfix"></div>
                            </div>
                            <%-- 三層都要裝 才有間距 --%>
                            <div class="x_content">
                                <!-- 1.carousel圖片滑動效果 3秒一次 -->
                                <div id="carousel1" class="carousel slide" data-interval="5000"
                                    data-ride="carousel">

                                    <ol class="carousel-indicators">
                                        <li data-target="#carousel1" data-slide-to="0" class="active"></li>
                                        <li data-target="#carousel1" data-slide-to="1"></li>
                                        <li data-target="#carousel1" data-slide-to="2"></li>
                                        <li data-target="#carousel1" data-slide-to="3"></li>
                                    </ol>
                                    <!-- 要播的圖片區 -->

                                    <div class="carousel-inner">
                                        <!-- 要播的圖片1 -->
                                        <div class="carousel-item active">
                                            <img class="d-block w-100" style="height: 250px" src="../TomUpload/bgcus1%20.jpg" alt="First slide" />
                                            <div class="carousel-caption d-none d-md-block text-dark">
                                            </div>
                                        </div>
                                        <div class="carousel-item">

                                            <img class="d-block w-100" style="height: 250px" src="../TomUpload/bgcus2.jpg" alt="Second slide">
                                        </div>
                                        <div class="carousel-item">
                                            <img class="d-block w-100" style="height: 250px" src="../TomUpload/bgcus03.jpg" alt="Third slide">
                                        </div>
                                        <div class="carousel-item">
                                            <img class="d-block w-100" style="height: 250px" src="../TomUpload/bgcus04.jpg" alt="Third slide">
                                        </div>
                                    </div>
                                    <!--  -->
                                    <a class="carousel-control-prev" href="#carousel1" data-slide="prev">
                                        <span class="carousel-control-prev-icon"></span>
                                    </a>
                                    <a class="carousel-control-next" href="#carousel1" data-slide="next">
                                        <span class="carousel-control-next-icon"></span>
                                    </a>
                                </div>
                            </div>

                            <div class="x_content">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="card-box table-responsive">
                                            <%-- 新增刪除鈕 --%>

                                            <asp:HiddenField ID="HiddenField1" runat="server" />



                                            <%-- 上傳excel檔 --%>
                                            <div style="text-align-last: right">
                                                <%--匯入 --%>
                                                <asp:FileUpload ID="OpenFile" runat="server" accept=".xlsx,xls" />
                                                <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-outline-info btn-xs " OnClientClick="return false"><i class="fas fa-upload"></i>上傳</asp:LinkButton>
                                                <asp:Label ID="UploadFileName" runat="server" Text="請上傳檔案"></asp:Label>
                                                <asp:LinkButton ID="linkUpload" runat="server" class="btn btn-outline-danger btn-xs" OnClientClick="return false" data-toggle="modal" data-target="#Uploadmodal"><i class="fab fa-accusoft">匯入</i></asp:LinkButton>

                                                <a href="/production/CustomerAdd.aspx" class="btn btn-outline-primary btn-xs"><i class="fa fa-plus"></i>新增</a>
                                                <%-- modal 點後功能取消 --%>
                                                <asp:LinkButton ID="lDeleteCustomer" runat="server" class="btn btn-outline-danger btn-xs" data-toggle="modal" data-target="#Deletemodal" OnClientClick="return false"><i class="fa fa-remove">刪除</i></asp:LinkButton>

                                            </div>
                                            <table id="datatable-buttons" class="table table-striped table-bordered" style="width: 100%">
                                                <thead>
                                                    <tr>
                                                        <th>

                                                            <%-- 全選按鈕 --%>

                                                            <asp:CheckBox ID="CheckBox2" runat="server" onclick="checkAll()" Text="全選" />


                                                        </th>
                                                        <th>照片</th>
                                                        <th>客戶姓名</th>
                                                        <th>公司國別</th>
                                                        <th>客戶公司</th>
                                                        <th>員工姓名</th>
                                                        <th>客戶電話</th>
                                                        <th>客戶性別</th>
                                                        <th>電子郵件</th>
                                                        <th>生日</th>
                                                        <th class="column-title" style="width: 10%">編輯</th>
                                                        <th class="column-title" style="width: 10%">寄信</th>
                                                    </tr>
                                                </thead>

                                                <asp:Repeater ID="Repeater1" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <%-- 多選功能 --%>
                                                            <td>
                                                                <asp:CheckBox ID="CheckBox1" runat="server" title='<%# Eval("CID") %>' /></td>
                                                            <td>

                                                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval ("CImg","~/TomUpload/{0}") %>' CssClass="rounded-circle" Width="50px" />
                                                            </td>
                                                            <td><%# Eval ("CName") %></td>
                                                            <td>
                                                                <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval ("Country","~/TomUpload/{0}.gif") %>' Width="50px" />
                                                                <%# Eval ("Country") %> 

                                                            </td>
                                                            <td><%# Eval ("CompanyName") %></td>
                                                            <td><%# TomCustomUtility.getEName(Convert.ToInt32(Eval ("EID"))) %></td>
                                                            <td><%# Eval ("Phone") %></td>
                                                            <td><%# Eval ("Gender") %></td>
                                                            <td><%# Eval ("Email") %></td>
                                                            <td><%# Eval ("Birthday") %></td>
                                                            <td class="column-title">
                                                                <a href="<%# Eval("CID","CustomerEdit.aspx?CID={0}") %>" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i>修改</a>
                                                            </td>
                                                            <td class="column-title">
                                                                <a href="<%# Eval("CID","CustomerSend.aspx?CID={0}") %>" class="btn btn-info btn-xs"><i class="far fa-envelope"></i>發信</a>
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

                <!-- /page content -->
            </div>
        </div>
    </div>
    <%-- 刪除提醒model --%>
    <div class="modal" id="Deletemodal">
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
    </div>
    <%-- 匯出提醒model --%>
    <div class="modal" id="Uploadmodal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title"><i class="fa fa-warning"></i>溫馨提示</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    您確定要匯入嗎?
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <asp:Button ID="Button1" runat="server" Text="確定" class="btn btn-primary" OnClick="UploadXml_Click" />
                    <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="remindUploadModal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title"><i class="fa fa-comment"></i>提示訊息</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    請選取資料後再匯入
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <asp:Button ID="Button2" runat="server" Text="確定" class="btn btn-danger" data-dismiss="modal" />

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
    <script src="https://kit.fontawesome.com/9c5d4c272d.js" crossorigin="anonymous"></script>
    <script src="../build/js/Tomjs.js"></script>
    <script>
        function checkAll() {

            $("#datatable-buttons input").each(function () {
                if ($(this).attr("name").indexOf("CheckBox1") > 0) {
                    this.checked = event.srcElement.checked;
                }
            });
        }
        $(function () {
            //蒐集點的內容

            $("#ContentPlaceHolder1_lDeleteCustomer").click(function () {
                var ary = [];
                $("#datatable-buttons input").each(function () {

                    if ($(this).attr("name").indexOf("CheckBox1") > 0) {

                        if (this.checked) {
                            ary.push($(this)[0].parentNode.title);
                        }
                    }
                });
                console.log(ary);
                $("#ContentPlaceHolder1_HiddenField1").val(ary);
            });
        });
    </script>
    <script>
        //新的按鈕 做傳送檔案
        $('#ContentPlaceHolder1_LinkButton1').on('click', function (e) {
            e.preventDefault();
            $('#ContentPlaceHolder1_OpenFile').trigger('click');


            const fileUploader = document.querySelector('#ContentPlaceHolder1_OpenFile');

            fileUploader.addEventListener('change', (e) => {
                console.log(e.target.files); // get file object
                //$("#ContentPlaceHolder1_UploadFileName").textContent = e.target.files[0].name;
                console.log(e.target.files[0].name);
                $("#ContentPlaceHolder1_UploadFileName").text(e.target.files[0].name);
            });


            //var content = $('#ContentPlaceHolder1_OpenFile').prop('files').target.files[0];
            //$("#ContentPlaceHolder1_UploadFileName").textContent =content ;



        });

    </script>
</asp:Content>

