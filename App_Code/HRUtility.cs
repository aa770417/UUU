using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for HRUtility
/// </summary>
public class HRUtility
{
    public HRUtility()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    //模擬登入
    public static Employee TestLogin()
    {
        DBEntities db = new DBEntities();
        Employee e = db.Employees.SingleOrDefault(emp => emp.EmployeeID == 4);        
        return e;
    }


    //拿取全名
    public static string GetLastName(int id)
    {
        DBEntities db = new DBEntities();
        Employee e = db.Employees.SingleOrDefault(emp => emp.EmployeeID == id);
        string LastName = e.LastName;
        return LastName;
    }

    //上班打卡
    public static bool InsertClockInRecord(ClockInOutRecord c)
    {
        DBEntities db = new DBEntities();
        ClockInOutRecord HadRecord = db.ClockInOutRecords.SingleOrDefault(re => re.EmployeeID == c.EmployeeID && re.Date == c.Date);
        bool OK = false;
        //檢查重複
        if (HadRecord != null)
        {
            return OK;
        }
        else
        {
            DBEntities db2 = new DBEntities();
            db2.ClockInOutRecords.Add(c);
            db2.SaveChanges();
            OK = true;
            return OK;
        }

    }

    //下班打卡
    public static bool InsertClockOutRecord(ClockInOutRecord c)
    {
        bool OK = false;
        DBEntities db = new DBEntities();
        ClockInOutRecord HadRecord = db.ClockInOutRecords.SingleOrDefault(re => re.EmployeeID == c.EmployeeID && re.Date == c.Date);
        //檢查重複及有無上班紀錄
        if (HadRecord == null){
            return OK;
        }else if (HadRecord.ClockOut == null){
            HadRecord.ClockOut = c.ClockOut;
            db.Entry(HadRecord).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();
            OK = true;
        }
        return OK;
    }

    //打卡紀錄-管理
    public static List<ClockInOutRecord> GetDepartmentIDRecordWithTimeAndPerson(int did, string year, string month, int who)
    {
        DBEntities db = new DBEntities();
        //取得部門員工全名
        Dictionary<int?, string> DEmpName = new Dictionary<int?, string>();
        List<Employee> emp = new List<Employee>();
        emp = db.Employees.Where(result => result.DepartmentID == did).ToList();
        foreach (var item in emp)
        {
            DEmpName.Add(item.EmployeeID, item.LastName + item.FirstName);
        }


        if (who == 0)
        {
            List<ClockInOutRecord> Result = new List<ClockInOutRecord>();
            Result = db.ClockInOutRecords.Where(result => result.DepartmentID == did && result.Note1 == year && result.Note2 == month).OrderByDescending(result => result.CIORID).ToList();
            foreach (var item in Result)
            {
                item.Note1 = DEmpName[item.EmployeeID];
            }

            return Result;

        }
        else
        {
            List<ClockInOutRecord> Result = new List<ClockInOutRecord>();
            Result = db.ClockInOutRecords.Where(result => result.EmployeeID == who && result.Note1 == year && result.Note2 == month).OrderByDescending(result => result.CIORID).ToList();
            foreach (var item in Result)
            {
                item.Note1 = DEmpName[item.EmployeeID];
            }

            return Result;

        }
    }

    //打卡紀錄-個人
    public static List<ClockInOutRecord> GetPersonalRecordWithTime(int id, string year, string month)
    {
        DBEntities db = new DBEntities();
        //取得員工全名
        Employee e = db.Employees.SingleOrDefault(emp => emp.EmployeeID == id);
        string EmpName = e.LastName + e.FirstName;

        //加入顯示姓名
        List<ClockInOutRecord> Result = new List<ClockInOutRecord>();
        Result = db.ClockInOutRecords.Where(result => result.EmployeeID == id && result.Note1 == year && result.Note2 == month).OrderByDescending(result => result.CIORID).ToList();
        foreach (var item in Result)
        {
            item.Note1 = EmpName;
        }

        return Result;
    }

