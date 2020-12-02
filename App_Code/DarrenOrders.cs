using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Orders 的摘要描述
/// </summary>
public class DarrenOrders
{
    public int E_ID { get; set; } //員工ID
    public int Ord_ID { get; set; } //商品訂單編號
    public string Ord_Date { get; set; } //會員訂單日期
    public string R_Name { get; set; } //員工(收貨人)姓名

    public string R_Phone { get; set; } //員工(收貨人)電話

    public string R_Moblile { get; set; } //員工(收貨人)手機

    public string R_Email { get; set; } //員工(收貨人)電子郵件

    public string R_Address { get; set; } //員工(收貨人)住址


}