using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// OrdersUtilty 的摘要描述
/// </summary>
public class OrdersUtilty
{
    //將購物車資料存入Orders資料表中的方法，用於CartList.aspx頁面中的確定按鈕
    public static void InsertOrdersInfo(DarrenOrders o)
    {
        using (SqlConnection cn = new SqlConnection(DarrenCommon.DBConnectionString))
        {
            SqlCommand P_Cmd = new SqlCommand
            ("Insert into DarrenOrders(E_ID,Ord_Date,R_Name,R_Phone,R_Moblile,R_Email,R_Address)values(@E_ID,@Ord_Date,@R_Name,@R_Phone,@R_Moblile,@R_Email,@R_Address)", cn);
            P_Cmd.Parameters.AddWithValue("@E_ID", o.E_ID);
            //P_Cmd.Parameters.AddWithValue("@Ord_ID", o.Ord_ID);
            P_Cmd.Parameters.AddWithValue("@Ord_Date", o.Ord_Date);
            P_Cmd.Parameters.AddWithValue("@R_Name", o.R_Name);
            P_Cmd.Parameters.AddWithValue("@R_Phone", o.R_Phone);
            P_Cmd.Parameters.AddWithValue("@R_Moblile", o.R_Moblile);
            P_Cmd.Parameters.AddWithValue("@R_Email", o.R_Email);
            P_Cmd.Parameters.AddWithValue("@R_Address", o.R_Address);
            cn.Open();
            P_Cmd.ExecuteNonQuery();
        }
    }
    public static int SendOrdersIDToCartList()
    {
        using (SqlConnection cn = new SqlConnection(DarrenCommon.DBConnectionString))
        {
            int Ord_ID = 0;
            //string CoursePrice = "";
            SqlCommand myCommand = new SqlCommand("select Top 1 *from DarrenOrders ORDER BY [Ord_ID] DESC", cn);
            //myCommand.Parameters.AddWithValue("@Ord_ID", Ord_ID);
            cn.Open();
            SqlDataReader dr = myCommand.ExecuteReader();
            while (dr.Read())
            {
                Ord_ID = Convert.ToInt32(dr[1]);
            }
            dr.Close();
            return Ord_ID;
        }
    }


    //將訂購人的Orders資料顯示在OrdersList.aspx頁面中
    public static List<DarrenOrders> DisplayOrdersInfoToOrdersList(int E_ID)
    {
            {
                SqlDataAdapter da = new SqlDataAdapter("select*from DarrenOrders where E_ID=@E_ID", DarrenCommon.DBConnectionString);
                  da.SelectCommand.Parameters.AddWithValue("@E_ID", E_ID);
            DataTable dt = new DataTable();

                da.Fill(dt);

                var k_List = from row in dt.AsEnumerable()//轉型成可以被列舉的物件
                             select new DarrenOrders()
                             {
                                 E_ID = Convert.ToInt32(row["E_ID"]),
                                 Ord_ID = Convert.ToInt32(row["Ord_ID"]),
                                 Ord_Date = row["Ord_Date"].ToString(),
                                 R_Name = row["R_Name"].ToString(),
                                 R_Phone = row["R_Phone"].ToString(),
                                 R_Moblile = row["R_Moblile"].ToString(),
                                 R_Email = row["R_Email"].ToString(),
                                 R_Address = row["R_Address"].ToString()
                             };
                return k_List.ToList();
            }

    }

}