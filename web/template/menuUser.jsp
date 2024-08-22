<%-- 
    Document   : menuUser
    Created on : 20/11/2023, 01:21:54 PM
    Author     : ninoj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="inicioUser.jsp">INVENTARIO</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.servletContext.contextPath}/user/inicioUser.jsp">Home</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Reportes
          </a>
          <ul class="dropdown-menu">
            <li class="nav-item">
                <a class="dropdown-item" href="${pageContext.servletContext.contextPath}/user/verProductosUser.jsp">Ver Productos</a>
            </li>
          </ul>
        </li>
      </ul>
      <form class="d-flex">
        <a class="btn btn-outline-danger" href="${pageContext.servletContext.contextPath}/LogoutServlet">Cerrar Sesión</a>
      </form>
    </div>
  </div>
</nav>