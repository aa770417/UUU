using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PeterHsuUtilities
/// </summary>
public class PeterHsuUtilities
{
    public static Employee CheckEmployeeLogin(string em, string pw)
    {

        DBEntities db = new DBEntities();

        Employee emp = db.Employees.SingleOrDefault(employee => employee.Email == em & employee.Password == pw);
        //var query = from member in db.Members
        //            where member.UserName == un && member.Password == pw
        //            select member;

        //Member m = query.SingleOrDefault();

        return emp;
    }

    public static Employee CheckEmployeeEmail(string em)
    {
        DBEntities db = new DBEntities();

        Employee emp = db.Employees.SingleOrDefault(employee => employee.Email == em);
        //var query = from member in db.Members
        //            where member.UserName == un 
        //            select member;

        //Member m = query.SingleOrDefault();

        return emp;
    }

    public static bool ResetEmployeePassword(Employee emp)
    {
        if (emp != null)
        {
            using (DBEntities db = new DBEntities())
            {
                db.Employees.Attach(emp);
                db.Entry(emp).Property(x => x.Password).IsModified = true;
                //db.SaveChanges();

                try
                {
                    db.SaveChanges();
                }
                catch (DbEntityValidationException ex)
                {
                    var entityError = ex.EntityValidationErrors.SelectMany(x => x.ValidationErrors).Select(x => x.ErrorMessage);
                    var getFullMessage = string.Join("; ", entityError);
                    var exceptionMessage = string.Concat(ex.Message, "errors are: ", getFullMessage);

                }




            }
            return true;
        }
        return false;
    }

    public static Employee GetEmployeeByEmpID(int empID)
    {
        DBEntities db = new DBEntities();

        Employee emp = db.Employees.SingleOrDefault(employee => employee.EmployeeID == empID);
        //var query = from member in db.Members
        //            where member.UserName == un 
        //            select member;

        //Member m = query.SingleOrDefault();

        return emp;
    }

    public static List<Employee> GetEmployees()
    {
        DBEntities db = new DBEntities();
        return db.Employees.ToList();
    }


    public static List<Employee> GetEmployeesByDepID(string depID)
    {
        int departID = int.Parse(depID);
        DBEntities db = new DBEntities();

        return db.Employees.Where(employee => employee.DepartmentID == departID).ToList();
    }

    public static List<Employee> GetEmployeesByEmpID(string empID)
    {
        int employeeID = int.Parse(empID);
        DBEntities db = new DBEntities();

        return db.Employees.Where(employee => employee.EmployeeID == employeeID).ToList();
    }

    public static string GetEmployeeNameByEmpID(int empID)
    {
        DBEntities db = new DBEntities();
        Employee emp = db.Employees.SingleOrDefault(employee => employee.EmployeeID == empID);
        string empFullName = emp.LastName + emp.FirstName;

        return empFullName;
    }


    public static string RenderNewPassword(Random rnd)
    {
        int chars = 9;

        string passwordChar = "12346789ABCDEFGHKLMNPQRTWXYZ";
        // 設定預設圖片文字
        string newPassword = "";

        for (int i = 1; i <= chars; i++)
        {
            newPassword += passwordChar[rnd.Next(0, passwordChar.Length)];
        }
        return newPassword;
    }

    public static bool AddWorkShiftRecords(List<WorkShiftRecord> wsRecordsList)
    {
        if (wsRecordsList != null)
        {
            using (DBEntities db = new DBEntities())
            {
                foreach (var item in wsRecordsList)
                {
                    db.WorkShiftRecords.Add(item);
                }

                int recordsAffected = db.SaveChanges();

                if (recordsAffected > 0)
                {
                    return true;
                }
            }
        }
        return false;
    }

    public static WorkShiftRecord GetWorkShiftRecordById(int wsrID)
    {
        DBEntities db = new DBEntities();

        WorkShiftRecord wsRecord = db.WorkShiftRecords.SingleOrDefault(record => record.WorkShiftRecordId == wsrID);
        //var query = from member in db.Members
        //            where member.UserName == un 
        //            select member;

        //Member m = query.SingleOrDefault();

        return wsRecord;
    }

    public static List<WorkShiftRecordsDepIdView> GetWorkShiftRecordsByDepId(int depID)
    {
        DBEntities db = new DBEntities();

        return db.WorkShiftRecordsDepIdViews.Where(records => records.DepartmentID == depID).ToList();
    }

