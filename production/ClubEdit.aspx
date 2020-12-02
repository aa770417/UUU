<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        ClubRepeater.DataSource = ClubUtility.GetAllClubs();
        ClubRepeater.DataBind();
    }

    //在第一個repeater裡面放第二個
    protected void ClubRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        //判斷裡層repeater處於外層repeater的哪個位置（alternatingitemtemplate,footertemplate,headertemplate,itemtemplate,separatortemplate）
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            HiddenField clubID = e.Item.FindControl("HiddenField1") as HiddenField;
            var repeater2 = (Repeater)e.Item.FindControl("MemberRepeater");

            //從隱藏欄位取得社團ID，再將他轉為Ibt型別帶進方法
            int id = Convert.ToInt32(clubID.Value);

            repeater2.DataSource = ClubUtility.GetMembersByClubID(id);
            repeater2.DataBind();
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--把上傳用按鈕藏起來--%>
    <style>
        input#upload, #insert {
            visibility: hidden;
            position: absolute;
            z-index: -1;
        }

        #fake {
            cursor: pointer;
            font-size: x-small;
        }

        #demo{
            color:lightgray;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- page content -->
    <div class="right_col" role="main">
        <div class="clearfix"></div>
        <%--club apply start--%>
        <div class="row">
            <div class="col-md-12">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>社團申請<small>Club Apply</small></h2>
                        <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <div id="jsGridApply"></div>
                    </div>
                </div>
            </div>
        </div>
        <%--club apply end--%>

        <%--club manage start--%>
        <div class="row">
            <div class="col-md-12">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>社團管理<small>Club Manage</small></h2>
                        <a id="demo">寶可夢狂熱粉

我要成為寶可夢大師!!

