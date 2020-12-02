using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

/// <summary>
/// Class1 的摘要描述
/// </summary>
public class DarrenCommon
{
    public static string DBConnectionString //這個是設定連線字串的類別
    {
        get//沒有任何欄位，也可以直接get
        {
            return
                ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        }
    }
}