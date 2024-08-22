<%-- 
    Document   : menu
    Created on : 19-nov-2023, 10:10:07
    Author     : ninoj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">INVENTARIO</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="${pageContext.servletContext.contextPath}/admin/inicioAdmin.jsp">Home</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Reportes
          </a>
          <ul class="dropdown-menu">
            <li class="nav-item">
                <a class="dropdown-item" href="${pageContext.servletContext.contextPath}/admin/verProductosAdmin.jsp">Ver Productos</a>
            </li>
            <li class="nav-item">
                <a class="dropdown-item" href="${pageContext.servletContext.contextPath}/admin/verUsers.jsp">Ver Usuarios</a>
            </li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Gestionar
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="${pageContext.servletContext.contextPath}/admin/adminProductos.jsp">Productos</a></li>
            <li><a class="dropdown-item" href="${pageContext.servletContext.contextPath}/admin/adminUser.jsp">Usuarios</a></li>
          </ul>
        </li>
      </ul>
      <!-- Agregar botón de cerrar sesión -->
      <form class="d-flex">
        <a class="btn btn-outline-danger" href="${pageContext.servletContext.contextPath}/LogoutServlet">Cerrar Sesión</a>
      </form>
    </div>
  </div>
</nav>
