<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.modelo.Producto"%>
<%@page import="com.modelo.ProductoDAO"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Facturacion</title>
    <!-- Enlaces a los estilos de Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        /* Estilo adicional para mejorar la apariencia del formulario */
        body {
            background-color: #f8f9fa;
        }

        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px #000000;
            margin-top: 50px;
        }

        h3 {
            color: #black;
        }

        /* Estilo para la descripción del producto */
        #descripcionProducto {
            font-style: italic;
            margin-top: 10px;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            background-color: #ffffff;
            color: #6c757d;
        }

        /* Estilo para la tabla del carrito */
        #tablaCarrito {
            margin-top: 20px;
        }
    </style>
    <script>
        // Lista de productos disponible para el script
        var productos = [
            <% ProductoDAO productoDAO = new ProductoDAO(); %>
            <% ArrayList<Producto> productos = productoDAO.mostrarProductos(); %>
            <% for (Producto p : productos) { %>
                {id: <%= p.getId() %>, nombre: '<%= p.getNombre() %>', descripcion: '<%= p.getDescripcion() %>', cantidad: <%= p.getCantidad() %>, precio: <%= p.getPrecio() %>},
            <% } %>
        ];

        // Lista para almacenar los productos seleccionados
        var carrito = [];

        // Función para actualizar la cantidad y mostrar la descripción al cambiar la selección del producto
        function actualizarInformacionProducto() {
            var productoSeleccionado = document.getElementById("producto");
            var cantidadInput = document.getElementById("cantidad");
            var descripcionProducto = document.getElementById("descripcionProducto");

            var producto = productos.find(p => p.id === parseInt(productoSeleccionado.value));
            cantidadInput.value = producto ? 1 : "";
            descripcionProducto.textContent = producto ? producto.descripcion : "";
            document.getElementById("cantidadDisponible").textContent = producto ? producto.cantidad : "";
        }

        // Función para agregar un producto al carrito
        function agregarAlCarrito() {
            var productoSeleccionado = document.getElementById("producto");
            var cantidadInput = document.getElementById("cantidad");

            var producto = productos.find(p => p.id === parseInt(productoSeleccionado.value));

            // Validar que la cantidad sea mayor que cero y no exceda la cantidad disponible
            if (producto && parseInt(cantidadInput.value) > 0 && parseInt(cantidadInput.value) <= producto.cantidad) {
                // Agregar el producto al carrito
                carrito.push({
                    id: producto.id,
                    nombre: producto.nombre,
                    cantidad: parseInt(cantidadInput.value),
                    precio: producto.precio
                });

                // Limpiar campos después de agregar al carrito
                productoSeleccionado.value = "";
                cantidadInput.value = "";

                // Actualizar la tabla del carrito
                mostrarCarrito();
            } else {
                alert("Selecciona un producto, proporciona una cantidad válida y asegúrate de que no exceda la cantidad disponible.");
            }
        }

        // Función para eliminar un producto del carrito
        function eliminarDelCarrito(index) {
            carrito.splice(index, 1);
            mostrarCarrito();
        }

        // Función para mostrar el contenido del carrito en la tabla
        function mostrarCarrito() {
            var tablaCarrito = document.getElementById("tablaCarrito");
            tablaCarrito.innerHTML = "";

            // Encabezado de la tabla
            tablaCarrito.innerHTML += "<thead><tr><th>ID</th><th>Producto</th><th>Cantidad</th><th>Precio unitario</th><th>Total</th><th>Acciones</th></tr></thead>";

            // Cuerpo de la tabla
            tablaCarrito.innerHTML += "<tbody>";
            var totalCarrito = 0;
            carrito.forEach(function (item, index) {
                var total = item.cantidad * item.precio;
                totalCarrito += total;
                tablaCarrito.innerHTML += "<tr><td>" + item.id + "</td><td>" + item.nombre + "</td><td>" + item.cantidad + "</td><td>$" + item.precio.toFixed(2) + "</td><td>$" + total.toFixed(2) + "</td><td><button type='button' class='btn btn-danger btn-sm' onclick='eliminarDelCarrito(" + index + ")'>Eliminar</button></td></tr>";
            });
            tablaCarrito.innerHTML += "</tbody>";

            // Mostrar total del carrito
            tablaCarrito.innerHTML += "<tfoot><tr><td colspan='4' class='text-end'><strong>Total Carrito:</strong></td><td>$" + totalCarrito.toFixed(2) + "</td><td></td></tr></tfoot>";
        }
        window.onload = function () {
            mostrarCarrito();
        };
        
        function generarFactura() {
        // Verificar que haya productos en el carrito
        if (carrito.length === 0) {
            alert("Agrega productos al carrito antes de facturar.");
            return;
        }

        // Obtener datos del cliente
        var nombreCliente = document.getElementById("txtNombre").value;
        var cedulaCliente = document.getElementById("txtCedula").value;
        var telefonoCliente = document.getElementById("txtTelefono").value;

        // Verificar que se hayan ingresado los datos del cliente
        if (!nombreCliente || !cedulaCliente || !telefonoCliente) {
            alert("Ingresa todos los datos del cliente antes de facturar.");
            return;
        }

        // Crear un objeto con los datos del cliente y productos
        var facturaData = {
            cliente: {
                nombre: nombreCliente,
                cedula: cedulaCliente,
                telefono: telefonoCliente
            },
            productos: carrito
        };

        // Realizar una petición al servidor para actualizar la base de datos
        fetch('ActualizaBaseDeDatosServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(facturaData),
        })
        .then(response => response.json())
        .then(data => {
            // La respuesta del servidor puede contener información adicional
            console.log('Respuesta del servidor:', data);

            // Después de actualizar la base de datos, redirigir a la página de inicio
            window.location.href = "factura.jsp";
        })
        .catch((error) => {
            console.error('Error al enviar la solicitud al servidor:', error);
        });
    }
    </script>
