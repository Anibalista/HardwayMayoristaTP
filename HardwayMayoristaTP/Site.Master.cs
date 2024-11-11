using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HardwayMayoristaTP
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Nivel"] == null)
            {
                Response.Redirect("frmLogout.aspx");
            }
            cargarInfo();
        }

        protected void cargarInfo()
        {
            string nombre = Session["Nombre"].ToString() ?? "";
            string apellido = Session["Apellido"].ToString() ?? "";
            Label1.Text = nombre + " " + apellido;
            string nivel = Session["Nivel"].ToString() ?? "";
            if (nivel == "admin")
            {
                nivel = "administrador";
            }
            if (!String.IsNullOrWhiteSpace(nivel))
            {
                nivel = char.ToUpper(nivel[0]) + nivel.Substring(1).ToLower();
            }
            Label2.Text = nivel;
        }
    }
}