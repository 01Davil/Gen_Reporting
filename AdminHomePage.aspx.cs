using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using System.Configuration;

public partial class AdminHomePage : System.Web.UI.Page
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public class count
    {
        public string active { get; set; }
        public string Unactive { get; set; }
          public string holiName { get; set; }
        public string holiDate { get; set; }
          public string locationName { get; set; }
          public string EmpName { get; set; }
          public string DOB { get; set; }
          public string OfficeMail { get; set; }
          public string TotalEmp { get; set; }
          public string TotalProj { get; set; }
          public string EmpCode { get; set; }
          public string TotalDays { get; set; }
          public string WorkingDays { get; set; }
          public string AbsentDays { get; set; }
          public string HoliDays { get; set; }
    }

    

    [WebMethod]
    public static List<count> Get_ProjCount()
    {
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection(conn);

        try
        {
            cmd = new SqlCommand("select count(id) as TotalProject from [dbo].[Project_Details]", con);
            cmd.CommandTimeout = 4800;
            SqlDataAdapter SDA = new SqlDataAdapter(cmd);
            SDA.Fill(ds);
            dt = ds.Tables[0];
        }
        catch (Exception ex)
        {

        }
        List<count> maplatlons = new List<count>();
        foreach (DataRow dtt in dt.Rows)
        {
            maplatlons.Add(new count
            {
                TotalProj = dtt["TotalProject"].ToString(),
                

            });
        }

        return maplatlons;

    }


    public class ListEmployee
    {
        public string id { get; set; }
        public string ProjectName { get; set; }
        public string ProjectCode { get; set; }
        public string Status { get; set; }
        public string TeamMember { get; set; }
        public string ReleasingDate { get; set; }
        public string MEETINGS_DETAILS { get; set; }
        public string EMPLOYEE_NAME { get; set; }
        public string DATE { get; set; }
    }

    
    [WebMethod]
    public static List<ListEmployee> show_LiveProject()
    {
        DataTable dt = new DataTable();
        DataTable ndt = new DataTable();
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection(conn);

        try
        {
            cmd = new SqlCommand("Admin_ShowLiveProject", con);
      
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 4800;
            SqlDataAdapter SDA = new SqlDataAdapter(cmd);
            SDA.Fill(ds);
            dt = ds.Tables[0];

        }
        catch (Exception ex)
        {

        }
        finally
        {
            con.Close();
        }
        List<ListEmployee> Data = new List<ListEmployee>();
        foreach (DataRow dttt in dt.Rows)
        {
            Data.Add(new ListEmployee
            {
            
                ProjectName = dttt["ProjectName"].ToString(),
                ProjectCode = dttt["ProjectCode"].ToString(),
                TeamMember = dttt["TeamMember"].ToString(),
                Status = dttt["Status"].ToString(),
                ReleasingDate = dttt["ReleasingDate"].ToString(),
               
            });
        }
        return Data;


    }


    [WebMethod]
    public static List<ListEmployee> show_Meeting()
    {
        DataTable dt = new DataTable();
        DataTable ndt = new DataTable();
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection(conn);

        try
        {
            cmd = new SqlCommand("GetMeetingDetails ", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 4800;
            SqlDataAdapter SDA = new SqlDataAdapter(cmd);
            SDA.Fill(ds);
            dt = ds.Tables[0];

        }
        catch (Exception ex)
        {

        }
        finally
        {
            con.Close();
        }
        List<ListEmployee> Data = new List<ListEmployee>();
        foreach (DataRow dttt in dt.Rows)
        {
            Data.Add(new ListEmployee
            {
                MEETINGS_DETAILS = dttt["MEETINGS_DETAILS"].ToString(),
                DATE = dttt["DATE"].ToString(),
                EMPLOYEE_NAME = dttt["EMPLOYEE_NAME"].ToString(),
               
                

            });
        }
        return Data;


    }



    [WebMethod]
    public static List<count> GetHolidaycount()
    {
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection(conn);

        try
        {
            cmd = new SqlCommand("GetHolidayDetails", con);
            cmd.CommandType = CommandType.StoredProcedure;
            // cmd.Parameters.AddWithValue("@userid", Userid);
            cmd.CommandTimeout = 4800;
            SqlDataAdapter SDA = new SqlDataAdapter(cmd);
            SDA.Fill(ds);
            dt = ds.Tables[0];
        }
        catch (Exception ex)
        {

        }
        List<count> maplatlons = new List<count>();
        foreach (DataRow dtt in dt.Rows)
        {
            maplatlons.Add(new count
            {
                holiName = dtt["HoliName"].ToString(),
                holiDate = dtt["HoliDate"].ToString(),
                locationName = dtt["LocationName"].ToString(),
            });
        }

        return maplatlons;

    }


      [WebMethod]
    public static List<count> GetBirthDay()
    {
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection(conn);

        try
        {
            cmd = new SqlCommand("Admin_ShowBday", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 4800;
            SqlDataAdapter SDA = new SqlDataAdapter(cmd);
            SDA.Fill(ds);
            dt = ds.Tables[0];
        }
        catch (Exception ex)
        {

        }
        List<count> maplatlons = new List<count>();
        foreach (DataRow dtt in dt.Rows)
        {
            maplatlons.Add(new count
            {
                EmpName = dtt["EmpName"].ToString(),
                DOB = dtt["DOB"].ToString(),
                OfficeMail = dtt["OfficeEmail"].ToString(),
            });
        }

        return maplatlons;

    }


      [WebMethod]
      public static List<count> GetData(string empid)
      {
          DataTable dt = new DataTable();
          DataSet ds = new DataSet();
          SqlCommand cmd = new SqlCommand();
          SqlConnection con = new SqlConnection(conn);

          try
          {
              cmd = new SqlCommand("select * from Master_EmployeeDetails where Sno = '"+ empid  +"' ", con);              
              cmd.CommandTimeout = 4800;
              SqlDataAdapter SDA = new SqlDataAdapter(cmd);
              SDA.Fill(ds);
              dt = ds.Tables[0];
          }
          catch (Exception ex)
          {

          }
          List<count> maplatlons = new List<count>();
          foreach (DataRow dtt in dt.Rows)
          {
              maplatlons.Add(new count
              {
                  EmpCode = dtt["EmpCode"].ToString(),                  
              });
          }

          return maplatlons;

      }

    // modal on history record
      [WebMethod]
      public static List<count> getEmployeeHistoryData(string EmpSno, string ToDate,string FromDate)
      {
          DataTable dt = new DataTable();
          DataSet ds = new DataSet();
          SqlCommand cmd = new SqlCommand();
          SqlConnection con = new SqlConnection(conn);

          try
          {
              cmd = new SqlCommand("getEmployeeHistoryRecord", con);
              cmd.CommandType = CommandType.StoredProcedure;
              cmd.Parameters.AddWithValue("@EmpSno", EmpSno);
              cmd.Parameters.AddWithValue("@ToDate", ToDate);
              cmd.Parameters.AddWithValue("@FromDate", FromDate);
              cmd.Parameters.AddWithValue("@Type", 1);
              cmd.CommandTimeout = 4800;
              SqlDataAdapter SDA = new SqlDataAdapter(cmd);
              SDA.Fill(ds);
              dt = ds.Tables[0];
          }
          catch (Exception ex)
          {

          }
          List<count> maplatlons = new List<count>();
          foreach (DataRow dtt in dt.Rows)
          {
              maplatlons.Add(new count
              {
                  TotalDays = dtt["totalDays"].ToString(),
                  WorkingDays = dtt["workingdays"].ToString(),
                  AbsentDays = dtt["absentDays"].ToString(),
                  HoliDays = dtt["HoliDays"].ToString() 
              });
          }

          return maplatlons;

      }

    // graph data  getEmployeeGraphData

      [WebMethod]
      public static List<object> getEmployeeGraphData(string EmpSno, string ToDate, string FromDate)
      {         
          string constr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;          
          List<object> chartData = new List<object>();
          chartData.Add(new object[] { "Days", "No Of Days" });

          using (SqlConnection con = new SqlConnection(constr))
          {
              using (SqlCommand cmd = new SqlCommand("getEmployeeHistoryRecord", con))
              {
                  cmd.CommandType = CommandType.StoredProcedure;
                  cmd.Connection = con;
                  cmd.Parameters.AddWithValue("@EmpSno", EmpSno);
                  cmd.Parameters.AddWithValue("@ToDate", ToDate);
                  cmd.Parameters.AddWithValue("@FromDate", FromDate);
                  cmd.Parameters.AddWithValue("@Type", 2);
                  con.Open();
                  using (SqlDataReader sdr = cmd.ExecuteReader())
                  {
                      while (sdr.Read())
                      {
                          chartData.Add(new object[] { sdr["EmpDays"], sdr["DaysNo"] });
                      }
                  }
                  con.Close();
                  return chartData;
              }
          }
      }

}