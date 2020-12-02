using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// OrderDetail 的摘要描述
/// </summary>
public class DarrenOrdersDetail
{
    public int Ord_ID { get; set; } //訂單編號
    public int P_ID { get; set; } //商品編號
    public string P_Name { get; set; } //商品名稱
    public int P_Price { get; set; } //價格
    public int P_Quantity { get; set; } //訂購數量
    public int P_Amount { get; set; }//總價
    public int E_ID { get; set; }//員工ID
}