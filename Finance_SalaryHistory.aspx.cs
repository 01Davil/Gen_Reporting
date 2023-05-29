using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
using System.Web;

public partial class Finance_SalaryHistory : System.Web.UI.Page
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
        public int PDay { get; set; }
        public int ADay { get; set; }
        public string date { get; set; }
        public int TotalDay { get; set; }
        public int Rate_Basic { get; set; }
        public int Rate_HRA { get; set; }
        public int Rate_Conveyance { get; set; }
        public int Rate_Allowance { get; set; }
        public int Rate_MediAllowance { get; set; }
        public int Rate_SpecialAllowance { get; set; }
        public int Rate_Bonus { get; set; }
        public int Rate_DA { get; set; }
        public int Rate_TA { get; set; }
        public int Rate_ArrearAllowance { get; set; }
        public int Rate_BonusAllowance { get; set; }
        public int Rate_ExtraAllowance { get; set; }
        public int Rate_Others { get; set; }
        public int Rate_TDS { get; set; }
        public int Rate_CTC { get; set; }
        public int Rate_TotalGross { get; set; }
        public int Rate_OtherAllowance { get; set; }
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
        public string BName { get; set; }
        public string BRName { get; set; }
        public string BRCode { get; set; }
        public string BrAddress { get; set; }
        public string IFSCCode { get; set; }
        public string AccountNo { get; set; }
        public string AccHolderName { get; set; }
        // 
        public string Fname { get; set; }
        public string Mname { get; set; }
        public string Department { get; set; }
        public string JobProfile { get; set; }
    }


    [WebMethod]
    public static List<EmployeeSalary> ShowSalaryhistory(int YearNo, int MonthNo, string EmailId)
    {
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(conn);
            con.Open();

            cmd = new SqlCommand("AccountShowSalary", con);
            cmd.Parameters.AddWithValue("@Year", YearNo);
            cmd.Parameters.AddWithValue("@Month", MonthNo);
            cmd.Parameters.AddWithValue("@EmailId", EmailId);
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
                PDay = int.Parse(dtt["PDay"].ToString()),
                ADay = int.Parse(dtt["ADay"].ToString()),
                //  date = dtt["date"].ToString(),
                TotalDay = ((int.Parse(dtt["PDay"].ToString())) + (int.Parse(dtt["ADay"].ToString()))),
                Rate_Basic = int.Parse(dtt["Rate_Basic"].ToString()),
                Rate_HRA = int.Parse(dtt["Rate_HRA"].ToString()),
                Rate_Conveyance = int.Parse(dtt["Rate_Conveyance"].ToString()),
                Rate_Allowance = int.Parse(dtt["Rate_Allowance"].ToString()),
                Rate_MediAllowance = int.Parse(dtt["Rate_MediAllowance"].ToString()),
                Rate_SpecialAllowance = int.Parse(dtt["Rate_SpecialAllowance"].ToString()),
                Rate_Bonus = int.Parse(dtt["Rate_Bonus"].ToString()),
                Rate_DA = int.Parse(dtt["Rate_DA"].ToString()),
                Rate_TA = int.Parse(dtt["Rate_TA"].ToString()),
                Rate_ArrearAllowance = int.Parse(dtt["Rate_ArrearAllowance"].ToString()),
                Rate_BonusAllowance = int.Parse(dtt["Rate_BonusAllowance"].ToString()),
                Rate_OtherAllowance = int.Parse(dtt["Rate_OtherAllowance"].ToString()),
                Rate_ExtraAllowance = int.Parse(dtt["Rate_ExtraAllowance"].ToString()),
                //  Rate_Others = int.Parse(dtt["Rate_Others"].ToString()),
                Rate_TDS = int.Parse(dtt["Rate_TDS"].ToString()),
                Rate_CTC = int.Parse(dtt["Rate_CTC"].ToString()),
                Rate_TotalGross = (int.Parse(dtt["Rate_Basic"].ToString()) + int.Parse(dtt["Rate_HRA"].ToString()) + int.Parse(dtt["Rate_Conveyance"].ToString()) +
                int.Parse(dtt["Rate_ArrearAllowance"].ToString()) + int.Parse(dtt["Rate_ExtraAllowance"].ToString()) + int.Parse(dtt["Rate_MediAllowance"].ToString())
                + int.Parse(dtt["Rate_SpecialAllowance"].ToString()) + int.Parse(dtt["Rate_OtherAllowance"].ToString()) + int.Parse(dtt["Rate_BonusAllowance"].ToString())
                + int.Parse(dtt["Rate_Bonus"].ToString()) + int.Parse(dtt["Rate_DA"].ToString()) + int.Parse(dtt["Rate_TA"].ToString()) + int.Parse(dtt["Rate_Allowance"].ToString())),
                ///
                /// 
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
                ////////////////////////////////////
                AccHolderName = dtt["AccHolderName"].ToString(),
                BName = dtt["BName"].ToString(),
                BRName = dtt["BRName"].ToString(),
                BRCode = dtt["BRCode"].ToString(),
                BrAddress = dtt["BrAddress"].ToString(),
                IFSCCode = dtt["IFSCCode"].ToString(),
                AccountNo = dtt["AccountNo"].ToString(),
            });
        }

        return Data;
    }
}