    //打卡記錄管理下拉選單-取得全部門員工姓名及ID
    public static Dictionary<int, string> GetDepartmentNameByDID(int did)
    {
        DBEntities db = new DBEntities();
        Dictionary<int, string> DEmpName = new Dictionary<int, string>();
        List<Employee> emp = new List<Employee>();
        DEmpName.Add(0, "全部");
        emp = db.Employees.Where(result => result.DepartmentID == did).ToList();

        foreach (var item in emp)
        {
            DEmpName.Add(item.EmployeeID, item.LastName + item.FirstName);
        }
        return DEmpName;
    }
    //打卡記錄管理下拉選單-取得全部門紀錄年分
    public static Dictionary<int, string> GetYearFromCIORByDID(int did)
    {
        DBEntities db = new DBEntities();
        Dictionary<int, string> DYear = new Dictionary<int, string>();
        List<ClockInOutRecord> cior = new List<ClockInOutRecord>();

        cior = db.ClockInOutRecords.Where(result => result.DepartmentID == did).ToList();

        foreach (var item in cior)
        {
            try
            {
                DYear.Add(int.Parse(item.Note1), item.Note1);
            }
            catch (ArgumentException)
            {
                DYear[int.Parse(item.Note1)] = item.Note1;
            }

        }
        return DYear;
    }

    //打卡記錄管理下拉選單-取得全部門月份
    public static Dictionary<int, string> GetMonthFromCIORByDID(int did)
    {
        DBEntities db = new DBEntities();
        Dictionary<int, string> DMonth = new Dictionary<int, string>();
        List<ClockInOutRecord> cior = new List<ClockInOutRecord>();

        cior = db.ClockInOutRecords.Where(result => result.DepartmentID == did).ToList();

        foreach (var item in cior)
        {
            try
            {
                DMonth.Add(int.Parse(item.Note2), item.Note2);
            }
            catch (ArgumentException)
            {
                DMonth[int.Parse(item.Note2)] = item.Note2;
            }

        }
        return DMonth;
    }

    //打卡記錄個人下拉選單-取得年分
    public static Dictionary<int, string> GetYearFromCIORByEID(int eid)
    {
        DBEntities db = new DBEntities();
        Dictionary<int, string> DYear = new Dictionary<int, string>();
        List<ClockInOutRecord> cior = new List<ClockInOutRecord>();

        cior = db.ClockInOutRecords.Where(result => result.EmployeeID == eid).ToList();

        foreach (var item in cior)
        {
            try
            {
                DYear.Add(int.Parse(item.Note1), item.Note1);
            }
            catch (ArgumentException)
            {
                DYear[int.Parse(item.Note1)] = item.Note1;
            }

        }
        return DYear;
    }

    //打卡記錄個人下拉選單-取得月份
    public static Dictionary<int, string> GetMonthFromCIORByEID(int eid)
    {
        DBEntities db = new DBEntities();
        Dictionary<int, string> DMonth = new Dictionary<int, string>();
        List<ClockInOutRecord> cior = new List<ClockInOutRecord>();

        cior = db.ClockInOutRecords.Where(result => result.EmployeeID == eid).ToList();

        foreach (var item in cior)
        {
            try
            {
                DMonth.Add(int.Parse(item.Note2), item.Note2);
            }
            catch (ArgumentException)
            {
                DMonth[int.Parse(item.Note2)] = item.Note2;
            }

        }
        return DMonth;
    }


    //打卡紀錄單筆審核
    public static void CIORSinglePassed(int ciorId)
    {
        DBEntities db = new DBEntities();
        ClockInOutRecord cior = db.ClockInOutRecords.SingleOrDefault(result => ciorId == result.CIORID);
        cior.Passed = "通過";
        db.Entry(cior).State = System.Data.Entity.EntityState.Modified;
        db.SaveChanges();
    }

    //讀取單項打卡紀錄
    public static ClockInOutRecord GetClockInOutRecordForModify(int ciorID)
    {
        DBEntities db = new DBEntities();
        ClockInOutRecord Record = db.ClockInOutRecords.SingleOrDefault(re => re.CIORID == ciorID);
        Employee e = db.Employees.SingleOrDefault(emp => emp.EmployeeID == Record.EmployeeID);
        string EmpName = e.LastName + e.FirstName;
        Record.Note1 = EmpName;

        return Record;
    }

