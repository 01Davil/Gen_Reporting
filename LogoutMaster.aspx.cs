using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LogoutMaster : System.Web.UI.Page
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        fun();
    }
    
    public void fun()
    {
        string ii = Session["LoginIDMax"].ToString();
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection(conn);
        con.Open();
        cmd = new SqlCommand("Master_LogoutEmployee", con);
        cmd.Parameters.AddWithValue("@ID", ii);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@Return", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
        cmd.ExecuteNonQuery();
        int UserTypeId = int.Parse( cmd.Parameters["@Return"].Value.ToString());
        con.Close();
        Session.Remove("LoginSno");
        Session.Remove("LoginIDMax");
        Session.Remove("LoginEmpCode");
        Session.Remove("LoginName");
        Session.Remove("LoginEmail");
        Session.Remove("LoginImage");
        Session.Remove("LoginRoleId");
        Response.Redirect("LoginPage.aspx");
    }
}