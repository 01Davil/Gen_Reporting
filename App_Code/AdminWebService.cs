using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;


/// <summary>
/// Summary description for AdminWebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class AdminWebService : System.Web.Services.WebService
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    public AdminWebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }
    [WebMethod]
    public void GetLeaveSummery()
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
            SqlCommand cmd = new SqlCommand("Admin_GetLeaveSummery", con);
            cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
            cmd.Parameters.Add("@Emp", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Emp"];
            cmd.Parameters.Add("@MonthNo", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["MonthNo"];
            cmd.Parameters.Add("@Type", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Type"];
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
    public void ApproveLevae()
    {
        int UserTypeId;
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("Admin_ApprovedLeave", con);
            cmd.Parameters.AddWithValue("@Sno", HttpContext.Current.Request.Form["Sno"]);
            cmd.Parameters.AddWithValue("@Name", HttpContext.Current.Request.Form["Name"]);
            cmd.Parameters.AddWithValue("@id", HttpContext.Current.Request.Form["id"]);
            cmd.Parameters.AddWithValue("@Status", HttpContext.Current.Request.Form["Status"]);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            con.Close();
            UserTypeId = 1;
        }
        catch (SqlException)
        {
            UserTypeId = 404;
        }
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(UserTypeId);
        HttpContext.Current.Response.Flush();
    }

    /// GetApplyWFH
    /// 
    [WebMethod]
    public void GetApplyWFH()
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
            con.Open();
            SqlCommand cmd = new SqlCommand("Admin_GetApplyWFH", con);
            cmd.Parameters.Add("@Emp_Email", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Emp"];
            cmd.Parameters.Add("@MonthNo", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["MonthNo"];
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
    // UpdateWFHStatus

    [WebMethod]
    public void UpdateWFHStatus()
    {
        int UserTypeId;
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("Admin_ApprovedWFH", con);
            cmd.Parameters.AddWithValue("@Sno", HttpContext.Current.Request.Form["Sno"]);
            cmd.Parameters.AddWithValue("@Name", HttpContext.Current.Request.Form["Name"]);
            cmd.Parameters.AddWithValue("@id", HttpContext.Current.Request.Form["id"]);
            cmd.Parameters.AddWithValue("@Status", HttpContext.Current.Request.Form["Status"]);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            con.Close();
            UserTypeId = 1;
        }
        catch (SqlException)
        {
            UserTypeId = 404;
        }
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(UserTypeId);
        HttpContext.Current.Response.Flush();
    }
    // 
    [WebMethod]
    public void DeleteExpenese()
    {
        string Result = "";
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand(" delete from Apply_Expenese where id = '" + HttpContext.Current.Request.Form["id"] + "'", con);
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
    /// GetHoliDayList
    /// 
    [WebMethod]
    public void GetHoliDayList()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        string d = HttpContext.Current.Request.Form["Sno"];
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("Master_GetHoliDayList", con);
            cmd.Parameters.Add("@Type", SqlDbType.VarChar).Value = "All";
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

    // 
    [WebMethod]
    public void GetActivityStatus()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();        
        string z = HttpContext.Current.Request.Form["roleid"];
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("Master_GetActivityStatus", con);            
            cmd.Parameters.AddWithValue("@roleid", z);
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

    // get complete project 
    [WebMethod]
    public void GetCompleteProject()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        string y = HttpContext.Current.Request.Form["type"];
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("Master_GetProjectStatus", con);
            cmd.Parameters.AddWithValue("@type", y);
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
    ///


    [WebMethod]
    public void GetLeaveReport()
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
            con.Open();
            SqlCommand cmd = new SqlCommand("Admin_LeaveReport", con);
            cmd.Parameters.AddWithValue("@Year", HttpContext.Current.Request.Form["Year"]);
            cmd.Parameters.AddWithValue("@MonthNo", HttpContext.Current.Request.Form["Month"]);
            cmd.Parameters.AddWithValue("@EmilID", HttpContext.Current.Request.Form["EmailID"]);
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

    // ShowAdjustLeaveDay

    [WebMethod]
    public void ShowAdjustLeaveDay()
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
            con.Open();
            SqlCommand cmd = new SqlCommand("Admin_AdjustLeave", con);
            cmd.Parameters.AddWithValue("@EmailID", HttpContext.Current.Request.Form["EmailID"]);
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
    // SaveAdjustLeaveDay

    [WebMethod]
    public void SaveAdjustLeaveDay()
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
            con.Open();
            SqlCommand cmd = new SqlCommand("Admin_Set_AdjustLeave", con);
            cmd.Parameters.AddWithValue("@LoginSno", HttpContext.Current.Request.Form["LoginSno"]);
            cmd.Parameters.AddWithValue("@EmpSno", HttpContext.Current.Request.Form["EmpSno"]);
            cmd.Parameters.AddWithValue("@DayNo", HttpContext.Current.Request.Form["DayNo"]);
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

    // dashboard work 
    //Attendance Status
    [WebMethod]
    public void EmployeeStatusAllType()
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
            con.Open();
            SqlCommand cmd = new SqlCommand("Admin_Dashboard_Details", con);
            cmd.Parameters.AddWithValue("@Type", HttpContext.Current.Request.Form["Type"]);
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
