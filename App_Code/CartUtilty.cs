using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.SessionState;

/// <summary>
/// CartUtilty 的摘要描述
/// </summary>

//購物車類別工具
public class CartUtilty
{

    public static string SendCourseNameToCart(int K_ID)
    {
        using (SqlConnection cn = new SqlConnection(DarrenCommon.DBConnectionString))
        {
            string CourseName = "";
            SqlCommand myCommand = new SqlCommand("select*from Knowledge where K_ID=@K_ID", cn);
            myCommand.Parameters.AddWithValue("@K_ID", K_ID);
            cn.Open();
            SqlDataReader dr = myCommand.ExecuteReader();
            while (dr.Read())
            {
                CourseName = dr[1].ToString();
                //txtDesc.Text = dr[1].ToString();
            }
            dr.Close();
            return CourseName;
        }
    }


    public static string SendCoursePriceToCart(int K_ID)
    {
        using (SqlConnection cn = new SqlConnection(DarrenCommon.DBConnectionString))
        {
            int CoursePrice = 0;
            //string CoursePrice = "";
            SqlCommand myCommand = new SqlCommand("select*from Knowledge where K_ID=@K_ID", cn);
            myCommand.Parameters.AddWithValue("@K_ID", K_ID);
            cn.Open();
            SqlDataReader dr = myCommand.ExecuteReader();
            while (dr.Read())
            {
                CoursePrice = Convert.ToInt32(dr[5]);
            }
            dr.Close();
            return CoursePrice.ToString();
        }
    }

}



