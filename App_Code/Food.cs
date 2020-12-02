using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Food 的摘要描述
/// </summary>
public class Foods
{
    public int FID { get; set; }
    public string FName { get; set; }
    public int FPrice { get; set; }
    public int FAmount { get; set; }
    public string FCategory { get; set; }
    public string FImg { get; set; }

}

public class FoodOrders
{
    public int FID { get; set; }
    public string FName { get; set; }
    public int FPrice { get; set; }
    public int FAmount { get; set; }
    public int FTotal { get; set; }
    public string FImg { get; set; }

}