using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MessageUtility
/// </summary>
public class MessageUtility
{
    public MessageUtility()
    {
        //
        // TODO: Add constructor logic here
        //
    }



    public static List<Employee> ShowEmployee()
    {
        DBEntities db = new DBEntities();

        return db.Employees.ToList();
    }
    //誰傳新訊息
    public static List<Employee> GetNewReceiveWhosMsg(int eid)
    {
        DBEntities db = new DBEntities();

        List<WorkMessage> Result = new List<WorkMessage>();
        List<Employee> Who = new List<Employee>();
        Result = db.WorkMessages.Where(result => result.RecipientEID == eid && result.HaveRead == "未讀").OrderBy(result => result.MessageID).ToList();
        foreach (var item in Result)
        {
            Employee a = db.Employees.SingleOrDefault(emp => emp.EmployeeID == item.SenderEID);


            if (!Who.Contains(a))
            {
                Who.Add(a);
            }

        }

        return Who;
    }



    //幾條訊息
    public static List<WorkMessage> GetPersonalReceiveMsgCount(int eid)
    {
        DBEntities db = new DBEntities();

        List<WorkMessage> Result = new List<WorkMessage>();
        Result = db.WorkMessages.Where(result => result.RecipientEID == eid && result.HaveRead == "未讀").OrderBy(result => result.MessageID).ToList();
        //判斷是否是送出

        return Result;
    }

    //個人與誰訊息接收紀錄
    public static List<WorkMessage> GetPersonalReceiveMessage(int eid, int whoid)
    {
        DBEntities db = new DBEntities();

        List<WorkMessage> Result = new List<WorkMessage>();
        Result = db.WorkMessages.Where(result => result.RecipientEID == eid && result.SenderEID == whoid || result.RecipientEID == whoid && result.SenderEID == eid).OrderBy(result => result.MessageID).ToList();
        //判斷是否是送出
        foreach (var item in Result)
        {
            if (item.SenderEID != eid) {

                item.HaveRead= "已讀";
                db.Entry(item).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();

                item.Note1 = "收到";
            } else { item.Note1 = "送出"; }
            
        }

        return Result;
    }

    //個人訊息送出紀錄 沒用了
    public static List<WorkMessage> GetPersonalSendMessage(int id)
    {
        DBEntities db = new DBEntities();
        //取得員工全名
        Employee e = db.Employees.SingleOrDefault(emp => emp.EmployeeID == id);
        string DName = e.DepartmentName;
        string EmpName = e.LastName + e.FirstName;


        //加入顯示姓名
        List<WorkMessage> Result = new List<WorkMessage>();
        Result = db.WorkMessages.Where(result => result.SenderEID == id).OrderByDescending(result => result.MessageID).ToList();
        foreach (var item in Result)
        {
            Employee who = db.Employees.SingleOrDefault(emp => emp.EmployeeID == item.RecipientEID);
            item.Note1 = who.DepartmentName + "," + who.LastName + who.FirstName;
            item.Note2 = DName + "," + EmpName;
            item.Note3 = who.ImageFileName;
        }

        return Result;
    }

    //個人單筆接收訊息 沒用了
    public static WorkMessage GetPersonalReceiveMessageDetail(int mid)
    {
        DBEntities db = new DBEntities();
        //取得員工全名

        //加入顯示姓名
        WorkMessage Result = db.WorkMessages.SingleOrDefault(result => result.MessageID == mid);
        Result.HaveRead = "已讀";
        db.Entry(Result).State = System.Data.Entity.EntityState.Modified;
        db.SaveChanges();
        WorkMessage Result1 = db.WorkMessages.SingleOrDefault(result => result.MessageID == mid);
        Employee who = db.Employees.SingleOrDefault(emp => emp.EmployeeID == Result1.SenderEID);
        Result1.Note1 = who.DepartmentName + "," + who.LastName + who.FirstName;
        Result1.Note3 = who.ImageFileName;

        return Result1;
    }

    //個人單筆發送訊息 沒用了
    public static WorkMessage GetPersonalSendMessageDetail(int mid)
    {
        DBEntities db = new DBEntities();
        //取得員工全名

        //加入顯示姓名
        WorkMessage Result = db.WorkMessages.SingleOrDefault(result => result.MessageID == mid);
        Employee who = db.Employees.SingleOrDefault(emp => emp.EmployeeID == Result.RecipientEID);
        Result.Note1 = who.DepartmentName + "," + who.LastName + who.FirstName;
        Result.Note3 = who.ImageFileName;

        return Result;
    }
    //傳訊息
    public static bool SendMsg(WorkMessage W)
    {
        DBEntities db = new DBEntities();
        Employee Sender = db.Employees.SingleOrDefault(re => re.EmployeeID == W.SenderEID);
        Employee Recipient = db.Employees.SingleOrDefault(re => re.EmployeeID == W.RecipientEID);

        bool OK = false;

        W.SenderDID = Sender.DepartmentID;
        W.RecipientDID = Recipient.DepartmentID;
        db.WorkMessages.Add(W);
        db.SaveChanges();
        OK = true;
        return OK;

    }





}