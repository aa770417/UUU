using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Product
/// </summary>
public class OrderProduct
{
    public int OrderId { get; set; }
    public string Client { get; set; }
    public DateTime OrderDate { get; set; }
    public string OrderNumber { get; set; }
    public string OrderSort { get; set; }
    public int OrderAmount { get; set; }
    public DateTime OrderIn { get; set; }
    public DateTime OrderOut { get; set; }
    public string Country { get; set; }
    public string Position { get; set; }
}

public class OrderProducts
{
    public int OrderId { get; set; }
    public string Client { get; set; }
    public string OrderDate { get; set; }
    public string OrderNumber { get; set; }
    public string OrderSort { get; set; }
    public int OrderAmount { get; set; }
    public string OrderIn { get; set; }
    public string OrderOut { get; set; }
    public string Country { get; set; }
    public string Position { get; set; }
}