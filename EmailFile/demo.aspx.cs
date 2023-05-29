using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EmailFile_demo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SendEmailBg("nishant.k@genesis-in.com", "5");
    }
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
           + " <br></br><a href='http://localhost:50066/EmailFile/demo2.aspx'style = 'background:#20e277;text-decoration:none !important; font-weight:500; margin-top:35px; color:#fff;text-transform:uppercase; font-size:14px;padding:10px 24px;display:inline-block;border-radius:50px;  ' > Reset  Password </ a > "
            + "<br></br></head>  </body> ";
        smtp.Send(msg);
        msg.Dispose();
       Response.Write(@"<script language='javascript'>alert('Mail sent successfully.');</script>");
    }
}