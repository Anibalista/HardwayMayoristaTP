<%@ Page Title="Principal" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frmPrincipal.aspx.cs" Inherits="HardwayMayoristaTP.frmPrincipal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-12 col-md-6 col-lg-3 mb-4">
            <div class="card bg-primary text-white h-100">
                <div class="card-body">
                    <h5 class="card-title">Pedidos</h5>
                    <p class="card-text">Gestión de pedidos.</p>
                </div>
                <div class="card-footer d-flex justify-content-between align-items-center">
                    <span>Total pedidos</span>
                    <span>76</span>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-3 mb-4">
            <div class="card bg-success text-white h-100">
                <div class="card-body">
                    <h5 class="card-title">Clientes</h5>
                    <p class="card-text">Gestión de clientes.</p>
                </div>
                <div class="card-footer d-flex justify-content-between align-items-center">
                    <span>Total clientes</span>
                    <span>3</span>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-3 mb-4">
            <div class="card bg-warning text-white h-100">
                <div class="card-body">
                    <h5 class="card-title">Usuarios</h5>
                    <p class="card-text">Gestión de usuarios.</p>
                </div>
                <div class="card-footer d-flex justify-content-between align-items-center">
                    <span>Total usuarios</span>
                    <span>4</span>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
