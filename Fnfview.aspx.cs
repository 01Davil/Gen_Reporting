using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
using System.Web;

public partial class Fnfview : System.Web.UI.Page
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
   
    static string EmpCode = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        /// get ReqNo
        EmpCode = Request.QueryString["EmpCode"].ToString();
    }

    public class EmployeeClass
    {
        public string Name { get; set; }
        public string EmpCode { get; set; }
        public string DOJ { get; set; }
        public string SAL { get; set; }
        public string RES { get; set; }
        public string ANUAL { get; set; }
        public string LAST { get; set; }
        public string NET { get; set; }
        public string NETM { get; set; }
        public string NETMW { get; set; }
        public string GRA { get; set; }       
        public string GRW { get; set; }
        public string LOA { get; set; }
        public string LOAW { get; set; }
        public string FINPA { get; set; }      
        public string FINPW { get; set; }
        public string NE { get; set; }
        public string FAW { get; set; }
        public string N1 { get; set; }

    }


    [WebMethod]
    public static List<EmployeeClass> GetFnf()
    {

        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();

            cmd = new SqlCommand("z1_FnF", con);
            cmd.Parameters.AddWithValue("@EmpCode", EmpCode);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 4800;
            con.Close();
            SqlDataAdapter SDA = new SqlDataAdapter(cmd);
            SDA.Fill(ds);
            dt = ds.Tables[0];
        }
        catch (Exception g)
        {
            string f = g.Message.ToString();
        }
        List<EmployeeClass> Data = new List<EmployeeClass>();

        foreach (DataRow dtt in dt.Rows)
        {
            Data.Add(new EmployeeClass
            {

                Name = dtt["Name"]. ToString(),
                EmpCode = dtt["EMP Code"].ToString(),
                DOJ = dtt["Date Of Joining"].ToString(),              
                SAL = dtt["Actual  CTC Salary"].ToString(),
                RES = dtt["Resigned / Superannuation on"].ToString(),
                ANUAL = dtt["Actual Net Salary"].ToString(),
                LAST = dtt["Last Working Day"].ToString(),
                NET = dtt["Net payable Amount"].ToString(),
                NETM = dtt["Net Salary for the month of April 23"].ToString(),
                NETMW = dtt["T1"].ToString(),
                GRA = dtt["Gratuity"].ToString(),
                GRW = dtt["T2"].ToString(),
                LOA = dtt["Net Loan Deduction"].ToString(),
                LOAW = dtt["T5"].ToString(),
                FINPA = dtt["Final Payble Amount"].ToString(),
                FINPW = dtt["T3"].ToString(),
                NE = dtt["Name"].ToString(),
                FAW = dtt["T4"].ToString(),
                N1 = dtt["Name"].ToString(),
            });
        }

        return Data;
    }
}