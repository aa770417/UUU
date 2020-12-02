using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;

/// <summary>
/// Employees 的摘要描述
/// </summary>
public class Common
{
    public static string DBConnectionString
    {
        get
        {
            return
                ConfigurationManager.ConnectionStrings["NW"].ConnectionString;
        }
    }
}