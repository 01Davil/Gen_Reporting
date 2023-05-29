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

public partial class Admin_GenerateSalary : System.Web.UI.Page
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public class EmployeeSalary
    {
        // Master data
        public string EmpCode { get; set; }
        public string EmpName { get; set; }
        public string PDay { get; set; }
        public string ADay { get; set; }
        //
        public int Basic { get; set; }
        public int HRA { get; set; }
        public int Conveyance { get; set; }
        public int Allowance { get; set; }
        public int MediAllowance { get; set; }
        public int SpecialAllowance { get; set; }
        public int Bonus { get; set; }
        public int DA { get; set; }
        public int TA { get; set; }
        public int ArrearAllowance { get; set; }
        public int BonusAllowance { get; set; }
        public int ExtraAllowance { get; set; }
        public int Others { get; set; }
        public int TDS { get; set; }
        public int CTC { get; set; }
        public int TotalGross { get; set; }
        public int OtherAllowance { get; set; }
        public int voucher { get; set; }
        public int OtherAdvanceDeduction { get; set; }
        public int Deducted { get; set; }
        public string ESIC_E { get; set; }
        public string ESIC_ER { get; set; }
        public string ESICNO { get; set; }
        public string EPF_E { get; set; }
        public string EPF_ER { get; set; }
        public int NetSalary { get; set; }
        // 
    }

    [WebMethod]
    public static List<EmployeeSalary> ShowSalaryhistory()
    {
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();

            cmd = new SqlCommand("[HR_GenerateSalary]", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 4800;
            con.Close();
            SqlDataAdapter SDA = new SqlDataAdapter(cmd);
            SDA.Fill(ds);
            dt = ds.Tables[0];
        }
        catch (Exception)
        {

        }
        List<EmployeeSalary> Data = new List<EmployeeSalary>();

        foreach (DataRow dtt in dt.Rows)
        {
            Data.Add(new EmployeeSalary
            {
                EmpCode = dtt["EmpCode"].ToString(),
                EmpName = dtt["EmpName"].ToString(),
                ADay = dtt["ADay"].ToString(),
                PDay = dtt["PDay"].ToString(),
                Basic = int.Parse(dtt["Basic"].ToString()),
                HRA = int.Parse(dtt["HRA"].ToString()),
                Conveyance = int.Parse(dtt["Conveyance"].ToString()),
                Allowance = int.Parse(dtt["Allowance"].ToString()),
                MediAllowance = int.Parse(dtt["MediAllowance"].ToString()),
                SpecialAllowance = int.Parse(dtt["SpecialAllowance"].ToString()),
                Bonus = int.Parse(dtt["Bonus"].ToString()),
                DA = int.Parse(dtt["DA"].ToString()),
                TA = int.Parse(dtt["TA"].ToString()),
                ArrearAllowance = int.Parse(dtt["ArrearAllowance"].ToString()),
                BonusAllowance = int.Parse(dtt["BonusAllowance"].ToString()),
                OtherAllowance = int.Parse(dtt["OtherAllowance"].ToString()),
                OtherAdvanceDeduction = int.Parse(dtt["OtherAdvanceDeduction"].ToString()),
                ExtraAllowance = int.Parse(dtt["ExtraAllowance"].ToString()),
                Others = int.Parse(dtt["OtherAllowance"].ToString()),
                TDS = int.Parse(dtt["TDS"].ToString()),
                CTC = int.Parse(dtt["CTC"].ToString()),
                TotalGross = int.Parse(dtt["TotalGross"].ToString()),
                voucher = int.Parse(dtt["voucher"].ToString()),
                NetSalary = int.Parse(dtt["NetSalary"].ToString()),
                Deducted = int.Parse(dtt["Deducted"].ToString()),
                ESICNO = dtt["ESICNO"].ToString(),
                ESIC_E = dtt["ESIC_E"].ToString(),
                ESIC_ER = dtt["ESIC_ER"].ToString(),
                EPF_E = dtt["Deducted"].ToString(),
                EPF_ER = dtt["Deducted"].ToString(),

            });
        }

        return Data;
    }

    // UpdateEmployeeSalary
    [WebMethod]
    public static string UpdateEmployeeSalarySp(string Code, string TBasic, string THra, string PF_E, string PF_ER, string ESICNO, string ESIC_E, string ESIC_ER, string ArrearAllowance, string BonusAllowance, string OtherAdvanceDeduction, string OtherAllowance, string RateAllowance, string RateExtraAllowance, string RateMedicalAllowance, string RateSpecialAllowance, string RateBonus, string RateDA, string TA, string Conveyance, string CTC, string TDS, string Voucher, string Deducted, string NetSalary, string GrossPay)
    {
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("HR_GenerateSalary_Edit", con);
            cmd.Parameters.AddWithValue("@EmpCode", Code);
            cmd.Parameters.AddWithValue("@TBasic", int.Parse(TBasic));
            cmd.Parameters.AddWithValue("@THra", int.Parse(THra));
            cmd.Parameters.AddWithValue("@PF_E", int.Parse(PF_E));
            cmd.Parameters.AddWithValue("@PF_ER", int.Parse(PF_ER));
            cmd.Parameters.AddWithValue("@ESICNO", ESICNO);
            cmd.Parameters.AddWithValue("@ESIC_E", int.Parse(ESIC_E));
            cmd.Parameters.AddWithValue("@ESIC_ER", int.Parse(ESIC_ER));
            cmd.Parameters.AddWithValue("@ArrearAllowance", int.Parse(ArrearAllowance));
            cmd.Parameters.AddWithValue("@BonusAllowance", int.Parse(BonusAllowance));
            cmd.Parameters.AddWithValue("@OtherAdvanceDeduction", int.Parse(OtherAdvanceDeduction));
            cmd.Parameters.AddWithValue("@OtherAllowance", int.Parse(OtherAllowance));
            cmd.Parameters.AddWithValue("@Allowance", int.Parse(RateAllowance));
            cmd.Parameters.AddWithValue("@ExtraAllowance", int.Parse(RateExtraAllowance));
            cmd.Parameters.AddWithValue("@MedicalAllowance", int.Parse(RateMedicalAllowance));
            cmd.Parameters.AddWithValue("@SpecialAllowance", int.Parse(RateSpecialAllowance));
            cmd.Parameters.AddWithValue("@Bonus", int.Parse(RateBonus));
            cmd.Parameters.AddWithValue("@DA", int.Parse(RateDA));
            cmd.Parameters.AddWithValue("@TA", int.Parse(TA));
            cmd.Parameters.AddWithValue("@Conveyance", int.Parse(Conveyance));
            cmd.Parameters.AddWithValue("@CTC", int.Parse(CTC));
            cmd.Parameters.AddWithValue("@TDS", int.Parse(TDS));
            cmd.Parameters.AddWithValue("@Voucher", int.Parse(Voucher));
            cmd.Parameters.AddWithValue("@Deducted", int.Parse(Deducted));
            cmd.Parameters.AddWithValue("@NetSalary", int.Parse(NetSalary));
            cmd.Parameters.AddWithValue("@GrossPay", int.Parse(GrossPay));
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            con.Close();
            return "Done";
        }
        catch (Exception ex)
        {
            string s = ex.Message.ToString();
            return s;
        }
    }

    [WebMethod]

    public static string ApprovedSalary()
    {

        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            cmd = new SqlCommand("Admin_Approved_Salary", con);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            con.Close();
            return "Done";
        }
        catch (Exception ex)
        {
            string s = ex.Message.ToString();
            return s;
        }
    }
}