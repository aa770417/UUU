<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
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
            lName.Text = empSession.LastName + empSession.FirstName + " 使用訂單管理系統";
        }
        else if (empSession.DepartmentID == 3 && empSession.AuthorizationLevel == "Employee")
        {
            lStatus.Text = "歡迎職員";
            lName.Text = empSession.LastName + empSession.FirstName + " 使用訂單管理系統";
            //職員看不到公佈欄新增 與刪除與編輯

        }


        HiddenField1.Value = empSession.AuthorizationLevel;

        using (var db = new DBEntities())
        {
            //按月訂單數資料 折線圖
            var orders = db.TomOrders.AsEnumerable().OrderBy(x => DateTime.Parse(x.Date)).GroupBy(x => DateTime.Parse(x.Date).ToString("yyyy-MM"))
                .ToDictionary(x => x.Key, x => x.Count());
            var labels = orders.Keys.ToArray();
            var data = orders.Values.ToArray();
            HiddenField2.Value = string.Join(",", labels);
            HiddenField3.Value = string.Join(",", data);

            //每一櫃的總數量
            var pie1 = db.TomOrders.AsEnumerable().Sum(p => int.Parse(p.NormalShip));
            var pie2 = db.TomOrders.AsEnumerable().Sum(p => int.Parse(p.ColdShip));
            var pie3 = db.TomOrders.AsEnumerable().Sum(p => int.Parse(p.DeepFrozenShip));
            int[] pie4 = new int[] { pie1, pie2, pie3 };
            HiddenField6.Value = string.Join(",", pie4);


            //按員工 接單數量長條圖
            var bars = db.TomOrders.AsEnumerable().OrderBy(x => x.EID).GroupBy(x => x.EID).ToDictionary(x => x.Key, x => x.Count());
            var empID = bars.Keys.ToArray();
            var data2 = bars.Values.ToArray();
            HiddenField4.Value = string.Join(",", empID);
            HiddenField5.Value = string.Join(",", data2);

        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../build/css/jsgrid.css" rel="stylesheet" />
    <link href="../build/css/jsgrid-theme.css" rel="stylesheet" />
    <%-- 新版fontawesome --%>
    <script src="https://kit.fontawesome.com/9c5d4c272d.js" crossorigin="anonymous"></script>
    <%-- 為了datepicker新增 --%>
    <link href="../build/css/jqueryui.css" rel="stylesheet" />
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.2/themes/cupertino/jquery-ui.css">
    <style>
        h2 {
            font-family: Helvetica, 'Hiragino Sans GB', 'Microsoft Yahei', '微軟雅黑', Arial, sans-serif;
        }

        .hasDatepicker {
            width: 100px;
            text-align: center;
        }

        .ui-datepicker * {
            font-family: 'Helvetica Neue Light', 'Open Sans', Helvetica;
            font-size: 14px;
            font-weight: 300 !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- page content -->
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>
                        <i class="fas fa-address-card"></i>
                        <asp:Label ID="lStatus" runat="server" Text="Label"></asp:Label>
                        <small>
                            <asp:Label ID="lName" runat="server" Text="Label"></asp:Label></small>
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                    </h3>
                </div>

                <div class="title_right">
                    <div class="col-md-5 col-sm-5   form-group pull-right top_search">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search for...">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">Go!</button>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="clearfix"></div>
            <%--整個row> column>  x-panel> xtitle xcontent  --%>
            <br />

            <div class="row">

                <%-- 折線圖區 --%>
                <div class="col-md-4 col-sm-4 ">
                    <div class="x_panel tile fixed_height_320">
                        <div class="x_title">

                            <h2><span style="font-size: 1em; color: blue;"><i class="fas fa-ship"></i></span>每月訂單數</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                                <li class="dropdown"></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div style="width: 90%;">
                                <canvas id="myChart" height="200" width="400" style="margin: 15px 10px 10px 0"></canvas>
                            </div>

                            <asp:HiddenField ID="HiddenField2" runat="server" />
                            <asp:HiddenField ID="HiddenField3" runat="server" />
                        </div>
                    </div>
                </div>
                <%-- 圓餅圖區 --%>
                <div class="col-md-4 col-sm-4 ">
                    <div class="x_panel tile fixed_height_320 overflow_hidden">
                        <div class="x_title">
                            <h2><span style="font-size: 1em; color: goldenrod;"><i class="fas fa-boxes"></i></span>貨櫃喜好度</h2>

                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div style="width: 100%;">
                                <canvas id="myPieChart"></canvas>
                                <asp:HiddenField ID="HiddenField6" runat="server" />
                            </div>
                            <div id="myToolTip" style="position: absolute;">
                                <p></p>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- 長條圖區 --%>
                <div class="col-md-4 col-sm-4 ">
                    <div class="x_panel tile fixed_height_320">
                        <div class="x_title">
                            <h2><span style="font-size: 1em; color: Tomato;"><i class="far fa-chart-bar  "></i></span>業務接單量</h2>

                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div style="width: 90%;">
                                <asp:HiddenField ID="HiddenField4" runat="server" />
                                <asp:HiddenField ID="HiddenField5" runat="server" />
                                <canvas id="myBarChart"></canvas>
                            </div>


                        </div>
                    </div>
                </div>
            </div>

        </div>
        <br />
        <div class="row" style="display: block;">
            <div class="col-md-12 col-sm-12  ">
                <div class="x_panel">
                    <div class="x_title">
                        <h2><span style="font-size: 1em; color: dimgray;"><i class="fas fa-tasks"></i></span>訂單管理系統</h2>
                        <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                            </li>
                            <li class="dropdown">
                                <%--<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <a class="dropdown-item" href="#">Settings 1</a>
                                        <a class="dropdown-item" href="#">Settings 2</a>
                                    </div>--%>
                            </li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <%-- 我要塞的內容 --%>
                        <div id="jsGrid"></div>

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">

    <script src="../build/js/jsgrid/jsgrid.js"></script>

    <script src="../build/js/jsgrid/i18n/zh-tw.js"></script>
    <script src="../build/js/utils.js"></script>
    <script src="../vendors/Chart.js/dist/Chart.js"></script>
    <script src="../build/js/jqueryui.js"></script>
    <script src="../build/js/datepicker-zh-TW.js"></script>

    <script>
        //審核用下拉選單資料
        var testpass = [
            { Name: "審核中", Id: "1" },
            { Name: "通過", Id: "2" },
            { Name: "未通過", Id: "3" },
        ];
    </script>
    <%-- jsgrid 部分 --%>
    <script>
        //jsgrid datepicker 客製化選項
        var MyDateField = function (config) {
            jsGrid.Field.call(this, config);
        };

        MyDateField.prototype = new jsGrid.Field({
            sorter: function (date1, date2) {
                return new Date(date1) - new Date(date2);
            },

            itemTemplate: function (value) {
                return new Date(value).toDateString();
            },

            insertTemplate: function (value) {
                return this._insertPicker = $("<input>").datepicker({ defaultDate: new Date() });
            },

            //editTemplate: function (value) {
            //    return this._editPicker = $("<input>").datepicker().datepicker("setDate", new Date(value));
            //},

            insertValue: function () {
                //輸入時會先直接進來，如果沒有值回傳空字串到下面執行預設必填驗證
                if (this._insertPicker.val() == "") {
                    return "";
                }
                return this._insertPicker.datepicker("getDate").toISOString();
            },

            editValue: function () {
                return this._editPicker.datepicker("getDate").toISOString();
            }
        });
        //初始化表格區
        jsGrid.fields.myDateField = MyDateField;

        $(function () {
            jsGrid.locale("zh-tw");
            //主管頁面
            if (ContentPlaceHolder1_HiddenField1.value == "Manager") {
                $("#jsGrid").jsGrid({
                    width: "100%",
                    height: "400px",
                    inserting: false,
                    editing: true,
                    //sorting: true,
                    deleteConfirm: "你確定要刪除嗎?",
                    //頁面載入
                    autoload: true,
                    paging: true,
                    pageLoading: true,
                    // pageSize 每頁筆數  pageIndex檢視頁面的索引
                    //收到SESSION 如果是員工 按鈕消失或無法選 但輸入時自動帶入FALSE
                    // 主管登入審核後，在更新到資料庫
                    pageSize: 8,
                    pageIndex: 1,
                    pageButtonCount: 3,
                    //主管頁面不能新增與刪除 只有審核區的修訂  不需驗證
                    fields: [
                        { name: "OID", type: "number", title: "訂單編號", width: 20 },
                        { name: "CID", type: "text", title: "客戶編號", width: 20, validate: "required", editing: false },
                        { name: "EID", type: "text", title: "員工編號", width: 20, validate: "required", editing: false },
                        { name: "Date", type: "myDateField", title: "訂貨日", width: 50, validate: "required", editing: false },
                        { name: "InDate", type: "myDateField", title: "進倉日", width: 50, validate: "required", editing: false },
                        { name: "OutDate", type: "myDateField", title: "出倉日", width: 50, validate: "required", editing: false },
                        { name: "NormalShip", type: "text", title: "普通櫃", width: 50, validate: "required", editing: false },
                        { name: "ColdShip", type: "text", title: "冷凍櫃", width: 50, validate: "required", editing: false },
                        { name: "DeepFrozenShip", type: "text", title: "急速冷凍櫃", width: 50, validate: "required", editing: false },
                        { name: "Total", type: "text", title: "總價", width: 30, editing: false },
                        {
                            name: "remark1", type: "select", align: "center",
                            title: "審核狀態", width: 30, sorting: false,
                            items: testpass,
                            valueField: "Id",
                            textField: "Name",
                            //自訂顯示 1.value是資料庫傳來的值 如果是1 要對應到物件的順序0 testpass[value-1].Name 取出物件的name   
                            //2.彩色標籤用 < div > 標籤 內寫style 產生 
                            itemTemplate: function (value, item) {
                                if (value == 1) {
                                    return "<div style='color:orange'>" + testpass[value - 1].Name + "</div>";
                                } else if (value == 2)
                                    return "<div style='color:green'>" + testpass[value - 1].Name + "</div>";
                                else if (value == 3)
                                    return "<div style='color:red'>" + testpass[value - 1].Name + "</div>";
                            },

                        },
                        { name: "remark2", type: "text", title: "備註", width: 20, sorting: false, editing: false },
                        //關閉刪除按鈕
                        { type: "control", deleteButton: false },
                    ],
                    controller: {
                        loadData: function (filter) {
                            var myData = null;
                            var itemCount = 0;
                            $.ajax({
                                type: "POST",
                                async: false,
                                //要設定非同步
                                //c#可以用~代表跟目錄 js只能/
                                url: "/production/TomWebService.asmx/getTomOrders",
                                data: JSON.stringify({
                                    pageSize: filter.pageSize,
                                    pageIndex: filter.pageIndex
                                })
                                //將換頁時拿到pagesize 和 pageindex 傳到function中，
                                ,
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {
                                    myData = data.d.Orders;
                                    itemCount = data.d.TotalCount;
                                },
                                failure: function (errMsg) {
                                    alert(errMsg);
                                }
                            })

                            //itemsCount:程式需要   data:資料庫
                            return {
                                data: myData,
                                itemsCount: itemCount
                            };
                        },
                        //新
                        insertItem: function (item) {
                            $.ajax({
                                type: "POST",
                                url: "/production/TomWebService.asmx/insertTomOrder",
                                data: JSON.stringify({ order: item }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) { alert("您已經完成新增"); }
                            });
                        },
                        updateItem: function (item) {
                            $.ajax({
                                type: "POST",
                                url: "/production/TomWebService.asmx/updateTomOrder",
                                data: JSON.stringify({ order: item }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) { alert("您已經更新資料"); }
                            });
                        },
                        deleteItem: function (item) {
                            $.ajax({
                                type: "POST",
                                url: "/production/TomWebService.asmx/deleteTomOrder",
                                data: JSON.stringify({ order: item }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) { alert("您已經刪除資料"); }
                            });
                        },
                    },
                });
            }
            //如果是員工
            else {
                jsGrid.locale("zh-tw");
                var MyDateField = function (config) {
                    jsGrid.Field.call(this, config);
                };

                MyDateField.prototype = new jsGrid.Field({
                    sorter: function (date1, date2) {
                        return new Date(date1) - new Date(date2);
                    },

                    itemTemplate: function (value) {
                       
                        return new Date(value).toDateString();
                        
                    },

                    insertTemplate: function (value) {
                        return this._insertPicker = $("<input>").datepicker({ defaultDate: new Date() });
                    },

                    editTemplate: function (value) {
                        return this._editPicker = $("<input>").datepicker().datepicker("setDate", new Date(value));
                   
                    },

                    insertValue: function () {
                        if (this._insertPicker.val() == "") {
                            return "";
                        }
                        return this._insertPicker.datepicker("getDate").toISOString();
                    },

                    editValue: function () {
                        return this._editPicker.datepicker("getDate").toISOString();
                    }
                });

                jsGrid.fields.myDateField = MyDateField;

                $("#jsGrid").jsGrid({
                    width: "100%",
                    height: "400px",
                    inserting: true,
                    editing: true,
                    //自訂化後排序功能要自己寫在webservice
                    sorting: false,
                    deleteConfirm: "你確定要刪除嗎?",
                    //頁面載入
                    autoload: true,
                    paging: true,
                    pageLoading: true,
                    // pageSize 每頁筆數  pageIndex檢視頁面的索引
                    //收到SESSION 如果是員工 按鈕消失或無法選 但輸入時自動帶入FALSE
                    pageSize: 8,
                    pageIndex: 1,
                    pageButtonCount: 3,
                    fields: [
                        { name: "OID", type: "number", title: "訂單編號", width: 20, editing: false, inserting: false },
                        {
                            name: "CID", type: "text", title: "客戶編號", width: 20,
                            //驗證寫法
                            validate: {
                                validator: "required",
                                message: "客戶編號為必填",
                            }
                        },

                        { name: "EID", type: "text", title: "員工編號", width: 20,  validate: {
                                validator: "required",
                                message: "員工編號為必填",
                            } },
                        { name: "Date", type: "myDateField", title: "訂貨日", width: 50,  validate: {
                                validator: "required",
                                message: "訂貨日為必填",
                            } },
                        { name: "InDate", type: "myDateField", title: "進倉日", width: 50,validate: {
                                validator: "required",
                                message: "進倉日為必填",
                            } },
                        { name: "OutDate", type: "myDateField", title: "出倉日", width: 50, validate: {
                                validator: "required",
                                message: "出倉日為必填",
                            }  },
                        { name: "NormalShip", type: "text", title: "普通櫃", width: 50,validate: {
                                validator: "required",
                                message: "普通櫃為必填",
                            }  },
                        { name: "ColdShip", type: "text", title: "冷凍櫃", width: 50, validate: {
                                validator: "required",
                                message: "冷凍櫃為必填",
                            } },
                        { name: "DeepFrozenShip", type: "text", title: "急速冷凍櫃", width: 50, validate: {
                                validator: "required",
                                message: "急速冷凍櫃為必填",
                            } },
                        {
                            name: "Total",
                            headerTemplate: function () {
                                return "<th class='jsgrid-header-cell'>總價</th>";
                            },
                            itemTemplate: function (value, item) {
                                return (item.NormalShip) * 100 + (item.ColdShip) * 200 + (item.DeepFrozenShip) * 300;
                            },
                            width: 30,
                        },
                        {
                            name: "remark1", type: "select", align: "center",
                            title: "審核狀態", width: 30, sorting: false,
                            items: testpass,
                            valueField: "Id",
                            textField: "Name",
                            selectedIndex: 0,
                            readOnly: true,
                            itemTemplate: function (value, item) {
                                if (value == 1) {
                                    return "<div style='color:orange'>" + testpass[value - 1].Name + "</div>";
                                } else if (value == 2)
                                    return "<div style='color:green'>" + testpass[value - 1].Name + "</div>";
                                else if (value == 3)
                                    return "<div style='color:red'>" + testpass[value - 1].Name + "</div>";
                            },
                        },

                        { name: "remark2", type: "text", title: "備註", width: 20, sorting: false },
                        { type: "control" },
                    ],
                    controller: {
                        loadData: function (filter) {
                            var myData = null;
                            var itemCount = 0;
                            $.ajax({
                                type: "POST",
                                async: false,
                                //要設定非同步
                                //c#可以用~代表跟目錄 js只能/
                                url: "/production/TomWebService.asmx/getTomOrders",
                                data: JSON.stringify({
                                    pageSize: filter.pageSize,
                                    pageIndex: filter.pageIndex
                                })
                                //將換頁時拿到pagesize 和 pageindex 傳到function中，
                                ,
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {
                                    myData = data.d.Orders;
                                    itemCount = data.d.TotalCount;
                                },
                                failure: function (errMsg) {
                                    alert(errMsg);
                                }
                            })

                            //itemsCount:程式需要   data:資料庫
                            return {
                                data: myData,
                                itemsCount: itemCount
                            };
                        },
                        //新
                        insertItem: function (item) {
                            $.ajax({
                                type: "POST",
                                url: "/production/TomWebService.asmx/insertTomOrder",
                                data: JSON.stringify({ order: item }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) { alert("您已經完成新增"); }
                            });
                        },
                        updateItem: function (item) {
                            $.ajax({
                                type: "POST",
                                url: "/production/TomWebService.asmx/updateTomOrder",
                                data: JSON.stringify({ order: item }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) { alert("您已經更新資料"); }
                            });
                        },
                        deleteItem: function (item) {
                            $.ajax({
                                type: "POST",
                                url: "/production/TomWebService.asmx/deleteTomOrder",
                                data: JSON.stringify({ order: item }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) { alert("您已經刪除資料"); }
                            });
                        },
                    },
                });
            }

        });

    </script>
    <%-- 曲線圖 --%>
    <script>
        var ctx1 = document.getElementById("myChart");
        var myChart1 = new Chart(ctx1, {
            type: 'line',
            data: {
                labels: document.getElementById("ContentPlaceHolder1_HiddenField2").value.split(","),
                /*["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],*/
                datasets: [{
                    borderColor: chartColors.yellow,
                    //線的顏色
                    backgroundColor: chartColors.yellow,
                    //背景顏色
                    label: '每月訂單',
                    data: document.getElementById("ContentPlaceHolder1_HiddenField3").value.split(","),
                    fill: false,
                    //是否填滿
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }
        });
    </script>

    <%-- 圓餅圖區 --%>
    <script>
        var ctx2 = document.getElementById("myPieChart");
        var myChart2 = new Chart(ctx2, {
            type: 'pie',
            data: {
                labels: ["普通櫃", "冷藏櫃", "低溫冷藏櫃"],
                datasets: [{
                    label: '上課人數',
                    ///
                    data:document.getElementById("ContentPlaceHolder1_HiddenField6").value.split(","),
                    backgroundColor: GetColors(3),
                    //label顏色(y軸)顏色六個，顏色就要六個
                }]
            },

        });
    </script>

    <%-- 長條圖 --%>
    <script>
        var ctx3 = document.getElementById("myBarChart");
        var myChart3 = new Chart(ctx3, {
            type: 'bar',
            data: {
                //labels: document.getElementById("ContentPlaceHolder1_HiddenField4").value.split(","),
                labels: ["辛七級", "黑冰冰", "朱歌亮", "邰至圓"],
                datasets: [{
                    label: '員工訂單量',
                    data: document.getElementById("ContentPlaceHolder1_HiddenField5").value.split(","),
                    borderWidth: 1,
                    backgroundColor: 'rgb(255, 159, 64)'
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }
        });
    </script>
</asp:Content>