    //修改紀錄
    public static bool ModifyClockInOutRecord(int ciorID, int modifyID, string CIn, string COut)
    {
        bool OK = false;
        DBEntities db = new DBEntities();
        ClockInOutRecord OldRecord = db.ClockInOutRecords.SingleOrDefault(re => re.CIORID == ciorID);
        if (OldRecord != null)
        {
            ClockInOutRecord newRecord = new ClockInOutRecord()
            {
                EmployeeID = OldRecord.EmployeeID,
                DepartmentID = OldRecord.DepartmentID,
                Date = OldRecord.Date,
                ClockIn = CIn,
                ClockOut = COut,
                Passed = "通過",
                ModifiedBy = modifyID,
                Note1 = OldRecord.Date.Substring(0, 4),
                Note2 = OldRecord.Date.Substring(5, 2)
            };
            OldRecord.ModifiedBy = modifyID;
            OldRecord.Passed = "已修改";
            db.Entry(OldRecord).State = System.Data.Entity.EntityState.Modified;
            db.ClockInOutRecords.Add(newRecord);
            db.SaveChanges();
            OK = true;

        }
        return OK;
    }

    //假單新增
    public static bool AddLeave(Leave L)
    {
        bool OK = false;
        if (L.Hour != 0 || L.Hour != null)
        {
            DBEntities db = new DBEntities();
            db.Leaves.Add(L);
            db.SaveChanges();
            return OK = true;
        }
        else { return OK; }
    }

    //請假紀錄-管理
    public static List<Leave> GetDepartmentLeaveRecordWithTime(int did, string year, string month, int who)
    {
        DBEntities db = new DBEntities();

        Dictionary<int?, string> DEmpName = new Dictionary<int?, string>();
        List<Employee> emp = new List<Employee>();
        emp = db.Employees.Where(result => result.DepartmentID == did).ToList();
        foreach (var item in emp)
        {
            DEmpName.Add(item.EmployeeID, item.LastName + item.FirstName);
        }

        if (who == 0)
        {
            List<Leave> Result = new List<Leave>();
            Result = db.Leaves.Where(result => result.DepartmentID == did && result.Date.Substring(0, 4) == year && result.Date.Substring(5, 2) == month).OrderByDescending(result => result.LeaveID).ToList();
            foreach (var item in Result)
            {
                item.Note2 = DEmpName[item.EmployeeID];
            }

            return Result;

        }
        else
        {
            List<Leave> Result = new List<Leave>();
            Result = db.Leaves.Where(result => result.EmployeeID == who && result.Date.Substring(0, 4) == year && result.Date.Substring(5, 2) == month).OrderByDescending(result => result.LeaveID).ToList();
            foreach (var item in Result)
            {
                item.Note2 = DEmpName[item.EmployeeID];
            }

            return Result;

        }
    }


    //請假紀錄-個人
    public static List<Leave> GetPersonalLeaveRecordWithTime(int id, string year, string month)
    {
        DBEntities db = new DBEntities();
        //取得員工全名
        Employee e = db.Employees.SingleOrDefault(emp => emp.EmployeeID == id);
        string EmpName = e.LastName + e.FirstName;

        //加入顯示姓名
        List<Leave> Result = new List<Leave>();
        Result = db.Leaves.Where(result => result.EmployeeID == id && result.Date.StartsWith(year + "-" + month)).OrderByDescending(result => result.LeaveID).ToList();
        foreach (var item in Result)
        {
            item.Note2 = EmpName;
        }

        return Result;
    }

    //請假記錄管理下拉選單-取得全部門紀錄年分
    public static Dictionary<int, string> GetYearFromLeaveByDID(int did)
    {
        DBEntities db = new DBEntities();
        Dictionary<int, string> DYear = new Dictionary<int, string>();
        List<Leave> Lr = new List<Leave>();

        Lr = db.Leaves.Where(result => result.DepartmentID == did).ToList();
                

        foreach (var item in Lr)
        {
            try
            {
                DYear.Add(int.Parse(item.Date.Substring(0, 4)), item.Date.Substring(0, 4));
            }
            catch (ArgumentException)
            {
                DYear[int.Parse(item.Date.Substring(0, 4))] = item.Date.Substring(0, 4);
            }

        }
        return DYear;
    }

