<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">




</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="right_col" role="main">
        <!-- top tiles -->
        <div class="row" style="display: inline-block;">
            <div class="tile_count">
                <div class="col-md-2 col-sm-4  tile_stats_count">
                    <span class="count_top"><i class="fa fa-user"></i>累積運輸數量</span>
                    <div class="count">7,353</div>
                    <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>4% </i>2019</span>
                </div>
                <div class="col-md-2 col-sm-4  tile_stats_count">
                    <span class="count_top"><i class="fa fa-clock-o"></i>平均日交易量</span>
                    <div class="count">20.19</div>
                    <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>5% </i>10月</span>
                </div>
                <div class="col-md-2 col-sm-4  tile_stats_count">
                    <span class="count_top"><i class="fa fa-user"></i>亞洲貨運量</span>
                    <div class="count green">2,314</div>
                    <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>16% </i>From last Week</span>
                </div>
                <div class="col-md-2 col-sm-4  tile_stats_count">
                    <span class="count_top"><i class="fa fa-user"></i>歐洲貨運量</span>
                    <div class="count red">1,067</div>
                    <span class="count_bottom"><i class="red"><i class="fa fa-sort-desc"></i>11% </i>From last Week</span>
                </div>
                <div class="col-md-2 col-sm-4  tile_stats_count">
                    <span class="count_top"><i class="fa fa-user"></i>大洋洲貨運量</span>
                    <div class="count">1,433</div>
                    <span class="count_bottom"><i class="red"><i class="fa fa-sort-desc"></i>6% </i>From last Week</span>
                </div>
                <div class="col-md-2 col-sm-4  tile_stats_count">
                    <span class="count_top"><i class="fa fa-user"></i>美洲貨運量</span>
                    <div class="count">1,844</div>
                    <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>7% </i>From last Week</span>
                </div>

            </div>
        </div>
        <!-- /top tiles -->

        <div class="row">
            <div class="col-md-12 col-sm-12 ">

                <!-- Start to do list -->
                <div class="col-md-4 col-sm-4 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>To Do List <small>Sample tasks</small></h2>
                            <ul class="nav navbar-right panel_toolbox">
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
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">

                            <div class="">
                                <ul class="to_do">
                                    <li>
                                        <p>
                                            <input type="checkbox" class="flat">
                                            上班打卡
                                        </p>
                                    </li>
                                    <li>
                                        <p>
                                            <input type="checkbox" class="flat">
                                            瀏覽佈告欄
                                        </p>
                                    </li>
                                    <li>
                                        <p>
                                            <input type="checkbox" class="flat">
                                            複查過往工作
                                        </p>
                                    </li>
                                    <li>
                                        <p>
                                            <input type="checkbox" class="flat">
                                            訂定今日工作日程及目標
                                        </p>
                                    </li>

                                    <li>
                                        <p>
                                            <input type="checkbox" class="flat">
                                            彙報工作
                                        </p>
                                    </li>
                                    <li>
                                        <p>
                                            <input type="checkbox" class="flat">
                                            履行職責
                                        </p>
                                    </li>
                                    <li>
                                        <p>
                                            <input type="checkbox" class="flat">
                                            檢討今日工作
                                        </p>
                                    </li>
                                    <li>
                                        <p>
                                            <input type="checkbox" class="flat">
                                            下班打卡並登出系統
                                        </p>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End to do list -->

                <div class="col-md-4 col-sm-4 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>時鐘</h2>
                            <ul class="nav navbar-right panel_toolbox">
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
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div style="margin: 0 auto;">
                                <iframe src="http://free.timeanddate.com/clock/i7jybbng/n241/szw300/szh300/hoc2a3f54/hbw2/cf100/hgr0/fas14/fac2a3f54/fdi76/mqc2a3f54/mqs3/mql13/mqw2/mqd98/mhc2a3f54/mhs3/mhl13/mhw2/mhd98/mmc2a3f54/mml5/mmw1/mmd94/hwm2/hhs2/hhb18/hms2/hml80/hmb18/hmr7/hsc2a3f54/hss1/hsl90/hsr3" frameborder="0" width="300" height="300"></iframe>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- start of weather widget -->
                <div class="col-md-4 col-sm-4 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>天氣</h2>
                            <ul class="nav navbar-right panel_toolbox">
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
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">

                            <div style="margin: 0 auto;">
                                <div class="elfsight-app-4f9a3dbb-745e-4af6-96e0-9248247a6a8b"></div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- end of weather widget -->

            </div>

        </div>
        <br />




        <div class="row">
            <%--Visitors--%>
            <div class="col-md-12 col-sm-12 ">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>世界地圖</h2>
                        <ul class="nav navbar-right panel_toolbox">
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
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <div class="dashboard-widget-content">
                            <div class="col-md-4 hidden-small">
                                <h2 class="line_30">貨運量統計</h2>

                                <table class="countries_list">
                                    <tbody>
                                        <tr>
                                            <td>亞洲</td>
                                            <td class="fs15 fw700 text-right">31%</td>
                                        </tr>
                                        <tr>
                                            <td>美洲</td>
                                            <td class="fs15 fw700 text-right">25%</td>
                                        </tr>
                                        <tr>
                                            <td>大洋洲</td>
                                            <td class="fs15 fw700 text-right">19%</td>
                                        </tr>
                                        <tr>
                                            <td>歐洲</td>
                                            <td class="fs15 fw700 text-right">14%</td>
                                        </tr>
                                        <tr>
                                            <td>非洲</td>
                                            <td class="fs15 fw700 text-right">9%</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div id="world-map-gdp" class="col-md-8 col-sm-12 " style="height: 280px;"></div>
                        </div>
                    </div>
                </div>
            </div>

        </div>



    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">

    <script src="https://apps.elfsight.com/p/platform.js" defer></script>

    <script>        


</script>
</asp:Content>

