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
                            <label for="dni">DNI</label>
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
</asp:Content>

