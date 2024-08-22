/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function llenarFormulario(fila){
    var id = $(fila).find(".id").text();
    var username = (fila).find(".username").text();
    var password = (fila).find(".password").text();
    var rol = (fila).find(".rol").text();
    
    $("#txtId").val(id);
    $("#txtUsername").val(username);
    $("#txtPassword").val(password);
    $("#txtRol").val(rol);
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
