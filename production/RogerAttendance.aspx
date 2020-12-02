<%@ Page Title="" Language="C#" MasterPageFile="~/production/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h3>Attendance 差勤系統 </h3>
                </div>

                <div class="title_right">
                    <div class="col-md-5 col-sm-5   form-group pull-right top_search">
                        
                    </div>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>相關規定及辦法</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>

                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">

                            <div class="col-md-12 col-lg-12 col-sm-12">
                                <!-- blockquote -->
                                <div>
                                    <h4>工作時間、休息、休假、請假</h4>

                                    第一條
                                    <br />
                                    本公司員工正常工作時間，每日不超過八小時，每週不得超過四十小時。本公司得視實際需要，依勞動基準法第三十條第二項、第三項及第三十條之一等規定實施彈性工時。<br />

                                    本公司得視勞工照顧家庭成員需要，允許勞工於不變更每日正常工作時數下，在一小時範圍內，彈性調整工作開始及終止之時間。依職業安全衛生法第二十一條、第二十九條及第三十一條規定，經醫師建議應縮短工作時間者，本公司將參採醫師之建議，調整員工之工作時間；其他法規另有規定者，本公司亦將遵守法令規定調整工時。<br />

                                    <hr />
                                    第二條<br />
                                    本公司有使員工在正常工作時間以外工作之必要者，經勞資會議同意後，得將工作時間延長之。延長之工作時間連同正常工作時間，一日不得超過十二小時。延長之工作時間，一個月不得超過四十六小時。因天災、事變或突發事件，本公司有使員工在正常工作時間以外工作之必要者，得將工作時間延長之。但應於延長開始後二十四小時內報當地主管機關備查。延長之工作時間，應於事後補給員工以適當之休息。員工得因健康或其他正當理由，不接受正常工作時間以外之工作。<br />
                                    <hr />
                                    第三條<br />
                                    本公司依第二十二條辦理後，因工作需要加班時，加班人員應填寫「加班單」，經權責主管核准後交加班人員憑以加班。<br />
                                    <hr />
                                    第四條<br />
                                    本公司員工繼續工作四小時，至少應有三十分鐘之休息。但實行輪班制或其工作有連續性或緊急性者，本公司得在工作時間內，另行調配其休息時間。<br />
                                    <hr />
                                    第五條<br />
                                    本公司員工每日應按規定時間出勤，不得遲到或早退，工作時間內未經許可亦不得任意離開工作崗位。<br />
                                    <hr />
                                    第六條<br />
                                    本公司員工若有遲到、早退或曠職（工）等情事發生時，按下列規定辦理：<br />
                                    一、於規定上班時間後十分鐘（含）以後出勤者，須依勞工請假規則之規定請假。<br />
                                    二、於規定下班時間前十分鐘（含）以前未經請假或因公而擅離工作崗位者，須依勞工請假規則之規定請假。<br />
                                    三、凡未經假、假滿未經續假或請假、續假未經核准而擅不出勤者均以曠職論之。<br />
                                    四、員工上下班漏讀卡者，若無具體確實之理由且經主管簽核者，以礦工論之。<br />
                                    五、曠職（工）者按日扣薪。<br />
                                    六、在接連例假日或規定休假日前後曠職（工）者，其中例假或休假日，不計入曠職（工）日數內，惟不因例假或休假日之間隔而阻其連續性。<br />
                                    <hr />
                                    第七條<br />
                                    凡規定出勤須讀卡之員工，其上下班均應親自讀卡，如有委託他人代讀卡，亦經查證屬實，請託人及代讀卡人各記大過乙次。並依實際出缺勤，另計曠職（工）時數。<br />
                                    <hr />
                                    第八條<br />
                                    本公司員工每七日中至少應有一日之休息，作為例假，工資照給。<br />
                                    <hr />
                                    第九條<br />
                                    員工於紀念日、勞動節日及其他中央主管機關規定應放假之日，均予休假，工資照給。包括：<br />
                                    一、紀念日如下：（一）中華民國開國紀念日（元月一日）。（二）和平紀念日（二月二十八日）。（三）國慶日（十月十日）。<br />
                                    二、勞動節日指五月一日勞動節。<br />
                                    三、中央主管機關規定應放假之日如下：（一）春節（農曆正月初一、初二、初三）。（二）兒童節（四月四日。兒童節與民族掃墓節同一日時，於前一日放假。但逢星期四時，於後一日放假）。（三）民族掃墓節（定於清明日）。（四）端午節（農曆五月五日）。（五）中秋節（農曆八月十五日）。（六）農曆除夕（農曆十二月之末日）。（七）其他經中央主管機關指定者。前開休假日經勞雇雙方協商同意後，得酌作調移。<br />
                                    <hr />
                                    第十條<br />
                                    員工於本公司繼續工作滿一定期間者，每年均依下列規定給予特別休假：<br />
                                    一、一年以上三年未滿者七日。<br />
                                    二、三年以上五年未滿者十日。<br />
                                    三、五年以上十年未滿者十四日。<br />
                                    四、十年以上者，每一年加給一日，加至三十日為止。<br />
                                    前項員工之工作年資自受僱當日起算；特別休假日期應由本公司與員工協商排定之；因年度終結或終止契約而未休，且可歸責於本公司者，其應休未休之日數，由本公司發給工資。<br />
                                    <hr />
                                    第十一條<br />
                                    第八條所定之例假，第九所定之休假及第十條所定之特別休假，工資照給。本公司經徵得員工同意於第九條及第十條之休假日工作者，工資加倍發給。<br />
                                    <hr />
                                    第十二條<br />
                                    因天災、事變或突發事件，本公司認為有繼續工作之必要時，得停止第八條至第十條所定員工之假期。但停止假期之工資，加倍發給，並應於事後補假休息。<br />
                                    <hr />
                                    第十三條<br />
                                    本公司員工除例假日、紀念節日及其他政府規定放假之日或因公出差者外，凡不克出勤或工作時間內不克繼續工作者，均應於公司線上請假平台完成請假程序，惟遇有急病或緊急事故時，得委託主管代辦請假手續。<br />
                                    <hr />
                                    第十四條<br />
                                    員工因婚、喪、疾病或其他正當理由得請假，假別分為公假（公傷病假）、事假（家庭照顧假）、普通傷病假、生理假、喪假、婚產假（婚假、產檢假、產假、陪產假、安胎休養請假）等。准假日數及工資給付如下：<br />
                                    一、婚假：員工結婚者給予婚假八日，可自結婚之日前十日起三個月內請畢。但經本公司同意者，得於一年內請畢。婚假期間，工資照給。<br />
                                    二、事假：員工因事必須親自處理者，得請事假；一年內合計不得超過十四日。事假期間不給工資。<br />
                                    三、普通傷病假：員工因普通傷害、疾病或生理原因必須治療或休養者，得依下列規定請普通傷病假，請假連續日（※期限請貴公司自訂）（含）以上者，須附繳醫療證明。（普通傷病假一年內合計未超過三十日部分，工資折半發給，其領有勞工保險普通傷病給付未達工資半數者，由本公司補足之）（一）未住院者，一年內合計不得超過三十日。（二）住院者，二年內合計不得超過一年。（三）未住院傷病假與住院傷病假，二年內合計不得超過一年。經醫師診斷，罹患癌症（含原位癌）採門診方式治療或懷孕期間需安胎休養者，其治療或休養期間，併入住院15傷病假計算。普通傷病假超過前款規定之期限，經以事假或特別休假抵充後仍未痊癒者，經本公司同意得予留職停薪。逾期未癒者得予資遣，惟如適用勞動基準法退休金制度且符合退休要件者，應發給退休金。<br />
                                    四、生理假：女性員工因生理日致工作有困難者，每月得請生理假一日，全年請假日數未逾三日，不併入病假計算，其餘日數併入病假計算。（請休生理假不需附證明文件，另，前開併入及不併入病假之生理假薪資，減半發給）。<br />
                                    五、喪假：工資照給。員工喪假得依習俗於百日內分次申請。<br />
                                    （一）父母、養父母、繼父母、配偶喪亡者，給予喪假八日。<br />
                                    （二）（外）祖父母、子女、配偶之父母、配偶之養父母或繼父母喪亡者，給予喪假六日。<br />
                                    （三）（外）曾祖父母、兄弟姊妹、配偶之（外）祖父母喪亡者，給予喪假三日。<br />
                                    六、公傷病假：員工因職業災害而致殘廢、傷害或疾病者，其治療、休養期間，給予公傷病假。<br />
                                    七、產假：<br />
                                    （一）女性員工分娩前後，應停止工作，給予產假八星期。<br />
                                    （二）妊娠三個月以上流產者，應停止工作，給予產假四星期。<br />
                                    （三）第一目、第二目規定之女性員工受僱工作在六個月以上者，停止工作期間工資照給，未滿六個月者減半發給。<br />
                                    （四）妊娠二個月以上未滿三個月流產者，應停止工作，給予產假一星期。<br />
                                    （五）妊娠未滿二個月流產者，應停止工作，給予產假16五日。<br />
                                    （六）女性員工請產假須提出證明文件。<br />
                                    八、安胎休養請假：員工懷孕期間需安胎休養者，其治療或休養期間，併入住院傷病假計算。安胎休養請假薪資之計算，依病假規定辦理。<br />
                                    九、陪產假：員工於其配偶分娩時，得於配偶分娩之當日及其前後合計十五日期間內，擇其中之五日請陪產假。陪產假期間，薪資照給。<br />
                                    十、產檢假：員工妊娠期間，給予產檢假五日。產檢假期間，薪資照給。<br />
                                    十一、家庭照顧假：員工於其家庭成員預防接種、發生嚴重之疾病或其他重大事故須親自照顧時，得請家庭照顧假；其請假日數併入事假計算，全年以七日為限。家庭照顧假薪資之計算，依事假規定辦理。<br />
                                    十二、公假：員工有依法令規定應給公假情事者，依實際需要天數給予公假，工資照給。員工請特別休假、婚假、喪假、公傷病假、公假、產假者，仍發給全勤獎金。員工任職滿六個月後，於每一子女滿三歲前，得申請育嬰留職停薪，期間至該子女滿三歲止，但不得逾二年。同時撫育子女二人以上者，其育嬰留職停薪期間應合併計算，最長以最幼子女受撫育二年為限。員工申請生理假、育嬰留職停薪、家庭照顧假、陪產假、安胎休養請假、產假、產檢假時，本公司不得拒絕或視為缺勤而影響其全勤獎金、考績或為其他不利之處分。<br />
                                    <hr />
                                    第十五條<br />
                                    員工因故必須請假者，應事先填寫請假單或口頭敘明理由經核定後方可離開工作崗位或不出勤；如遇急病或臨時重大事故，得於三日內委託同事、家屬、親友或以電話、傳真、E─mail、限時函件報告單位主管，代辦請假手續。如需補述理由或提供證明，當事人應於七日內提送，其工作單位按權責核定之。
                                    <hr />
                                    第十六條<br />
                                    員工事假及普通傷病假全年總日數的計算，均自每年一月一日起至同年十二月三十一日止。(※貴公司如有另定會計年度者，員工事假及普通傷病假全年總日數，得依其會計年度計算。)
                                    <hr />
                                    第十七條<br />
                                    請假之最小單位，小時計。一次連續請普通傷病假超過三十日以上之期間，如遇例假日、紀念日、勞動節日及由中央主管機關規定應放假之日，併計於請假期間內。<hr />

                                </div>




                            </div>
                        </div>
                    </div>
                </div>
            </div>




            <div class="row">

              <div class="col-md-12 col-sm-12 ">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Form Wizards <small>Sessions</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">


                    <!-- Smart Wizard -->
                    <p>This is a basic form wizard example that inherits the colors from the selected scheme.</p>
                    <div id="wizard" class="form_wizard wizard_horizontal">
                      <ul class="wizard_steps">
                        <li>
                          <a href="#step-1">
                            <span class="step_no">1</span>
                            <span class="step_descr">
                                              Step 1<br />
                                              <small>Step 1 description</small>
                                          </span>
                          </a>
                        </li>
                        <li>
                          <a href="#step-2">
                            <span class="step_no">2</span>
                            <span class="step_descr">
                                              Step 2<br />
                                              <small>Step 2 description</small>
                                          </span>
                          </a>
                        </li>
                        <li>
                          <a href="#step-3">
                            <span class="step_no">3</span>
                            <span class="step_descr">
                                              Step 3<br />
                                              <small>Step 3 description</small>
                                          </span>
                          </a>
                        </li>
                        <li>
                          <a href="#step-4">
                            <span class="step_no">4</span>
                            <span class="step_descr">
                                              Step 4<br />
                                              <small>Step 4 description</small>
                                          </span>
                          </a>
                        </li>
                      </ul>
                      <div id="step-1">
                        <div class="form-horizontal form-label-left">

                          <div class="form-group row">
                            <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">First Name <span class="required">*</span>
                            </label>
                            <div class="col-md-6 col-sm-6 ">
                              <input type="text" id="first-name" required="required" class="form-control  ">
                            </div>
                          </div>
                          <div class="form-group row">
                            <label class="col-form-label col-md-3 col-sm-3 label-align" for="last-name">Last Name <span class="required">*</span>
                            </label>
                            <div class="col-md-6 col-sm-6 ">
                              <input type="text" id="last-name" name="last-name" required="required" class="form-control ">
                            </div>
                          </div>
                          <div class="form-group row">
                            <label for="middle-name" class="col-form-label col-md-3 col-sm-3 label-align">Middle Name / Initial</label>
                            <div class="col-md-6 col-sm-6 ">
                              <input id="middle-name" class="form-control col" type="text" name="middle-name">
                            </div>
                          </div>
                          <div class="form-group row">
                            <label class="col-form-label col-md-3 col-sm-3 label-align">Gender</label>
                            <div class="col-md-6 col-sm-6 ">
                              <div id="gender" class="btn-group" data-toggle="buttons">
                                <label class="btn btn-secondary" data-toggle-class="btn-primary" data-toggle-passive-class="btn-secondary">
                                  <input type="radio" name="gender" value="male" class="join-btn"> &nbsp; Male &nbsp;
                                </label>
                                <label class="btn btn-primary" data-toggle-class="btn-primary" data-toggle-passive-class="btn-secondary">
                                  <input type="radio" name="gender" value="female" class="join-btn"> Female
                                </label>
                              </div>
                            </div>
                          </div>
                          <div class="form-group row">
                            <label class="col-form-label col-md-3 col-sm-3 label-align">Date Of Birth <span class="required">*</span>
                            </label>
                            <div class="col-md-6 col-sm-6 ">
                              <input id="birthday" class="date-picker form-control" required="required" type="text">
                            </div>
                          </div>

                        </div>

                      </div>
                      <div id="step-2">
                        <h2 class="StepTitle">Step 2 Content</h2>
                        <p>
                          do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
                          fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                        </p>
                        <p>
                          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
                          in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                        </p>
                      </div>
                      <div id="step-3">
                        <h2 class="StepTitle">Step 3 Content</h2>
                        <p>
                          sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore
                          eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                        </p>
                        <p>
                          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
                          in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                        </p>
                      </div>
                      <div id="step-4">
                        <h2 class="StepTitle">Step 4 Content</h2>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                          Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                        </p>
                        <p>
                          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
                          in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                        </p>
                        <p>
                          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
                          in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                        </p>
                      </div>

                    </div>
                    <!-- End SmartWizard Content -->






                  </div>
                </div>
              </div>
            </div>





        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PlaceHolderJQuery" runat="Server">

    <!-- jQuery Smart Wizard -->
    <script src="../vendors/jQuery-Smart-Wizard/js/jquery.smartWizard.js"></script>

</asp:Content>

