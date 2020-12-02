using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for EmpUtility
/// </summary>
public class EmpUtility
{
    public EmpUtility()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    //取得全部員工(含離職)
    public static List<TomEmployee> GetAllEmployees()
    {
        SqlDataAdapter da = new SqlDataAdapter(
            "select * from Employee", TomCommon.DBConnect);

        DataTable dt = new DataTable();

        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new TomEmployee()
                    {
                        EmployeeID = Convert.ToInt32(row["EmployeeID"]),
                        Password = row["Password"].ToString(),
                        LastName = row["LastName"].ToString(),
                        FirstName = row["FirstName"].ToString(),
                        Gender = row["Gender"].ToString(),
                        DepartmentID = Convert.ToInt32(dt.Rows[0]["DepartmentID"]),
                        DepartmentName = row["DepartmentName"].ToString(),
                        AuthorizationLevel = row["AuthorizationLevel"].ToString(),
                        Salary = Convert.ToInt32(row["Salary"]),

                    };
        return query.ToList();
    }
    public static bool CheckEmp(string userName, string passWord)
    {
        using (SqlConnection cn = new SqlConnection(TomCommon.DBConnect))
        {
            SqlDataAdapter da = new SqlDataAdapter(
                  "select * from Employee where UserName=@userName and Password=@passWord", cn);
            da.SelectCommand.Parameters.AddWithValue("@userName", userName);
            da.SelectCommand.Parameters.AddWithValue("@passWord", passWord);

            DataTable dt = new DataTable();
            da.Fill(dt);
            //若搜尋到一筆資料代表有此人 通過驗證
            return dt.Rows.Count == 1;
        }
    }

    //登入後 透過username找到相關權限相關資訊
    public static List<TomEmployee> EmpInfo(string userName)
    {
        using (SqlConnection cn = new SqlConnection(TomCommon.DBConnect))
        {
            SqlDataAdapter da = new SqlDataAdapter(
                     "select FirstName,LastName,DepartmentID,DepartmentName,AuthorizationLevel from Employee where UserName=@userName", cn);
            da.SelectCommand.Parameters.AddWithValue("@userName", userName);
            DataTable dt = new DataTable();
            da.Fill(dt);
            var query = from row in dt.AsEnumerable()
                        select new TomEmployee()
                        {
                            LastName = row["LastName"].ToString(),
                            FirstName = row["FirstName"].ToString(),
                            DepartmentID = Convert.ToInt32(dt.Rows[0]["DepartmentID"]),
                            DepartmentName = row["DepartmentName"].ToString(),
                            AuthorizationLevel = row["AuthorizationLevel"].ToString(),
                        };
            return query.ToList();

        }
    }

}



