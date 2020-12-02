using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;



/// <summary>
/// Summary description for CustomUtility
/// </summary>
public class TomCustomUtility
{
    //將id 轉成員工姓名
    public static string getEName(int EID)
    {
        Dictionary<int, string> EmpName = new Dictionary<int, string>();
        List<TomEmployee> emp = new List<TomEmployee>();
        emp = EmpUtility.GetAllEmployees();
        // 組出需要的id/姓名 字典，讓後面可以做查詢
        foreach (var item in emp)
        {
            EmpName.Add(item.EmployeeID, item.LastName + item.FirstName);
        }
        //參數丟進來 在字典內查詢回傳
        string Name = EmpName[EID];
        return Name;
    }
    //將姓名轉為員工id
    public static int getEID(string name)
    {
        Dictionary<string, int> Empid = new Dictionary<string, int>();
        List<TomEmployee> emp = new List<TomEmployee>();
        emp = EmpUtility.GetAllEmployees();
        foreach (var item in emp)
        {
            Empid.Add(item.LastName + item.FirstName, item.EmployeeID);
        }
        int eid = Empid[name];
        return eid;
    }

    public TomCustomUtility()
    {

    }
    //拿資料
    public static List<TomCustomer> FindAllCustomer()
    {
        SqlConnection cn = new SqlConnection(TomCommon.DBConnect);
        SqlDataAdapter da = new SqlDataAdapter("Select CID, CName, Country, CompanyName,EID,Phone,CImg,Gender,Email,Remark2 From Customer", cn);
        DataTable dt = new DataTable();
        da.Fill(dt);

        var query = from row in dt.AsEnumerable()
                    select new TomCustomer()
                    {
                        CID = Convert.ToInt32(row["CID"]),
                        CName = row["CName"].ToString(),
                        Country = row["Country"].ToString(),
                        CompanyName = row["CompanyName"].ToString(),
                        EID = Convert.ToInt32(row["EID"]),
                        Phone = row["Phone"].ToString(),
                        CImg = row["CImg"] is DBNull ? "" : row["CImg"].ToString(),
                        Gender = row["Gender"].ToString(),
                        Email = row["Email"] is DBNull ? "" : row["Email"].ToString(),
                        Birthday = row["Remark2"] is DBNull ? "" : row["Remark2"].ToString(),

                    };

        return query.ToList();
    }
    //新增
    public static void AddProduct(TomCustomer c)
    {
        using (SqlConnection cn = new SqlConnection(TomCommon.DBConnect))
        {
            SqlCommand cmd = new SqlCommand(
                "insert into Customer(CName , Country,CompanyName , EID , Phone,CImg,Gender,Email,Remark2) values(@CName , @Country ,@CompanyName, @EID , @Phone,@CImg,@Gender,@Email,@Birthday)",
                cn);

            cmd.Parameters.AddWithValue("@CName", c.CName);
            cmd.Parameters.AddWithValue("@Country", c.Country);
            cmd.Parameters.AddWithValue("@CompanyName", c.CompanyName);
            cmd.Parameters.AddWithValue("@EID", c.EID);
            cmd.Parameters.AddWithValue("@Phone", c.Phone);
            //判斷是否是空值來上傳
            if (c.CImg is null)
            {
              cmd.Parameters.AddWithValue("@CImg", DBNull.Value);
            }else cmd.Parameters.AddWithValue("@CImg", c.CImg);

            cmd.Parameters.AddWithValue("@Gender", c.Gender);
            cmd.Parameters.AddWithValue("@Email", c.Email);
            cmd.Parameters.AddWithValue("@Birthday", c.Birthday);

            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    //編輯
    public static void UpdateCustomer(TomCustomer c)
    {
        SqlConnection cn = new SqlConnection(TomCommon.DBConnect);
        SqlCommand cmd = new SqlCommand(
            "UPDATE Customer SET  [CName] = @CName, [Country] = @Country, [CompanyName] = @CompanyName,[EID]=@EID,[Phone]=@Phone,[CImg]=@CImg,[Gender]=@Gender,[Email]=@Email,[Remark2]=@Birthday WHERE[CID] = @CID",
                cn);

        cmd.Parameters.AddWithValue("@CID", c.CID);
        cmd.Parameters.AddWithValue("@CName", c.CName);
        cmd.Parameters.AddWithValue("@Country", c.Country);
        cmd.Parameters.AddWithValue("@CompanyName", c.CompanyName);
        cmd.Parameters.AddWithValue("@EID", c.EID);
        cmd.Parameters.AddWithValue("@Phone", c.Phone);
        cmd.Parameters.AddWithValue("@CImg", c.CImg);
        cmd.Parameters.AddWithValue("@Gender", c.Gender);
        cmd.Parameters.AddWithValue("@Email", c.Email);
        cmd.Parameters.AddWithValue("@Birthday", c.Birthday);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();

    }
    //用id拿單一資料
    public static TomCustomer GetCustomer(int CID)
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["NW"].ConnectionString);
        SqlDataAdapter da = new SqlDataAdapter("select * from [Customer] where CID=@CID", cn);

        da.SelectCommand.Parameters.AddWithValue("@CID", CID);

        DataTable dt = new DataTable();

        da.Fill(dt);

        if (dt.Rows.Count == 0)
        {
            return null;
        }
        else
        {
            return new TomCustomer()
            {
                CID = Convert.ToInt32(dt.Rows[0]["CID"]),
                CName = dt.Rows[0]["CName"].ToString(),
                Country = dt.Rows[0]["Country"].ToString(),
                CompanyName = dt.Rows[0]["CompanyName"].ToString(),
                EID = Convert.ToInt32(dt.Rows[0]["EID"]),
                Phone = dt.Rows[0]["Phone"].ToString(),
                Gender = dt.Rows[0]["Gender"].ToString(),
                Email = dt.Rows[0]["Email"].ToString(),
                Birthday = dt.Rows[0]["Remark2"].ToString(),
                CImg = dt.Rows[0]["CImg"].ToString(),

            };
        }
    }
    public static void DeleteCustomer(int id)
    {
        using (SqlConnection cn = new SqlConnection(TomCommon.DBConnect))
        {
            SqlCommand cmd = new SqlCommand(
                "delete Customer WHERE[CID] = @CID",
                cn);

            cmd.Parameters.AddWithValue("@CID", id);

            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }


}


