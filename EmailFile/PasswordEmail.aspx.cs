using System;
using System.Net;
using System.Net.Mail;
using System.Web.Services;

public partial class EmailFile_PasswordEmail : System.Web.UI.Page
{
    //string Mess = "You have successfully Generated a Password.";
    //string s= "Password Generated";
    //string Email = "nishant.k@genesis-in.com";

    protected void Page_Load(object sender, EventArgs e)
    {
    //    SendEmailBg(Email,Mess,s);
    }
    public void SendEmailBg(string SendEmail,string Mess, string S)
    {
        string dttime = DateTime.Now.ToString("yyyy-MM-dd");
        MailMessage msg = new MailMessage();
        SmtpClient smtp = new SmtpClient();
        MailAddress from = new MailAddress("info@genesiscloudapps.com", S);
        msg.To.Add(SendEmail);
        msg.From = from;
        msg.Subject = S + Convert.ToDateTime(dttime).ToString("dd/MM/yyy");
        msg.IsBodyHtml = true;
        smtp.Host = "mail.genesiscloudapps.com";
        smtp.Port = 25;
        smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
        smtp.Credentials = new NetworkCredential("info@genesiscloudapps.com", "k1#D6li9");
        msg.Body = "<body><head> <div style='text-align: center;padding: 40px 0;background: #EBF0F5;'> "
                 + "  <div style='background: white;padding: 60px;border-radius: 4px; box-shadow: 0 2px 3px #C8D0D8;display: inline-block; margin: 0 auto;'>"
                 + "<div style = 'border-radius:200px; height:200px; width:200px; background: #F8FAF5; margin:0 auto;'>"

                 + " <i style=' color: #9ABC66;font-size: 80px;line-height: 200px;margin-left:-15px; transform: rotate(40deg); '>✓</i>"

                 + "  </div> <h1 style=' color: #88B04B;font-family: 'Nunito Sans', 'Helvetica Neue', sans-serif;font-weight: 900;font-size: 40px;margin-bottom: 10px;'>Success</h1> "
                 + "  <p style='  color: #404F5E;font-family: 'Nunito Sans', 'Helvetica Neue', sans-serif; font-size:20px;margin: 0;'>'"+Mess+"'</p> </div>"
                  + "<br></br> </div></head>  </body> ";
        smtp.Send(msg);
        msg.Dispose();
    }


    [WebMethod]
    public static int sentEmailWeb(string Mess,string Sno ,string Email)
    {
        EmailFile_PasswordEmail obj = new EmailFile_PasswordEmail();

        obj.SendEmailBg(Email, Mess, Sno);
        return 1;
    }
}