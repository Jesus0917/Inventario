<%-- 
    Document   : inicio
    Created on : 19-nov-2023, 10:04:02
    Author     : ninoj
--%>

<%@page import="com.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <title>.:Inventario:.</title>
    </head>
    <body>
        <div class="container">
            <%@include file="../template/menuAdmin.jsp" %>
            <h1>Bienvenido al sistema de Inventario</h1>

            <%-- Obtener el usuario desde la sesión --%>
            <%
                Usuario usuario = (Usuario) session.getAttribute("usuario");
                if (usuario != null) {
            %>
            <br>
            <h2>Usuario: <%= usuario.getUsername() %></h2>
            <%
                }
            %>
        </div>
        <footer class="text-center mt-4">
            <p id="clock"></p>
        </footer>
        <script>
            function cerrarNavegador() {
                window.close();
            }

            function updateClock() {
                var now = new Date();
                var hours = now.getHours();
                var minutes = now.getMinutes();
                var seconds = now.getSeconds();
                var formattedTime = padZero(hours) + ":" + padZero(minutes) + ":" + padZero(seconds);

                var date = now.toDateString();

                document.getElementById("clock").innerHTML = "Hora: " + formattedTime + " | Fecha: " + date;

                setTimeout(updateClock, 1000); // Actualizar cada segundo
            }

            function padZero(num) {
                return (num < 10 ? '0' : '') + num;
            }

            // Llamar a la función de actualización inicial
            updateClock();
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </body>
    <footer>
        
    </footer>
</html>