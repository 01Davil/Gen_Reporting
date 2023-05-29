using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
using System.Web;

public partial class FNF : System.Web.UI.Page
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    static string MonthNo = "";
    static string YearNo = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginType"] == null || Session["LoginSno"] == null || Session["LoginIDMax"] == null || Session["LoginEmpCode"] == null || Session["LoginName"] == null || Session["LoginEmail"] == null || Session["LoginImage"] == null || Session["LoginRoleId"] == null)
        {
            Response.Redirect("LoginPage.aspx");
        }
        else
        {
            MonthNo = Request.QueryString["MonthNo"];
            YearNo = Request.QueryString["YearNo"];
        }
    }
    public class EmployeeClass
    {
        public string id { get; set; }
        public string EmpName { get; set; }
        public string EmpCode { get; set; }
        public string SNO { get; set; }
        


    }
    [WebMethod]
    public static List<EmployeeClass> SearchView(string EmpCode)
    {

        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("FNFECODE_SEARCH", con);
            cmd.Parameters.AddWithValue("@EmpCode", EmpCode);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 4800;
            con.Close();
            SqlDataAdapter SDA = new SqlDataAdapter(cmd);
            SDA.Fill(ds);
            dt = ds.Tables[0];
        }
        catch (Exception)
        {

        }
        List<EmployeeClass> Data = new List<EmployeeClass>();

        foreach (DataRow dtt in dt.Rows)
        {
            Data.Add(new EmployeeClass
            {
                EmpCode = dtt["EMP Code"].ToString(),
                EmpName = dtt["Name"].ToString(),

            });
        }

        return Data;
    }

    [WebMethod]
    public static List<EmployeeClass> SearchView2()
    {

        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("Z1FnFview", con);
            //cmd.Parameters.AddWithValue("@EmpCode", EmpCode);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 4800;
            con.Close();
            SqlDataAdapter SDA = new SqlDataAdapter(cmd);
            SDA.Fill(ds);
            dt = ds.Tables[0];
        }
        catch (Exception)
        {

        }
        List<EmployeeClass> Data = new List<EmployeeClass>();

        foreach (DataRow dtt in dt.Rows)
        {
            Data.Add(new EmployeeClass
            {
                //id = dtt["id"].ToString(),
                EmpCode = dtt["EMP Code"].ToString(),
                EmpName = dtt["Name"].ToString(),
                SNO = dtt["EMP Code"].ToString(),

            });
        }

        return Data;
    }
}