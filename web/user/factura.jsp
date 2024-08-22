<%@ page import="java.util.ArrayList" %>
<%@ page import="com.modelo.Producto" %>
<%@ page import="com.modelo.ProductoDAO" %>
<%@ page import="java.util.Iterator" %>

<%
    // Obtener la lista de productos del carrito desde la sesión
    ArrayList<Producto> carrito = (ArrayList<Producto>) request.getAttribute("carrito");

    // Verificar si la lista de productos del carrito no es nula
    if (carrito != null) {
        // La lista no es nula, puedes acceder a sus elementos

        // Actualizar la cantidad en la base de datos y recalcular el total
        ProductoDAO productoDAO = new ProductoDAO();
        Iterator<Producto> iterator = carrito.iterator();
        while (iterator.hasNext()) {
            Producto item = iterator.next();
            int cantidadActualizada = item.getCantidad();
            int idProducto = item.getId();

            // Actualizar la cantidad en la base de datos
            ProductoDAO.actualizarCantidadProductos(idProducto, cantidadActualizada);

            // Eliminar el producto del carrito si la cantidad es cero
            if (cantidadActualizada == 0) {
                iterator.remove();
            }
        }
    } else {
        // La lista es nula, maneja este caso según tus necesidades
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Factura</title>
    <!-- Enlaces a los estilos de Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- Otros enlaces de estilo o scripts si es necesario -->
</head>
<body>
    <div class="container mt-4">
        <h3>Factura</h3>
        <p><strong>Nombre:</strong> <%= request.getAttribute("nombre") %></p>
        <p><strong>Cédula:</strong> <%= request.getAttribute("cedula") %></p>
        <p><strong>Teléfono:</strong> <%= request.getAttribute("telefono") %></p>

        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th>Precio unitario</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    if (carrito != null) {
                        // La lista no es nula, puedes acceder a sus elementos
                        for (Producto item : carrito) {
                %>
                            <tr>
                                <td><%= item.getId() %></td>
                                <td><%= item.getNombre() %></td>
                                <td><%= item.getCantidad() %></td>
                                <td>$<%= item.getPrecio() %></td>
                                <td>$<%= item.getPrecio() * item.getCantidad() %></td>
                            </tr>
                <%
                        }
                    } else {
                        // La lista es nula, maneja este caso según tus necesidades
                    }
                %>
            </tbody>
        </table>

        <a href="inicioUser.jsp" class="btn btn-primary">Volver al Inicio</a>
    </div>

    <!-- Enlaces a los scripts de Bootstrap y jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <!-- Otros enlaces de scripts si es necesario -->
</body>
</html>
