using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
using System.Web.Script.Services;
using System.Xml.Linq;
using System.Net.Mail;
using System.Net;

public partial class Finance_PreBidMeeting : System.Web.UI.Page
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public class ItemClass
    {
        public string Tender_Name { get; set; }
        public string Company_Name { get; set; }
        public string AttenderName { get; set; }
        public string Discussion { get; set; }
        public string OurQuery { get; set; }
        public string Status { get; set; }
        public string MeetingDate { get; set; }
        public string T_MeetingFile { get; set; }
        public string Other_CompanyName { get; set; }
        public string Other_CompanyQuery { get; set; }
        public string file { get; set; }

        public int id { get; set; }
        public int Mid { get; set; }
    }
    [WebMethod]
    public static List<ItemClass> SaveReqSlipItemp(string Tender_Name, string Company_Name, string AttenderName, string Discussion, string OurQuery,
     string Status, string MeetingDate, string T_MeetingFile, string Other_CompanyName, string Other_CompanyQuery, string file)
    {
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("SavePreBidMeeting2", con);
            cmd.Parameters.AddWithValue("@Tender_Name", Tender_Name);
            cmd.Parameters.AddWithValue("@Company_Name", Company_Name);
            cmd.Parameters.AddWithValue("@AttenderName", AttenderName);
            cmd.Parameters.AddWithValue("@Discussion", Discussion);
            cmd.Parameters.AddWithValue("@OurQuery", OurQuery);
            cmd.Parameters.AddWithValue("@Status", Status);
            cmd.Parameters.AddWithValue("@MeetingDate", MeetingDate);
            cmd.Parameters.AddWithValue("@T_MeetingFile", T_MeetingFile);
            cmd.Parameters.AddWithValue("@Other_CompanyName", Other_CompanyName);
            cmd.Parameters.AddWithValue("@Other_CompanyQuery", Other_CompanyQuery);
            cmd.Parameters.AddWithValue("@Other_CompFile", file);
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
        List<ItemClass> Data = new List<ItemClass>();

        foreach (DataRow dtt in dt.Rows)
        {
            Data.Add(new ItemClass
            {

                Mid = int.Parse(dtt["Mid"].ToString()),
                id = int.Parse(dtt["id"].ToString()),
                Tender_Name = dtt["Tender_Name"].ToString(),
                Company_Name = dtt["Company_Name"].ToString(),
                AttenderName = dtt["AttenderName"].ToString(),
                Discussion = dtt["Discussion"].ToString(),
                OurQuery = dtt["OurQuery"].ToString(),
                Status = dtt["Status"].ToString(),
                MeetingDate = dtt["MeetingDate"].ToString(),
                T_MeetingFile = dtt["T_MeetingFile"].ToString(),
                Other_CompanyName = dtt["Other_CompanyName"].ToString(),
                Other_CompanyQuery = dtt["Other_CompanyQuery"].ToString(),
                file = dtt["Other_CompFile"].ToString(),
            });
        }

        return Data;
    }
}