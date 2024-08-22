<%-- 
    Document   : verProductosAdmin
    Created on : 19-nov-2023, 10:26:38
    Author     : ninoj
--%>

<%@page import="com.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.modelo.Producto" %>
<%@page import="com.modelo.ProductoDAO" %>
<%@page import="java.util.ArrayList" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
%>
<%
    // Verificar si el usuario está autenticado antes de mostrar los productos
    Usuario usuario = (Usuario)session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <title>.:Inventario:.</title>
    </head>
    <body>
        <%!
            ProductoDAO productoDAO = new ProductoDAO();
        %>
        <div class="container">
            <%@include file="../template/menuAdmin.jsp" %>
            <h1>Ver Productos Disponibles</h1>
            <hr>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <th>Id</th>
                        <th>Nombre</th>
                        <th>Descripcion</th>
                        <th>Precio</th>
                        <th>Cantidad Disponible</th>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Producto> ListaProducto = productoDAO.mostrarProductos();
                            for (Producto elem : ListaProducto) {
                        %>
                        <tr>
                            <td class="id"><%= elem.getId() %></td>
                            <td class="nombre"><%= elem.getNombre() %></td>
                            <td class="descripcion"><%= elem.getDescripcion() %></td>
                            <td class="precio"><%= elem.getPrecio() %></td>
                            <td class="cantidad"><%= elem.getCantidad() %></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </body>
</html>
