using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.Services;
using System.Web.UI;

public partial class CreatePassword : System.Web.UI.Page
{
    private static String conn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    string Sno = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Sno = Request.QueryString["Sno"];
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string p1 = TextBox1.Text;
        string p2 = TextBox2.Text;
        string Email = "";
        if (p1.Length == 0 || p2.Length == 0 || p1 == " " || p2 == " ")
        {
            string s = "Please enter and confirm your password.";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "Alert", "<script>ShowError('" + s + "')</script>", false);
        }
        else
        {
            if (p1 != p2)
            {
                string s1 = "Please enter the same password in both fields.";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "Alert", "<script>ShowError('" + s1 + "')</script>", false);
            }
            else
            {
                SqlConnection con = new SqlConnection(conn);
                con.Open();
                SqlCommand cmd = new SqlCommand("Master_CreatePassword", con);
                cmd.Parameters.Add("@NewPass", SqlDbType.VarChar).Value = p1;
                cmd.Parameters.Add("@Sno", SqlDbType.VarChar).Value = Sno;
                cmd.Parameters.Add("@Email", SqlDbType.Char, 100);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters["@Email"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                Email = (string)cmd.Parameters["@Email"].Value;
                con.Close();
                Email = Email.Replace(" ", "");
                SendEmailBg(Email, "You have successfully Generated a Password", "Password Generated");
            }

        }
    }

    public void SendEmailBg(string SendEmail, string Mess, string S)
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
                 + "  <p style='  color: #404F5E;font-family: 'Nunito Sans', 'Helvetica Neue', sans-serif; font-size:20px;margin: 0;'>'" + Mess + "'</p> </div>"
                  + "<br></br> </div></head>  </body> ";
        smtp.Send(msg);
        msg.Dispose();

        string s1 = "Password Generated Successfully.";
        ScriptManager.RegisterStartupScript(this, typeof(Page), "Alert", "<script>ShowGets('" + s1 + "')</script>", false);
    }


}