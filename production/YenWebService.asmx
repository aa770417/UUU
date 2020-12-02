<%@ WebService Language="C#" Class="YenWebService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class YenWebService : System.Web.Services.WebService
{

    [WebMethod]
    public YenEmployee GetEmployeeByID(int id)
    {
        return EmployeeUtility.GetEmployeeByID(id);
    }

    [WebMethod]
    public Club GetClub(int id)
    {
        return ClubUtility.GetClub(id);
    }
    //根據社團ID取得成員資料
    [WebMethod]
    public List<ClubMember> GetMembersByClubID(int id)
    {
        return ClubUtility.GetMembersByClubID(id);
    }

    [WebMethod]
    public void ApplyMember(string clubid, string clubName, string id, string deptId, string reason)
    {
        YenEmployee em = EmployeeUtility.GetEmployeeByID(Convert.ToInt32(id));

        ClubMember cm = new ClubMember()
        {
            ClubID = Convert.ToInt32(clubid),
            Club = clubName,
            Name = em.LastName + em.FirstName,
            EID = Convert.ToInt32(id),
            DeptID = Convert.ToInt32(deptId),
            DeptName = em.DepartmentName,
            Reason = reason
        };

        ClubUtility.ApplyMember(cm);
    }

    //以降序方式取得申請社團的名單
    [WebMethod]
    public Result GetApplys(int pageSize, int pageIndex)
    {
        //取得資料庫的員工申請資料
        List<ClubMember> memberApply = ClubUtility.GetApplys();

        //pageIndex從1開始
        int startIndex = (pageIndex - 1) * pageSize;
        int realPageSize =
                memberApply.Count - startIndex > pageSize
                ? pageSize : memberApply.Count - startIndex;
        List<ClubMember> members = memberApply.GetRange(startIndex, realPageSize);
        return new Result()
        {
            TotalCount = memberApply.Count,
            clubMembers = members
        };
    }

    [WebMethod]
    public void Approve(ClubMember clubMember)
    {
        ClubMember cm = clubMember;

        ClubUtility.Approve(cm);

    }

    //以升序方式取得申請社團的名單
    [WebMethod]
    public Result GetAllClubs(int pageSize, int pageIndex)
    {
        //取得資料庫的員工申請資料
        List<Club> clubs = ClubUtility.GetAllClubs();

        //pageIndex從1開始
        int startIndex = (pageIndex - 1) * pageSize;
        int realPageSize =
                clubs.Count - startIndex > pageSize
                ? pageSize : clubs.Count - startIndex;
        List<Club> club = clubs.GetRange(startIndex, realPageSize);
        return new Result()
        {
            TotalCount = clubs.Count,
            allClubs = club
        };
    }

    //新增社團
    [WebMethod]
    public void AddClub(Club cl)
    {
        Club club = new Club()
        {
            ClubName = cl.ClubName,
            Description = cl.Description,
            Detail = cl.Detail,
            Img = cl.Img
        };

        ClubUtility.AddClub(club);
    }

    //修改社團
    [WebMethod]
    public void UpdateClub(Club club)
    {
        //先根據id取回舊的club資料
        Club oldclub = ClubUtility.GetClub(club.Id);
        string oldImg = oldclub.Img;
        //如果傳回來的Img是"" => 代表沒有更新圖片，就不更新Img
        if (club.Img == "")
        {
            Club cl = new Club()
            {
                Id = club.Id,
                ClubName = club.ClubName,
                Description = club.Description,
                Detail = club.Detail,
                Img = oldImg,
                Members = club.Members
            };
            ClubUtility.UpdateClub(cl);
        }
        else
        {
            Club cl = new Club()
            {
                Id = club.Id,
                ClubName = club.ClubName,
                Description = club.Description,
                Detail = club.Detail,
                Img = club.Img,
                Members = club.Members
            };
            ClubUtility.UpdateClub(cl);
        }
    }

    //刪除社團
    [WebMethod]
    public void deleteClub(Club club)
    {
        int id = club.Id;

        ClubUtility.DeleteClub(id);
    }

    //取得社團人員變動的資料
    [WebMethod]
    public ClubMember GetMember(int id)
    {
       return ClubUtility.GetMember(id);
    }


}

public class Result
{
    public int TotalCount { get; set; }
    public List<ClubMember> clubMembers { get; set; }
    public List<Club> allClubs { get; set; }
}