    public static List<WorkShiftRecord> GetWorkShiftRecords()
    {
        using (DBEntities db = new DBEntities())
        {
            return db.WorkShiftRecords.ToList();
        }
    }

    public static bool EditWorkShiftRecord(WorkShiftRecord wsRecord)
    {
        if (wsRecord != null)
        {
            using (DBEntities db = new DBEntities())
            {
                db.WorkShiftRecords.Attach(wsRecord);
                db.Entry(wsRecord).Property(x => x.WorkDate).IsModified = true;
                db.SaveChanges();
            }
            return true;
        }
        return false;
    }

    public static bool DeleteWorkShiftRecord(WorkShiftRecord wsRecord)
    {
        if (wsRecord != null)
        {
            using (DBEntities db = new DBEntities())
            {
                WorkShiftRecord record = db.WorkShiftRecords.SingleOrDefault(x => x.WorkShiftRecordId == wsRecord.WorkShiftRecordId);
                db.WorkShiftRecords.Remove(record);
                db.SaveChanges();
            }
            return true;
        }
        return false;
    }

    public static bool AddMeetRoomBookingRecord(MeetingRoomBookingRecord meetBookingRecord)
    {
        if (meetBookingRecord != null)
        {
            List<MeetingRoomBookingRecord> records = GetMeetRoomBookingRecordsByRoomID((int)meetBookingRecord.RoomId);

            foreach (var item in records)
            {
                bool Check1 = (meetBookingRecord.StartDateTime < item.StartDateTime) & (meetBookingRecord.StartDateTime < item.EndDateTime) & (meetBookingRecord.EndDateTime < item.StartDateTime) & (meetBookingRecord.EndDateTime < item.EndDateTime);
                bool Check2 = (meetBookingRecord.StartDateTime > item.StartDateTime) & (meetBookingRecord.StartDateTime > item.EndDateTime) & (meetBookingRecord.EndDateTime > item.StartDateTime) & (meetBookingRecord.EndDateTime > item.EndDateTime);

                if ((Check1 == false) && (Check2 == false))
                {
                    return false;
                }
            }
            using (DBEntities db = new DBEntities())
            {
                db.MeetingRoomBookingRecords.Add(meetBookingRecord);
                int recordsAffected = db.SaveChanges();

                if (recordsAffected > 0)
                {
                    return true;
                }
            }
        }
        return false;
    }

    public static bool DeleteMeetingRoomBookingRecord(MeetingRoomBookingRecord record)
    {
        if (record != null)
        {
            using (DBEntities db = new DBEntities())
            {
                MeetingRoomBookingRecord record1 = db.MeetingRoomBookingRecords.SingleOrDefault(x => x.Id == record.Id);
                db.MeetingRoomBookingRecords.Remove(record1);
                db.SaveChanges();
            }
            return true;
        }
        return false;
    }

    public static List<MeetingRoomBookingRecord> GetMeetRoomBookingRecords()
    {
        DBEntities db = new DBEntities();
        return db.MeetingRoomBookingRecords.ToList();
    }

    public static List<MeetingRoomBookingRecord> GetMeetRoomBookingRecordsByRoomID(int roomID)
    {
        DBEntities db = new DBEntities();
        return db.MeetingRoomBookingRecords.Where(bookingrecords => bookingrecords.RoomId == roomID).ToList();
    }

    public static List<MeetingRoomBookingRecord> GetMeetRoomBookingRecordsByEmpID(int empID)
    {
        DBEntities db = new DBEntities();
        return db.MeetingRoomBookingRecords.Where(bookingrecords => bookingrecords.EmployeeID == empID).ToList();
    }

    public static MeetingRoomBookingRecord GetMeetRoomBookingRecordByID(int id)
    {
        DBEntities db = new DBEntities();
        return db.MeetingRoomBookingRecords.SingleOrDefault(bookingrecords => bookingrecords.Id == id);
    }

    public static bool SaveMeetingRecordFilePath(int id, string filepath)
    {
        if (id > 0 && filepath != null)
        {
            MeetingRoomBookingRecord record = new MeetingRoomBookingRecord()
            {
                Id = id,
                MeetingRecordPath = filepath
            };

            using (DBEntities db = new DBEntities())
            {
                db.MeetingRoomBookingRecords.Attach(record);
                db.Entry(record).Property(x => x.MeetingRecordPath).IsModified = true;
                db.SaveChanges();
            }
            return true;
        }
        return false;
    }
}