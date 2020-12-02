using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ClubUtility
/// </summary>
public class ClubUtility
{
    //根據id取得相對應的社團資料
    public static Club GetClub(int id)
    {
        DBEntities db = new DBEntities();

        Club c = db.Clubs.SingleOrDefault(club => club.Id == id);

        return c;
    }

    //取得全部社團資料
    public static List<Club> GetAllClubs()
    {
        DBEntities db = new DBEntities();

        return db.Clubs.ToList();
    }

    //新增社團
    public static void AddClub(Club club)
    {
        DBEntities db = new DBEntities();

        //db.Configuration.ValidateOnSaveEnabled = false;

        db.Clubs.Add(club);

        db.SaveChanges();
    }

    //修改社團
    public static void UpdateClub(Club club)
    {
        DBEntities db = new DBEntities();

        db.Entry(club).State = System.Data.Entity.EntityState.Modified;

        db.SaveChanges();
    }

    //刪除社團
    public static void DeleteClub(int id)
    {
        DBEntities db = new DBEntities();

        Club cl = db.Clubs.SingleOrDefault(x => x.Id == id);
        //var query = from prod in db.Products
        //            where prod.Id == id
        //            select prod;

        //Product p = query.SingleOrDefault();

        db.Clubs.Remove(cl);

        db.SaveChanges();
    }

    //申請成為社團成員
    public static void ApplyMember(ClubMember cm)
    {
        DBEntities db = new DBEntities();

        db.ClubMembers.Add(cm);

        db.SaveChanges();
    }

    //取得申請社團成員的資料
    public static List<ClubMember> GetApplys()
    {
        DBEntities db = new DBEntities();

        return db.ClubMembers.OrderByDescending(x => x.Id).ToList();
    }

    //根據員工ID取得他的社團資料
    public static ClubMember GetMember(int id)
    {
        DBEntities db = new DBEntities();

        return db.ClubMembers.SingleOrDefault(x => x.Id == id);
    }


    //根據社團ID取得社團成員資料
    public static List<ClubMember> GetMembersByClubID(int id)
    {
        DBEntities db = new DBEntities();

        return db.ClubMembers.Where(x => x.ClubID == id && x.Approval == "同意").ToList();
    }

    //批准 => 修改欄位
    public static void Approve(ClubMember cm)
    {
        DBEntities db = new DBEntities();
        //將批准結果修改至ClubMember
        db.Entry(cm).State = System.Data.Entity.EntityState.Modified;

        db.SaveChanges();

        //根據批准申請的內容，取得要修改的社團ID
        Club c = db.Clubs.SingleOrDefault(club => club.Id == cm.ClubID);

        //計算批准授權的人數
        CalculateApprove(c);
    }

    //計算取得批准授權的人數
    public static void CalculateApprove(Club c)
    {
        DBEntities db = new DBEntities();
        //計算截至目前為止該部門有同意的人數
        int count = (from cms in db.ClubMembers where cms.ClubID == c.Id && cms.Approval == "同意" select cms).Count();

        //計算出的成員數+當下批准的這一位
        c.Members = count;
        db.Entry(c).State = System.Data.Entity.EntityState.Modified;
        db.SaveChanges();
    }

}