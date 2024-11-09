using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HardwayMayoristaTP
{
    public partial class frmConsultaCliente : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }
        }


        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string searchValue = txtBuscar.Text.Trim();
            string query = "SELECT Personas.Dni, Personas.NombreApellido, Personas.Email, Personas.Telefono, Clientes.Localidad " +
                           "FROM Clientes INNER JOIN Personas ON Clientes.IdPersona = Personas.Id " +
                           "INNER JOIN TipoDni ON Personas.IdTipoDni = TipoDni.Id " +
                           "WHERE (Personas.Dni LIKE '%' + @Consulta + '%' OR Personas.NombreApellido LIKE '%' + @Consulta + '%' " +
                           "OR Personas.Email LIKE '%' + @Consulta + '%' OR Personas.Telefono LIKE '%' + @Consulta + '%' " +
                           "OR Clientes.Localidad LIKE '%' + @Consulta + '%') AND Clientes.Activo = 1";
            string connectionString = ConfigurationManager.ConnectionStrings["HardwayMayoristaConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Consulta", searchValue);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridViewClientes.DataSource = dt;
                GridViewClientes.DataBind();
            }
        }

        protected void GridViewClientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                // Obtener el DNI desde el CommandArgument
                string dni = e.CommandArgument.ToString();

                // Guardar el DNI en la sesión
                Session["DniCliente"] = dni;

                // Redirigir a la página de edición
                Response.Redirect("frmEditClientes.aspx");
            }
            else if (e.CommandName == "EditEliminar")
            {
                // Obtener el DNI desde el CommandArgument
                string dni = e.CommandArgument.ToString();

                // Configurar la consulta para marcar el cliente como inactivo
                SqlDataSource1.UpdateParameters["Dni"].DefaultValue = dni;
                SqlDataSource1.Update();
            }
        }

        protected void btnAgregarCliente_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmAltaCliente.aspx");
        }
    }
}

