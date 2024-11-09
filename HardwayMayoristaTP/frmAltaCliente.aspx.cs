using HardwaySI4_PP1.Models;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace HardwayMayoristaTP
{
    public partial class frmAltaCliente : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!autorizar())
                {
                    Response.Redirect("frmPrincipal.aspx");
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

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    var persona = new Personas
                    {
                        Dni = txtDNI.Text,
                        NombreApellido = txtNombre.Text + " " + txtApellido.Text,
                        Email = txtEmail.Text,
                        Telefono = txtCelular.Text,
                        IdTipoDni = int.Parse(DropDownTipoDni.SelectedValue)
                    };

                    if (ObtenerIdPersonaPorDNI(persona.Dni) > 0)
                    {
                        mensajeError("danger", "<strong>¡Error!</strong> La persona con ese DNI ya está registrada", true);
                        return;
                    }

                    if (InsertarPersona(persona) <= 0)
                    {
                        mensajeError("danger", "<strong>¡Error!</strong> Ocurrió un error al registrar la persona", true);
                        return;
                    }

                    int personaId = ObtenerIdPersonaPorDNI(persona.Dni);
                    if (personaId < 1)
                    {
                        mensajeError("danger", "<strong>¡Error!</strong> No se pudo encontrar a la persona  registrada", true);
                        return;
                    }
                    
                    var cliente = new Clientes
                    {
                        IdPersona = personaId,
                        Localidad = txtLocalidad.Text
                    };

                    if (InsertarCliente(cliente) > 0)
                    {
                        mensajeError("success", "<strong>¡Éxito!</strong> El cliente se ha registrado exitosamente.", true);
                        limpiarCampos();
                        return;
                    }

                    mensajeError("danger", "<strong>¡Error!</strong> No se pudo registrar a la persona como cliente", true);
                }
            }
            catch (Exception ex)
            {
                mensajeError("danger", "<strong>¡Error!</strong> Ocurrió un error al registrar el cliente: " + ex.Message, true);
            }
        }

        protected void limpiarCampos()
        {
            txtNombre.Text = string.Empty;
            txtApellido.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtCelular.Text = string.Empty;
            txtLocalidad.Text = string.Empty;
            txtDNI.Text = string.Empty;
            DropDownTipoDni.SelectedIndex = 0;
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            limpiarCampos();
            Response.Redirect("frmPrincipal.aspx");
        }

        protected void mensajeError(string color, string msg, bool mostrar)
        {
            string div = $"<div class='alert alert-{color} alert-dismissible fade show' role='alert'>"
                        + $"{msg}"
                        + "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            LabelMensaje.Text = div;
            LabelMensaje.Visible = mostrar;
        }

        private int InsertarPersona(Personas persona)
        {
            SqlDataSourcePersonas.InsertParameters["Dni"].DefaultValue = persona.Dni;
            SqlDataSourcePersonas.InsertParameters["NombreApellido"].DefaultValue = persona.NombreApellido;
            SqlDataSourcePersonas.InsertParameters["Email"].DefaultValue = persona.Email;
            SqlDataSourcePersonas.InsertParameters["Telefono"].DefaultValue = persona.Telefono;
            SqlDataSourcePersonas.InsertParameters["IdTipoDni"].DefaultValue = persona.IdTipoDni.ToString();
            return SqlDataSourcePersonas.Insert();
        }

        private int ObtenerIdPersonaPorDNI(string dni)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HardwayMayoristaConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT Id FROM Personas WHERE Dni = @Dni";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Dni", dni);

                conn.Open();
                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    return Convert.ToInt32(result);
                }
                return 0;
            }
        }

        private int InsertarCliente(Clientes cliente)
        {
            SqlDataSourceClientes.InsertParameters["IdPersona"].DefaultValue = cliente.IdPersona.ToString();
            SqlDataSourceClientes.InsertParameters["Localidad"].DefaultValue = cliente.Localidad;
            return SqlDataSourceClientes.Insert();
        }
    }
}
