<%-- 
    Document   : adminUser
    Created on : 20/11/2023, 03:36:37 PM
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
            <hr>
            <div class="row">
                <div class="col-8"><h1>Gestion de usuarios</h1></div>
                <div class="col-4 align-self-center">
                    <div class="d-grid gap-2">
                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModalA">Agregar nuevo usuario</button>
                    </div>
                </div>
            </div>
            <hr>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <th>Id</th>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Rol</th>
                        <th>Opciones</th>
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
                            <td>
                                <button type="button" class="btn btn-primary btnEditar" data-bs-toggle="modal" data-bs-target="#exampleModal">Editar</button>
                                <button type="button" class="btn btn-danger btnEliminar" data-bs-toggle="modal" data-bs-target="#exampleModal">Eliminar</button>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- Modal Editar -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Datos usuario</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <form action="${pageContext.servletContext.contextPath}/UserServlet" method="POST" role="form">
                      <div class="row">
                          <div class="col-6">
                              <label>Id</label>
                              <input type="number" name="txtId" class="form-control" id="txtId" readonly placeholder="Generacion automatica">
                          </div>
                          <div class="col-6">
                              <label>Username</label>
                              <input type="text" name="txtUsername" class="form-control" id="txtUsername">
                          </div>
                          <div class="col-6">
                              <label>Password</label>
                              <input type="text" name="txtPassword" class="form-control" id="txtPassword">
                          </div>
                          <div class="col-6">
                              <label>Rol</label>
                              <input type="text" name="txtRol" class="form-control" id="txtRol" placeholder="usuario - admin">
                          </div>
                      </div>
                      <div class="row">
                          <div class="col-12">
                              <hr>
                              <button type="submit" name="btnEditar" class="btn btn-primary">Editar</button>
                              <button type="submit" name="btnEliminar" class="btn btn-danger">Eliminar</button>
                          </div>
                      </div>
                  </form>
              </div>
            </div>
          </div>
        </div>
        <!-- Modal Agregar -->
        <div class="modal fade" id="exampleModalA" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Datos usuario</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <form action="${pageContext.servletContext.contextPath}/UserServlet" method="POST" role="form">
                      <div class="row">
                          <div class="col-6">
                              <label>Id</label>
                              <input type="number" name="txtId" class="form-control" id="txtId" readonly placeholder="Generacion automatica">
                          </div>
                          <div class="col-6">
                              <label>Username</label>
                              <input type="text" name="txtUsername" class="form-control" id="txtUsername">
                          </div>
                          <div class="col-6">
                              <label>Password</label>
                              <input type="text" name="txtPassword" class="form-control" id="txtPassword">
                          </div>
                          <div class="col-6">
                              <label>Rol</label>
                              <input type="text" name="txtRol" class="form-control" id="txtRol" placeholder="usuario - admin">
                          </div>
                      </div>
                      <div class="row">
                          <div class="col-12">
                              <hr>
                              <button type="submit" name="btnGuardar" class="btn btn-success">Agregar Usuario</button>
                              <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
                          </div>
                      </div>
                  </form>
              </div>
            </div>
          </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <%
            if(request.getAttribute("message")!= null){   
        %>
        <script>alert('<%= request.getAttribute("message") %>') </script>
        <%
         }
        %>
        <script src="${pageContext.servletContext.contextPath}/js/usuario.js"></script>
    </body>
</html>
