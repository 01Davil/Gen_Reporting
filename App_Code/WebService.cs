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

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    SqlConnection con = new SqlConnection(conn);
    SqlCommand cmd;
    JavaScriptSerializer js = new JavaScriptSerializer();
    JavaScriptSerializer serializer = new JavaScriptSerializer();
    public WebService()
    {
        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }
    
    /// <summary>
    /// View WFH Leave
    /// </summary>
    [WebMethod]
    public void Get_WFH()
    {
        String resultJSON = "";
        DataTable dt;
        string from = "NA";
        string to = "NA";
        string fromto = HttpContext.Current.Request.Form["Date"]; 
        if (fromto != "NA")
        {
            fromto = fromto.Replace("\n", "");
            fromto = fromto.Replace(" ", "").Trim();
            string[] arr = fromto.Split('-');
            from = arr[0].ToString();
            to = arr[1].ToString();
        }
        try
        {
            string s = HttpContext.Current.Request.Form["TDate"];
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("Get_WFH", con);
            cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
            cmd.Parameters.Add("@FDate", SqlDbType.VarChar).Value = from;
            cmd.Parameters.Add("@TDate", SqlDbType.VarChar).Value = to;
            cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Email"];
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
    /// <summary>
    /// Get Employee NameList
    /// </summary>
    [WebMethod]
    public void Get_EmployeOfficeEmailList()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("Get_EmployeOfficeEmailList", con);
            cmd.Parameters.Add("@Name", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Num"];
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dt = new DataTable();
            dt = ds.Tables[0];

            JavaScriptSerializer serializer = new JavaScriptSerializer();
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
    
    /// <summary>
    ///  Approval WFH Leave 
    /// </summary>
    [WebMethod]
    public void UpdateWFHStatus()
    {
        string Ret = "";
        SqlConnection con = new SqlConnection(conn);
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("UpdateWFHStatus", con);
            cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
            cmd.Parameters.Add("@Status", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Status"];
            cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Id"];
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            con.Close();
            Ret = "Save";
        }
        catch (SqlException d)
        {
            Ret = d.Message.ToString();
        }

        List<Dictionary<String, Object>> tableRows = new List<Dictionary<string, object>>();
        Dictionary<String, Object> row;
        row = new Dictionary<string, object>();
        row.Add("response", Ret);
        tableRows.Add(row);
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        String resultJSON = serializer.Serialize(tableRows).ToString();
        Context.Response.Write(resultJSON);
    }
    /// <summary>
    /// Get Employee Attendance
    /// </summary>
    [WebMethod]
    public void GetAttendance()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        string fromto = HttpContext.Current.Request.Form["Date"];
        string from = "";
        string To = "";
        if (fromto == "NA")
        {
            from = "NA";
            To = "NA";
        }
        else
        {
            fromto = fromto.Replace("\n", "");
            fromto = fromto.Replace(" ", "").Trim();
            string[] arr = fromto.Split('-');
            from = arr[0].ToString();
            To = arr[1].ToString();
        }
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("GetAttendance", con);
            cmd.Parameters.Add("@AttendanceType", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["AttendanceType"];
            cmd.Parameters.Add("@EmpEmail", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["EmpEmail"];
            cmd.Parameters.Add("@From", SqlDbType.VarChar).Value = from;
            cmd.Parameters.Add("@To", SqlDbType.VarChar).Value = To;
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
            string s = ex.Message.ToString();
            resultJSON = ex.Message.ToString();
        }
        finally
        {
            con.Close();
        }
        Context.Response.Write(resultJSON);

    }
    /// <summary>
    /// Get Apply Leave
    /// </summary>
    [WebMethod]
    public void GetApplyLeave()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        string from = "NA";
        string to = "NA";
        string fromto = HttpContext.Current.Request.Form["Date"];
        if (fromto != "NA" || fromto != "All")
        {
            from = "NA";
            to = "NA";
        }
        else
        {

            fromto = fromto.Replace("\n", "");
            fromto = fromto.Replace(" ", "").Trim();
            string[] arr = fromto.Split('-');
            from = arr[0].ToString();
            to = arr[1].ToString();
        }
        try
        {
            String Email = HttpContext.Current.Request.Form["Email"];
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("GetApplyLeave", con);
            cmd.Parameters.AddWithValue("@Sno", HttpContext.Current.Request.Form["Sno"]);
            cmd.Parameters.AddWithValue("@Email", Email);
            cmd.Parameters.AddWithValue("@FDate", from);
            cmd.Parameters.AddWithValue("@TDate", to);
            cmd.Parameters.AddWithValue("@LeavaType", HttpContext.Current.Request.Form["LeavaType"]);
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
    
    /// <summary>
    /// Approve Leave
    /// </summary>
    [WebMethod]
    public void ApproveLevae()
    {
        int UserTypeId;
        string n = HttpContext.Current.Request.Form["Status"];
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("ApproveLevae", con);
            cmd.Parameters.AddWithValue("@Sno", HttpContext.Current.Request.Form["Sno"]);
            cmd.Parameters.AddWithValue("@Name", HttpContext.Current.Request.Form["Name"]);
            cmd.Parameters.AddWithValue("@id", HttpContext.Current.Request.Form["Id"]);
            cmd.Parameters.AddWithValue("@Status", n);
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
    ///
    //
    // 
    ///
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
            SqlCommand cmd = new SqlCommand("AdjustLeave", con);
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
            cmd.Parameters.AddWithValue("@id", HttpContext.Current.Request.Form["id"]);
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
    [WebMethod]
    public void SaveAssignWork()
    {
        int UserTypeId;
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("Emp_SetAssignWork", con);
            cmd.Parameters.AddWithValue("@WorkEmail", HttpContext.Current.Request.Form["WorkEmail"]);
            cmd.Parameters.AddWithValue("@ProjectName", HttpContext.Current.Request.Form["ProjectName"]);
            cmd.Parameters.AddWithValue("@TaskName", HttpContext.Current.Request.Form["TaskName"]);
            cmd.Parameters.AddWithValue("@TaskDeaDline", HttpContext.Current.Request.Form["TaskDeaDline"]);
            cmd.Parameters.AddWithValue("@TaskDetails", HttpContext.Current.Request.Form["TaskDetails"]);
            cmd.Parameters.AddWithValue("@AssignEmail", HttpContext.Current.Request.Form["AssignEmail"]);
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

    [WebMethod]
    public void GetEmployeeDetails()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("Emp_GetEmployeeDetailsWork", con);
            cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Num"];
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dt = new DataTable();
            dt = ds.Tables[0];

            JavaScriptSerializer serializer = new JavaScriptSerializer();
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
    public void GetEmployeeAssignWorkList()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        string from = "NA";
        string to = "NA";
        string fromto = HttpContext.Current.Request.Form["Date"];
        if (fromto == "NA" || fromto == "All")
        {
            from = "NA";
            to = "NA";
        }
        else
        {

            fromto = fromto.Replace("\n", "");
            fromto = fromto.Replace(" ", "").Trim();
            string[] arr = fromto.Split('-');
            from = arr[0].ToString();
            to = arr[1].ToString();
        }
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("Emp_GetAssignWork", con);
            cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
            cmd.Parameters.Add("@EmpEmail", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["EmpEmail"];
            cmd.Parameters.Add("@FDate", SqlDbType.VarChar).Value = from;
            cmd.Parameters.Add("@TDate", SqlDbType.VarChar).Value = to;
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
    public void GetEmployeeAssignDetails()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        string from = "NA";
        string to = "NA";
        string fromto = HttpContext.Current.Request.Form["Date"];
        if (fromto == "NA" || fromto == "All")
        {
            from = "NA";
            to = "NA";
        }
        else
        {

            fromto = fromto.Replace("\n", "");
            fromto = fromto.Replace(" ", "").Trim();
            string[] arr = fromto.Split('-');
            from = arr[0].ToString();
            to = arr[1].ToString();
        }
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("Emp_GetMyTask", con);
            cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
            cmd.Parameters.Add("@Type", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Type"];
            cmd.Parameters.Add("@FDate", SqlDbType.VarChar).Value =from;
            cmd.Parameters.Add("@TDate", SqlDbType.VarChar).Value = to;
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
    public void UpdateAssignWork()
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
            SqlCommand cmd = new SqlCommand("Emp_UpdateAssignTask", con);
            cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
            cmd.Parameters.Add("@Id", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Id"];
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

    // GetWFHReport

    [WebMethod]
    public void GetWFHReport()
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
            SqlCommand cmd = new SqlCommand("GetWFHReport", con);
            cmd.Parameters.Add("@YearNo", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["YearNo"];
            cmd.Parameters.Add("@MonthNo", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["MonthNo"];
            cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Email"];
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

    // GetLeaveReport
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
            SqlCommand cmd = new SqlCommand("GetLeaveReport", con);
            cmd.Parameters.Add("@YearNo", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["YearNo"];
            cmd.Parameters.Add("@MonthNo", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["MonthNo"];
            cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Email"];
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

    // Check_Generated

    [WebMethod]
    public void Admin_Check_AttendanceGenerated()
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
            SqlCommand cmd = new SqlCommand("Admin_Check_AttendanceGenerated", con);
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

    //ApprovalAttendance

    [WebMethod]
    public void ApprovalAttendance()
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
            SqlCommand cmd = new SqlCommand("ApprovalAttendance", con);
            cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
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

    //Check_SalaryGenerated


    [WebMethod]
    public void Check_SalaryGenerated()
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
            SqlCommand cmd = new SqlCommand("Check_SalaryGenerated", con);
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

    }/// <summary>
    /// 
    /// </summary>
    [WebMethod]
    public void Get_EPF_ESIC()
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
            SqlCommand cmd = new SqlCommand("Get_EPF_ESIC", con);
            cmd.Parameters.Add("@Year", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Year"];
            cmd.Parameters.Add("@Month", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Monh"];
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

    // GetExpeneseBill
    [WebMethod]
    public void GetExpeneseBill()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        string from = "NA";
        string to = "NA";
        string fromto = HttpContext.Current.Request.Form["formto"];
        if (fromto == "NA" || fromto == "All")
        {
            from = "NA";
            to = "NA";
        }
        else
        {

            fromto = fromto.Replace("\n", "");
            fromto = fromto.Replace(" ", "").Trim();
            string[] arr = fromto.Split('-');
            from = arr[0].ToString();
            to = arr[1].ToString();
        }
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("GetExpeneseBill", con);
            cmd.Parameters.Add("@BillType", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["BillType"];
            cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Email"];
            cmd.Parameters.Add("@FDate", SqlDbType.VarChar).Value = from;
            cmd.Parameters.Add("@TDate", SqlDbType.VarChar).Value = to;
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
    public void SaveExpenese()
    {
        string Result = "";
        string Sno = HttpContext.Current.Request.Form["Sno"];
        string Ampunt = HttpContext.Current.Request.Form["Ampunt"];
        string Purpose = HttpContext.Current.Request.Form["Purpose"];
        string TypeExp = HttpContext.Current.Request.Form["TypeExp"];
        string Gpath = HttpContext.Current.Server.MapPath("~/UploadFile/ExpenesesFile/");
        if (!Directory.Exists(Gpath))
        {
            Directory.CreateDirectory(Gpath);
        }
        int fileCount = Directory.GetFiles(Gpath, "*.*", SearchOption.AllDirectories).Length;
        HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];
        string UName =fileCount + Path.GetExtension(postedFile.FileName);
        string MPath = Gpath + UName;
        postedFile.SaveAs(MPath);
        //UName = "https://genesiscloudapps.com/Gen_Reporting/GenReporting/UploadFile/ExpenesesFile/" + UName;
        UName = "http://122.160.172.187/genreporting/UploadFile/" + UName;

        // 
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("Emp_SetExpenese", con);
            cmd.Parameters.AddWithValue("@Sno", Sno);
            cmd.Parameters.AddWithValue("@Amount", Ampunt);
            cmd.Parameters.AddWithValue("@Purpose", Purpose);
            cmd.Parameters.AddWithValue("@TypeExp", TypeExp);
            cmd.Parameters.AddWithValue("@Url", UName);
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

    //
    [WebMethod]
    public void UpdateExpeneseSP()
    {
        string Result = "";
        string Sno = HttpContext.Current.Request.Form["Sno"];
        string Ampunt = HttpContext.Current.Request.Form["Ampunt"];
        string Purpose = HttpContext.Current.Request.Form["Purpose"];
        string ID = HttpContext.Current.Request.Form["Id"];
        string TypeExp = HttpContext.Current.Request.Form["TypeExp"];
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("Emp_UpdateExpenese", con);
            cmd.Parameters.AddWithValue("@Sno", Sno);
            cmd.Parameters.AddWithValue("@Amount", Ampunt);
            cmd.Parameters.AddWithValue("@Purpose", Purpose);
            cmd.Parameters.AddWithValue("@Url", "NA");
            cmd.Parameters.AddWithValue("@Id", ID);
            cmd.Parameters.AddWithValue("@TypeExp", TypeExp);
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
    public void UpdateExpenese()
    {
        string Result = "";
        string Sno = HttpContext.Current.Request.Form["Sno"];
        string Ampunt = HttpContext.Current.Request.Form["Ampunt"];
        string Purpose = HttpContext.Current.Request.Form["Purpose"];
        string ID = HttpContext.Current.Request.Form["Id"];
        string TypeExp = HttpContext.Current.Request.Form["TypeExp"];
        string Gpath = HttpContext.Current.Server.MapPath("~/UploadFile/ExpenesesFile/");
        if (!Directory.Exists(Gpath))
        {
            Directory.CreateDirectory(Gpath);
        }
        int fileCount = Directory.GetFiles(Gpath, "*.*", SearchOption.AllDirectories).Length;
        HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];
        string UName = fileCount + Path.GetExtension(postedFile.FileName);
        string MPath = Gpath + UName;
        postedFile.SaveAs(MPath);
        //UName = "https://genesiscloudapps.com/Gen_Reporting/GenReporting/UploadFile/ExpenesesFile/" + UName;
        UName = "http://122.160.172.187/genreporting/UploadFile/" + UName;

        // 
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("Emp_UpdateExpenese", con);
            cmd.Parameters.AddWithValue("@Sno", Sno);
            cmd.Parameters.AddWithValue("@Amount", Ampunt);
            cmd.Parameters.AddWithValue("@Purpose", Purpose);
            cmd.Parameters.AddWithValue("@Url", UName);
            cmd.Parameters.AddWithValue("@Id", ID);
            cmd.Parameters.AddWithValue("@TypeExp", TypeExp);
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
    public void GetApplyExpeneseSP()
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
            SqlCommand cmd = new SqlCommand("Emp_GetApplyExpenese", con);
            cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
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

    // get type of expenese
    [WebMethod]
    public void TypeofExpenese()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        string s = HttpContext.Current.Request.Form["Sno"];
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("Get_Type_of_Expenese", con);
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

    // UpdatePaymentStatus

    [WebMethod]
    public void UpdatePaymentStatus()
    {
        string Result = "";
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("UPDATE Apply_Expenese SET PaymentStatus='Done',PaymentDate=getdate() WHERE id= '" + HttpContext.Current.Request.Form["id"] + "'", con);
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

    // ApprovelExpeneseBill

    [WebMethod]
    public void ApprovelExpeneseBill()
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
            SqlCommand cmd = new SqlCommand("ShowExpeneseBill", con);
            cmd.Parameters.Add("@BillType", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["BillType"];
            cmd.Parameters.Add("@Payment", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Payment"];
            cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Email"];
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

    // ApprovedStatusExpenese

    [WebMethod]
    public void ApprovedStatusExpenese()
    {
        string Sno = HttpContext.Current.Request.Form["Sno"];
        string Name = HttpContext.Current.Request.Form["Name"];
        string Id = HttpContext.Current.Request.Form["Id"];
        string Status = HttpContext.Current.Request.Form["Status"];

        string Result = "";
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            //cmd = new SqlCommand("update Apply_Expenese set ApprovedStatus = " + Status + ", ApprovedSno ="+ Sno + ", ApprovedName = "+ Name + " where id= "+ Id, con);
              cmd =new SqlCommand("update Apply_Expenese set ApprovedStatus = @Status,ApprovedSno=@Sno, ApprovedName=@Name where id=@Id", con);
            cmd.Parameters.AddWithValue("@Status", Status);
            cmd.Parameters.AddWithValue("@Sno", Sno);
            cmd.Parameters.AddWithValue("@Name", Name);
            cmd.Parameters.AddWithValue("@Id", Id);
            cmd.ExecuteNonQuery();
            con.Close();
            Result = "Save";
        }
        catch (SqlException e)
        {
            Result = "Not" +e.Message.ToString();
        }
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(Result);
        HttpContext.Current.Response.Flush();
    }


    [WebMethod]
    public void SaveAttendance()
    {
        string Ret = "";
        String resultJSON = "";
        SqlConnection con = new SqlConnection(conn);
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("AddAttendanceManuall", con);
            cmd.Parameters.Add("@EmpEmail", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["EmpEmail"];
            cmd.Parameters.Add("@AttendanceDate", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Date"];
            cmd.Parameters.Add("@Purpose", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Purpose"];
            cmd.Parameters.Add("@ApplySno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["ApplySno"];
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            con.Close();
            Ret = "Save";
        }
        catch (SqlException d)
        {
            Ret = d.Message.ToString();
        }
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        resultJSON = serializer.Serialize(Ret).ToString();
        Context.Response.Write(resultJSON);

        //return Ret;

    }
    [WebMethod]
    public void GetAttendanceManuall()
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
            SqlCommand cmd = new SqlCommand("GetAttendanceManuall", con);
            cmd.Parameters.Add("@YearNo", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["YearNo"];
            cmd.Parameters.Add("@MonthNo", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["MonthNo"];
            cmd.Parameters.Add("@EmpName", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["EmpName"];
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
            string s = ex.Message.ToString();
            resultJSON = ex.Message.ToString();
        }
        finally
        {
            con.Close();
        }
        Context.Response.Write(resultJSON);

    }

    // Update_AttebdanceGenerated


    [WebMethod]
    public void Update_AttebdanceGenerated()
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
            SqlCommand cmd = new SqlCommand("Update_AttebdanceGenerated", con);
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
            string s = ex.Message.ToString();
            resultJSON = ex.Message.ToString();
        }
        finally
        {
            con.Close();
        }
        Context.Response.Write(resultJSON);

    }

    // Update_SalarGenerated
    
    [WebMethod]
    public void Update_SalarGenerated()
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
            SqlCommand cmd = new SqlCommand("Update_SalarGenerated", con);
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
            string s = ex.Message.ToString();
            resultJSON = ex.Message.ToString();
        }
        finally
        {
            con.Close();
        }
        Context.Response.Write(resultJSON);

    }
    // Check_Salary


    [WebMethod]
    public void Admin_Check_Salary()
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
            SqlCommand cmd = new SqlCommand("Admin_Check_Salary", con);
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
            string s = ex.Message.ToString();
            resultJSON = ex.Message.ToString();
        }
        finally
        {
            con.Close();
        }
        Context.Response.Write(resultJSON);

    }

    // AccountCheck_SalaryGenerated

    [WebMethod]
    public void AccountCheck_SalaryGenerated()
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
            SqlCommand cmd = new SqlCommand("AccountCheck_SalaryGenerated", con);
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
            string s = ex.Message.ToString();
            resultJSON = ex.Message.ToString();
        }
        finally
        {
            con.Close();
        }
        Context.Response.Write(resultJSON);

    }
    [WebMethod]
    public void Admin_ApprovedSalary()
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
            SqlCommand cmd = new SqlCommand("Admin_ApprovedSalary", con);
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
            string s = ex.Message.ToString();
            resultJSON = ex.Message.ToString();
        }
        finally
        {
            con.Close();
        }
        Context.Response.Write(resultJSON);

    }


    // employee all Record  GetEmployeeAllRecord
    [WebMethod]
    public void GetEmployeeAllRecord()
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
            SqlCommand cmd = new SqlCommand("Hr_EmployeeProfile", con);
            cmd.Parameters.AddWithValue("@count", HttpContext.Current.Request.Form["count"]);
            cmd.Parameters.AddWithValue("@Email", HttpContext.Current.Request.Form["Email"]);
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

    // ChangePasssword

    // employee all Record  GetEmployeeAllRecord
    [WebMethod]
    public void ChangePasssword()
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
            SqlCommand cmd = new SqlCommand("ChangePassword", con);
            cmd.Parameters.AddWithValue("@Sno", HttpContext.Current.Request.Form["Sno"]);
            cmd.Parameters.AddWithValue("@Oldpass", HttpContext.Current.Request.Form["oldpass"]);
            cmd.Parameters.AddWithValue("@NewPassword", HttpContext.Current.Request.Form["newPassword"]);
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

    // GetAssignRole

    [WebMethod]
    public void GetAssignRole()
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
            SqlCommand cmd = new SqlCommand("GetDetails", con);
            cmd.Parameters.AddWithValue("@Email", HttpContext.Current.Request.Form["Email"]);
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

    // GetLoginPermission

    [WebMethod]
    public void ShowPermission()
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
            SqlCommand cmd = new SqlCommand("GetLoginPermission", con);
            cmd.Parameters.AddWithValue("@Email", HttpContext.Current.Request.Form["Email"]);
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
    public void ShowPageList()
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
            SqlCommand cmd = new SqlCommand("ShowPageList", con);
            cmd.Parameters.AddWithValue("@Sno", HttpContext.Current.Request.Form["Sno"]);
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

    /// UpdatePermission
    [WebMethod]
    public void UpdatePermission()
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
            SqlCommand cmd = new SqlCommand("Update_Group_Page", con);
            cmd.Parameters.AddWithValue("@Updateid", HttpContext.Current.Request.Form["Updateid"]);
            cmd.Parameters.AddWithValue("@val", HttpContext.Current.Request.Form["val"]);
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

        //string Updateid = HttpContext.Current.Request.Form["Updateid"];
        //string val = HttpContext.Current.Request.Form["val"];
        //string Ret = "";
        //String resultJSON = "";
        //SqlConnection con = new SqlConnection(conn);
        //try
        //{
        //    Context.Response.Clear();
        //    Context.Response.ContentType = "application/json";
        //    con.Open();
        //    string sql = "Update [Group_Page] set Type=+" + val + " where id =" + Updateid;
        //    SqlCommand cmd = new SqlCommand(sql, con);
        //    cmd.ExecuteNonQuery();
        //    con.Close();
        //    Ret = "Save";
        //}
        //catch (SqlException d)
        //{
        //    Ret = d.Message.ToString();
        //}
        //JavaScriptSerializer serializer = new JavaScriptSerializer();
        //resultJSON = serializer.Serialize(Ret).ToString();
        //Context.Response.Write(resultJSON);

        //return Ret;

    }

    // ShowSubPermission

    [WebMethod]
    public void ShowSubPermission()
    {
        string Email = HttpContext.Current.Request.Form["Email"];
        String Pageid = HttpContext.Current.Request.Form["Pageid"];
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
            SqlCommand cmd = new SqlCommand("ShowSubPermission", con);
            cmd.Parameters.AddWithValue("@Email", Email);
            cmd.Parameters.AddWithValue("@Pageid", Pageid);
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

    // SubUpdatePermission

    [WebMethod]
    public void SubUpdatePermission()
    {
        string Updateid = HttpContext.Current.Request.Form["Updateid"];
        string val = HttpContext.Current.Request.Form["val"];
        string Ret = "";
        String resultJSON = "";
        SqlConnection con = new SqlConnection(conn);
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            string sql = "update Sub_Group_Page set type=+" + val + " where id =" + Updateid;
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.ExecuteNonQuery();
            con.Close();
            Ret = "Save";
        }
        catch (SqlException d)
        {
            Ret = d.Message.ToString();
        }
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        resultJSON = serializer.Serialize(Ret).ToString();
        Context.Response.Write(resultJSON);

        //return Ret;

    }

    // SaveEvent

    [WebMethod]
    public void SaveEvent()
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
            SqlCommand cmd = new SqlCommand("SaveEvent", con);
            cmd.Parameters.AddWithValue("@Sno", HttpContext.Current.Request.Form["Sno"]);
            cmd.Parameters.AddWithValue("@EventName", HttpContext.Current.Request.Form["EventName"]);
            cmd.Parameters.AddWithValue("@EventDate", HttpContext.Current.Request.Form["EventDate"]);
            cmd.Parameters.AddWithValue("@Description", HttpContext.Current.Request.Form["Description"]);
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


    // ShowEvent


    [WebMethod]
    public void ShowEvent()
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
            SqlCommand cmd = new SqlCommand("ShowEvent", con);
            cmd.Parameters.AddWithValue("@Date", HttpContext.Current.Request.Form["Date"]);
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
    public void DeleteEvent()
    {
        string Result = "";
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("delete from Master_Event where id = '" + HttpContext.Current.Request.Form["id"] + "'", con);
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


    // UpdateEvent

    [WebMethod]
    public void UpdateEvent()
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
            SqlCommand cmd = new SqlCommand("UpdateEvent", con);
            cmd.Parameters.AddWithValue("@id", HttpContext.Current.Request.Form["id"]);
            cmd.Parameters.AddWithValue("@EventName", HttpContext.Current.Request.Form["EventName"]);
            cmd.Parameters.AddWithValue("@EventDate", HttpContext.Current.Request.Form["EventDate"]);
            cmd.Parameters.AddWithValue("@Description", HttpContext.Current.Request.Form["Description"]);
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


        //string id = HttpContext.Current.Request.Form["id"];
        //string EventName = HttpContext.Current.Request.Form["EventName"];
        //string EventDate = HttpContext.Current.Request.Form["EventDate"];
        //string Description = HttpContext.Current.Request.Form["Description"];
        //string Result = "";
        //try
        //{
        //    SqlCommand cmd = new SqlCommand();
        //    SqlConnection con = new SqlConnection(conn);
        //    con.Open();
        //    String SQl = "update Master_Event set EventName=" + EventName + ",EventDate = " + EventDate + ", EventDescription=" + Description + " where id =" + id;
        //    SQl = SQl.Remove('.',' ');
        //    cmd = new SqlCommand(SQl, con);
        //    cmd.ExecuteNonQuery();
        //    con.Close();
        //    Result = "Save";
        //}
        //catch (SqlException ex)
        //{
        //    string e = ex.Message.ToString();
        //    Result = "Not";
        //}
        //HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        //HttpContext.Current.Response.Write(Result);
        //HttpContext.Current.Response.Flush();
    }



    // GetLeLeaveStatus

    [WebMethod]
    public void GetLeaveStatus()
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
            SqlCommand cmd = new SqlCommand("GetLeaveStatus", con);
            cmd.Parameters.AddWithValue("@Sno", HttpContext.Current.Request.Form["Sno"]);
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
