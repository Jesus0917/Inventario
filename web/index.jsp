<%-- 
    Document   : index
    Created on : 19-nov-2023, 10:02:12
    Author     : ninoj
--%>
<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>.:Inventario:.</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .login-container {
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .login-form {
            padding: 20px;
        }

        .login-form label {
            font-weight: bold;
        }

        .login-form input {
            border-radius: 5px;
        }

        .login-form button {
            border-radius: 5px;
        }

        .close-button {
            background-color: #6c757d;
            color: #fff;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="login-container">
                    <form action="${pageContext.servletContext.contextPath}/LoginServlet" method="post" class="login-form">
                        <h2 class="text-center">Iniciar Sesión</h2>

                        <div class="mb-3">
                            <label for="username" class="form-label">Usuario:</label>
                            <input type="text" id="username" name="username" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Contraseña:</label>
                            <input type="password" id="password" name="password" class="form-control" required>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block">Iniciar Sesión</button>
                        <button type="button" class="btn btn-secondary btn-block close-button" onclick="cerrarNavegador()">Cerrar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <footer class="text-center mt-4">
        <p id="clock"></p>
        <p>Hecho por: Miguel Cuervo - Jesus Garcia</p>
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
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>

