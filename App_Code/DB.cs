﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;

public partial class Board
{
    public int BID { get; set; }
    public string Time { get; set; }
    public string Title { get; set; }
    public string Context { get; set; }
    public string Category { get; set; }
    public string EmployeeID { get; set; }
    public string Remark1 { get; set; }
    public string Remark2 { get; set; }
}

public partial class ClockInOutRecord
{
    public int CIORID { get; set; }
    public Nullable<int> EmployeeID { get; set; }
    public Nullable<int> DepartmentID { get; set; }
    public string Date { get; set; }
    public string ClockIn { get; set; }
    public string ClockOut { get; set; }
    public string Passed { get; set; }
    public Nullable<int> ModifiedBy { get; set; }
    public string Note1 { get; set; }
    public string Note2 { get; set; }
}

public partial class Club
{
    public int Id { get; set; }
    public string ClubName { get; set; }
    public string Description { get; set; }
    public string Detail { get; set; }
    public string Img { get; set; }
    public Nullable<int> Members { get; set; }
}

public partial class ClubMember
{
    public int Id { get; set; }
    public int ClubID { get; set; }
    public string Club { get; set; }
    public Nullable<int> EID { get; set; }
    public string Name { get; set; }
    public Nullable<int> DeptID { get; set; }
    public string DeptName { get; set; }
    public string Reason { get; set; }
    public string Approval { get; set; }
}

public partial class Employee
{
    public int EmployeeID { get; set; }
    public string UserName { get; set; }
    public string Password { get; set; }
    public string LastName { get; set; }
    public string FirstName { get; set; }
    public string Gender { get; set; }
    public Nullable<System.DateTime> BirthDate { get; set; }
    public int DepartmentID { get; set; }
    public string DepartmentName { get; set; }
    public string AuthorizationLevel { get; set; }
    public string HireStatus { get; set; }
    public Nullable<System.DateTime> HiredDate { get; set; }
    public Nullable<System.DateTime> ResignedDate { get; set; }
    public int Salary { get; set; }
    public string ImageFileName { get; set; }
    public string Address { get; set; }
    public string Phone { get; set; }
    public string Mobile { get; set; }
    public string Email { get; set; }
    public string Age { get; set; }
    public string ServiceYear { get; set; }
    public string Relationship { get; set; }
    public string Other1 { get; set; }
    public string Other2 { get; set; }
}

public partial class Leave
{
    public int LeaveID { get; set; }
    public Nullable<int> EmployeeID { get; set; }
    public Nullable<int> DepartmentID { get; set; }
    public string TypeOfLeave { get; set; }
    public string Date { get; set; }
    public string TimeStart { get; set; }
    public string TimeOff { get; set; }
    public Nullable<int> Hour { get; set; }
    public string Reason { get; set; }
    public string ProofImg { get; set; }
    public string Passed { get; set; }
    public Nullable<int> ModifiedBy { get; set; }
    public string Note1 { get; set; }
    public string Note2 { get; set; }
}

public partial class MeetingRoomBookingRecord
{
    public int Id { get; set; }
    public Nullable<int> RoomId { get; set; }
    public Nullable<int> EmployeeID { get; set; }
    public Nullable<System.DateTime> StartDateTime { get; set; }
    public Nullable<System.DateTime> EndDateTime { get; set; }
    public string MeetingRecordPath { get; set; }
    public Nullable<int> Note1 { get; set; }
    public string Note2 { get; set; }
}

public partial class PayrollCalculation
{
    public int PayrollCalculationID { get; set; }
    public Nullable<int> EmployeeID { get; set; }
    public Nullable<int> DepartmentID { get; set; }
    public string YearMonth { get; set; }
    public Nullable<int> CalculatedSalary { get; set; }
    public Nullable<int> SalaryBonus { get; set; }
    public Nullable<int> PerfectAttendance { get; set; }
    public Nullable<int> TravelSubsidy { get; set; }
    public Nullable<int> SalaryTotal { get; set; }
    public string Note1 { get; set; }
    public string Note2 { get; set; }
}

public partial class Performance
{
    public int PerformanceID { get; set; }
    public Nullable<int> EmployeeID { get; set; }
    public Nullable<int> DepartmentID { get; set; }
    public Nullable<int> Year { get; set; }
    public Nullable<int> Month { get; set; }
    public Nullable<int> Grade { get; set; }
    public string Reason { get; set; }
    public string Note1 { get; set; }
    public string Note2 { get; set; }
}

public partial class SpecialPlan
{
    public int S_ID { get; set; }
    public string S_Name { get; set; }
    public string S_Category { get; set; }
    public string S_Vendor { get; set; }
    public Nullable<decimal> S_Price { get; set; }
    public string S_Stock { get; set; }
    public string S_ImgInfo { get; set; }
    public string S_DetailInfo { get; set; }
}

public partial class TomOrder
{
    public int OID { get; set; }
    public Nullable<int> CID { get; set; }
    public Nullable<int> EID { get; set; }
    public string Date { get; set; }
    public string InDate { get; set; }
    public string OutDate { get; set; }
    public string NormalShip { get; set; }
    public string ColdShip { get; set; }
    public string DeepFrozenShip { get; set; }
    public Nullable<int> Total { get; set; }
    public string remark1 { get; set; }
    public string remark2 { get; set; }
}

public partial class WorkMessage
{
    public int MessageID { get; set; }
    public string SendTime { get; set; }
    public string HaveRead { get; set; }
    public Nullable<int> SenderDID { get; set; }
    public Nullable<int> SenderEID { get; set; }
    public Nullable<int> RecipientDID { get; set; }
    public Nullable<int> RecipientEID { get; set; }
    public string MessageSubject { get; set; }
    public string MessageContent { get; set; }
    public string ReMessage { get; set; }
    public string MessageAttachment { get; set; }
    public string Note1 { get; set; }
    public string Note2 { get; set; }
    public string Note3 { get; set; }
}

public partial class WorkShiftRecord
{
    public int WorkShiftRecordId { get; set; }
    public int EmployeeID { get; set; }
    public System.DateTime WorkDate { get; set; }
}

public partial class WorkShiftRecordsDepIdView
{
    public int WorkShiftRecordId { get; set; }
    public int EmployeeID { get; set; }
    public System.DateTime WorkDate { get; set; }
    public int DepartmentID { get; set; }
}