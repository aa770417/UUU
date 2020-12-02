using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Common
/// </summary>
public class TomCommon
{
   
    public static string DBConnect
    {
        get
        {
           return ConfigurationManager.ConnectionStrings["NW"].ConnectionString;
        }
    }
}