寶可夢（日版名：ポケットモンスター，Pocket Monsters，英文版名：Pokémon，舊譯「精靈寶可夢」）是由Game Freak開發、任天堂與寶可夢公司發行的電子遊戲系列，為寶可夢跨媒體系列的一部分。系列以角色扮演遊戲為核心，首部作品在1996年發行於Game Boy掌上主機平台，後續作品登陸任天堂各世代遊戲機。</a>
                        <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <div id="jsGridManage"></div>
                    </div>
                </div>
            </div>
        </div>
        <%--club manage end--%>

        <%--club member start--%>
        <div class="row">
            <div class="col-md-12">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>社團成員<small>Club Member</small></h2>
                        <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <%--ClubRepeater--%>
                    <asp:Repeater ID="ClubRepeater" runat="server" OnItemDataBound="ClubRepeater_ItemDataBound">
                        <HeaderTemplate>
                            <div class="x_content">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div class="col-md-6 col-sm-6  ">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2><%# Eval("ClubName") %></h2>
                                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("Id") %>' />
                                        <ul class="nav navbar-right panel_toolbox">
                                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                            </li>
                                        </ul>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <table class="table table-hover" id="Club<%# Eval("Id") %>">
                                            <asp:Repeater ID="MemberRepeater" runat="server">
                                                <HeaderTemplate>
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>員工ID</th>
                                                            <th>姓名</th>
                                                            <th>部門</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <th scope="row"><%# Convert.ToInt32(DataBinder.Eval(Container, "ItemIndex", "")) + 1%></th>
                                                        <td><%# Eval("EID") %></td>
                                                        <td><%# Eval("Name") %></td>
                                                        <td><%# Eval("DeptName") %></td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </tbody>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        </table>
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
        <%--club member end--%>
    </div>

    <!-- /page content -->

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">
    <link href="../src/js/jsgrid.css" rel="stylesheet" />
    <link href="../src/js/jsgrid-theme.css" rel="stylesheet" />
    <script src="../src/js/jsgrid.js"></script>
    <script>
        $(function () {
            //社團申請
            $("#jsGridApply").jsGrid({
                width: "100%",
                height: "200px",

                inserting: false,
                editing: true,
                sorting: false,

                autoload: true,

                paging: true,
                pageLoading: true,
                pageSize: 4, //一頁3筆
                pageIndex: 1, //從第1頁開始

                fields: [
                    { name: "Id", type: "text", width: 10, title: "Id", visible: false },
                    { name: "Club", type: "text", width: 100, title: "申請社團", editing: false },
                    { name: "EID", type: "text", width: 50, title: "申請人ID", editing: false },
                    { name: "Name", type: "text", width: 100, title: "申請人", editing: false },
                    { name: "DeptName", type: "text", width: 50, title: "申請人部門", editing: false },
                    { name: "Reason", type: "text", width: 150, title: "理由", editing: false },
                    {
                        name: "Approval", type: "select", width: 50, title: "批准",
                        items: [
                            { id: "0", name: "同意" },
                            { id: "1", name: "駁回" }
                        ],
                        valueField: "name",
                        textField: "name",
                        //當一開始沒有值時，value會顯示null。先隱藏，接著根據值的不同，變換顏色
                        itemTemplate: function (value, item) {
                            if (value == null) {
                                return "<div></div>"
                            } else if (value == "同意") {
                                return "<div style='color:green'>" + value + "</div>"
                            } else {
                                return "<div style='color:red'>" + value + "</div>"
                            }
                        }
                    },
                    { type: "control", deleteButton: false, editButton: false }
                ],
                controller: {
                    loadData: function (filter) {
                        //1.主執行緒
                        var myData = null;
                        var itemCount = 0;
                        //2.工作執行緒
                        $.ajax({
                            type: "POST",
                            async: false,//如果沒關掉同步，則當工作執行緒執行步驟2時，主執行緒會直接執行3，
                            //由於還沒有資料可以返還，會造成問題
                            url: "YenWebService.asmx/GetApplys",
                            //傳輸參數
                            data: JSON.stringify({
                                pageSize: filter.pageSize,
                                pageIndex: filter.pageIndex
                            }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                myData = data.d.clubMembers;
                                itemCount = data.d.TotalCount;
                            },
                            failure: function (errMsg) {
                                alert(errMsg);
                            }
                        });

                        //3.主執行緒
                        //反正就是要給他
                        return {
                            data: myData,
                            itemsCount: itemCount
                        };
                    },
                    updateItem: function (item) {
                        $.ajax({
                            type: "POST",
                            url: "YenWebService.asmx/Approve",
                            data: JSON.stringify({ clubMember: item }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                alert("更新成功");
                                $("#jsGridManage").jsGrid("loadData");
                                //執行一個方法，把id傳進方法裡，更新底下的社團名單
                                loadClubMember(item.Id);
                            }
                        });
                    },
                }
            });
            //社團管理
            $("#jsGridManage").jsGrid({
                width: "100%",
                height: "400px",

                inserting: true,
                editing: true,
                sorting: false,

                autoload: true,

                deleteConfirm: "確定要刪除該社團嗎?",

                paging: true,
                pageLoading: true,
                pageSize: 5, //一頁3筆
                pageIndex: 1, //從第1頁開始

                fields: [
                    { name: "Id", type: "text", width: 30, title: "社團ID", align: "center", inserting: false, editing: false },
                    {
                        name: "Img", type: "text", width: 50, title: "圖片", align: "center",
                        itemTemplate: function (value, item) {
                            if (item.Img) {
                                return `<img src="images/Clubs/${item.Img}" "width="42" height="42">`;
                            }
                            return '';
                        },
                        insertTemplate: function () {
                            return '<input type="file" id="insert" accept="image/png, image/jpeg" /><label for="insert" value="上傳" class="btn btn-round btn-primary" id="fake">上傳</label>';
                        },
                        insertValue: function () {
                            return "";
                        },
                        //修改狀態時，會出現按鈕，按了可以上傳圖片。實際上是把上傳按鈕藏起來，用一個label充當外觀
                        editTemplate: function () {
                            return '<input type="file" id="upload" accept="image/png, image/jpeg" /><label for="upload" value="上傳" class="btn btn-round btn-info" id="fake">上傳</label>';
                        },
                        editValue: function () {
                            return "";
                        }
                    },
                    { name: "ClubName", type: "text", width: 50, title: "社團名稱", },
                    { name: "Description", type: "text", width: 100, title: "描述(30字內)", },
                    { name: "Detail", type: "text", width: 170, title: "詳細內容", },
                    { name: "Members", type: "text", width: 30, title: "成員數", editing: false, inserting: false },
                    { type: "control", }
                ],
                controller: {
                    loadData: function (filter1) {
                        //1.主執行緒
                        var myData = null;
                        var itemCount = 0;
                        //2.工作執行緒
                        $.ajax({
                            type: "POST",
                            async: false,//如果沒關掉同步，則當工作執行緒執行步驟2時，主執行緒會直接執行3                           
                            url: "YenWebService.asmx/GetAllClubs",
                            //傳輸參數
                            data: JSON.stringify({
                                pageSize: filter1.pageSize,
                                pageIndex: filter1.pageIndex
                            }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                myData = data.d.allClubs;
                                itemCount = data.d.TotalCount;
                            },
                            failure: function (errMsg) {
                                alert(errMsg);
                            }
                        });

                        //3.主執行緒
                        //反正就是要給他
                        return {
                            data: myData,
                            itemsCount: itemCount
                        };
                    },
                    insertItem: function (item) {
                        //上傳圖片
                        var file_data = $('#insert').prop('files')[0];
                        var form_data = new FormData();
                        form_data.append('file', file_data);
                        $.ajax({
                            url: "/production/Upload.aspx", // 將圖片帶到另外一頁後，存起來。
                            dataType: 'text', // what to expect back from the server
                            cache: false,
                            contentType: false,
                            processData: false,
                            data: form_data,
                            type: 'post'
                        });
                        //item.Img原本是空值，將檔名傳回給他
                        if (file_data != undefined) {
                            item.Img = file_data.name;
                        } else {
                            item.Img = "";
                        }

                        $.ajax({
                            type: "POST",
                            url: "YenWebService.asmx/AddClub",
                            data: JSON.stringify({ cl: item }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                alert("新增成功");
                                $("#jsGridManage").jsGrid("loadData");
                            }
                        });
                    },
                    updateItem: function (item) {
                        //上傳圖片
                        var file_data = $('#upload').prop('files')[0];

                        item.Img = item.Img;
                        //如果有上傳圖片才執行
                        //沒上傳圖片會是undefined
                        if (file_data != undefined) {
                            var form_data = new FormData();
                            form_data.append('file', file_data);
                            $.ajax({
                                url: "/production/Upload.aspx", // 將圖片帶到另外一頁後，存起來。
                                dataType: 'text', // what to expect back from the server
                                cache: false,
                                contentType: false,
                                processData: false,
                                data: form_data,
                                type: 'post'
                            });
                            //item.Img原本是空值，將檔名傳回給他
                            item.Img = file_data.name;
                        }

                        $.ajax({
                            type: "POST",
                            url: "YenWebService.asmx/UpdateClub",
                            data: JSON.stringify({ club: item }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                alert("更新成功");
                                $("#jsGridManage").jsGrid("loadData");
                            }
                        });
                    },
                    deleteItem: function (item) {
                        $.ajax({
                            type: "POST",
                            url: "YenWebService.asmx/deleteClub",
                            data: JSON.stringify({ club: item }),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                alert("刪除成功");
                                $("#jsGridManage").jsGrid("loadData");
                            }
                        });
                    },
                }
            });

            function loadClubMember(Id) {
                var mydata = {
                    id: Id
                };
                $.ajax({
                    type: 'POST',
                    url: "YenWebService.asmx/GetMember",
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(mydata),
                    success: function (data) {
                        console.log(data.d);
                        $(data.d).each(function (index, item) {
                            //同意的狀況，append一筆資料上去                         
                            if (item.Approval == "同意") {
                                $(`#Club${item.ClubID}`).append(
                                    `<tr>
                                 <th scope="rope">${$(`#Club${item.ClubID}`).find("tr").length}</th>
                                 <td>${item.EID}</td>
                                 <td>${item.Name}</td>
                                 <td>${item.DeptName}</td>                                
                                </tr>`);
                            }
                            //駁回的狀況，移除那筆資料
                            else {
                                //$(`#Club${item.ClubID}`).find("tr")[1].children[1].innerText
                                for (var i = 0; i < item.EID; i++) {
                                    if ($(`#Club${item.ClubID}`).find("tr")[i].children[1].innerText == item.EID) {
                                        $(`#Club${item.ClubID}`).find("tr")[i].remove();
                                    }
                                }
                            }

                        });
                    }
                });
            };
            //$("#Club1").find("tr") => 找到這個table的所有tr
            //$("#Club1").find("tr")[1].children[1].innerText => 找到第一個tr裡的第一個子成員(即ID)

            ////駁回的狀況，重新load全部的資料回去
            //function reloadClubMember(ClubID) {
            //    var mydata = {
            //        id: ClubID
            //    };
            //    $.ajax({
            //        type: 'POST',
            //        url: "YenWebService.asmx/GetMembersByClubID",
            //        contentType: "application/json;charset=utf-8",
            //        data: JSON.stringify(mydata),
            //        success: function (data) {
            //            console.log(data.d);
            //            $(data.d).each(function (index, item) {
            //                $(`#Club${item.ClubID}`).replaceWith(
            //                    `<div class="x_content" id="Club${item.ClubID}">
            //                 <table class="table table-hover">                                
            //                     <tbody>
            //                            <tr>
            //                                <th scope="rope">${index + 1}</th>
            //                                <td>${item.EID}</td>
            //                                <td>${item.Name}</td>
            //                                <td>${item.DeptName}</td>
            //                            </tr>
            //                    </tbody>
            //                </table>
            //             </div>`);
            //            });
            //        }
            //    });
            //};
        });
    </script>

</asp:Content>

