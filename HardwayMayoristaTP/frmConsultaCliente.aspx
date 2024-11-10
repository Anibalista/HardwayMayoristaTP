<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="frmConsultaCliente.aspx.cs" Inherits="HardwayMayoristaTP.frmConsultaCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2 class="my-4">Lista de Clientes</h2>
        <div class="row mb-3">
            <div class="col-md-6">
                <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" Placeholder="Buscar cliente..." />
            </div>
            <div class="col-md-2">
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-primary" />
            </div>
            <div class="col-md-4 text-end">
                <asp:Button ID="btnAgregarCliente" runat="server" Text="Agregar Cliente" CssClass="btn btn-warning" OnClick="btnAgregarCliente_Click" />
            </div>
        </div>
        <div class="row mb-3 align-items-end">
            <div class="col-md-4">
                <asp:Button ID="btnExportarExcel" runat="server" Text="Exportar a Excel" CssClass="btn btn-success" OnClick="btnExportarExcel_Click" />

            </div> 
            <div class="col-md-4">
                <asp:Button ID="btnExportarPDF" runat="server" Text="Exportar a PDF" CssClass="btn btn-danger" OnClick="btnExportarPDF_Click" />

            </div>

        </div>
        <div class="table-responsive">
            <asp:GridView ID="GridViewClientes" runat="server" CssClass="col-12" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" OnRowCommand="GridViewClientes_RowCommand">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Dni" HeaderText="Dni" SortExpression="Dni" /> 
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                    <asp:BoundField DataField="Apellido" HeaderText="Apellido" SortExpression="Apellido" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="Telefono" HeaderText="Telefono" SortExpression="Telefono" />
                    <asp:BoundField DataField="Localidad" HeaderText="Localidad" SortExpression="Localidad" />
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditar" runat="server" CommandName="Edit" CommandArgument='<%# Eval("Dni") %>' Text="✏️" CssClass="btn btn-sm btn-primary mx-1"></asp:LinkButton>
                            <asp:LinkButton ID="btnEliminar" runat="server" CommandName="EditEliminar" CommandArgument='<%# Eval("Dni") %>' Text="🗑️" CssClass="btn btn-sm mx-1" OnClientClick="return confirm('¿Está seguro de que desea eliminar este cliente?');"></asp:LinkButton>
                        </ItemTemplate> 
                    </asp:TemplateField>
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HardwayMayoristaConnectionString %>" SelectCommand="SELECT Personas.Dni, Personas.Nombre, Personas.Apellido, Personas.Email, Personas.Telefono, Clientes.Localidad, Clientes.IdPersona FROM Clientes INNER JOIN Personas ON Clientes.IdPersona = Personas.Id INNER JOIN TipoDni ON Personas.IdTipoDni = TipoDni.Id WHERE (Personas.Dni LIKE N'%' + @Consulta + N'%') AND (Clientes.Activo = 1) OR (Clientes.Activo = 1) AND (Personas.Nombre LIKE N'%' + @Consulta + N'%') OR (Clientes.Activo = 1) AND (Personas.Apellido LIKE N'%' + @Consulta + N'%') OR (Clientes.Activo = 1) AND (Personas.Email LIKE N'%' + @Consulta + N'%') OR (Clientes.Activo = 1) AND (Personas.Telefono LIKE N'%' + @Consulta + N'%') OR (Clientes.Activo = 1) AND (Clientes.Localidad LIKE N'%' + @Consulta + N'%')" UpdateCommand="UPDATE Clientes SET Activo = 0 FROM Clientes INNER JOIN Personas ON Clientes.IdPersona = Personas.Id WHERE (Personas.Dni = @Dni)">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtBuscar" ConvertEmptyStringToNull="False" Name="Consulta" PropertyName="Text" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Dni" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Label ID="lblMensaje" runat="server" CssClass="alert alert-info" Visible="false"></asp:Label>

    </div>
</asp:Content>
