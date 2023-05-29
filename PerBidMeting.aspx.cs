using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class PerBidMeting : System.Web.UI.Page
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public class classMonth
    {

        public string Tender_Name { get; set; }
    }
    [WebMethod]
    public static List<classMonth> GetNameprebidtender(string Name)
    {
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();

            cmd = new SqlCommand("GetTenderPrebidName", con);
            cmd.Parameters.AddWithValue("@Name", Name);
            cmd.Parameters.AddWithValue("@Type", "A");
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

                Tender_Name = dtt["TerName"].ToString(),
            });
        }

        return Data;
    }
    // GetVname
    public class NameList
    {
        public string Tender_Name { get; set; }
        public string Company_Name { get; set; }


    }
    [WebMethod]
    public static List<NameList> PrebidtenderDetails(string Name)
    {
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            cmd = new SqlCommand("GetTenderPrebidName", con);
            cmd.Parameters.AddWithValue("@Name", Name);
            cmd.Parameters.AddWithValue("@Type", "B");
            con.Open();
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
        List<NameList> Data = new List<NameList>();

        foreach (DataRow dtt in dt.Rows)
        {
            Data.Add(new NameList
            {
                Tender_Name = dtt["Tender_Name"].ToString(),
                Company_Name = dtt["Company_Name"].ToString(),

            });
        }

        return Data;
    }
}