    //請假記錄管理下拉選單-取得全部門月份
    public static Dictionary<int, string> GetMonthFromLeaveByDID(int did)
    {
        DBEntities db = new DBEntities();
        Dictionary<int, string> DMonth = new Dictionary<int, string>();
        List<Leave> Lr = new List<Leave>();

        Lr = db.Leaves.Where(result => result.DepartmentID == did).ToList();

        foreach (var item in Lr)
        {
            try
            {
                DMonth.Add(int.Parse(item.Date.Substring(5, 2)), item.Date.Substring(5, 2));
            }
            catch (ArgumentException)
            {
                DMonth[int.Parse(item.Date.Substring(5, 2))] = item.Date.Substring(5, 2);
            }

        }
        return DMonth;
    }

    //請假記錄個人下拉選單-取得年分
    public static Dictionary<int, string> GetYearFromLeaveByEID(int eid)
    {
        DBEntities db = new DBEntities();
        Dictionary<int, string> DYear = new Dictionary<int, string>();
        List<Leave> Lr = new List<Leave>();

        Lr = db.Leaves.Where(result => result.EmployeeID == eid).ToList();

        foreach (var item in Lr)
        {
            try
            {
                DYear.Add(int.Parse(item.Date.Substring(0, 4)), item.Date.Substring(0, 4));
            }
            catch (ArgumentException)
            {
                DYear[int.Parse(item.Date.Substring(0, 4))] = item.Date.Substring(0, 4);
            }

        }
        return DYear;
    }

    //請假記錄個人下拉選單-取得月份
    public static Dictionary<int, string> GetMonthFromLeaveByEID(int eid)
    {
        DBEntities db = new DBEntities();
        Dictionary<int, string> DMonth = new Dictionary<int, string>();
        List<Leave> Lr = new List<Leave>();

        Lr = db.Leaves.Where(result => result.EmployeeID == eid).ToList();

        foreach (var item in Lr)
        {
            try
            {
                DMonth.Add(int.Parse(item.Date.Substring(5, 2)), item.Date.Substring(5, 2));
            }
            catch (ArgumentException)
            {
                DMonth[int.Parse(item.Date.Substring(5, 2))] = item.Date.Substring(5, 2);
            }

        }
        return DMonth;
    }

    //取請假單Detail
    public static Leave GetPersonalLeaveRecordByLID(int lid)
    {
        DBEntities db = new DBEntities();
        //加入顯示姓名

        Leave leave = db.Leaves.SingleOrDefault(result => result.LeaveID == lid);

        Employee e = db.Employees.SingleOrDefault(emp => emp.EmployeeID == leave.EmployeeID);
        string EmpName = e.LastName + e.FirstName;
        leave.Note2 = EmpName;


        return leave;
    }

    //請假單審核
    public static bool LeavePass(int LID)
    {
        bool OK = false;
        DBEntities db = new DBEntities();
        Leave L = db.Leaves.SingleOrDefault(result => LID == result.LeaveID);
        if (L != null)
        {
            L.Passed = "通過";
            db.Entry(L).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();
            return OK = true;
        }
        else { return OK; }
    }
    //請假單退件
    public static bool LeaveReturn(int LID,string reason,int MID)
    {
        bool OK = false;
        DBEntities db = new DBEntities();
        Leave L = db.Leaves.SingleOrDefault(result => LID == result.LeaveID);
        if (L != null)
        {
            L.Passed = "退件";
            L.Note1 = reason;
            L.ModifiedBy = MID;
            db.Entry(L).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();
            return OK = true;
        }
        else { return OK; }
    }
    //沒有ALL的部門姓名
    public static Dictionary<int, string> GetDepartmentNameByDIDNoAll(int did)
    {
        DBEntities db = new DBEntities();
        Dictionary<int, string> DEmpName = new Dictionary<int, string>();
        List<Employee> emp = new List<Employee>();
        DEmpName.Add(0, "請選擇");
        emp = db.Employees.Where(result => result.DepartmentID == did).ToList();

        foreach (var item in emp)
        {
            DEmpName.Add(item.EmployeeID, item.LastName + item.FirstName);
        }
        return DEmpName;
    }

}