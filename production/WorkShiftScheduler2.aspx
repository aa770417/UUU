<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        //string[] empsession = { "3", "軒華", "1", "主管" };
        //Session["Employee"] = empsession;

        //string[] empStringArray = (string[])Session["Employee"];

        //Employee empSession = (Employee)Session["Employee"];

        if (Session["Employee"] == null)
        {
            Response.Redirect("~/production/Login.aspx");
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@3.10.2/dist/fullcalendar.min.css' rel='stylesheet' />
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@3.10.2/dist/fullcalendar.print.css' rel='stylesheet' media='print' />

    <style>
        #external-events {
            position: relative;
            /*z-index: 2;*/
            /*top: 30px;
            left: 200px;*/
            width: auto;
            padding: 0 10px;
            border: 1px solid #ccc;
            background: #eee;
        }

            #external-events .fc-event {
                margin: 1em 0;
                cursor: move;
            }

        #calendar-container {
            position: relative;
            z-index: 1;
            margin-left: 200px;
        }

        #calendar {
            max-width: 900px;
            margin: 20px auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h4>員工排班<small></small></h4>
                </div>

                <div class="title_right">
                    <div class="col-lg-5 col-md-5 col-sm-5 form-group pull-right top_search">
                        <div class="bs-glyphicons">
                            <span class="glyphicon glyphicon-floppy-disk">
                                <button id="btnSave" type="submit">儲存</button>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <%--<ul class="nav navbar-right panel_toolbox">
                                <li>請選擇待排班員工:</li>
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-user"></i></a>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <a class="dropdown-item" href="#">Settings 1</a>
                                        <a class="dropdown-item" href="#">Settings 2</a>                         
                                    </div>
                                </li>
                            </ul>--%>

                            <%--選擇待排班員工，開始--%>
                            <div class="dropdown">
                                <button id="btnEmployeeSelect" class="btn btn-primary dropdown-toggle" type="button"
                                    data-toggle="dropdown">
                                    請選擇待排班員工
                                </button>

                                <div id="ddmEmployees" class="dropdown-menu dropdown-menu-right pre-scrollable"></div>
                            </div>
                            <%--選擇待排班員工，結束--%>

                            <div class="clearfix"></div>
                        </div>

                        <%--可拖曳待排班員工，開始--%>
                        <div class="col-lg-auto col-md-2 col-sm-2">
                            <div id='external-events'>
                                <p id="pEmployee">
                                    <strong>待排班員工</strong>
                                </p>
                                <%--<div class='fc-event'>Tom</div>--%>
                                <p>
                                    <input type='checkbox' id='drop-remove' checked="checked" />
                                    <label for='drop-remove'>拖曳後移除</label>
                                </p>
                            </div>
                        </div>
                        <%--可拖曳待排班員工，結束--%>


                        <%--排班月曆，開始--%>
                        <div class="col-lg-10 col-md-10 col-sm-10">
                            <div class="calendar-container">
                                <div id="calendar"></div>
                            </div>
                        </div>
                        <%--排班月曆，結束--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">

    <script src='https://cdn.jsdelivr.net/npm/moment@2.24.0/min/moment.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/jquery@3.5.0/dist/jquery.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@3.10.2/dist/fullcalendar.min.js'></script>
    <script src='https://code.jquery.com/ui/1.11.3/jquery-ui.min.js'></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/locale-all.min.js"></script>

    <script>
        var eventsData = [];
        //var eventsData = JSON.parse(localStorage.getItem('eventsDataList')) || [];

        $(function () {

            // initialize the external events
            // -----------------------------------------------------------------

            $('#external-events .fc-event').each(function () {

                // store data so the calendar knows to render an event upon drop
                $(this).data('event', {
                    title: $.trim($(this).text()), // use the element's text as the event title
                    stick: true // maintain when user navigates (see docs on the renderEvent method)
                });

                // make the event draggable using jQuery UI
                $(this).draggable({
                    zIndex: 999,
                    revert: true,      // will cause the event to go back to its
                    revertDuration: 0  //  original position after the drag
                });
            });


            // initialize the calendar
            // -----------------------------------------------------------------

            

            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
                locale: 'zh-tw',
                editable: true,
                droppable: true, // this allows things to be dropped onto the calendar
                drop: function (date) {

                    //當有員工被拖放至月曆後，將員工資料及日期存入一個JavaScript物件
                    $('.fc-event').data('event', { title: $(this).text(), startDate: date.format(), endDate: date.format() });

                    var eventObject = {
                        name: $(".fc-event").data("event").title,
                        workDate: $(".fc-event").data("event").startDate,
                        //endDate: $(".fc-event").data("event").endDate
                    };
                    //將物件放入一個陣列
                    eventsData.push(eventObject);
          
                    //localStorage.setItem('eventsDataList', JSON.stringify(eventsData));

                    //alert(date.format() + "員工: " + $(this).text());
                    //alert($(".fc-event").data("event").title + $(".fc-event").data("event").startDate);

                    // is the "remove after drop" checkbox checked?
                    if ($('#drop-remove').is(':checked')) {
                        // if so, remove the element from the "Draggable Events" list
                        $(this).remove();
                    }
                },
                events: [],


                eventDrop: function (event /*, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view */) {
                    // handle all internal drops (or 'moves').

                    alert(event.title + " 將在這天工作： " + event.start.format());
                    //localStorage = event.title + event.start.format();
                    //alert(localStorage);

                    //var events = event;

                    //// add dates to eventsData[]
                    //eventsData.push({
                    //    //name: $(this).html(),
                    //    //startDate: fixed,
                    //    //endDate: fixed

                    //    name: $(this).title,
                    //    startDate: events.startDate,
                    //    endDate: events.endDate

                    //});
                },

                //eventReceive: function (event) {
                //    $('.fc-event').data('event', { title: event.title, startDate: event.start, endDate: event.end });

                //    alert($(".fc-event").data("event").title + $(".fc-event").data("event").start);

                //}
            });


            //在document ready時，將部門員工加入dropdown menu供使用者點選
            $.ajax({
                type: 'POST',
                url: '/production/PeterHsuWebService.asmx/GetEmployeesByDepID',
                //data: JSON.stringify(data),  //要傳資料出去，才加入此屬性
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    //alert("success");
                    //console.log(data.d);
                    $(data.d).each(function (index, item) {
                        $("#ddmEmployees").append(
                            `<a class="dropdown-item" href="#">${item.EmployeeID}_${item.LastName}_${item.FirstName}</a>`);
                    });
                },
                error: function (err) {
                    alert("資料庫查無員工資料");
                }
            });


            //使用者點選員工時，將員工加入external-events
            $("#ddmEmployees").on('click', 'a', function () {

                //將可拖曳的員工全部移除
                $("#external-events .fc-event").remove();

                //產生5個可拖曳的員工
                var i;
                for (i = 0; i < 5; i++) {
                    $("#external-events").append(
                        `<div class='fc-event'>${$(this).text()}</div>`);
                }

                //初始化員工拖曳elements，將其設定為可拖曳
                $('#external-events .fc-event').each(function () {

                    // store data so the calendar knows to render an event upon drop
                    $(this).data('event', {
                        title: $.trim($(this).text()), // use the element's text as the event title
                        stick: true // maintain when user navigates (see docs on the renderEvent method)
                    });

                    // make the event draggable using jQuery UI
                    $(this).draggable({
                        zIndex: 999,
                        revert: true,      // will cause the event to go back to its
                        revertDuration: 0  //  original position after the drag
                    });
                });
            });

            //按儲存按鈕
            $("#btnSave").click(function () {
             
                $.ajax({
                    type: 'POST',
                    url: '/production/PeterHsuWebService.asmx/AddWorkShiftRecords',
                    data: JSON.stringify({JsonArr:eventsData}),  //要傳資料出去，才加入此屬性
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        if (data.d == true) {
                            alert("儲存成功");
                        }
                        location.href = "/production/WorkShiftRecordsTable.aspx";
                    },
                    error: function (err) {
                        alert("儲存0筆資料，或儲存失敗！");
                    }
                });
            });
        });
    </script>
</asp:Content>

