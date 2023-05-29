using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

/// <summary>
/// Summary description for LoginLogoutService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class LoginLogoutService : System.Web.Services.WebService
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    public LoginLogoutService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

   
    [WebMethod]
    public void  LogoutNow()
    {
        string UserTypeId;
        SqlConnection con = new SqlConnection(conn);
        SqlCommand cmd = new SqlCommand();
            con.Open();
            cmd = new SqlCommand("Master_LogoutEmployee", con);
            cmd.Parameters.AddWithValue("@ID", HttpContext.Current.Request.Form["ID"]);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Return", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            cmd.ExecuteNonQuery();
             UserTypeId = cmd.Parameters["@Return"].Value.ToString();
            con.Close();
        String resultJSON = "";
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        resultJSON = serializer.Serialize(UserTypeId).ToString();
        Context.Response.Write(resultJSON);
    }
    // Login Employee

    [WebMethod]
    public void LoginEmployee()
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
            SqlCommand cmd = new SqlCommand("Master_LoginEmployee", con);
            cmd.Parameters.AddWithValue("@Username", HttpContext.Current.Request.Form["UserId"]);
            cmd.Parameters.AddWithValue("@Password", HttpContext.Current.Request.Form["Pass"]);
            cmd.Parameters.AddWithValue("@Lat", HttpContext.Current.Request.Form["Lat"]);
            cmd.Parameters.AddWithValue("@Lon", HttpContext.Current.Request.Form["Lon"]);
            cmd.Parameters.AddWithValue("@SystemType", HttpContext.Current.Request.Form["Type"]);
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
