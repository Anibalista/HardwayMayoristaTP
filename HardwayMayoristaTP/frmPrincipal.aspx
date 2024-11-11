<%@ Page Title="Principal" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frmPrincipal.aspx.cs" Inherits="HardwayMayoristaTP.frmPrincipal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-12 col-md-6 col-lg-3 mb-4">
            <div class="card bg-primary text-white h-100 shadow-lg" style="min-height: 200px;">
                <div class="card-body">
                    <h4 class="card-title">Pedidos</h4>
                    <p class="card-text">Gestión de pedidos.</p>
                </div>
                <div class="card-footer d-flex justify-content-between align-items-center">
                    <span>Total pedidos</span>
                    <span>76</span>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-3 mb-4">
            <div class="card bg-success text-white h-100 shadow-lg" style="min-height: 200px;">
                <div class="card-body">
                    <h4 class="card-title">Clientes</h4>
                    <p class="card-text">Gestión de clientes.</p>
                </div>
                <div class="card-footer d-flex justify-content-between align-items-center">
                    <span>Total clientes</span>
                    <asp:Label ID="LabelClientes" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-3 mb-4">
            <div class="card bg-warning text-white h-100 shadow-lg" style="min-height: 200px;">
                <div class="card-body">
                    <h4 class="card-title">Usuarios</h4>
                    <p class="card-text">Gestión de usuarios.</p>
                </div>
                <div class="card-footer d-flex justify-content-between align-items-center">
                    <span>Total usuarios</span>
                    <asp:Label ID="LabelUsers" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HardwayMayoristaConnectionString %>" SelectCommand="SELECT Id, IdPersona, Localidad, Activo FROM Clientes WHERE (Activo = 1)"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:HardwayMayoristaConnectionString %>" SelectCommand="SELECT * FROM [Usuarios]"></asp:SqlDataSource>
    </div>
</asp:Content>

