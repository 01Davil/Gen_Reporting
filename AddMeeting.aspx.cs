using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddMeeting : System.Web.UI.Page
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public class classMonth
    {
        public string EmpName { get; set; }
        public string DepName { get; set; }
        public string EmpName2 { get; set; }
        public string DepName2 { get; set; }
        public string id { get; set; }
    }
    [WebMethod]
    public static List<classMonth> GetMonth()
    {
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();

            cmd = new SqlCommand("Emp_GetMonth", con);
            cmd.Parameters.AddWithValue("@Type", "WFH");
            cmd.Parameters.AddWithValue("@YearNo", 0);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 4800;
            con.Close();
            SqlDataAdapter SDA = new SqlDataAdapter(cmd);
            SDA.Fill(ds);
            dt = ds.Tables[0];
        }
        catch (Exception s)
        {
            string ss = s.Message.ToString();
        }
        List<classMonth> Data = new List<classMonth>();

        foreach (DataRow dtt in dt.Rows)
        {
            Data.Add(new classMonth
            {
               // DepName2 = dtt["id"].ToString(),
                DepName = dtt["mname"].ToString(),
            });
        }

        return Data;
    }

    [WebMethod]
    public static List<classMonth> GetMonthWithYear(string DepName)
    {
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("Emp_Name", con);         
            cmd.Parameters.AddWithValue("@D_Name", DepName);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 4800;
            con.Close();
            SqlDataAdapter SDA = new SqlDataAdapter(cmd);
            SDA.Fill(ds);
            dt = ds.Tables[0];
        }
        catch (Exception s)
        {
            string ss = s.Message.ToString();
        }
        List<classMonth> Data = new List<classMonth>();

        foreach (DataRow dtt in dt.Rows)
        {
            Data.Add(new classMonth
            {
               // EmpName2 = dtt["id"].ToString(),
                EmpName = dtt["EmpName"].ToString(),
            });
        }

        return Data;
    }
    public class classYear
    {
        public string EmpName { get; set; }
        public string DepName { get; set; }
    }
    [WebMethod]
    public static List<classMonth> GetYear()
    {
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();

            cmd = new SqlCommand("Emp_GetDepartment_harsh", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 4800;
            con.Close();
            SqlDataAdapter SDA = new SqlDataAdapter(cmd);
            SDA.Fill(ds);
            dt = ds.Tables[0];
        }
        catch (Exception s)
        {
            string ss = s.Message.ToString();
        }
        List<classMonth> Data = new List<classMonth>();

        foreach (DataRow dtt in dt.Rows)
        {
            Data.Add(new classMonth
            {
               // DepName2 = dtt["id"].ToString(),
                DepName = dtt["D_Name"].ToString(),
            });
        }

        return Data;
    }


     [WebMethod]
    public static List<classMonth> getCityCount(string DepName)
    {
        DataTable dt = new DataTable();
        DataTable ndt = new DataTable();
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection(conn);

        try
        {
            con.Close();
            con.Open();
            SqlDataReader reader;
            cmd = new SqlCommand("select * from Master_EmployeeDesignation", con);
            reader = cmd.ExecuteReader();
            dt = new DataTable();
            dt.Load(reader);
        }
        catch (Exception ex)
        {
           
        }
        List<classMonth> Data = new List<classMonth>();

        foreach (DataRow dtt in dt.Rows)
        {
            Data.Add(new classMonth
            {

                DepName = dtt["D_Name"].ToString(),

            });
        }

        return Data;

    }

}