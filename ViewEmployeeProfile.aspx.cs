using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewEmployeeProfile : System.Web.UI.Page
{
    //string Sno = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["LoginSno"] == null || Session["LoginName"] == null)
        
            Response.Redirect("LoginPage.aspx");
        
        //else
        //{
        //    // get Employee Sno id 
        //    Sno= Request.QueryString["Sno"].ToString();
        //}
    }
   
    //  end
}