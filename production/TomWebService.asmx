<%@ WebService Language="C#" Class="TomWebService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下列一行。
[System.Web.Script.Services.ScriptService]
public class TomWebService : System.Web.Services.WebService
{
    //[WebMethod(EnableSession=true)]

    //類別都叫用entity建好的類別
    //分頁處理pageSize  pageIndex 
    [WebMethod]
    public TomResult getTomOrders(int pageSize, int pageIndex)
    {
        //取回資料庫所有資料 >算分頁
        List<TomOrder> myOrder = TomOrderUtility.GetAllTomOrders();
        int startIndex = (pageIndex - 1) * pageSize;
        int realPageSize =
                myOrder.Count - startIndex > pageSize
                ? pageSize : myOrder.Count - startIndex;
        List<TomOrder> orders = myOrder.GetRange(startIndex, realPageSize);
        return new TomResult()
        {
            TotalCount = myOrder.Count,
            Orders = orders
        };
    }
    [WebMethod]
    public void insertTomOrder(TomOrder order)
    {
         //在後端進行加總運算
        order.Total = int.Parse(order.NormalShip) * 100 + int.Parse(order.ColdShip) * 200 + int.Parse(order.DeepFrozenShip) * 300;
        TomOrderUtility.AddTomOrder(order);
    }
    [WebMethod]
    public void updateTomOrder(TomOrder order)
    {
        TomOrderUtility.UpdateTomOrder(order);
    }

    [WebMethod]
    public void deleteTomOrder(TomOrder order)
    {
        TomOrderUtility.DeleteTomOrder(order.OID);
    }
}



//JSGRID需要的回應內容
public class TomResult
{
    public int TotalCount { get; set; }
    public List<TomOrder> Orders { get; set; }
}


