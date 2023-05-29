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
public partial class TenderDetails : System.Web.UI.Page
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
 
    
    [WebMethod]
    public static string SaveEmployeeData(string Tender_Name, string Company_Name, string T_Publication_Date, string T_PreBidMeetingDate, string T_SubmittingDate, string T_ExtendSubDate, string OpeningDate, string T_Item, string T_Quantity, string T_Location, string T_File, string T_Source)
    {
        try
        {
            SqlConnection con = new SqlConnection(conn);
            SqlCommand cmd = new SqlCommand("Tender_Details",con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Tender_Name", Tender_Name);
            cmd.Parameters.AddWithValue("@Company_Name", Company_Name);
            cmd.Parameters.AddWithValue("@T_Publication_Date", T_Publication_Date);
            cmd.Parameters.AddWithValue("@T_PreBidMeetingDate", T_PreBidMeetingDate);
             cmd.Parameters.AddWithValue("@T_SubmittingDate", T_SubmittingDate);
             cmd.Parameters.AddWithValue("@Extended_SubmissionDate", T_ExtendSubDate);
            cmd.Parameters.AddWithValue("@OpeningDate", OpeningDate);
            cmd.Parameters.AddWithValue("@T_Item", T_Item);
            cmd.Parameters.AddWithValue("@T_Quantity", T_Quantity);
            cmd.Parameters.AddWithValue("@T_Location", T_Location);
            cmd.Parameters.AddWithValue("@T_File", T_File);
            cmd.Parameters.AddWithValue("@T_Source", T_Source);
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