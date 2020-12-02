using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Product 的摘要描述
/// </summary>
public class Order
{
    public static DataTable FindOrder()
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["NW"].ConnectionString);
        SqlDataAdapter da = new SqlDataAdapter("Select [OrderId],[Client],[OrderDate],[OrderNumber],[OrderSort],[OrderAmount],[OrderIn],[OrderOut],[Country],[Position] From [Order]", cn);
        DataSet ds = new DataSet();
        da.Fill(ds, "Orders");
        return ds.Tables["Orders"];
    }
    public static DataTable FindOrderK()
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["NW"].ConnectionString);
        SqlDataAdapter da = new SqlDataAdapter("Select [OrderId],[Client],[OrderDate],[OrderNumber],[OrderSort],[OrderAmount],[OrderIn],[OrderOut],[Country],[Position] From [Order] Where [Position] like '基隆港'", cn);
        DataSet ds = new DataSet();
        da.Fill(ds, "Orders");
        return ds.Tables["Orders"];
    }

    public static DataTable FindOrderG()
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["NW"].ConnectionString);
        SqlDataAdapter da = new SqlDataAdapter("Select [OrderId],[Client],[OrderDate],[OrderNumber],[OrderSort],[OrderAmount],[OrderIn],[OrderOut],[Country],[Position] From [Order] Where [Position] like '觀音倉'", cn);
        DataSet ds = new DataSet();
        da.Fill(ds, "Orders");
        return ds.Tables["Orders"];
    }

    public static DataTable FindOrder(string g)
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["NW"].ConnectionString);
        SqlDataAdapter da = new SqlDataAdapter("Select * From [Order] Where [OrderNumber] Like @OrderNumber or [Client] Like @Client or [Country] like @Country or [Position] like @Position", cn);
        da.SelectCommand.Parameters.AddWithValue("@OrderNumber", "%" + g + "%");
        da.SelectCommand.Parameters.AddWithValue("@Client", "%" + g + "%");
        da.SelectCommand.Parameters.AddWithValue("@Country", "%" + g + "%");
        da.SelectCommand.Parameters.AddWithValue("@Position", "%" + g + "%");
        DataSet ds = new DataSet();
        da.Fill(ds, "Orders");

        return ds.Tables["Orders"];
    }

    public static List<OrderProducts> GetFindOrder(string g)
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["NW"].ConnectionString);
        SqlDataAdapter da = new SqlDataAdapter("Select * From [Order] Where [OrderNumber] Like @OrderNumber or [Client] Like @Client or [Country] like @Country or [Position] like @Position", cn);
        da.SelectCommand.Parameters.AddWithValue("@OrderNumber", "%" + g + "%");
        da.SelectCommand.Parameters.AddWithValue("@Client", "%" + g + "%");
        da.SelectCommand.Parameters.AddWithValue("@Country", "%" + g + "%");
        da.SelectCommand.Parameters.AddWithValue("@Position", "%" + g + "%");
        DataTable dt = new DataTable();

        da.Fill(dt);

        if (dt.Rows.Count == 0)
        {
            return null;
        }
        else
        {
            var query = from row in dt.AsEnumerable()
                        select new OrderProducts()
                        {
                            OrderId = Convert.ToInt32(dt.Rows[0]["OrderId"]),
                            Client = dt.Rows[0]["Client"].ToString(),
                            OrderDate = ((DateTime)dt.Rows[0]["OrderDate"]).ToShortDateString(),
                            OrderNumber = dt.Rows[0]["OrderNumber"].ToString(),
                            OrderSort = dt.Rows[0]["OrderSort"].ToString(),
                            OrderAmount = Convert.ToInt32(dt.Rows[0]["OrderAmount"]),
                            OrderIn = Convert.ToDateTime(dt.Rows[0]["OrderIn"]).ToShortDateString(),
                            OrderOut = Convert.ToDateTime(dt.Rows[0]["OrderOut"]).ToShortDateString(),
                            Country = dt.Rows[0]["Country"].ToString(),
                            Position = dt.Rows[0]["Position"].ToString()
                        };
            return query.ToList();
        }

    }

    public static void AddOrder(OrderProducts p)
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["NW"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Insert Into [Order] ([Client],[OrderDate],[OrderNumber],[OrderSort],[OrderAmount],[OrderIn],[OrderOut],[Country],[Position]) Values (@Client,@OrderDate,@OrderNumber,@OrderSort,@OrderAmount,@OrderIn,@OrderOut,@Country,@Position)", cn);
        cmd.Parameters.AddWithValue("@Client", p.Client);
        cmd.Parameters.AddWithValue("@OrderDate", p.OrderDate);
        cmd.Parameters.AddWithValue("@OrderNumber", p.OrderNumber);
        cmd.Parameters.AddWithValue("@OrderSort", p.OrderSort);
        cmd.Parameters.AddWithValue("@OrderAmount", p.OrderAmount);
        cmd.Parameters.AddWithValue("@OrderIn", p.OrderIn);
        cmd.Parameters.AddWithValue("@OrderOut", p.OrderOut);
        cmd.Parameters.AddWithValue("@Country", p.Country);
        cmd.Parameters.AddWithValue("@Position", p.Position);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void EditOrder(OrderProduct p)
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["NW"].ConnectionString);
        SqlCommand cmd = new SqlCommand("UPDATE [Order] set [Client] = @Client,[OrderDate] = @OrderDate,[OrderNumber] = @OrderNumber,[OrderSort] = @OrderSort,[OrderAmount] = @OrderAmount,[OrderIn] = @OrderIn,[OrderOut] = @OrderOut,[Country] = @Country,[Position] = @Position WHERE [OrderId] = @OrderId", cn);
        cmd.Parameters.AddWithValue("@OrderId", p.OrderId);
        cmd.Parameters.AddWithValue("@Client", p.Client);
        cmd.Parameters.AddWithValue("@OrderDate", p.OrderDate);
        cmd.Parameters.AddWithValue("@OrderNumber", p.OrderNumber);
        cmd.Parameters.AddWithValue("@OrderSort", p.OrderSort);
        cmd.Parameters.AddWithValue("@OrderAmount", p.OrderAmount);
        cmd.Parameters.AddWithValue("@OrderIn", p.OrderIn);
        cmd.Parameters.AddWithValue("@OrderOut", p.OrderOut);
        cmd.Parameters.AddWithValue("@Country", p.Country);
        cmd.Parameters.AddWithValue("@Position", p.Position);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    public static void TurnOrder(int t)
    {
        OrderProducts p = GetOrder(t);
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["NW"].ConnectionString);
        SqlCommand cmd = new SqlCommand("UPDATE [Order] set [Position] = @Position WHERE [OrderId] = @OrderId", cn);
        cmd.Parameters.AddWithValue("@OrderId", p.OrderId);
        if (p.Position == "基隆港")
        {cmd.Parameters.AddWithValue("@Position", "觀音倉");}
        else
        {cmd.Parameters.AddWithValue("@Position", "基隆港");}
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }

    //public static void TurnK(int t)
    //{
    //    SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["NW"].ConnectionString);
    //    SqlCommand cmd = new SqlCommand("UPDATE [Order] set [Position] = '基隆港' WHERE [OrderId] = @OrderId", cn);
    //    cmd.Parameters.AddWithValue("@OrderId", t);
    //    cn.Open();
    //    cmd.ExecuteNonQuery();
    //    cn.Close();
    //}

    public static OrderProducts GetOrder(int OrderId)
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["NW"].ConnectionString);
        SqlDataAdapter da = new SqlDataAdapter("select * from [Order] where OrderId=@OrderId", cn);
        da.SelectCommand.Parameters.AddWithValue("@OrderId", OrderId);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            return null;
        }
        else
        {
            return new OrderProducts()
            {
                OrderId = Convert.ToInt32(dt.Rows[0]["OrderId"]),
                Client = dt.Rows[0]["Client"].ToString(),
                OrderDate = Convert.ToDateTime(dt.Rows[0]["OrderDate"]).ToShortDateString(),
                OrderNumber = dt.Rows[0]["OrderNumber"].ToString(),
                OrderSort = dt.Rows[0]["OrderSort"].ToString(),
                OrderAmount = Convert.ToInt32(dt.Rows[0]["OrderAmount"]),
                OrderIn = Convert.ToDateTime(dt.Rows[0]["OrderIn"]).ToShortDateString(),
                OrderOut = Convert.ToDateTime(dt.Rows[0]["OrderOut"]).ToShortDateString(),
                Country = dt.Rows[0]["Country"].ToString(),
                Position = dt.Rows[0]["Position"].ToString()
            };
        }
    }

    public static void DeleteOrder(int OrderId)
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["NW"].ConnectionString);
        SqlCommand da = new SqlCommand("delete [Order] where OrderId=@OrderId", cn);

        da.Parameters.AddWithValue("@OrderId", OrderId);

        cn.Open();
        da.ExecuteNonQuery();
        cn.Close();
    }

}