using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.Script.Services;


/// <summary>
/// Summary description for TenderWebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class TenderWebService : System.Web.Services.WebService
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    SqlConnection con = new SqlConnection(conn);
    DataTable dt;
    SqlCommand cmd;
    SqlDataReader reader;
    public TenderWebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }


    //-- @Price

    [WebMethod]
    public void SaveTender()
    {
        string Result = "";
        string Tender_Name = HttpContext.Current.Request.Form["Tender_Name"];
        string Company_Name = HttpContext.Current.Request.Form["Company_Name"];
        string T_Publication_Date = HttpContext.Current.Request.Form["T_Publication_Date"];
        string T_PreBidMeetingDate = HttpContext.Current.Request.Form["T_PreBidMeetingDate"];
        string T_SubmittingDate = HttpContext.Current.Request.Form["T_SubmittingDate"];
        string T_ExtendSubDate = HttpContext.Current.Request.Form["T_ExtendSubDate"];
        string OpeningDate = HttpContext.Current.Request.Form["OpeningDate"];
        string T_Item = HttpContext.Current.Request.Form["T_Item"];
        string T_Quantity = HttpContext.Current.Request.Form["T_Quantity"];
        string Price = HttpContext.Current.Request.Form["Price"];
        string T_Location = HttpContext.Current.Request.Form["T_Location"];
        string T_Source = HttpContext.Current.Request.Form["T_Source"];
        string Gpath = HttpContext.Current.Server.MapPath("~/UploadFile/TenderUploadFile/");

        if (!Directory.Exists(Gpath))
        {
            Directory.CreateDirectory(Gpath);
        }
        int fileCount = Directory.GetFiles(Gpath, "*.*", SearchOption.AllDirectories).Length;
        HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];
        string UName = Tender_Name + fileCount + Path.GetExtension(postedFile.FileName);
        string MPath = Gpath + UName;
        postedFile.SaveAs(MPath);
        UName = "https://genesiscloudapps.com/Gen_Reporting/GenReporting/UploadFile/TenderUploadFile/" + UName;
        // 
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("Tender_Details", con);
            cmd.Parameters.AddWithValue("@Tender_Name", Tender_Name);
            cmd.Parameters.AddWithValue("@Company_Name", Company_Name);
            cmd.Parameters.AddWithValue("@T_Publication_Date", T_Publication_Date);
            cmd.Parameters.AddWithValue("@T_PreBidMeetingDate", T_PreBidMeetingDate);
            cmd.Parameters.AddWithValue("@T_SubmittingDate", T_SubmittingDate);
            cmd.Parameters.AddWithValue("@Extended_SubmissionDate", T_ExtendSubDate);
            cmd.Parameters.AddWithValue("@OpeningDate", OpeningDate);
            cmd.Parameters.AddWithValue("@T_Item", T_Item);
            cmd.Parameters.AddWithValue("@T_Quantity", T_Quantity);
            cmd.Parameters.AddWithValue("@Price", Price);
            cmd.Parameters.AddWithValue("@T_Location", T_Location);
            cmd.Parameters.AddWithValue("@T_Source", T_Source);
            cmd.Parameters.AddWithValue("@T_File", UName);


            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            con.Close();
            Result = "Save";
        }
        catch (SqlException)
        {
            Result = "Not";
        }
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(Result);
        HttpContext.Current.Response.Flush();
    }


    [WebMethod]
    public void GetTenderList()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();

        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            string s = HttpContext.Current.Request.Form["Sno"];
            con.Open();
            SqlCommand cmd = new SqlCommand("Select id,Tender_Name,Company_Name,convert(varchar ,T_Publication_Date,105) as T_Publication_Date ,convert(varchar,T_SubmittingDate,105)as T_SubmittingDate,convert(varchar,OpeningDate,105)as OpeningDate,convert(varchar,T_PreBidMeetingDate,105) as T_PreBidMeetingDate,convert(varchar,Extended_SubmissionDate,105)as Extended_SubmissionDate,T_Item,T_Quantity,Price,T_Location,T_File,T_Source,(case when status=0 then 'Pending' when status = 1 then 'Win' else 'Lose' end) status,DbDateTime from Master_TenderDetails", con);
            //cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
            //cmd.Parameters.Add("@Type", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Type"];
            cmd.CommandType = CommandType.Text;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dt = new DataTable();
            dt = ds.Tables[0];

            List<Dictionary<String, Object>> tableRows = new List<Dictionary<string, object>>();
            Dictionary<String, Object> row;
            row = new Dictionary<string, object>();
            if (dt.Rows.Count > 0)
            {

                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col].ToString());
                    }
                    tableRows.Add(row);
                }
                resultJSON = serializer.Serialize(tableRows).ToString();

            }
            else
            {
                row.Add("response", "Fail");
                tableRows.Add(row);
                resultJSON = serializer.Serialize(tableRows).ToString();

            }
        }

        catch (Exception ex)
        {
            resultJSON = ex.Message.ToString();
        }
        finally
        {
            con.Close();
        }
        Context.Response.Write(resultJSON);

    }


    [WebMethod]
    public void GetTenderDataWin()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();

        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            string s = HttpContext.Current.Request.Form["id"];
            con.Open();
            SqlCommand cmd = new SqlCommand("GetTenderData", con);
            cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["id"];
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dt = new DataTable();
            dt = ds.Tables[0];

            List<Dictionary<String, Object>> tableRows = new List<Dictionary<string, object>>();
            Dictionary<String, Object> row;
            row = new Dictionary<string, object>();
            if (dt.Rows.Count > 0)
            {

                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col].ToString());
                    }
                    tableRows.Add(row);
                }
                resultJSON = serializer.Serialize(tableRows).ToString();

            }
            else
            {
                row.Add("response", "Fail");
                tableRows.Add(row);
                resultJSON = serializer.Serialize(tableRows).ToString();

            }
        }

        catch (Exception ex)
        {
            resultJSON = ex.Message.ToString();
        }
        finally
        {
            con.Close();
        }
        Context.Response.Write(resultJSON);

    }




    [WebMethod]
    public void SaveWinTenderDetails()
    {
        string Result = "";
        string Tender_Name = HttpContext.Current.Request.Form["Tender_Name"];
        string Tender_Item = HttpContext.Current.Request.Form["Tender_Item"];
        string T_Quantity = HttpContext.Current.Request.Form["T_Quantity"];
        string Price = HttpContext.Current.Request.Form["Price"];
        string Delivery_Date = HttpContext.Current.Request.Form["Delivery_Date"];
        string Delivery_Location = HttpContext.Current.Request.Form["Delivery_Location"];
        string L1_Our_Company = HttpContext.Current.Request.Form["L1_Our_Company"];
        string L1_Bid_Price = HttpContext.Current.Request.Form["L1_Bid_Price"];
        string L2_Second_Com = HttpContext.Current.Request.Form["L2_Second_Com"];
        string L2_Bid_Price = HttpContext.Current.Request.Form["L2_Bid_Price"];
        string L3_Third_Comany = HttpContext.Current.Request.Form["L3_Third_Comany"];
        string L3_Bid_Price = HttpContext.Current.Request.Form["L3_Bid_Price"];
        // 
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("SaveWin_TenderData", con);
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
            cmd.ExecuteNonQuery();
            con.Close();
            Result = "Save";
        }
        catch (SqlException)
        {
            Result = "Not";
        }
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(Result);
        HttpContext.Current.Response.Flush();
    }


    //save Lost tender details
    [WebMethod]
    public void SaveLostTenderDetails()
    {
        string Result = "";
        string Tender_Name = HttpContext.Current.Request.Form["Tender_Name"];
        string Tender_Item = HttpContext.Current.Request.Form["Tender_Item"];
        string T_Quantity = HttpContext.Current.Request.Form["T_Quantity"];
        string Price = HttpContext.Current.Request.Form["Price"];
        string Delivery_Date = HttpContext.Current.Request.Form["Delivery_Date"];

        string L1_Winner_Company = HttpContext.Current.Request.Form["L1_Winner_Company"];
        string L1_Bid_Price = HttpContext.Current.Request.Form["L1_Bid_Price"];
        string L2_Second_Com = HttpContext.Current.Request.Form["L2_Second_Com"];
        string L2_Bid_Price = HttpContext.Current.Request.Form["L2_Bid_Price"];
        string L3_Third_Comany = HttpContext.Current.Request.Form["L3_Third_Comany"];
        string L3_Bid_Price = HttpContext.Current.Request.Form["L3_Bid_Price"];
        string OurPosition = HttpContext.Current.Request.Form["OurPosition"];
        string Our_Bid_Price = HttpContext.Current.Request.Form["Our_Bid_Price"];



        // 
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("SaveLost_TenderData", con);
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
            cmd.ExecuteNonQuery();
            con.Close();
            Result = "Save";
        }
        catch (SqlException)
        {
            Result = "Not";
        }
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(Result);
        HttpContext.Current.Response.Flush();
    }



    [WebMethod]
    public void SaveOtherCPreBidMeeting()
    {
        string Result = "";
        string Tender_Name = HttpContext.Current.Request.Form["Tender_Name"];
        string Other_CompanyName = HttpContext.Current.Request.Form["Other_CompanyName"];
        string Other_CompanyQuery = HttpContext.Current.Request.Form["Other_CompanyQuery"];
        string Gpath = HttpContext.Current.Server.MapPath("~/UploadFile/TenderMeetingFile/");

        if (!Directory.Exists(Gpath))
        {
            Directory.CreateDirectory(Gpath);
        }
        int fileCount = Directory.GetFiles(Gpath, "*.*", SearchOption.AllDirectories).Length;
        HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];
        string UName = Tender_Name + fileCount + Path.GetExtension(postedFile.FileName);
        string MPath = Gpath + UName;
        postedFile.SaveAs(MPath);
        UName = "https://genesiscloudapps.com/Gen_Reporting/GenReporting/UploadFile/TenderMeetingFile/" + UName;

        // 
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("T_OtherDataPrebMeeting", con);
            cmd.Parameters.AddWithValue("@Tender_Name", Tender_Name);
            cmd.Parameters.AddWithValue("@Other_CompanyName", Other_CompanyName);
            cmd.Parameters.AddWithValue("@Other_CompanyQuery", Other_CompanyQuery);
            cmd.Parameters.AddWithValue("@Other_CompFile", UName);


            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            con.Close();
            Result = "Save";
        }
        catch (SqlException)
        {
            Result = "Not";
        }
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(Result);
        HttpContext.Current.Response.Flush();
    }

    [WebMethod]
    public void SavePreBidMeeting()
    {
        string Result = "";
        string Tender_Name = HttpContext.Current.Request.Form["Tender_Name"];
        string Company_Name = HttpContext.Current.Request.Form["Company_Name"];
        string AttenderName = HttpContext.Current.Request.Form["AttenderName"];
        string Discussion = HttpContext.Current.Request.Form["Discussion"];
        string OurQuery = HttpContext.Current.Request.Form["OurQuery"];
        string Status = HttpContext.Current.Request.Form["Status"];
        string MeetingDate = HttpContext.Current.Request.Form["MeetingDate"];
        string Gpath = HttpContext.Current.Server.MapPath("~/UploadFile/TenderMeetingFile/");
        string Other_CompanyName = HttpContext.Current.Request.Form["Other_CompanyName"];
        string Other_CompanyQuery = HttpContext.Current.Request.Form["Other_CompanyQuery"];
        string Gpath1 = HttpContext.Current.Server.MapPath("~/UploadFile/TenderMeetingFile/");

        if (!Directory.Exists(Gpath))
        {
            Directory.CreateDirectory(Gpath);
        }
        int fileCount = Directory.GetFiles(Gpath, "*.*", SearchOption.AllDirectories).Length;
        HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];
        string UName = Tender_Name + fileCount + Path.GetExtension(postedFile.FileName);
        string MPath = Gpath + UName;
        postedFile.SaveAs(MPath);
        UName = "https://genesiscloudapps.com/Gen_Reporting/GenReporting/UploadFile/TenderMeetingFile/" + UName;

        // 
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("SavePreBidMeeting", con);
            cmd.Parameters.AddWithValue("@Tender_Name", Tender_Name);
            cmd.Parameters.AddWithValue("@Company_Name", Company_Name);
            cmd.Parameters.AddWithValue("@AttenderName", AttenderName);
            cmd.Parameters.AddWithValue("@Discussion", Discussion);
            cmd.Parameters.AddWithValue("@OurQuery", OurQuery);
            cmd.Parameters.AddWithValue("@Status", Status);
            cmd.Parameters.AddWithValue("@MeetingDate", MeetingDate);
            cmd.Parameters.AddWithValue("@T_MeetingFile", UName);
            //cmd.Parameters.AddWithValue("@Other_CompanyName", Other_CompanyName);
            //cmd.Parameters.AddWithValue("@Other_CompanyQuery", Other_CompanyQuery);
            //cmd.Parameters.AddWithValue("@Other_CompFile", UName);


            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            con.Close();
            Result = "Save";
        }
        catch (SqlException)
        {
            Result = "Not";
        }
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(Result);
        HttpContext.Current.Response.Flush();
    }




    [WebMethod]
    public void GetWinTenderList()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();

        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            string s = HttpContext.Current.Request.Form["Sno"];
            con.Open();
            SqlCommand cmd = new SqlCommand("select Id,Tender_Name,Tender_Item,T_Quantity,Price,convert(varchar ,Delivery_Date,105) as Delivery_Date,Delivery_Location,L1_Our_Company,L1_Bid_Price,L2_Second_Com,L2_Bid_Price,L3_Third_Comany,L3_Bid_Price from Win_TenderDetails", con);
            //cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
            //cmd.Parameters.Add("@Type", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Type"];
            //cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dt = new DataTable();
            dt = ds.Tables[0];

            List<Dictionary<String, Object>> tableRows = new List<Dictionary<string, object>>();
            Dictionary<String, Object> row;
            row = new Dictionary<string, object>();
            if (dt.Rows.Count > 0)
            {

                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col].ToString());
                    }
                    tableRows.Add(row);
                }
                resultJSON = serializer.Serialize(tableRows).ToString();

            }
            else
            {
                row.Add("response", "Fail");
                tableRows.Add(row);
                resultJSON = serializer.Serialize(tableRows).ToString();

            }
        }

        catch (Exception ex)
        {
            resultJSON = ex.Message.ToString();
        }
        finally
        {
            con.Close();
        }
        Context.Response.Write(resultJSON);

    }
    [WebMethod]
    public void GetLostTenderList()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();

        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            string s = HttpContext.Current.Request.Form["Sno"];
            con.Open();
            SqlCommand cmd = new SqlCommand("select Id,Tender_Name,Tender_Item,T_Quantity,Price,convert(varchar ,Delivery_Date,105) as Delivery_Date,L1_Winner_Company,L1_Bid_Price,L2_Second_Comp,L2_Bid_Price,L3_Third_Company,L3_Bid_Price,OurPosition,Our_Bid_Price from Lost_TenderDetails", con);
            //cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
            //cmd.Parameters.Add("@Type", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Type"];
            //cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dt = new DataTable();
            dt = ds.Tables[0];

            List<Dictionary<String, Object>> tableRows = new List<Dictionary<string, object>>();
            Dictionary<String, Object> row;
            row = new Dictionary<string, object>();
            if (dt.Rows.Count > 0)
            {

                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col].ToString());
                    }
                    tableRows.Add(row);
                }
                resultJSON = serializer.Serialize(tableRows).ToString();

            }
            else
            {
                row.Add("response", "Fail");
                tableRows.Add(row);
                resultJSON = serializer.Serialize(tableRows).ToString();

            }
        }

        catch (Exception ex)
        {
            resultJSON = ex.Message.ToString();
        }
        finally
        {
            con.Close();
        }
        Context.Response.Write(resultJSON);

    }



    [WebMethod]
    public void GetPendingTenderList()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();

        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            string s = HttpContext.Current.Request.Form["Sno"];
            con.Open();
            SqlCommand cmd = new SqlCommand("PendingTenderDetails", con);
            //cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
            //cmd.Parameters.Add("@Type", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Type"];
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dt = new DataTable();
            dt = ds.Tables[0];

            List<Dictionary<String, Object>> tableRows = new List<Dictionary<string, object>>();
            Dictionary<String, Object> row;
            row = new Dictionary<string, object>();
            if (dt.Rows.Count > 0)
            {

                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col].ToString());
                    }
                    tableRows.Add(row);
                }
                resultJSON = serializer.Serialize(tableRows).ToString();

            }
            else
            {
                row.Add("response", "Fail");
                tableRows.Add(row);
                resultJSON = serializer.Serialize(tableRows).ToString();

            }
        }

        catch (Exception ex)
        {
            resultJSON = ex.Message.ToString();
        }
        finally
        {
            con.Close();
        }
        Context.Response.Write(resultJSON);

    }


    [WebMethod]
    public void PreBidMeetingTenderList()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();

        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            string Tender_Name = HttpContext.Current.Request.Form["Tender_Name"];
            con.Open();
            SqlCommand cmd = new SqlCommand("GetPreBidMeetingList", con);
            cmd.Parameters.Add("@Tender_Name", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Tender_Name"];
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dt = new DataTable();
            dt = ds.Tables[0];

            List<Dictionary<String, Object>> tableRows = new List<Dictionary<string, object>>();
            Dictionary<String, Object> row;
            row = new Dictionary<string, object>();
            if (dt.Rows.Count > 0)
            {

                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col].ToString());
                    }
                    tableRows.Add(row);
                }
                resultJSON = serializer.Serialize(tableRows).ToString();

            }
            else
            {
                row.Add("response", "Fail");
                tableRows.Add(row);
                resultJSON = serializer.Serialize(tableRows).ToString();

            }
        }

        catch (Exception ex)
        {
            resultJSON = ex.Message.ToString();
        }
        finally
        {
            con.Close();
        }
        Context.Response.Write(resultJSON);

    }
}
