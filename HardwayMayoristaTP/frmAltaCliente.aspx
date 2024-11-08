<%@ Page Title="Alta de Cliente" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frmAltaCliente.aspx.cs" Inherits="HardwayMayoristaTP.frmAltaCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3 mb-4">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="card-title">Registro de Cliente</h5>
                </div>
                <div class="card-body">
                    
                        <div class="form-group">
                            <label for="nombre">Nombre</label>
                            <asp:RequiredFieldValidator ID="RequiredNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="Debe ingresar un nombre"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="apellido">Apellido</label>
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="celular">Celular</label>
                            <asp:TextBox ID="txtCelular" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="localidad">Localidad</label>
                            <asp:TextBox ID="txtLocalidad" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="dropTipoDni">TIPO DE DNI</label>
                            <asp:DropDownList ID="dropTipoDni" runat="server" DataSourceID="SqlDataSourceTipoDni" DataTextField="Tipo" DataValueField="Id"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="txtDNI">DNI</label>
                            <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group d-flex justify-content-between" style="margin: 5px 150px;">
                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" />
                            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-danger" />
                        </div>

                    
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceClientes" runat="server" ConnectionString="<%$ ConnectionStrings:HardwayMayoristaConnectionString %>" DeleteCommand="DELETE FROM [Clientes] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Clientes] ([IdPersona], [IdLocalidad]) VALUES (@IdPersona, @IdLocalidad)" SelectCommand="SELECT * FROM [Clientes]" UpdateCommand="UPDATE [Clientes] SET [IdPersona] = @IdPersona, [IdLocalidad] = @IdLocalidad WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="IdPersona" Type="Int32" />
            <asp:Parameter Name="IdLocalidad" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="IdPersona" Type="Int32" />
            <asp:Parameter Name="IdLocalidad" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePersonas" runat="server" ConnectionString="<%$ ConnectionStrings:HardwayMayoristaConnectionString %>" DeleteCommand="DELETE FROM [Personas] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Personas] ([Dni], [NombreApellido], [Email], [Telefono], [IdTipoDni]) VALUES (@Dni, @NombreApellido, @Email, @Telefono, @IdTipoDni)" SelectCommand="SELECT * FROM [Personas]" UpdateCommand="UPDATE [Personas] SET [Dni] = @Dni, [NombreApellido] = @NombreApellido, [Email] = @Email, [Telefono] = @Telefono, [IdTipoDni] = @IdTipoDni WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Dni" Type="String" />
            <asp:Parameter Name="NombreApellido" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="Telefono" Type="String" />
            <asp:Parameter Name="IdTipoDni" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Dni" Type="String" />
            <asp:Parameter Name="NombreApellido" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="Telefono" Type="String" />
            <asp:Parameter Name="IdTipoDni" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTipoDni" runat="server" ConnectionString="<%$ ConnectionStrings:HardwayMayoristaConnectionString %>" DeleteCommand="DELETE FROM [TipoDni] WHERE [Id] = @Id" InsertCommand="INSERT INTO [TipoDni] ([Tipo]) VALUES (@Tipo)" SelectCommand="SELECT Id, Tipo FROM TipoDni" UpdateCommand="UPDATE [TipoDni] SET [Tipo] = @Tipo WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Tipo" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Tipo" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

