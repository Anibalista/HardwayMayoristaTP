using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HardwayMayoristaTP
{
    public partial class frmLogin : Page
    {
        private const int MaxIntentos = 4;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Consultar si el usuario existe
            var viewUser = (DataView)SqlDataSource2.Select(DataSourceSelectArguments.Empty);
            if (viewUser.Count > 0)
            {
                var rowUser = viewUser[0];
                bool activo = Convert.ToBoolean(rowUser["Activo"]);
                int intentosFallidos = Convert.ToInt32(rowUser["IntentosFallidos"]);

                // Guardar estado en la sesión
                Session["activo"] = activo;
                Session["intentosFallidos"] = intentosFallidos;

                if (activo)
                {
                    // Consultar la combinación de usuario y contraseña
                    var viewLogin = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
                    if (viewLogin.Count > 0)
                    {
                        var rowLogin = viewLogin[0];
                        // Login exitoso
                        Session["Nombre"] = rowLogin["NombreApellido"].ToString();
                        Session["Nivel"] = rowLogin["Nivel"].ToString();

                        // Reiniciar los intentos fallidos y activar la cuenta
                        Session["intentosFallidos"] = 0;
                        Session["activo"] = true;
                        SqlDataSource1.Update(); // Actualizar la base de datos

                        Response.Redirect("frmPrincipal.aspx");
                    }
                    else
                    {
                        // Login fallido, incrementar intentos
                        intentosFallidos++;
                        Session["intentosFallidos"] = intentosFallidos;

                        if (intentosFallidos >= MaxIntentos)
                        {
                            Session["activo"] = false;
                            ValidationSummary1.HeaderText = "Usuario desactivado por múltiples intentos fallidos.";
                        }
                        else
                        {
                            ValidationSummary1.HeaderText = "Credenciales incorrectas. Por favor, inténtelo de nuevo.";
                        }

                        ValidationSummary1.DataBind(); // Forzar la actualización de ValidationSummary
                        SqlDataSource2.Update(); // Actualizar la base de datos
                    }
                }
                else
                {
                    ValidationSummary1.HeaderText = "Usuario desactivado. Contacte al administrador.";
                    ValidationSummary1.DataBind(); // Forzar la actualización de ValidationSummary
                }
            }
            else
            {
                ValidationSummary1.HeaderText = "Usuario no encontrado.";
                ValidationSummary1.DataBind(); // Forzar la actualización de ValidationSummary
            }
        }
    }
}
