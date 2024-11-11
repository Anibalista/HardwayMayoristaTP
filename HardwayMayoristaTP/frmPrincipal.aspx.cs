using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace HardwayMayoristaTP
{
    public partial class frmPrincipal : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ContarClientesActivos();
                ContarUsuarios();
            }
        }

        private void ContarClientesActivos()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HardwayMayoristaConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Clientes WHERE Activo = 1";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int totalClientesActivos = (int)cmd.ExecuteScalar();
                LabelClientes.Text = totalClientesActivos.ToString();
            }
        }

        private void ContarUsuarios()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HardwayMayoristaConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Usuarios";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int totalUsuarios = (int)cmd.ExecuteScalar();
                LabelUsers.Text = totalUsuarios.ToString();
            }
        }
    }
}
