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
/// Summary description for Employee_MasterService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class Employee_MasterService : System.Web.Services.WebService
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    SqlConnection con = new SqlConnection(conn);
    SqlCommand cmd;
    JavaScriptSerializer js = new JavaScriptSerializer();
    JavaScriptSerializer serializer = new JavaScriptSerializer();

    public Employee_MasterService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }
    /// <summary>
    /// Employee  Apply Leave
    /// </summary>
    [WebMethod]
    public void ApplyLeave()
    {
        String resultJSON = "";
        string fromto = HttpContext.Current.Request.Form["Date"];
        fromto = fromto.Replace("\n", "");
        fromto = fromto.Replace(" ", "").Trim();
        string[] arr = fromto.Split('-');
        string from = arr[0].ToString();
        string To = arr[1].ToString();
        string Ret = "";
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            cmd = new SqlCommand("Emp_ApplyLeave", con);
            cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
            cmd.Parameters.Add("@TypeLeave", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["TypeLeave"];
            cmd.Parameters.Add("@FDate1", SqlDbType.VarChar).Value = from;
            cmd.Parameters.Add("@TDate1", SqlDbType.VarChar).Value = To;
            cmd.Parameters.Add("@Purpose", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Purpose"];
            cmd.Parameters.Add("@Ret", SqlDbType.Char, 100);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters["@Ret"].Direction = ParameterDirection.Output;
            cmd.ExecuteNonQuery();
            Ret = (string)cmd.Parameters["@Ret"].Value;
            con.Close();
        }
        catch (SqlException d)
        {
            Ret = d.Message.ToString();
        }
        resultJSON = serializer.Serialize(Ret).ToString();
        Context.Response.Write(resultJSON);   
    }/// <summary>
    /// Get Employee Available Leave 
    /// </summary>
    [WebMethod]
    public void GetAvailableLeave()
    {
        String resultJSON = "";
        DataTable dt;
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("Emp_GetAvailableLeave", con);
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

    }/// <summary>
    /// Get employe Leave
    /// </summary>
    [WebMethod]
    public void GetEmployeeApplyLeave()
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
            SqlCommand cmd = new SqlCommand("Emp_GetApplyLeave", con);
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
    /// <summary>
    ///  get employee   GetAvailableWFH
    /// </summary>
    [WebMethod]
    public void GetAvailableWFH()
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
            SqlCommand cmd = new SqlCommand("Emp_GetAvailableWFH", con);
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
    }/// <summary>
    ///  apply work form home leave
    /// </summary>
    [WebMethod]
    public void ApplyWFH()
    {
        string s = HttpContext.Current.Request.Form["FDate"];
        string Ret = "";
        String resultJSON = "";
        SqlConnection con = new SqlConnection(conn);
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("Emp_ApplyWFH", con);
            cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
            cmd.Parameters.Add("@FDate", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["FDate"];
            cmd.Parameters.Add("@TDate", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["TDate"];
            cmd.Parameters.Add("@Purpose", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Purpose"];
            cmd.Parameters.Add("@Ret", SqlDbType.Char, 100);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters["@Ret"].Direction = ParameterDirection.Output;
            cmd.ExecuteNonQuery();
            Ret = (string)cmd.Parameters["@Ret"].Value;
            con.Close();
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
            SqlCommand cmd = new SqlCommand("Emp_GetApplyWFM", con);
            cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
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
   
    ///
    
    
    ////

    [WebMethod]
    public void GetDropAssignWork()
    {
        DataTable dt;
        SqlConnection con = new SqlConnection(conn);
        String resultJSON = "";
        JavaScriptSerializer js = new JavaScriptSerializer();
        JavaScriptSerializer serializer = new JavaScriptSerializer();

        string fromto = HttpContext.Current.Request.Form["Date"];
        string form = "";
        string to = "";
        fromto = fromto.Replace("\n", "");
        fromto = fromto.Replace(" ", "").Trim();
        string[] arr = fromto.Split('-');
        form = arr[0].ToString();
        to = arr[1].ToString();

        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("Emp_GetMyTask", con);
            cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
            cmd.Parameters.Add("@Type", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Type"];
            cmd.Parameters.Add("@FDate", SqlDbType.VarChar).Value = form;
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
    public void GetEmployeeLeaveSummery()
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
            SqlCommand cmd = new SqlCommand("Emp_GetLeaveSummery", con);
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
        string Result = "";
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("update Apply_Employee_Leave set Approve_Name='" + HttpContext.Current.Request.Form["Name"] + "' , Approve_Sno= '" + HttpContext.Current.Request.Form["Sno"] + "',Status='" + HttpContext.Current.Request.Form["Status"].Trim() + "' where id = '" + HttpContext.Current.Request.Form["Id"] + "'", con);
            cmd.ExecuteNonQuery();
            con.Close();
            Result = "Save";
        }
        catch (SqlException s)
        {
            Result = "Not";
        }
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(Result);
        HttpContext.Current.Response.Flush();
    
}
    [WebMethod]
    public void GetAppledWFHList()
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
            SqlCommand cmd = new SqlCommand("Emp_GetWFHSummery", con);
            cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
            cmd.Parameters.Add("@Emp", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Emp"];
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
    public void UpdateWFHStatuss()
    {
        string Ret = "";
        SqlConnection con = new SqlConnection(conn);
        try
        {
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            con.Open();
            SqlCommand cmd = new SqlCommand("Emp_WFHApproved", con);
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

    /// Get Employee Event Lsit 
   
    // get Meeting List
   


    // get Holi day list Month by
    
    [WebMethod]
    public void Get_HolidayList()
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
            SqlCommand cmd = new SqlCommand("Master_GetHoliDayList", con);
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
    // get employee Task List 
    [WebMethod]
    public void Get_TaskList()
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
            SqlCommand cmd = new SqlCommand("Get_TaskWork", con);
            cmd.Parameters.Add("@sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
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
    
    // Get_Leave
    [WebMethod]
    public void Get_Leave()
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
            SqlCommand cmd = new SqlCommand("Emp_Das_Get_Leave", con);
            cmd.Parameters.Add("@sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
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
    // get leave on modal 
    [WebMethod]
    public void GetLeaveModal()
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
            SqlCommand cmd = new SqlCommand("Emp_Das_Get_Leave_modal", con);
            cmd.Parameters.AddWithValue("@sno", HttpContext.Current.Request.Form["Sno"]);
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
    /// Get_WFH
    [WebMethod]
    public void Get_WFH()
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
            SqlCommand cmd = new SqlCommand("Emp_Das_Get_WFH", con);
            cmd.Parameters.Add("@sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
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
    // get tender list 
    //[WebMethod]
    //public void Get_TenderList()
    //{
    //    DataTable dt;
    //    SqlConnection con = new SqlConnection(conn);
    //    String resultJSON = "";
    //    JavaScriptSerializer js = new JavaScriptSerializer();
    //    JavaScriptSerializer serializer = new JavaScriptSerializer();
    //    try
    //    {
    //        Context.Response.Clear();
    //        Context.Response.ContentType = "application/json";
    //        con.Open();
    //        SqlCommand cmd = new SqlCommand("Emp_Dash_TenderList", con);
    //        cmd.Parameters.Add("@sno", SqlDbType.VarChar).Value = HttpContext.Current.Request.Form["Sno"];
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        SqlDataAdapter da = new SqlDataAdapter(cmd);
    //        DataSet ds = new DataSet();
    //        da.Fill(ds);
    //        dt = new DataTable();
    //        dt = ds.Tables[0];

    //        List<Dictionary<String, Object>> tableRows = new List<Dictionary<string, object>>();
    //        Dictionary<String, Object> row;
    //        row = new Dictionary<string, object>();
    //        if (dt.Rows.Count > 0)
    //        {

    //            foreach (DataRow dr in dt.Rows)
    //            {
    //                row = new Dictionary<string, object>();
    //                foreach (DataColumn col in dt.Columns)
    //                {
    //                    row.Add(col.ColumnName, dr[col].ToString());
    //                }
    //                tableRows.Add(row);
    //            }
    //            resultJSON = serializer.Serialize(tableRows).ToString();

    //        }
    //        else
    //        {
    //            row.Add("response", "Fail");
    //            tableRows.Add(row);
    //            resultJSON = serializer.Serialize(tableRows).ToString();

    //        }
    //    }

    //    catch (Exception ex)
    //    {
    //        resultJSON = ex.Message.ToString();
    //    }
    //    finally
    //    {
    //        con.Close();
    //    }
    //    Context.Response.Write(resultJSON);
    //}
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



    /// <summary>
    /// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /// </summary>

}
