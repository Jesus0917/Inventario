/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function llenarFormulario(fila){
    var id = $(fila).find(".id").text();
    var nombre = (fila).find(".nombre").text();
    var descripcion = (fila).find(".descripcion").text();
    var precio = (fila).find(".precio").text();
    var cantidad = (fila).find(".cantidad").text();
    
    $("#txtId").val(id);
    $("#txtNombre").val(nombre);
    $("#txtDescripcion").val(descripcion);
    $("#txtPrecio").val(precio);
    $("#txtCantidad").val(cantidad);
    $("#txtId option[selected]").removeAttr('selected');
    
}

$(document).ready(function(){
   $("#exampleModal").on("hidden.bs.modal", function(){
       $('form')[0].reset();
   });
   $(document).on('click', '.btnEditar', function(){
        llenarFormulario($(this).closest('tr'));
   });
   $(document).on('click', '.btnEliminar', function(){
        llenarFormulario($(this).closest('tr'));
   });
});