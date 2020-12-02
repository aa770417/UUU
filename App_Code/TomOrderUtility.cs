using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for TomOrderUtility
/// </summary>
public class TomOrderUtility
{
    public static void AddTomOrder(TomOrder order)
    {
        DBEntities db = new DBEntities();

        db.TomOrders.Add(order);

        db.SaveChanges();
    }
    public static void UpdateTomOrder(TomOrder order)
    {
        DBEntities db = new DBEntities();

        db.Entry(order).State = System.Data.Entity.EntityState.Modified;

        db.SaveChanges();
    }
    public static void DeleteTomOrder(int id)
    {
        DBEntities db = new DBEntities();

        TomOrder o = db.TomOrders.SingleOrDefault(TomOrder => TomOrder.OID == id);
        //var query = from prod in db.Products
        //            where prod.Id == id
        //            select prod;

        //Product p = query.SingleOrDefault();

        db.TomOrders.Remove(o);

        db.SaveChanges();

    }
    //查詢 全部 用id 用品名 從ws呼叫這裡的方法
    public static List<TomOrder> GetAllTomOrders()
    {
        DBEntities db = new DBEntities();

        return db.TomOrders.ToList();
    }
    public static TomOrder GetTomOrder(int id)
    {

        DBEntities db = new DBEntities();

        TomOrder o = db.TomOrders.SingleOrDefault(order => order.OID == id);

        return o;
    }
    //一個顧客可能有多筆
    public static List<TomOrder> GetTomOrderByCID(int id)
    {

        DBEntities db = new DBEntities();

        return db.TomOrders.Where(order => order.EID == id).ToList();
    }
}