</head>
<body>

<div class="container mt-4">
    <div class="row">
        <!-- Formulario de Cliente y Productos -->
        <div class="col-md-6">
            <h3 class="mb-4">Información del Cliente y Productos</h3>
            <form action="FacturaServlet" method="POST">
                <!-- Información del Cliente -->
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre:</label>
                    <input type="text" class="form-control" id="txtNombre" name="txtNombre" required>
                </div>
                <div class="mb-3">
                    <label for="cedula" class="form-label">Cédula:</label>
                    <input type="number" class="form-control" id="txtCedula" name="txtCedula" required>
                </div>
                <div class="mb-3">
                    <label for="telefono" class="form-label">Teléfono:</label>
                    <input type="number" class="form-control" id="txtTelefono" name="Telefono" required>
                </div>

                <!-- Información de Productos -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="producto" class="form-label">Seleccionar Producto:</label>
                        <select class="form-control" id="producto" name="producto" required onchange="actualizarInformacionProducto()">
                            <!-- Placeholder para indicar al usuario -->
                            <option value="" disabled selected>Selecciona un producto</option>
                            <!-- Opciones de productos -->
                            <% for (Producto p : productos) { %>
                                <option value="<%= p.getId() %>"><%= p.getNombre() %></option>
                            <% } %>
                        </select>
                        <!-- Descripción del producto -->
                        <div id="descripcionProducto"></div>
                        <!-- Cantidad disponible -->
                        <div>Cantidad Disponible: <span id="cantidadDisponible"></span></div>
                        <!-- Botón para agregar al carrito -->
                        <button type="button" class="btn btn-success mt-3" onclick="agregarAlCarrito()">Agregar al Carrito</button>
                    </div>
                    <div class="col-md-6">
                        <label for="cantidad" class="form-label">Cantidad Deseada:</label>
                        <input type="number" class="form-control" id="cantidad" name="cantidad" min="1" required>
                    </div>
                </div>
            </form>
        </div>

        <!-- Tabla del Carrito -->
        <div class="col-md-6">
            <h3 class="mb-4">Carrito de Compras</h3>
            <table class="table" id="tablaCarrito">
                <!-- La tabla del carrito se generará dinámicamente desde el script -->
            </table>
            <!-- Botones de Acción -->
                <div class="text-center">
                    <!-- Botón para generar factura y volver al inicio -->
                    <button type="button" class="btn btn-primary" onclick="generarFactura()">Facturar</button>
                </div>
        </div>
    </div>
</div>

<!-- Enlaces a los scripts de Bootstrap y jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
