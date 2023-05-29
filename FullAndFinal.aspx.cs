using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class FullAndFinal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string excelPath = Server.MapPath("~/UploadFile/ExcelFile/") + Path.GetFileName(FileUpload1.PostedFile.FileName);
        FileUpload1.SaveAs(excelPath);

        string conString = string.Empty;
        string extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
        switch (extension)
        {
            case ".xls": //Excel 97-03
                conString = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                break;
            case ".xlsx": //Excel 07 or higher
                conString = ConfigurationManager.ConnectionStrings["Excel07+ConString"].ConnectionString;
                break;

        }
        conString = string.Format(conString, excelPath);
        using (OleDbConnection excel_con = new OleDbConnection(conString))
        {
            excel_con.Open();
            string sheet1 = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null).Rows[0]["TABLE_NAME"].ToString();
            DataTable dtExcelData = new DataTable();

            dtExcelData.Columns.AddRange(new DataColumn[] {
                new DataColumn("EMP Code", typeof(Int64)),
                new DataColumn("Name", typeof(string)),
                new DataColumn("Date of Joining", typeof(string)),
                new DataColumn("Resigned / Superannuation on", typeof(string)),
                new DataColumn("Actual  CTC Salary", typeof(string)),
                new DataColumn("Actual Net Salary", typeof(string)),
                new DataColumn("Net Salary for the month of April 23", typeof(string)),
                new DataColumn("Net Loan Deduction", typeof(string)),
                new DataColumn("Gratuity", typeof(string)),
                new DataColumn("Final Payble Amount", typeof(string)),
                new DataColumn("Net payable Amount", typeof(string))

               });

            using (OleDbDataAdapter oda = new OleDbDataAdapter("SELECT * FROM [" + sheet1 + "]", excel_con))
            {
                oda.Fill(dtExcelData);
            }
            excel_con.Close();

            string consString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(consString))
            {
                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                {
                    //Set the database table name
                    sqlBulkCopy.DestinationTableName = "NewGen.dbo.Employee_Full_And_Final";
                    sqlBulkCopy.ColumnMappings.Add("EMP Code", "EMP Code");
                    sqlBulkCopy.ColumnMappings.Add("Name", "Name");
                    sqlBulkCopy.ColumnMappings.Add("Date of Joining", "Date of Joining");
                    sqlBulkCopy.ColumnMappings.Add("Resigned / Superannuation on", "Resigned / Superannuation on");
                    sqlBulkCopy.ColumnMappings.Add("Last Working Day", "Last Working Day");
                    sqlBulkCopy.ColumnMappings.Add("Actual  CTC Salary", "Actual  CTC Salary");
                    sqlBulkCopy.ColumnMappings.Add("Actual Net Salary", "Actual Net Salary");
                    sqlBulkCopy.ColumnMappings.Add("Net Salary for the month of April 23", "Net Salary for the month of April 23");
                    sqlBulkCopy.ColumnMappings.Add("Net Loan Deduction", "Net Loan Deduction");
                    sqlBulkCopy.ColumnMappings.Add("Gratuity", "Gratuity");
                    sqlBulkCopy.ColumnMappings.Add("Final Payble Amount", "Final Payble Amount");
                    sqlBulkCopy.ColumnMappings.Add("Net payable Amount", "Net payable Amount");

                    con.Open();
                    sqlBulkCopy.WriteToServer(dtExcelData);
                    con.Close();
                }
            }
        }
        ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Employee Details Upload Successful !');", true);

    }
}