using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Employee 的摘要描述
/// </summary>
public class YenEmployee
{
    public int EmployeeID { get; set; }
    public string UserName { get; set; }
    public string Password { get; set; }
    public string LastName { get; set; }
    public string FirstName { get; set; }
    public string Gender { get; set; }
    public string BirthDate { get; set; }
    public int DepartmentID { get; set; }
    public string DepartmentName { get; set; }
    public string AuthorizationLevel { get; set; }
    public string HireStatus { get; set; }
    public string HiredDate { get; set; }
    public string ResignedDate { get; set; }
    public int Salary { get; set; }
    public string ImageFileName { get; set; }
    public string Address { get; set; }
    public string Phone { get; set; }
    public string Mobile { get; set; }
    public string Email { get; set; }
    public string Other1 { get; set; }
    public string Other2 { get; set; }
    public string Age { get; set; }
    public string ServiceYear { get; set; }
}