<%@ WebService Language="C#" Class="HRWebService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class HRWebService : System.Web.Services.WebService
{

    [WebMethod]
    public bool AddClockInRecord(string EID, string DID, string date, string CIn)
    {
        ClockInOutRecord c = new ClockInOutRecord()
        {
            EmployeeID = int.Parse(EID),
            DepartmentID = int.Parse(DID),
            Date = date,
            ClockIn = CIn,
            Passed = "未審核",
            Note1 = date.Substring(0, 4),
            Note2 = date.Substring(5, 2)

        };

        return HRUtility.InsertClockInRecord(c);
    }

    [WebMethod]
    public bool AddClockOutRecord(string EID, string DID, string date, string COut)
    {
        ClockInOutRecord c = new ClockInOutRecord()
        {
            EmployeeID = int.Parse(EID),
            DepartmentID = int.Parse(DID),
            Date = date,
            ClockOut = COut
        };

        return HRUtility.InsertClockOutRecord(c);
    }

    [WebMethod]
    public ClockInOutRecord GetClockInOutRecord(string CIORID)
    {
        int C = int.Parse(CIORID);
        return HRUtility.GetClockInOutRecordForModify(C);
    }

    [WebMethod]
    public bool LeaveReturn(string LID, string reason, string MID)
    {
        int C = int.Parse(LID);
        int M = int.Parse(MID);
        return HRUtility.LeaveReturn(C, reason, M);
    }

    [WebMethod]
    public WorkMessage GetReceiveDetail(string MID)
    {
        int C = int.Parse(MID);
        return MessageUtility.GetPersonalReceiveMessageDetail(C);
    }

    [WebMethod]
    public WorkMessage GetSendDetail(string MID)
    {
        int C = int.Parse(MID);
        return MessageUtility.GetPersonalSendMessageDetail(C);
    }

    [WebMethod]
    public bool LeavePass(string LID)
    {
        int C = int.Parse(LID);
        return HRUtility.LeavePass(C);
    }

    [WebMethod]
    public bool SendMsg(string EID, string ToEID, string Time, string MsgSubject)
    {
        WorkMessage W = new WorkMessage()
        {
            SendTime = Time,
            HaveRead = "未讀",
            SenderEID = int.Parse(EID),
            RecipientEID = int.Parse(ToEID),
            MessageSubject = MsgSubject,
            
        };

        return MessageUtility.SendMsg(W);
    }


}