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

public partial class TenderDetailsList : System.Web.UI.Page
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public class ListEmployee
    {
        public string id { get; set; }
        public string Tender_Name { get; set; }
        public string Company_Name { get; set; }
        public string T_Publication_Date { get; set; }
        public string T_PreBidMeetingDate { get; set; }
        public string T_SubmittingDate { get; set; }
        public string Extended_SubmissionDate { get; set; }
        public string OpeningDate { get; set; }
        public string T_Item { get; set; }
        public string T_Quantity { get; set; }
        public string T_Location { get; set; }
        public string T_File { get; set; }
        public string T_Source { get; set; }
        
    }


    [WebMethod]
    public static List<ListEmployee> show_TenderDetails()
    {
        DataTable dt = new DataTable();
        DataTable ndt = new DataTable();
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection(conn);

        try
        {
            cmd = new SqlCommand("Select * from Master_TenderDetails", con);

        //    cmd.CommandType = CommandType.StoredProcedure;
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
                id = dttt["id"].ToString(),
                Tender_Name = dttt["Tender_Name"].ToString(),
                Company_Name = dttt["Company_Name"].ToString(),
                T_Publication_Date = dttt["T_Publication_Date"].ToString(),
                T_PreBidMeetingDate = dttt["T_PreBidMeetingDate"].ToString(),
                T_SubmittingDate = dttt["T_SubmittingDate"].ToString(),
                Extended_SubmissionDate = dttt["Extended_SubmissionDate"].ToString(),
                OpeningDate = dttt["OpeningDate"].ToString(),
                T_Item = dttt["T_Item"].ToString(),
                T_Quantity = dttt["T_Quantity"].ToString(),
                T_Location = dttt["T_Location"].ToString(),
                T_File = dttt["T_File"].ToString(),
                T_Source = dttt["T_Source"].ToString(),

            });
        }
        return Data;


    }

//Win Model
    [WebMethod]
    public static List<ListEmployee> getTenderData(string Id)
    {
        DataTable dt = new DataTable();
        DataTable ndt = new DataTable();
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection(conn);

        try
        {
            cmd = new SqlCommand("GetTenderData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", Id);
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
                id = dttt["Id"].ToString(),
                Tender_Name = dttt["Tender_Name"].ToString(),
                T_Item = dttt["T_Item"].ToString(),
                T_Quantity = dttt["T_Quantity"].ToString(),

            });
        }
        return Data;


    }



    [WebMethod]
    public static string SaveWinTender(string Tender_Name, string Tender_Item, string T_Quantity,string Price, string Delivery_Date, string Delivery_Location,string L1_Our_Company, string L1_Bid_Price, string L2_Second_Com,string L2_Bid_Price, string L3_Third_Comany,string L3_Bid_Price)
    {
        try
        {
            SqlConnection con = new SqlConnection(conn);
            SqlCommand cmd = new SqlCommand("SaveWin_TenderData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Tender_Name", Tender_Name);
            cmd.Parameters.AddWithValue("@Tender_Item", Tender_Item);
            cmd.Parameters.AddWithValue("@T_Quantity", T_Quantity);
            cmd.Parameters.AddWithValue("@Price", Price);
            cmd.Parameters.AddWithValue("@Delivery_Date", Delivery_Date);
            cmd.Parameters.AddWithValue("@Delivery_Location", Delivery_Location);
            cmd.Parameters.AddWithValue("@L1_Our_Company", L1_Our_Company);
            cmd.Parameters.AddWithValue("@L1_Bid_Price", L1_Bid_Price);
            cmd.Parameters.AddWithValue("@L2_Second_Com", L2_Second_Com);
            cmd.Parameters.AddWithValue("@L2_Bid_Price", L2_Bid_Price);
            cmd.Parameters.AddWithValue("@L3_Third_Comany", L3_Third_Comany);
            cmd.Parameters.AddWithValue("@L3_Bid_Price", L3_Bid_Price);

            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            return "Success:";
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
    }



    //Lost Model
    [WebMethod]
    public static List<ListEmployee> getTenderDataInLost(string Id)
    {
        DataTable dt = new DataTable();
        DataTable ndt = new DataTable();
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection(conn);

        try
        {
            cmd = new SqlCommand("GetTenderData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", Id);
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
                id = dttt["Id"].ToString(),
                Tender_Name = dttt["Tender_Name"].ToString(),
                T_Item = dttt["T_Item"].ToString(),
                T_Quantity = dttt["T_Quantity"].ToString(),

            });
        }
        return Data;


    }

//ConfigurationSaveMode Lost data

    [WebMethod]
    public static string SaveLostTender(string Tender_Name, string Tender_Item, string T_Quantity, string Price, string Delivery_Date, string L1_Winner_Company, string L1_Bid_Price, string L2_Second_Com, string L2_Bid_Price, string L3_Third_Comany, string L3_Bid_Price, string OurPosition, string Our_Bid_Price)
    {
        try
        {
            SqlConnection con = new SqlConnection(conn);
            SqlCommand cmd = new SqlCommand("SaveLost_TenderData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Tender_Name", Tender_Name);
            cmd.Parameters.AddWithValue("@Tender_Item", Tender_Item);
            cmd.Parameters.AddWithValue("@T_Quantity", T_Quantity);
            cmd.Parameters.AddWithValue("@Price", Price);
            cmd.Parameters.AddWithValue("@Delivery_Date", Delivery_Date);

            cmd.Parameters.AddWithValue("@L1_Winner_Company", L1_Winner_Company);
            cmd.Parameters.AddWithValue("@L1_Bid_Price", L1_Bid_Price);
            cmd.Parameters.AddWithValue("@L2_Second_Com", L2_Second_Com);
            cmd.Parameters.AddWithValue("@L2_Bid_Price", L2_Bid_Price);
            cmd.Parameters.AddWithValue("@L3_Third_Comany", L3_Third_Comany);
            cmd.Parameters.AddWithValue("@L3_Bid_Price", L3_Bid_Price);
            cmd.Parameters.AddWithValue("@OurPosition", OurPosition);
            cmd.Parameters.AddWithValue("@Our_Bid_Price", Our_Bid_Price);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            return "Success:";
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
    }
}