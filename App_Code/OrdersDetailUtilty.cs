using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// OrdersDetailUtilty 的摘要描述
/// </summary>
public class OrdersDetailUtilty
{
    //將購物車資料存入OrdersDetai資料表中的方法，用於CartList.aspx頁面中的確定按鈕
    public static void InsertOrdersDetailInfo(DarrenOrdersDetail od)
    {
        using (SqlConnection cn = new SqlConnection(DarrenCommon.DBConnectionString))
        {
            SqlCommand OD_Cmd = new SqlCommand
                ("Insert into DarrenOrdersDetail(Ord_ID,P_ID,P_Name,P_Price,P_Quantity,P_Amount,E_ID)values(@Ord_ID,@P_ID,@P_Name,@P_Price,@P_Quantity,@P_Amount,@E_ID)", cn);
            OD_Cmd.Parameters.AddWithValue("@Ord_ID", od.Ord_ID);
            OD_Cmd.Parameters.AddWithValue("@P_ID", od.P_ID);
            OD_Cmd.Parameters.AddWithValue("@P_Name", od.P_Name);
            OD_Cmd.Parameters.AddWithValue("@P_Price", od.P_Price);
            OD_Cmd.Parameters.AddWithValue("@P_Quantity", od.P_Quantity);
            OD_Cmd.Parameters.AddWithValue("@P_Amount", od.P_Amount);
            OD_Cmd.Parameters.AddWithValue("@E_ID", od.E_ID);
            cn.Open();
            OD_Cmd.ExecuteNonQuery();
        }
    }
    //將訂購人的OrdersDetail資料顯示在OrdersDetailList.aspx頁面中
    public static List<DarrenOrdersDetail> DisplayOrdersDetailInfoToOrdersList(int Ord_ID)
    {
        {
            SqlDataAdapter da = new SqlDataAdapter("select*from DarrenOrdersDetail where Ord_ID=@Ord_ID", DarrenCommon.DBConnectionString);
            da.SelectCommand.Parameters.AddWithValue("@Ord_ID", Ord_ID);
            DataTable dt = new DataTable();
            da.Fill(dt);
            var k_List = from row in dt.AsEnumerable()
                         select new DarrenOrdersDetail()
                         {        
                             Ord_ID = Convert.ToInt32(row["Ord_ID"]),
                             P_ID = Convert.ToInt32(row["P_ID"]),
                             P_Name = row["P_Name"].ToString(),
                             P_Price = Convert.ToInt32(row["P_Price"]),
                             P_Quantity = Convert.ToInt32(row["P_Quantity"]),
                             P_Amount = Convert.ToInt32(row["P_Amount"]),
                             E_ID = Convert.ToInt32(row["E_ID"])
                         };
            return k_List.ToList();
        }
    }
}