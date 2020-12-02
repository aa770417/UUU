using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// KnowledgeUtilty 的摘要描述
/// </summary>
public class KnowledgeUtilty
{
    //新增Knowledge資料表中資料的方法，用於KnowledgeInfoManage.aspx的新增按鈕
    public static void InsertKnowledgeInfo(Knowledge k)
    {
        using (SqlConnection cn = new SqlConnection(DarrenCommon.DBConnectionString))
        {
            SqlCommand K_Cmd = new SqlCommand
                ("Insert into Knowledge(K_Course,K_Category,K_Institution,K_Location,K_Price,K_Hour,K_Date,K_Contact,K_Phone,K_ImgInfo,K_DetailInfo)values(@K_Course,@K_Category,@K_Institution,@K_Location,@K_Price,@K_Hour,@K_Date,@K_Contact,@K_Phone,@K_ImgInfo,@K_DetailInfo)", cn);
            K_Cmd.Parameters.AddWithValue("@K_Course", k.K_Course);
            K_Cmd.Parameters.AddWithValue("@K_Category", k.K_Category);
            K_Cmd.Parameters.AddWithValue("@K_Institution", k.K_Institution);
            K_Cmd.Parameters.AddWithValue("@K_Location", k.K_Location);
            K_Cmd.Parameters.AddWithValue("@K_Price", k.K_Price);
            K_Cmd.Parameters.AddWithValue("@K_Hour", k.K_Hour);
            K_Cmd.Parameters.AddWithValue("@K_Date", k.K_Date);
            K_Cmd.Parameters.AddWithValue("@K_Contact", k.K_Contact);
            K_Cmd.Parameters.AddWithValue("@K_Phone", k.K_Phone);
            K_Cmd.Parameters.AddWithValue("@K_ImgInfo", k.K_ImgInfo);
            K_Cmd.Parameters.AddWithValue("@K_DetailInfo", k.K_DetailInfo);
            cn.Open();
            K_Cmd.ExecuteNonQuery();
        }
    }

