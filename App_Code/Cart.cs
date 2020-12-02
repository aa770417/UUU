using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Cart 的摘要描述
/// </summary>
public class Cart //購物車類別
{
    public int Ord_ID { get; set; } //訂單編號
    public int P_ID { get; set; } //商品編號
    public string P_Name { get; set; } //商品名稱
    public int P_Price { get; set; } //價格
    public int P_Quantity { get; set; } //訂購數量
    public int E_ID { get; set; }//員工ID
    //商品小計
    public int Amount//總價
    {
        get
        {
            return P_Price * P_Quantity;
        }
    }/// </summary>
}


//取得商品總價
//public bool AddProduct(int ProductId)
//{
//    //判斷相同Id的CartItem是否已經存在購物車內
//    if ())
//    {   //不存在購物車內，則新增一筆

//    }
//    else
//    {   //存在購物車內，則將商品數量累加
//        findItem.Quantity += 1;
//    }
//    return true;
//}

//private bool AddProduct(Product product)
//{
//    //將Product轉為CartItem
//    var cartItem = new 
//    {

//    };

//    //加入CartItem至購物車
//    this.cartItems.Add(cartItem);
//    return true;
//}
//public bool RemoveProduct(int ProductId)
//{


//    //判斷相同Id的CartItem是否已經存在購物車內
//    if ()
//    {
//        //不存在購物車內，不需做任何動作
//    }
//    else
//    {   //存在購物車內，將商品移除
//        
//    }
//    return true;
//}
//public bool ClearCart()
//{
//    this.cartItems.Clear();
//    return true;
//}

////將購物車商品轉成OrderDetail的List
//public List<OrderDetail> ToOrderDetailList(int orderId)
//{
//    var result = new List<OrderDetail>();
//    foreach ()
//    {
//        result.Add()()
//        {
//        });
//    }
//    return result;
//}




