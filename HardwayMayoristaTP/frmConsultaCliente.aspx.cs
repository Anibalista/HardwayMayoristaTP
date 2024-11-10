using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using OfficeOpenXml;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Web;

namespace HardwayMayoristaTP
{
    public partial class frmConsultaCliente : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarGrilla();
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
            if (Session["Nivel"].ToString() == "gerente")
            {
                return true;
            }
            if (Session["Nivel"].ToString() == "logistica")
            {
                return true;
            }
            return false;
        }

        protected bool autorizarEliminar()
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

        protected void cargarGrilla()
        {
            lblMensaje.Visible = false;
            string searchValue = "";
            string query = "SELECT Personas.Dni, Personas.Nombre, Personas.Apellido, Personas.Email, Personas.Telefono, Clientes.Localidad " +
               "FROM Clientes INNER JOIN Personas ON Clientes.IdPersona = Personas.Id " +
               "INNER JOIN TipoDni ON Personas.IdTipoDni = TipoDni.Id " +
               "WHERE (Personas.Dni LIKE '%' + @Consulta + '%' OR Personas.Nombre LIKE '%' + @Consulta + '%' " +
               "OR Personas.Apellido LIKE '%' + @Consulta + '%' OR Personas.Email LIKE '%' + @Consulta + '%' " +
               "OR Personas.Telefono LIKE '%' + @Consulta + '%' OR Clientes.Localidad LIKE '%' + @Consulta + '%') " +
               "AND Clientes.Activo = 1";

            string connectionString = ConfigurationManager.ConnectionStrings["HardwayMayoristaConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Consulta", searchValue);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count < 1)
                {
                    mensajeError("danger", "No existe cliente con el dato ingresado", true);
                }
                else
                {
                    lblError.Visible = false;
                    lblMensaje.Visible = false;
                }

                GridViewClientes.DataSource = dt;
                GridViewClientes.DataSourceID = null;
                GridViewClientes.DataBind();
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            lblMensaje.Visible = false;
            string searchValue = txtBuscar.Text.Trim();
            string query = "SELECT Personas.Dni, Personas.Nombre, Personas.Apellido, Personas.Email, Personas.Telefono, Clientes.Localidad " +
               "FROM Clientes INNER JOIN Personas ON Clientes.IdPersona = Personas.Id " +
               "INNER JOIN TipoDni ON Personas.IdTipoDni = TipoDni.Id " +
               "WHERE (Personas.Dni LIKE '%' + @Consulta + '%' OR Personas.Nombre LIKE '%' + @Consulta + '%' " +
               "OR Personas.Apellido LIKE '%' + @Consulta + '%' OR Personas.Email LIKE '%' + @Consulta + '%' " +
               "OR Personas.Telefono LIKE '%' + @Consulta + '%' OR Clientes.Localidad LIKE '%' + @Consulta + '%') " +
               "AND Clientes.Activo = 1";

            string connectionString = ConfigurationManager.ConnectionStrings["HardwayMayoristaConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Consulta", searchValue);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count < 1)
                {
                    mensajeError("danger", "No existe cliente con el dato ingresado", true);
                } else
                {
                    lblError.Visible = false;
                    lblMensaje.Visible = false;
                }
                
                GridViewClientes.DataSource = dt;
                GridViewClientes.DataSourceID = null;
                GridViewClientes.DataBind();
            }
        }

        protected void GridViewClientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (!autorizarEliminar())
            {
                mensajeError("danger", "No tiene las credenciales válidas para realizar esa acción", true);
                return;
            }
            Session["error"] = false;
            if (e.CommandName == "Edit")
            {
                // Obtener el DNI desde el CommandArgument
                string dni = e.CommandArgument.ToString();

                // Guardar el DNI en la sesión
                Session["Dni"] = dni;

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
            cargarGrilla();
        }
        protected void mensajeError(string color, string msg, bool mostrar)
        {
            string div = $"<div class='alert alert-{color} alert-dismissible fade show' role='alert'>"
                        + $"{msg}"
                        + "<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>";
            lblError.Text = div;
            lblError.Visible = mostrar;
            Session["error"] = mostrar;
        }

        protected void btnExportarExcel_Click(object sender, EventArgs e)
        {
            if (GridViewClientes.Rows.Count < 1)
            {
                mensajeError("danger", "No existen clientes en la consulta, listado cancelado", true);
                return;
            }

            ExcelPackage.LicenseContext = LicenseContext.NonCommercial; // Configurar el contexto de la licencia

            using (ExcelPackage excel = new ExcelPackage())
            {
                var worksheet = excel.Workbook.Worksheets.Add("Clientes");

                // Añadir encabezados
                string[] headers = { "Documento"," Nombre", "Apellido", "Email", "Celular", "Localidad" };
                for (int i = 0; i < headers.Length; i++)
                {
                    worksheet.Cells[1, i + 1].Value = headers[i];
                }

                // Añadir datos
                int totalCols = headers.Length;
                for (int i = 0; i < GridViewClientes.Rows.Count; i++)
                {
                    for (int j = 0; j < totalCols; j++)
                    {
                        // Decodificar caracteres HTML antes de agregarlos
                        string cellText = HttpUtility.HtmlDecode(GridViewClientes.Rows[i].Cells[j].Text);
                        worksheet.Cells[i + 2, j + 1].Value = cellText;
                    }
                }

                // Ajustar ancho de las celdas
                for (int i = 1; i <= totalCols; i++)
                {
                    worksheet.Column(i).AutoFit();
                }

                string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                string folderPath = Server.MapPath("~/Temp");

                // Crear el directorio si no existe
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string excelFileName = $"ClientesMayoristas_{timestamp}.xlsx";
                string excelPath = Path.Combine(folderPath, excelFileName);
                FileInfo excelFile = new FileInfo(excelPath);
                excel.SaveAs(excelFile);

                // Proporcionar un enlace de descarga
                lblMensaje.Text = $"<a href='/Temp/{excelFileName}' download='{excelFileName}'>Haga clic aquí para descargar el archivo Excel</a>";
                lblMensaje.Visible = true;
            }
        }


        protected void btnExportarPDF_Click(object sender, EventArgs e)
        {
            if (GridViewClientes.Rows.Count < 1)
            {
                mensajeError("danger", "No existen clientes en la consulta, listado cancelado", true);
                return;
            }
            using (MemoryStream ms = new MemoryStream())
            {
                Document doc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
                PdfWriter writer = PdfWriter.GetInstance(doc, ms);
                doc.Open();

                // Definir la tabla con el número correcto de columnas
                PdfPTable table = new PdfPTable(6); // Número correcto de columnas
                table.WidthPercentage = 100; // Ajustar tabla al 100% del área de impresión

                // Anchos relativos de las columnas
                float[] widths = new float[] { 15f, 20f, 20f, 30f, 15f, 20f };
                table.SetWidths(widths);

                // Añadir encabezados
                string[] headers = { "Documento", " Nombre", "Apellido", "Email", "Celular", "Localidad" };
                foreach (string header in headers)
                {
                    PdfPCell pdfCell = new PdfPCell(new Phrase(header));
                    table.AddCell(pdfCell);
                }

                // Añadir datos
                foreach (GridViewRow gridViewRow in GridViewClientes.Rows)
                {
                    // Decodificar caracteres HTML
                    string[] cellTexts = new string[6];
                    for (int i = 0; i < 6; i++)
                    {
                        cellTexts[i] = HttpUtility.HtmlDecode(gridViewRow.Cells[i].Text);
                    }

                    // Agregar celdas individuales basadas en las columnas específicas
                    table.AddCell(new PdfPCell(new Phrase(cellTexts[0]))); // Documento
                    table.AddCell(new PdfPCell(new Phrase(cellTexts[1]))); // Nombre
                    table.AddCell(new PdfPCell(new Phrase(cellTexts[2]))); // Nombre
                    table.AddCell(new PdfPCell(new Phrase(cellTexts[3]))); // Email
                    table.AddCell(new PdfPCell(new Phrase(cellTexts[4]))); // Celular
                    table.AddCell(new PdfPCell(new Phrase(cellTexts[5]))); // Localidad
                }

                doc.Add(table);
                doc.Close();

                string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                string folderPath = Server.MapPath("~/Temp");

                // Crear el directorio si no existe
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string pdfFileName = $"ClientesMayoristas_{timestamp}.pdf";
                string pdfPath = Path.Combine(folderPath, pdfFileName);
                File.WriteAllBytes(pdfPath, ms.ToArray());

                // Proporcionar un enlace de descarga
                lblMensaje.Text = $"<a href='/Temp/{pdfFileName}' download='{pdfFileName}'>Haga clic aquí para descargar el archivo PDF</a>";
                lblMensaje.Visible = true;
            }
        }
        
        protected void btnAgregarCliente_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmAltaCliente.aspx");
        }
    }
}