    //刪除Knowledge資料表中資料的方法，用於KnowledgeInfoManage.aspx頁面的刪除欄位的刪除按鈕
    public static void DeleteKnowledgeInfo(int K_ID)
    {
        using (SqlConnection cn = new SqlConnection(DarrenCommon.DBConnectionString))
        {
            SqlCommand K_Cmd = new SqlCommand("delete Knowledge where K_ID=@K_ID", cn);
            K_Cmd.Parameters.AddWithValue("@K_ID", K_ID);
            cn.Open();
            K_Cmd.ExecuteNonQuery();
        }
    }
    //更新Knowledge資料表中資料的方法，用於KnowledgeInfoUpdate.aspx頁面
    public static void UpdateKnowledgeInfo(Knowledge k)
    {
        using (SqlConnection cn = new SqlConnection(DarrenCommon.DBConnectionString))
        {
            SqlCommand K_Cmd = new SqlCommand("Update Knowledge set K_Course=@K_Course,K_Category=@K_Category,K_Institution=@K_Institution,K_Location=@K_Location,K_Price=@K_Price,K_Hour=@K_Hour,K_Date=@K_Date,K_Contact=@K_Contact,K_Phone=@K_Phone,K_ImgInfo=@K_ImgInfo,K_DetailInfo=@K_DetailInfo where K_ID=@K_ID", cn);
            K_Cmd.Parameters.AddWithValue("@K_ID", k.K_ID);
            K_Cmd.Parameters.AddWithValue("@K_Course", k.K_Course);
            K_Cmd.Parameters.AddWithValue("@K_Category", k.K_Category);
            K_Cmd.Parameters.AddWithValue("@K_Institution", k.K_Institution);
            K_Cmd.Parameters.AddWithValue("@K_Location", k.K_Location);
            K_Cmd.Parameters.AddWithValue("@K_Price", k.K_Price);
            K_Cmd.Parameters.AddWithValue("@K_Hour", k.K_Hour);
            K_Cmd.Parameters.AddWithValue("@K_Date", k.K_Date);
            K_Cmd.Parameters.AddWithValue("@K_Contact", k.K_Contact);
            K_Cmd.Parameters.AddWithValue("@K_Phone", k.K_Phone);
            K_Cmd.Parameters.AddWithValue("@K_ImgInfo", k.K_ImgInfo);
            K_Cmd.Parameters.AddWithValue("@K_DetailInfo", k.K_DetailInfo);
            cn.Open();
            K_Cmd.ExecuteNonQuery();
        }
    }
    //顯示課程資訊的方法，用於KnowledgeInfoDetail.aspx頁面
    public static List<Knowledge> DisPlayKnowledgeInfoByK_ID(int K_ID)
    {
        {
            SqlDataAdapter da = new SqlDataAdapter("select*from Knowledge where K_ID=@K_ID", DarrenCommon.DBConnectionString);
            da.SelectCommand.Parameters.AddWithValue("@K_ID", K_ID);
            DataTable dt = new DataTable();
            da.Fill(dt);

            var k_List = from row in dt.AsEnumerable()//轉型成可以被列舉的物件
                         select new Knowledge()
                         {
                             K_ID = Convert.ToInt32(row["K_ID"]),
                             K_Course = row["K_Course"].ToString(),
                             K_Category = row["K_Category"].ToString(),
                             K_Institution = row["K_Institution"].ToString(),
                             K_Location = row["K_Location"].ToString(),
                             K_Price = Convert.ToInt32(row["K_Price"]),
                             K_Hour = Convert.ToInt32(row["K_Hour"]),
                             K_Date = row["K_Date"].ToString(),
                             K_Contact = row["K_Contact"].ToString(),
                             K_Phone = row["K_Phone"].ToString(),
                             K_ImgInfo = row["K_ImgInfo"].ToString(),
                             K_DetailInfo = row["K_DetailInfo"].ToString()
                         };
            return k_List.ToList();

        }
    }
    //顯示全部課程資訊的方法，用於KnowledgeInfoOverview.aspx頁面
    public static List<Knowledge> GetAllKnowledgeInfo()
    {
        {
            SqlDataAdapter da = new SqlDataAdapter("select*from Knowledge", DarrenCommon.DBConnectionString);
            DataTable dt = new DataTable();

            da.Fill(dt);

            var k_List = from row in dt.AsEnumerable()//轉型成可以被列舉的物件
                         select new Knowledge()
                         {
                             K_ID = Convert.ToInt32(row["K_ID"]),
                             K_Course = row["K_Course"].ToString(),
                             K_Category = row["K_Category"].ToString(),
                             K_Institution = row["K_Institution"].ToString(),
                             K_Location = row["K_Location"].ToString(),
                             K_Price = Convert.ToInt32(row["K_Price"]),
                             K_Hour = Convert.ToInt32(row["K_Hour"]),
                             K_Date = row["K_Date"].ToString(),
                             K_Contact = row["K_Contact"].ToString(),
                             K_Phone = row["K_Phone"].ToString(),
                             K_ImgInfo = row["K_ImgInfo"].ToString(),
                             K_DetailInfo = row["K_DetailInfo"].ToString()
                         };
            return k_List.ToList();
        }
    }
    //顯示資訊類課程資訊的方法，用於KnowledgeInfoOverview.aspx頁面的資訊類課程頁籤
    public static List<Knowledge> GetKnowledgeInfoForIT()
    {
        {
            SqlDataAdapter da = new SqlDataAdapter("select*from Knowledge where K_Category='資訊科技'", DarrenCommon.DBConnectionString);
            DataTable dt = new DataTable();

            da.Fill(dt);

            var k_List = from row in dt.AsEnumerable()//轉型成可以被列舉的物件
                         select new Knowledge()
                         {
                             K_ID = Convert.ToInt32(row["K_ID"]),
                             K_Course = row["K_Course"].ToString(),
                             K_Category = row["K_Category"].ToString(),
                             K_Institution = row["K_Institution"].ToString(),
                             K_Location = row["K_Location"].ToString(),
                             K_Price = Convert.ToInt32(row["K_Price"]),
                             K_Hour = Convert.ToInt32(row["K_Hour"]),
                             K_Date = row["K_Date"].ToString(),
                             K_Contact = row["K_Contact"].ToString(),
                             K_Phone = row["K_Phone"].ToString(),
                             K_ImgInfo = row["K_ImgInfo"].ToString(),
                             K_DetailInfo = row["K_DetailInfo"].ToString()
                         };
            return k_List.ToList();
        }
    }
    //顯示運動休閒類課程資訊的方法，用於KnowledgeInfoOverview.aspx頁面的運動休閒類課程頁籤
    public static List<Knowledge> GetKnowledgeInfoForSL()
    {
        {
            SqlDataAdapter da = new SqlDataAdapter("select*from Knowledge where K_Category='運動休閒'", DarrenCommon.DBConnectionString);
            DataTable dt = new DataTable();

            da.Fill(dt);

            var k_List = from row in dt.AsEnumerable()//轉型成可以被列舉的物件
                         select new Knowledge()
                         {
                             K_ID = Convert.ToInt32(row["K_ID"]),
                             K_Course = row["K_Course"].ToString(),
                             K_Category = row["K_Category"].ToString(),
                             K_Institution = row["K_Institution"].ToString(),
                             K_Location = row["K_Location"].ToString(),
                             K_Price = Convert.ToInt32(row["K_Price"]),
                             K_Hour = Convert.ToInt32(row["K_Hour"]),
                             K_Date = row["K_Date"].ToString(),
                             K_Contact = row["K_Contact"].ToString(),
                             K_Phone = row["K_Phone"].ToString(),
                             K_ImgInfo = row["K_ImgInfo"].ToString(),
                             K_DetailInfo = row["K_DetailInfo"].ToString()
                         };
            return k_List.ToList();
        }
    }
    //顯示語言學習類課程資訊的方法，用於KnowledgeInfoOverview.aspx頁面的語言學習類課程頁籤
    public static List<Knowledge> GetKnowledgeInfoForLL()
    {
        {
            SqlDataAdapter da = new SqlDataAdapter("select*from Knowledge where K_Category='語言學習'", DarrenCommon.DBConnectionString);
            DataTable dt = new DataTable();

            da.Fill(dt);

            var k_List = from row in dt.AsEnumerable()//轉型成可以被列舉的物件
                         select new Knowledge()
                         {
                             K_ID = Convert.ToInt32(row["K_ID"]),
                             K_Course = row["K_Course"].ToString(),
                             K_Category = row["K_Category"].ToString(),
                             K_Institution = row["K_Institution"].ToString(),
                             K_Location = row["K_Location"].ToString(),
                             K_Price = Convert.ToInt32(row["K_Price"]),
                             K_Hour = Convert.ToInt32(row["K_Hour"]),
                             K_Date = row["K_Date"].ToString(),
                             K_Contact = row["K_Contact"].ToString(),
                             K_Phone = row["K_Phone"].ToString(),
                             K_ImgInfo = row["K_ImgInfo"].ToString(),
                             K_DetailInfo = row["K_DetailInfo"].ToString()
                         };
            return k_List.ToList();
        }
    }

}
