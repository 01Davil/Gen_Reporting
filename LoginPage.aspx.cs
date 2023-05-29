using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Runtime.InteropServices;
using System.Web;
using System.Web.Services;
using System.Web.UI;
public partial class LoginPage : System.Web.UI.Page
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["LoginSno"] = "NA";
        Session["LoginIDMax"] = "NA";
        Session["LoginEmpCode"] = "NA";
        Session["LoginName"] = "NA";
        Session["LoginEmail"] = "NA";
        Session["LoginImage"] = "NA";
        Session["LoginRoleId"] = "NA";
        Session.Timeout = 324000;
    }
    [WebMethod]
    public static string SetValuse(string LoginSno,string LoginIDMax,string LoginEmpCode,string LoginName,string LoginEmail, string LoginImage, string LoginRoleId)
    {
        HttpContext.Current.Session["LoginSno"] = LoginSno;
        HttpContext.Current.Session["LoginIDMax"] = LoginIDMax;
        HttpContext.Current.Session["LoginEmpCode"] = LoginEmpCode;
        HttpContext.Current.Session["LoginName"] = LoginName;
        HttpContext.Current.Session["LoginEmail"] = LoginEmail;
        HttpContext.Current.Session["LoginImage"] = LoginImage;
        HttpContext.Current.Session["LoginRoleId"] = LoginRoleId;
        return "ok";
    }
    [WebMethod]
    public static string ForGetPassword(String Email)
    {
        String SNo = " ";
        SqlConnection con = new SqlConnection(conn);
        con.Open();
        SqlCommand cmd = new SqlCommand("Master_EmailExit", con);
        cmd.Parameters.AddWithValue("@Email",Email);
        cmd.Parameters.Add("@Ret", SqlDbType.Char, 100);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters["@Ret"].Direction = ParameterDirection.Output;
        cmd.ExecuteNonQuery();
        SNo = (string)cmd.Parameters["@Ret"].Value;
        SNo = SNo.Replace(" ", "");
        con.Close();
        if (SNo != "No")
        {
            LoginPage ob = new LoginPage();
            ob.SendEmailBg(Email, SNo);
            SNo = "Yes";
        }
        return SNo;
    }
    
    // end email forget Password 

    public void SendEmailBg(string SendEmail, string Sno)
    {

        string dttime = DateTime.Now.ToString("yyyy-MM-dd");
        MailMessage msg = new MailMessage();
        SmtpClient smtp = new SmtpClient();
        MailAddress from = new MailAddress("info@genesiscloudapps.com", "Password Forget Email ");
        msg.To.Add(SendEmail);
        msg.From = from;
        msg.Subject = "Password Forget Email" + Convert.ToDateTime(dttime).ToString("dd/MM/yyy");
        msg.IsBodyHtml = true;
        smtp.Host = "mail.genesiscloudapps.com";
        smtp.Port = 25;
        smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
        smtp.Credentials = new NetworkCredential("info@genesiscloudapps.com", "k1#D6li9");

        msg.Body = "<body><head> "
            + "<br></br> <h1 style = 'color:#1e1e2d; font-weight:500; margin:0;font-size:32px;font-family:'Rubik',sans-serif;' > You have requested to reset your password</ h1 > "
            + "<br></br>"
            + "<br></br><p style='color:#455056; font-size:15px;line-height:24px; margin:0;'> We cannot simply send you your old password. <br></br>A unique link to reset your password has been generated for you.To reset your password, <br></br> click the following link and follow the instructions.</ p > "
           + " <br></br><a href='https://genesiscloudapps.com/Gen_Reporting/GenReporting/ForGetPassword.aspx?Sno=" + Sno + " 'style = 'background:#20e277;text-decoration:none !important; font-weight:500; margin-top:35px; color:#fff;text-transform:uppercase; font-size:14px;padding:10px 24px;display:inline-block;border-radius:50px;' > Reset  Password </ a > "
            + "<br></br></head> </body>";
        smtp.Send(msg);
        msg.Dispose();
    }

    //

  
}
