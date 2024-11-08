<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmLogin.aspx.cs" Inherits="HardwayMayoristaTP.frmLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login Hardway</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
    <style>
        .login-card {
            background-color: #ffffff; /* Fondo blanco para la tarjeta */
            min-height: 600px; /* Mínimo de 600px */
            height: 50vh; /* 50% del navegador */
            display: flex;
            flex-direction: column;
            justify-content: space-around; /* Distribuir uniformemente los campos */
            margin-top: 100px;
            border-radius: 15px; /* Bordes redondeados */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Sombra */
            padding: 20px; /* Añadir algo de padding */
        }
        body {
            background: linear-gradient(71.17deg, #FEAF00 19.35%, #F8D442 90.12%); /* Gradiente de fondo */
        }
        .validation-error {
            color: red;
        }
        .auto-style1 {
            width: 1304px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-4 col-lg-6 col-md-8 col-sm-10 col-12 d-flex justify-content-center">
                    <div class="card login-card">
                        <div class="card-body">
                            <h3 class="auto-style1">Hardway Mayorista</h3>
                            <div class="form-group">
                                <label for="Usuario">Usuario</label>
                                <asp:TextBox ID="Usuario" runat="server" CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvUsuario" runat="server" ControlToValidate="Usuario" ErrorMessage="El campo Usuario es obligatorio." CssClass="validation-error" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label for="Contrasena">Contraseña</label>
                                <asp:TextBox ID="Contrasena" runat="server" TextMode="Password" CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvContrasena" runat="server" ControlToValidate="Contrasena" ErrorMessage="El campo Contraseña es obligatorio." CssClass="validation-error" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revContrasena" runat="server" ControlToValidate="Contrasena" ErrorMessage="La contraseña debe tener al menos 8 caracteres." ValidationExpression=".{8,}" CssClass="validation-error" Display="Dynamic" />
                            </div>
                            <asp:Button ID="btnLogin" runat="server" Text="INICIAR SESIÓN" CssClass="btn btn-warning btn-block mt-3" OnClick="btnLogin_Click" />
                            <a href="#" class="d-block text-center mt-3">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HardwayMayoristaConnectionString %>" SelectCommand="SELECT Usuarios.Id, Usuarios.[User], Usuarios.password, Usuarios.Activo, Usuarios.FechaAlta, Usuarios.Observaciones, Usuarios.IdNivel, Usuarios.IdPersona, Usuarios.IntentosFallidos, Personas.NombreApellido, Niveles.Nivel FROM Usuarios INNER JOIN Personas ON Usuarios.IdPersona = Personas.Id INNER JOIN Niveles ON Usuarios.IdNivel = Niveles.Id WHERE (Usuarios.[User] = @User ) AND (Usuarios.password = @password)" DeleteCommand="DELETE FROM [Usuarios] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Usuarios] ([User], [password], [Activo], [FechaAlta], [Observaciones], [IdNivel], [IdPersona], [IntentosFallidos]) VALUES (@User, @password, @Activo, @FechaAlta, @Observaciones, @IdNivel, @IdPersona, @IntentosFallidos)" UpdateCommand="UPDATE Usuarios SET Activo = 1, IntentosFallidos = 0 WHERE ([User] = @User )">
                                <DeleteParameters>
                                    <asp:Parameter Name="Id" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="User" Type="String" />
                                    <asp:Parameter Name="password" Type="String" />
                                    <asp:Parameter Name="Activo" Type="Boolean" />
                                    <asp:Parameter DbType="DateTime2" Name="FechaAlta" />
                                    <asp:Parameter Name="Observaciones" Type="String" />
                                    <asp:Parameter Name="IdNivel" Type="Int32" />
                                    <asp:Parameter Name="IdPersona" Type="Int32" />
                                    <asp:Parameter Name="IntentosFallidos" Type="Int32" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="Usuario" Name="User" PropertyName="Text" Type="String" />
                                    <asp:ControlParameter ControlID="Contrasena" Name="password" PropertyName="Text" Type="String" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:ControlParameter ControlID="Usuario" Name="User" PropertyName="Text" Type="String" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            ¿Olvidó su contraseña? Restaurar contraseña</a>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:HardwayMayoristaConnectionString %>" SelectCommand="SELECT [User], IntentosFallidos, Activo FROM Usuarios WHERE ([User] = @User )" UpdateCommand="UPDATE Usuarios SET Activo = @activo, IntentosFallidos = @intentosFallidos WHERE ([User] = @user )">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="Usuario" Name="User" PropertyName="Text" Type="String" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:SessionParameter ConvertEmptyStringToNull="False" DefaultValue="" Name="intentosFallidos" SessionField="intentosFallidos" />
                                    <asp:SessionParameter ConvertEmptyStringToNull="False" Name="activo" SessionField="activo" />
                                    <asp:ControlParameter ControlID="Usuario" ConvertEmptyStringToNull="False" Name="user" PropertyName="Text" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <br />
                            <br />
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validation-error" HeaderText="Por favor corrija los siguientes errores:" />
                            <br />

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
