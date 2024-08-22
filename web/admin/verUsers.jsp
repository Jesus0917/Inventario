<%-- 
    Document   : verUsers
    Created on : 20/11/2023, 03:37:37 PM
    Author     : ninoj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.modelo.Usuario" %>
<%@page import="com.modelo.UsuarioDAO" %>
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
            UsuarioDAO usuarioDAO = new UsuarioDAO();
        %>
        <div class="container">
            <%@include file="../template/menuAdmin.jsp" %>
            <h1>Ver Usuarios</h1>
            <hr>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <th>Id</th>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Rol</th>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Usuario> ListaUsuario = usuarioDAO.mostrarUsuarios();
                            for (Usuario elem : ListaUsuario) {
                        %>
                        <tr>
                            <td class="id"><%= elem.getId() %></td>
                            <td class="username"><%= elem.getUsername() %></td>
                            <td class="password"><%= elem.getPassword() %></td>
                            <td class="rol"><%= elem.getRol() %></td>
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