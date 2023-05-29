using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Finance_SalarySlip : System.Web.UI.Page
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {


    }

    public class EmployeeClass
    {
        public string SalaryDate { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Sno { get; set; }
        public string Designation { get; set; }
        public string Department { get; set; }
        public string DOJ { get; set; }
        public string BankName { get; set; }
        public string Company { get; set; }
        public string AccountNo { get; set; }
        public string PanNo { get; set; }
        public int BasicDA { get; set; }
        public string Conveyance { get; set; }
        public string OtherAllowance { get; set; }
        public string SpecialAllowance { get; set; }
        public string GrossPay { get; set; }
        public int ESI { get; set; }
        public int EPF { get; set; }
        public string TDS { get; set; }
        public string OtherAdvanceDeduction { get; set; }
        public string Deducted { get; set; }
        public string PDay { get; set; }
        public string NetSalary { get; set; }
    }


    /// <summary>
    /// 
    /// </summary>
    /// <param name="MonthNo"></param>
    /// <returns></returns>
    [WebMethod]
    public static List<EmployeeClass> GetDetails(string MonthNo)
    {

        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();

            cmd = new SqlCommand("Emp_GetSalarySlip", con);
            cmd.Parameters.AddWithValue("@Sno", int.Parse(HttpContext.Current.Session["LoginSno"].ToString()));
            cmd.Parameters.AddWithValue("@MonthNo", MonthNo);
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
                SalaryDate = (dtt["MonthName"].ToString() + " - " + dtt["YearNo"].ToString()),
                Code = dtt["EmpCode"].ToString(),
                Name = dtt["EmpName"].ToString(),
                Designation = dtt["JobProfile"].ToString(),
                Department = dtt["Department"].ToString(),
                BankName = dtt["BName"].ToString(),
                DOJ = dtt["DOJ"].ToString(),
                AccountNo = dtt["AccountNo"].ToString(),
                PanNo = dtt["PanNo"].ToString(),
                //
                BasicDA = (int.Parse(dtt["Basic"].ToString()) + int.Parse(dtt["DA"].ToString())),
                Conveyance = dtt["Conveyance"].ToString(),
                OtherAllowance = dtt["OtherAllowance"].ToString(),
                SpecialAllowance = dtt["SpecialAllowance"].ToString(),
                GrossPay = dtt["GrossPay"].ToString(),
                EPF = (int.Parse(dtt["EPF_E"].ToString()) + int.Parse(dtt["EPF_ER"].ToString())),
                ESI = (int.Parse(dtt["ESIC_E"].ToString()) + int.Parse(dtt["ESIC_ER"].ToString())),
                TDS = dtt["TDS"].ToString(),
                OtherAdvanceDeduction = dtt["OtherAdvanceDeduction"].ToString(),
                Deducted = dtt["Deducted"].ToString(),
                PDay = dtt["PDay"].ToString(),
                NetSalary = dtt["NetSalary"].ToString(),
            });
        }

        return Data;
    }
}