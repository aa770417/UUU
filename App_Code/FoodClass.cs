using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// FoodClass 的摘要描述
/// </summary>
public class FoodClass
{

    public static DataTable FindFood()
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        SqlDataAdapter da = new SqlDataAdapter("Select [FID],[FName],[FPrice],[FCategory],[FImg] From [Food]", cn);
        DataSet ds = new DataSet();
        da.Fill(ds, "Foods");
        return ds.Tables["Foods"];
    }

    public static DataTable FoodOrderFind()
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        SqlDataAdapter da = new SqlDataAdapter("Select [FID],[FName],[FPrice],[FAmount],[FTotal],[FImg] From [FoodOrders]", cn);
        DataSet ds = new DataSet();
        da.Fill(ds, "Foods");
        return ds.Tables["Foods"];
    }

    public static void FoodOrder(int f, int a, int t)
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("UPDATE [FoodOrder] set [FAmount] = @FAmount, [FTotal] = @FTotal WHERE [FID] = @FID", cn);
        cmd.Parameters.AddWithValue("@FID", f);
        cmd.Parameters.AddWithValue("@FAmount", a);
        cmd.Parameters.AddWithValue("@FTotal", t);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static void FoodOrderUP(string n, int a, int t)
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("UPDATE [FoodOrders] set [FAmount] = @FAmount, [FTotal] = @FTotal WHERE [FName] = @FName", cn);
        cmd.Parameters.AddWithValue("@FName", n);
        cmd.Parameters.AddWithValue("@FAmount", a);
        cmd.Parameters.AddWithValue("@FTotal", t);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static List<FoodOrders> GetFood(string id)
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        SqlDataAdapter da = new SqlDataAdapter($"SELECT [FID],[FName],[FPrice],[FAmount],[FTotal],[FImg] FROM [FoodOrder] where [FID] in ({id})", cn);
        //da.SelectCommand.Parameters.AddWithValue("@FID", id);
        DataTable dt = new DataTable();
        da.Fill(dt);
        var query = from row in dt.AsEnumerable()
                    select new FoodOrders()
                    {
                        FID = Convert.ToInt32(row["FID"]),
                        FName = row["FName"].ToString(),
                        FPrice = Convert.ToInt32(row["FPrice"]),
                        FAmount = Convert.ToInt32(row["FAmount"]),
                        FTotal = Convert.ToInt32(row["FTotal"]),
                        FImg = row["FImg"].ToString()
                    };
        return query.ToList();
    }
    public static List<FoodOrders> GetFoodOrder()
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        SqlDataAdapter da = new SqlDataAdapter("SELECT [FID],[FName],[FPrice],[FAmount],[FTotal],[FImg] FROM [FoodOrders]", cn);
        DataTable dt = new DataTable();
        da.Fill(dt);
        var query = from row in dt.AsEnumerable()
                    select new FoodOrders()
                    {
                        FID = Convert.ToInt32(row["FID"]),
                        FName = row["FName"].ToString(),
                        FPrice = Convert.ToInt32(row["FPrice"]),
                        FAmount = Convert.ToInt32(row["FAmount"]),
                        FTotal = Convert.ToInt32(row["FTotal"]),
                        FImg = row["FImg"].ToString()
                    };
        return query.ToList();
    }
    public static void FoodEdit(FoodOrders f)
    {
        try
        {
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            SqlCommand cmd = new SqlCommand(@"UPDATE [FoodOrder] 
                                           SET [FName] = @FName,
                                               [FAmount] = @FAmount,
                                               [FPrice] = @FPrice,
                                               [FTotal] = @FTotal ,
                                               [FImg] = @FImg
                                           WHERE [FID] = @FID", cn);
            cmd.Parameters.AddWithValue("@FID", f.FID);
            cmd.Parameters.AddWithValue("@FName", f.FName);
            cmd.Parameters.AddWithValue("@FAmount", f.FAmount);
            cmd.Parameters.AddWithValue("@FPrice", f.FPrice);
            cmd.Parameters.AddWithValue("@FTotal", f.FTotal);
            cmd.Parameters.AddWithValue("@FImg", f.FImg);
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
        }
        catch (Exception ex)
        {
            System.Console.WriteLine(ex.Message);
        }
    }

    public static FoodOrders GetFoodEdit(int id)
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        SqlDataAdapter da = new SqlDataAdapter("SELECT [FID],[FName],[FPrice],[FAmount],[FTotal],[FImg] FROM [FoodOrders] where [FID]=@FID", cn);
        da.SelectCommand.Parameters.AddWithValue("@FID", id);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            return null;
        }
        else
        {
            return new FoodOrders()
            {
                FID = Convert.ToInt32(dt.Rows[0]["FID"]),
                FName = dt.Rows[0]["FName"].ToString(),
                FPrice = Convert.ToInt32(dt.Rows[0]["FPrice"]),
                FAmount = Convert.ToInt32(dt.Rows[0]["FAmount"]),
                FTotal = Convert.ToInt32(dt.Rows[0]["FTotal"]),
                FImg = dt.Rows[0]["FImg"].ToString()
            };
        }
    }

    public static void FoodOrderAdd(FoodOrders f)
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Insert Into [FoodOrders] ([FName],[FPrice],[FAmount],[FTotal],[FImg]) Values (@FName,@FPrice,@FAmount,@FTotal,@FImg)", cn);
        cmd.Parameters.AddWithValue("@FName", f.FName);
        cmd.Parameters.AddWithValue("@FPrice", f.FPrice);
        cmd.Parameters.AddWithValue("@FAmount", f.FAmount);
        cmd.Parameters.AddWithValue("@FTotal", f.FTotal);
        cmd.Parameters.AddWithValue("@FImg", f.FImg);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static void FoodOrderAdds(FoodOrders f)
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand(
        @"if not exists(select 1 from[FoodOrders] where[FName] = @FName)
        insert into[FoodOrders]([FID],[FName],[FPrice],[FAmount],[FTotal],[FImg]) VALUES(@FID,@FName,@FPrice,@FAmount,@FTotal,@FImg)
        else
        update[FoodOrders] set [FAmount] = @FAmount, [FTotal] = @FTotal,[FImg] = @FImg WHERE [FID] = @FID", cn);

        cmd.Parameters.AddWithValue("@FID", f.FID);
        cmd.Parameters.AddWithValue("@FName", f.FName);
        cmd.Parameters.AddWithValue("@FPrice", f.FPrice);
        cmd.Parameters.AddWithValue("@FAmount", f.FAmount);
        cmd.Parameters.AddWithValue("@FTotal", f.FTotal);
        cmd.Parameters.AddWithValue("@FImg", f.FImg);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

public static void DeleteFood(int FID)
{
    SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
    SqlCommand da = new SqlCommand("delete [FoodOrders] where FID=@FID", cn);

    da.Parameters.AddWithValue("@FID", FID);

    cn.Open();
    da.ExecuteNonQuery();
    cn.Close();
}

}