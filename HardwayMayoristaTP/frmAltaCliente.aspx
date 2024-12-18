﻿<%@ Page Title="Alta de Cliente" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frmAltaCliente.aspx.cs" Inherits="HardwayMayoristaTP.frmAltaCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3 mb-4">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="card-title">Registro de Cliente</h5>
                </div>
                <div class="card-body">
                    <asp:Label ID="LabelMensaje" runat="server" Visible="False"></asp:Label>
                        <div class="form-group">
                            <label for="nombre">Nombre</label>
                            <asp:RequiredFieldValidator ID="RequiredNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="Ingrese un nombre" ForeColor="Red" style="margin-left:50px"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionNombre" runat="server" ErrorMessage="El nombre solo puede contener letras" ValidationExpression="^[a-zA-Z\s'-]+$" ForeColor="Red" style="margin-left:10px" ControlToValidate="txtNombre"></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="apellido">
                            Apellido<asp:RequiredFieldValidator ID="RequiredApellido" runat="server" ControlToValidate="txtApellido" ErrorMessage="RequiredFieldValidator" ForeColor="Red" style="margin-left:50px">Ingrese un apellido</asp:RequiredFieldValidator>
                            </label>
                            &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionApellido" runat="server" ErrorMessage="El apellido solo puede contener letras" ValidationExpression="^[a-zA-Z\s'-]+$" ForeColor="Red" style="margin-left:10px" ControlToValidate="txtApellido"></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="email">Email<asp:RequiredFieldValidator ID="RequiredEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Ingrese un Email" ForeColor="Red" style="margin-left:50px"></asp:RequiredFieldValidator>
                            </label>
                            <asp:RegularExpressionValidator ID="RegularExpressionEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Ingrese un email válido" ValidationExpression="^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$" ForeColor="Red" style="margin-left:10px"></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="celular">Celular<asp:RequiredFieldValidator ID="RequiredCelular" runat="server" ControlToValidate="txtCelular" ErrorMessage="Ingrese un n° de celular" ForeColor="Red" style="margin-left:40px"></asp:RequiredFieldValidator>
                            </label>
                            &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionCelular" runat="server" ErrorMessage="Ingrese solo Nros, entre 10 y 13 dígitos" ValidationExpression="^\d{10,13}$" ForeColor="Red" style="margin-left:10px" ControlToValidate="txtCelular"></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtCelular" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="localidad">Localidad<asp:RequiredFieldValidator ID="RequiredLocalidad" runat="server" ControlToValidate="txtLocalidad" ErrorMessage="Ingrese una localidad" ForeColor="Red" style="margin-left:50px"></asp:RequiredFieldValidator>
                            </label>
                            &nbsp;<asp:TextBox ID="txtLocalidad" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="tipoDni">
                            <br />
                            Tipo de Documento</label>&nbsp;
                            <asp:DropDownList ID="DropDownTipoDni" runat="server" DataSourceID="SqlDataSourceTipoDni" DataTextField="Tipo" DataValueField="Id"></asp:DropDownList>
                            <br />
                            <br />
                        </div>
                        <div class="form-group">
                            <label for="dni">DNI<asp:RequiredFieldValidator ID="RequiredDNI" runat="server" ControlToValidate="txtDNI" ErrorMessage="Ingrese un DNI" ForeColor="Red" style="margin-left:50px"></asp:RequiredFieldValidator>
                            </label>
                            &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionDNI" runat="server" ErrorMessage="Ingrese solo números , entre 7 y 8 dígitos" ValidationExpression="^\d{7,8}$" ForeColor="Red" style="margin-left:10px" ControlToValidate="txtDNI"></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group d-flex justify-content-between" style="margin: 5px 150px;">
                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClientClick="return confirmGuardar();" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
                            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" OnClientClick="return confirmCancelar();" CssClass="btn btn-danger" OnClick="btnCancelar_Click" />
                        </div>
                    <script type="text/javascript">
    confirmCancelarcliente() {
        return confirm("¿Estás seguro de cancelar?");
    };
    confirmGuardarcliente() {
        return confirm("¿Estás seguro de guardar los cambios?");
    }
                    </script>
                    
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceClientes" runat="server" ConnectionString="<%$ ConnectionStrings:HardwayMayoristaConnectionString %>" 
    DeleteCommand="DELETE FROM [Clientes] WHERE [Id] = @Id" 
    InsertCommand="INSERT INTO Clientes(IdPersona, Localidad, Activo) VALUES (@IdPersona, @Localidad, 1)" 
    SelectCommand="SELECT * FROM [Clientes]" 
    UpdateCommand="UPDATE [Clientes] SET [IdPersona] = @IdPersona, [IdLocalidad] = @IdLocalidad WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="IdPersona" Type="Int32" />
            <asp:ControlParameter ControlID="txtLocalidad" Name="Localidad" PropertyName="Text" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="IdPersona" Type="Int32" />
            <asp:Parameter Name="IdLocalidad" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePersonas" runat="server" ConnectionString="<%$ ConnectionStrings:HardwayMayoristaConnectionString %>" DeleteCommand="DELETE FROM [Personas] WHERE [Id] = @Id" InsertCommand="INSERT INTO Personas(Dni, Email, Telefono, IdTipoDni, Nombre, Apellido) VALUES (@Dni, @Email, @Telefono, @IdTipoDni, @Nombre, @Apellido)" SelectCommand="SELECT Id, Dni, Email, Telefono, IdTipoDni, Nombre, Apellido FROM Personas WHERE (Dni = @Dni)" UpdateCommand="UPDATE [Personas] SET [Dni] = @Dni, [NombreApellido] = @NombreApellido, [Email] = @Email, [Telefono] = @Telefono, [IdTipoDni] = @IdTipoDni WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="txtDNI" ConvertEmptyStringToNull="False" Name="Dni" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtEmail" ConvertEmptyStringToNull="False" Name="Email" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtCelular" ConvertEmptyStringToNull="False" DefaultValue="" Name="Telefono" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="DropDownTipoDni" ConvertEmptyStringToNull="False" DefaultValue="1" Name="IdTipoDni" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtNombre" ConvertEmptyStringToNull="False" Name="Nombre" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtApellido" ConvertEmptyStringToNull="False" Name="Apellido" PropertyName="Text" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="txtDNI" ConvertEmptyStringToNull="False" Name="Dni" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Dni" Type="String" />
            <asp:Parameter Name="NombreApellido" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="Telefono" Type="String" />
            <asp:Parameter Name="IdTipoDni" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTipoDni" runat="server" ConnectionString="<%$ ConnectionStrings:HardwayMayoristaConnectionString %>" DeleteCommand="DELETE FROM [TipoDni] WHERE [Id] = @Id" InsertCommand="INSERT INTO [TipoDni] ([Tipo]) VALUES (@Tipo)" SelectCommand="SELECT [Id], [Tipo] FROM [TipoDni]" UpdateCommand="UPDATE [TipoDni] SET [Tipo] = @Tipo WHERE [Id] = @Id">
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

