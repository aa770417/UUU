using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for BoardUtility
/// </summary>
public class TomBoardUtility
{
 

    public static void AddBoard(Board board)
    {
        DBEntities db = new DBEntities();

        db.Boards.Add(board);

        db.SaveChanges();
    }
    public static void UpdateBoard(Board board)
    {
        DBEntities db = new DBEntities();

        db.Entry(board).State = System.Data.Entity.EntityState.Modified;

        db.SaveChanges();
    }
    public static void DeleteBoard(int id)
    {
        DBEntities db = new DBEntities();

        Board b = db.Boards.SingleOrDefault(board => board.BID == id);
        //var query = from prod in db.Products
        //            where prod.Id == id
        //            select prod;

        //Product p = query.SingleOrDefault();

        db.Boards.Remove(b);

        db.SaveChanges();

    }
    //查詢 全部 用id 用品名 從ws呼叫這裡的方法
    public static List<Board> GetAllBoards()
    {
        DBEntities db = new DBEntities();

        return db.Boards.ToList();
    }
    public static Board GetBoard(int id)
    {

        DBEntities db = new DBEntities();

        Board o = db.Boards.SingleOrDefault(board => board.BID == id);

        return o;
    }
    //一個顧客可能有多筆
    //public static List<Board> GetOrderByEID(int id)
    //{

    //    DBEntities db = new DBEntities();

    //    return db.Orders.Where(order => order.EID == id).ToList();
    //}


}