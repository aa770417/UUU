using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// EmployeeUtility 的摘要描述
/// </summary>
public class EmployeeUtility
{
    //取得全部員工(不含離職)
    public static List<YenEmployee> GetEmployees()
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "select * from Employee where ResignedDate > GETDATE() or ResignedDate is null ", Common.DBConnectionString);

        DataTable dt = new DataTable();

        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new YenEmployee()
                    {
                        EmployeeID = Convert.ToInt32(row["EmployeeID"]),
                        UserName = row["UserName"].ToString(),
                        Password = row["Password"].ToString(),
                        LastName = row["LastName"].ToString(),
                        FirstName = row["FirstName"].ToString(),
                        Gender = row["Gender"].ToString(),
                        DepartmentName = row["DepartmentName"].ToString(),
                        AuthorizationLevel = row["AuthorizationLevel"].ToString(),
                        HiredDate = Convert.ToDateTime(row["HiredDate"]).ToShortDateString(),
                        Salary = Convert.ToInt32(row["Salary"]),
                        ServiceYear = Math.Round((decimal)new TimeSpan(DateTime.Now.Ticks - Convert.ToDateTime(row["HiredDate"]).Ticks).Days / 365, 1).ToString(),
                        //年齡
                        Age = row["BirthDate"] is DBNull ? "" : Math.Round((decimal)new TimeSpan(DateTime.Now.Ticks - Convert.ToDateTime(row["BirthDate"]).Ticks).Days / 365, 0).ToString()
                    };
        return query.ToList();        
    }

    //取得全部員工(含離職)
    public static List<YenEmployee> GetAllEmployees()
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "select * from Employee", Common.DBConnectionString);

        DataTable dt = new DataTable();

        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new YenEmployee()
                    {
                        EmployeeID = Convert.ToInt32(row["EmployeeID"]),
                        UserName = row["UserName"].ToString(),
                        Password = row["Password"].ToString(),
                        LastName = row["LastName"].ToString(),
                        FirstName = row["FirstName"].ToString(),
                        Gender = row["Gender"].ToString(),
                        DepartmentName = row["DepartmentName"].ToString(),
                        AuthorizationLevel = row["AuthorizationLevel"].ToString(),
                        HiredDate = Convert.ToDateTime(row["HiredDate"]).ToShortDateString(),
                        //會有空值的狀況，若不給""會造成程式錯誤
                        ResignedDate = row["ResignedDate"] is DBNull ? "" : Convert.ToDateTime(row["ResignedDate"]).ToShortDateString(),
                        Salary = Convert.ToInt32(row["Salary"]),
                        ServiceYear = row["ResignedDate"] is DBNull ?
                        Math.Round((decimal)new TimeSpan(DateTime.Now.Ticks - Convert.ToDateTime(row["HiredDate"]).Ticks).Days / 365, 1).ToString() :
                        Math.Round((decimal)new TimeSpan(Convert.ToDateTime(row["ResignedDate"]).Ticks - Convert.ToDateTime(row["HiredDate"]).Ticks).Days / 365, 1).ToString(),
                        //年齡
                        Age = row["BirthDate"] is DBNull ? "" : Math.Round((decimal)new TimeSpan(DateTime.Now.Ticks - Convert.ToDateTime(row["BirthDate"]).Ticks).Days / 365, 0).ToString()
                    };
        return query.ToList();
    }

    //根據id取得員工資料
    public static YenEmployee GetEmployeeByID(int id)
    {
        using (SqlConnection cn = new SqlConnection(Common.DBConnectionString))
        {
            SqlDataAdapter da = new SqlDataAdapter(
            "select * from Employee where EmployeeID = @id", cn);

            da.SelectCommand.Parameters.AddWithValue("@id", id);

            DataTable dt = new DataTable();

            da.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                return null;
            }
            else
            {
                return new YenEmployee()
                {
                    EmployeeID = Convert.ToInt32(dt.Rows[0]["EmployeeID"]),
                    UserName = dt.Rows[0]["UserName"].ToString(),
                    Password = dt.Rows[0]["Password"].ToString(),
                    LastName = dt.Rows[0]["LastName"].ToString(),
                    FirstName = dt.Rows[0]["FirstName"].ToString(),
                    Gender = dt.Rows[0]["Gender"].ToString(),
                    BirthDate = dt.Rows[0]["BirthDate"] is DBNull ? "" : ((DateTime)dt.Rows[0]["BirthDate"]).ToShortDateString(),
                    DepartmentID = Convert.ToInt32(dt.Rows[0]["DepartmentID"]),
                    DepartmentName = dt.Rows[0]["DepartmentName"].ToString(),
                    AuthorizationLevel = dt.Rows[0]["AuthorizationLevel"].ToString(),
                    Salary = Convert.ToInt32(dt.Rows[0]["Salary"]),
                    HiredDate = ((DateTime)dt.Rows[0]["HiredDate"]).ToShortDateString(),
                    ResignedDate = dt.Rows[0]["ResignedDate"] is DBNull ? null : ((DateTime)dt.Rows[0]["ResignedDate"]).ToShortDateString(),
                    //年資
                    ServiceYear = Math.Round((decimal)new TimeSpan(DateTime.Now.Ticks - Convert.ToDateTime(dt.Rows[0]["HiredDate"]).Ticks).Days / 365, 1).ToString(),
                    //年齡
                    Age = dt.Rows[0]["BirthDate"] is DBNull ? null : Math.Round((decimal)new TimeSpan(DateTime.Now.Ticks - Convert.ToDateTime(dt.Rows[0]["BirthDate"]).Ticks).Days / 365, 0).ToString(),
                    Mobile = dt.Rows[0]["Mobile"] is DBNull ? null : dt.Rows[0]["Mobile"].ToString(),
                    Email = dt.Rows[0]["Email"] is DBNull ? null : dt.Rows[0]["Email"].ToString(),
                    Address = dt.Rows[0]["Address"] is DBNull ? null : dt.Rows[0]["Address"].ToString(),
                    ImageFileName = dt.Rows[0]["ImageFileName"] is DBNull ? null : dt.Rows[0]["ImageFileName"].ToString()
                };
            }
        }
    }

    //根據id修改員工資料(人事)
    public static void UpdateEmployeeByID(YenEmployee e)
    {
        using (SqlConnection cn = new SqlConnection(Common.DBConnectionString))
        {
            SqlCommand command = new SqlCommand("update Employee set Password = @Password, LastName=@LastName, FirstName=@FirstName," +
                                            " Gender=@Gender,DepartmentName=@DepartmentName,DepartmentID=@DepartmentID, AuthorizationLevel=@AuthorizationLevel, Salary=@Salary, ResignedDate=@ResignedDate," +
                                            "Mobile=@Mobile, Address=@Address where EmployeeID = @EmployeeID", cn);

            command.Parameters.AddWithValue("@EmployeeID", e.EmployeeID);
            //command.Parameters.AddWithValue("@Email", e.Email);
            command.Parameters.AddWithValue("@Password", e.Password);
            command.Parameters.AddWithValue("@LastName", e.LastName);
            command.Parameters.AddWithValue("@FirstName", e.FirstName);
            command.Parameters.AddWithValue("@Gender", e.Gender);
            command.Parameters.AddWithValue("@DepartmentName", e.DepartmentName);
            command.Parameters.AddWithValue("@DepartmentID", e.DepartmentID);
            command.Parameters.AddWithValue("@AuthorizationLevel", e.AuthorizationLevel);
            command.Parameters.AddWithValue("@Salary", e.Salary);
            if (e.ResignedDate != null)
                command.Parameters.AddWithValue("@ResignedDate", e.ResignedDate);
            else
                command.Parameters.AddWithValue("@ResignedDate", DBNull.Value);
            if (e.Mobile != null)
                command.Parameters.AddWithValue("@Mobile", e.Mobile);
            else
                command.Parameters.AddWithValue("@Mobile", DBNull.Value);            
            if (e.Address != null)
                command.Parameters.AddWithValue("@Address", e.Address);
            else
                command.Parameters.AddWithValue("@Address", DBNull.Value);
            cn.Open();
            command.ExecuteNonQuery();
            cn.Close();
        }
    }

    //修改員工資料(個人)
    public static void UpdateInfo(YenEmployee e)
    {
        using (SqlConnection cn = new SqlConnection(Common.DBConnectionString))
        {
            SqlCommand command = new SqlCommand("update Employee set Password=@Password, Mobile=@Mobile, Address=@Address, Birthdate=@Birthdate, ImageFileName=@ImageFileName where EmployeeID = @EmployeeID", cn);

            command.Parameters.AddWithValue("@EmployeeID", e.EmployeeID);
            command.Parameters.AddWithValue("@Password", e.Password);            
            if (e.Mobile != null)
                command.Parameters.AddWithValue("@Mobile", e.Mobile);
            else
                command.Parameters.AddWithValue("@Mobile", DBNull.Value);
            if (e.Email != null)
                command.Parameters.AddWithValue("@Email", e.Email);
            else
                command.Parameters.AddWithValue("@Email", DBNull.Value);
            if (e.Address != null)
                command.Parameters.AddWithValue("@Address", e.Address);
            else
                command.Parameters.AddWithValue("@Address", DBNull.Value);
            if (e.BirthDate != null)
                command.Parameters.AddWithValue("@BirthDate", e.BirthDate);
            else
                command.Parameters.AddWithValue("@BirthDate", DBNull.Value);
            if (e.ImageFileName != null)
                command.Parameters.AddWithValue("@ImageFileName", e.ImageFileName);
            else
                command.Parameters.AddWithValue("@ImageFileName", DBNull.Value);
            cn.Open();
            command.ExecuteNonQuery();
            cn.Close();
        }
    }

    //根據部門取得員工資訊
    public static List<YenEmployee> GetEmployeesByDepartmentID(int id)
    {
        SqlDataAdapter da = new SqlDataAdapter(
    "select * from Employee where DepartmentID=@id", Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@id", id);

        DataTable dt = new DataTable();

        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new YenEmployee()
                    {
                        EmployeeID = Convert.ToInt32(row["EmployeeID"]),
                        UserName = row["UserName"].ToString(),
                        Password = row["Password"].ToString(),
                        LastName = row["LastName"].ToString(),
                        FirstName = row["FirstName"].ToString(),
                        Gender = row["Gender"].ToString(),
                        DepartmentName = row["DepartmentName"].ToString(),
                        AuthorizationLevel = row["AuthorizationLevel"].ToString(),
                        HiredDate = Convert.ToDateTime(row["HiredDate"]).ToShortDateString(),
                        ResignedDate = row["ResignedDate"] is DBNull ? "" : Convert.ToDateTime(row["ResignedDate"]).ToShortDateString(),
                        Salary = Convert.ToInt32(row["Salary"]),
                        //年資
                        ServiceYear = row["ResignedDate"] is DBNull ?
                        Math.Round((decimal)new TimeSpan(DateTime.Now.Ticks - Convert.ToDateTime(row["HiredDate"]).Ticks).Days / 365, 1).ToString() :
                        Math.Round((decimal)new TimeSpan(Convert.ToDateTime(row["ResignedDate"]).Ticks - Convert.ToDateTime(row["HiredDate"]).Ticks).Days / 365, 1).ToString(),
                        //年齡
                        Age = row["BirthDate"] is DBNull ? "" : Math.Round((decimal)new TimeSpan(DateTime.Now.Ticks - Convert.ToDateTime(row["BirthDate"]).Ticks).Days / 365, 0).ToString()
                    };
        return query.ToList();
    }

    //下拉式選單。根據傳入的ID，選擇查詢動作
    public static List<YenEmployee> DropDownList(int id)
    {
        if (id == 0)
            return GetAllEmployees();
        else
            return GetEmployeesByDepartmentID(id);
    }

    //修改員工資料
    public static void InsertEmployee(YenEmployee e)
    {
        using (SqlConnection cn = new SqlConnection(Common.DBConnectionString))
        {
            SqlCommand cmd = new SqlCommand(
                "insert into Employee (Email, Password, LastName, FirstName, Gender, DepartmentID, DepartmentName, AuthorizationLevel, HiredDate, Salary)"
                + "values(@Email, @Password, @LastName, @FirstName, @Gender, @DepartmentID, @DepartmentName, @AuthorizationLevel, @HiredDate, @Salary)",
                cn);

            cmd.Parameters.AddWithValue("@Email", e.Email);
            cmd.Parameters.AddWithValue("@Password", e.Password);
            cmd.Parameters.AddWithValue("@LastName", e.LastName);
            cmd.Parameters.AddWithValue("@FirstName", e.FirstName);
            cmd.Parameters.AddWithValue("@Gender", e.Gender);
            cmd.Parameters.AddWithValue("@DepartmentID", e.DepartmentID);
            cmd.Parameters.AddWithValue("@DepartmentName", e.DepartmentName);
            cmd.Parameters.AddWithValue("@AuthorizationLevel", e.AuthorizationLevel);
            cmd.Parameters.AddWithValue("@HiredDate", e.HiredDate);
            cmd.Parameters.AddWithValue("@Salary", e.Salary);

            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }

    //根據id，將權限修改至0
    public static void RemoveAuthorizational(int id)
    {
        using (SqlConnection cn = new SqlConnection(Common.DBConnectionString))
        {
            SqlCommand command = new SqlCommand("update Employee set Email=@Email where EmployeeID = @EmployeeID", cn);

            command.Parameters.AddWithValue("@EmployeeID", id);
            command.Parameters.AddWithValue("@Email", "");
            cn.Open();
            command.ExecuteNonQuery();
            cn.Close();
        }
    }

    //根據id，刪除
    public static void DeleteEmployeeByID(int id)
    {
        using (SqlConnection cn = new SqlConnection(Common.DBConnectionString))
        {
            SqlCommand command = new SqlCommand("delete Employee where EmployeeID=@EmployeeID", cn);

            command.Parameters.AddWithValue("@EmployeeID", id);
            cn.Open();
            command.ExecuteNonQuery();
        }
    }

    //根據帳號密碼，判斷是否有這個員工
    public static bool CheckEmployee(string email, string password)
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "select * from Employee where Email=@email and Password=@password",
            Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@email", email);
        da.SelectCommand.Parameters.AddWithValue("@password", password);

        DataTable dt = new DataTable();
        da.Fill(dt);
        //如果有取得，就會有一筆資料
        return dt.Rows.Count == 1;

    }

    //根據登入時的Username，取得該員工的資料
    public static YenEmployee GetEmployeeInfo(string email)
    {
        using (SqlConnection cn = new SqlConnection(Common.DBConnectionString))
        {
            SqlDataAdapter da = new SqlDataAdapter(
            "select * from Employee where Email = @email", cn);

            da.SelectCommand.Parameters.AddWithValue("@email", email);

            DataTable dt = new DataTable();

            da.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                return null;
            }
            else
            {
                return new YenEmployee()
                {
                    EmployeeID = Convert.ToInt32(dt.Rows[0]["EmployeeID"]),
                    Email = dt.Rows[0]["email"].ToString(),
                    LastName = dt.Rows[0]["LastName"].ToString(),
                    FirstName = dt.Rows[0]["FirstName"].ToString(),
                    DepartmentID = Convert.ToInt32(dt.Rows[0]["DepartmentID"]),
                    AuthorizationLevel = dt.Rows[0]["AuthorizationLevel"].ToString()
                };
            }
        }

    }

    //驗證帳號是否存在
    public static bool CheckUserName(string userName)
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "select UserName from Employee where UserName=@username",
            Common.DBConnectionString);

        da.SelectCommand.Parameters.AddWithValue("@username", userName);

        DataTable dt = new DataTable();
        da.Fill(dt);
        //如果有取得，就會有一筆資料
        return dt.Rows.Count == 1;
    }

    //輸出用
    public static List<YenEmployee> PrintEmployees()
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "select EmployeeID, LastName, FirstName, DepartmentName, AuthorizationLevel, HiredDate, Salary, Gender, BirthDate from Employee", Common.DBConnectionString);

        DataTable dt = new DataTable();

        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new YenEmployee()
                    {
                        EmployeeID = Convert.ToInt32(row["EmployeeID"]),
                        LastName = row["LastName"].ToString(),
                        FirstName = row["FirstName"].ToString(),
                        DepartmentName = row["DepartmentName"].ToString(),
                        AuthorizationLevel = row["AuthorizationLevel"].ToString(),
                        HiredDate = Convert.ToDateTime(row["HiredDate"]).ToShortDateString(),
                        Salary = Convert.ToInt32(row["Salary"]),
                        ServiceYear = Math.Round((decimal)new TimeSpan(DateTime.Now.Ticks - Convert.ToDateTime(row["HiredDate"]).Ticks).Days / 365, 1).ToString(),
                        Gender = row["Gender"].ToString(),
                        Age = row["BirthDate"] is DBNull ? "" : Math.Round((decimal)new TimeSpan(DateTime.Now.Ticks - Convert.ToDateTime(row["BirthDate"]).Ticks).Days / 365, 0).ToString()
                    };
        return query.ToList();
        //計算年資
        //int d = new TimeSpan(DateTime.Now.Ticks - DateTime(hiredate).Ticks).Days;
        //decimal pd = (decimal)d / 365;
        //Label3.Text = Math.Round(pd,1).ToString();

    }

    //輸出用(含離職員工)
    public static List<YenEmployee> PrintAllEmployees()
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "select EmployeeID, LastName, FirstName, DepartmentName, AuthorizationLevel, HiredDate,ResignedDate, Salary, Gender, BirthDate from Employee", Common.DBConnectionString);

        DataTable dt = new DataTable();

        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new YenEmployee()
                    {
                        EmployeeID = Convert.ToInt32(row["EmployeeID"]),
                        LastName = row["LastName"].ToString(),
                        FirstName = row["FirstName"].ToString(),
                        DepartmentName = row["DepartmentName"].ToString(),
                        AuthorizationLevel = row["AuthorizationLevel"].ToString(),
                        HiredDate = Convert.ToDateTime(row["HiredDate"]).ToShortDateString(),
                        ResignedDate = row["ResignedDate"] is DBNull ? "" : Convert.ToDateTime(row["ResignedDate"]).ToShortDateString(),
                        Salary = Convert.ToInt32(row["Salary"]),
                        ServiceYear = Math.Round((decimal)new TimeSpan(DateTime.Now.Ticks - Convert.ToDateTime(row["HiredDate"]).Ticks).Days / 365, 1).ToString(),
                        Gender = row["Gender"].ToString(),
                        Age = row["BirthDate"] is DBNull ? "" : Math.Round((decimal)new TimeSpan(DateTime.Now.Ticks - Convert.ToDateTime(row["BirthDate"]).Ticks).Days / 365, 0).ToString()
                    };
        return query.ToList();
        //計算年資
        //int d = new TimeSpan(DateTime.Now.Ticks - DateTime(hiredate).Ticks).Days;
        //decimal pd = (decimal)d / 365;
        //Label3.Text = Math.Round(pd,1).ToString();

    }

    //取回員工頭貼檔名
    public static string GetImageFileName(int id)
    {
        YenEmployee emp = GetEmployeeByID(id);
        return emp.ImageFileName;
    }
}
