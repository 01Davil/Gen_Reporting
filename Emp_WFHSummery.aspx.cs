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

public partial class Emp_WFHSummery : System.Web.UI.Page
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public class classMonth
    {
        public string MonthNo { get; set; }
        public string MonthName { get; set; }
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
                MonthNo = dtt["id"].ToString(),
                MonthName = dtt["mname"].ToString(),
            });
        }

        return Data;
    }
}