using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EmployeeMasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginSno"] == null || Session["LoginIDMax"] == null || Session["LoginEmpCode"] == null || Session["LoginName"] == null || Session["LoginEmail"] == null || Session["LoginImage"] == null || Session["LoginRoleId"] == null)
        {
            Response.Redirect("LoginPage.aspx");
        }

    }
}
