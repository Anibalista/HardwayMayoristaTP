using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace HardwayMayoristaTP
{
    public partial class frmGestionClientes : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!autorizar())
                {
                    Response.Redirect("frmPrincipal.aspx");
                }
                if (Session["Dni"] != null)
                {
                    string dniCliente = Session["Dni"].ToString();
                    CargarTiposDni();
                    CargarDatosCliente(dniCliente);
                }
                else
                {
                    Response.Redirect("frmConsultaCliente.aspx");
                }
            }
        }

        protected bool autorizar()
        {
            if (Session["Nivel"] == null)
            {
                return false;
            }
            if (Session["Nivel"].ToString() == "admin")
            {
                return true;
            }
            if (Session["Nivel"].ToString() == "vendedor")
            {
                return true;
            }
            return false;
        }

        private void CargarTiposDni()
        {
            // Esto asegura que el DropDownList de Tipo de Dni se rellena correctamente
            DropDownTipoDni.DataBind();
        }

        private void CargarDatosCliente(string dni)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HardwayMayoristaConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT Clientes.Id, Clientes.IdPersona, Clientes.Localidad, Clientes.Activo, " +
                               "Personas.Id AS Expr1, Personas.Dni, Personas.Nombre, Personas.Apellido, Personas.Email, Personas.Telefono, Personas.IdTipoDni " +
                               "FROM Clientes " +
                               "INNER JOIN Personas ON Clientes.IdPersona = Personas.Id " +
                               "INNER JOIN TipoDni ON Personas.IdTipoDni = TipoDni.Id " +
                               "WHERE Personas.Dni = @Dni";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Dni", dni);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    // Guardar Ids en la sesión
                    Session["ID"] = reader["Id"].ToString();
                    Session["IdPersona"] = reader["IdPersona"].ToString();

                    // Rellenar campos del formulario
                    txtDNI.Text = reader["Dni"].ToString();
                    txtNombre.Text = reader["Nombre"].ToString();
                    txtApellido.Text = reader["Apellido"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    txtCelular.Text = reader["Telefono"].ToString();
                    txtLocalidad.Text = reader["Localidad"].ToString();
                    DropDownTipoDni.SelectedValue = reader["IdTipoDni"].ToString();
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    string dni = txtDNI.Text;
                    string nombre = txtNombre.Text;
                    string apellido = txtApellido.Text;
                    string email = txtEmail.Text;
                    string celular = txtCelular.Text;
                    string localidad = txtLocalidad.Text;
                    int idTipoDni = int.Parse(DropDownTipoDni.SelectedValue);

                    string connectionString = ConfigurationManager.ConnectionStrings["HardwayMayoristaConnectionString"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = "UPDATE Personas SET Nombre = @Nombre, Apellido = @Apellido, Email = @Email, Telefono = @Telefono, IdTipoDni = @IdTipoDni " +
                                       "WHERE Dni = @Dni; " +
                                       "UPDATE Clientes SET Localidad = @Localidad " +
                                       "WHERE IdPersona = (SELECT Id FROM Personas WHERE Dni = @Dni)";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@Nombre", nombre);
                        cmd.Parameters.AddWithValue("@Apellido", apellido);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Telefono", celular);
                        cmd.Parameters.AddWithValue("@Localidad", localidad);
                        cmd.Parameters.AddWithValue("@IdTipoDni", idTipoDni);
                        cmd.Parameters.AddWithValue("@Dni", dni);

                        conn.Open();
                        cmd.ExecuteNonQuery();

                        lblMensaje.Text = "<div class='alert alert-success alert-dismissible fade show' role='alert'>" +
                                          "<strong>¡Éxito!</strong> Los datos del cliente se han actualizado exitosamente." +
                                          "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
                        lblMensaje.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    lblMensaje.Text = "<div class='alert alert-danger alert-dismissible fade show' role='alert'>" +
                                      "<strong>¡Error!</strong> Ocurrió un error al actualizar los datos del cliente: " + ex.Message +
                                      "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
                    lblMensaje.Visible = true;
                }
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmConsultaCliente.aspx");
        }
    }
}

