using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Class1 的摘要描述
/// </summary>
public class Knowledge//知識補給頁面會用到的欄位
{
    public int K_ID { get; set; } //課程編號
    public string K_Course { get; set; }//課程名稱
    public string K_Category { get; set; }//課程分類
    public string K_Institution { get; set; }//認證機構
    public string K_Location { get; set; }//上課地點
    public int K_Price { get; set; }//課程優惠價
    public int K_Hour { get; set; }//課程時數
    public string K_Date { get; set; }//開課日期
    public string K_Contact { get; set; }//認證機構企業窗口
    public string K_Phone { get; set; }//認證機構企業窗口聯絡方式
    public string K_ImgInfo { get; set; }//Knowledge總覽頁面圖片資訊
    public string K_DetailInfo { get; set; }//Knowledge個別課程頁面資訊

}