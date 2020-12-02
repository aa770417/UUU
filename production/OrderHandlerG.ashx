<%@ WebHandler Language="C#" Class="OrderHandler" %>

using System;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Script.Serialization;


public class OrderHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.Charset = "utf-8";
        //取得所有 GetOrderAmount 的總和
        var amount = GetOrderAmount();
        context.Response.Write(new JavaScriptSerializer().Serialize(amount));
    }


    private int GetOrderAmount()
    {
        int dAmount = 0;
        string TSQL = @"Select [OrderAmount] From [Order] Where [Position] like '觀音倉'";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["NW"].ConnectionString))
        {
            SqlCommand command = new SqlCommand(TSQL, cn);
            try
            {
                cn.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    dAmount += (int)reader["OrderAmount"];
                }
                reader.Close();
                cn.Close();
                cn.Dispose();
            }
            catch (System.Exception ex)
            {
                throw;
            }
        }
        return dAmount;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}