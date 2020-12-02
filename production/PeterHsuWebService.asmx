<%@ WebService Language="C#" Class="PeterHsuWebService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;


[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]

public class PeterHsuWebService : System.Web.Services.WebService
{

    [WebMethod(EnableSession = true)]
    public List<Employee> GetEmployees()
    {
        return PeterHsuUtilities.GetEmployees();
    }

    [WebMethod(EnableSession = true)]
    public List<Employee> GetEmployeesByDepID()
    {
        //string[] empStringArray = (string[])Session["Employee"];

        Employee empSession = (Employee)Session["Employee"];

        // Attempt to grab the value from your Session
        if (Session["Employee"] == null)
        {
            // It does not exist, return
            return null;
        }

        return PeterHsuUtilities.GetEmployeesByDepID(empSession.DepartmentID.ToString());
    }

    [WebMethod(EnableSession = true)]
    public bool AddWorkShiftRecords(List<eventsData> JsonArr)
    {
        List<WorkShiftRecord> shiftRecordsList = new List<WorkShiftRecord>();

        foreach (var item in JsonArr)
        {
            string[] idName = item.name.Split('_');
            int empID = Convert.ToInt32(idName[0]);

            WorkShiftRecord shiftRecord = new WorkShiftRecord()
            {
                EmployeeID = empID,
                WorkDate = Convert.ToDateTime(item.workDate)
            };

            shiftRecordsList.Add(shiftRecord);
        }

        bool AddSuccess = PeterHsuUtilities.AddWorkShiftRecords(shiftRecordsList);

        if (AddSuccess == true)
        {
            return true;
        }
        return false;
    }

    public class eventsData
    {
        public string name { get; set; }
        public string workDate { get; set; }
    }

}