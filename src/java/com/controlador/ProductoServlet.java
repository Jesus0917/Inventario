/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controlador;

import com.modelo.Producto;
import com.modelo.ProductoDAO;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ninoj
 */
public class ProductoServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            //Captura de datos
            int id = Integer.parseInt(request.getParameter("txtId"));
            String nombre = request.getParameter("txtNombre");
            String descripcion = request.getParameter("txtDescripcion");
            Double precio = Double.valueOf(request.getParameter("txtPrecio"));
            int cantidad = Integer.parseInt(request.getParameter("txtCantidad"));
            String mensaje = "Error";
            int res;
            
            Producto p = new Producto(id, nombre, descripcion, precio, cantidad);
            ProductoDAO productoDAO = new ProductoDAO();
            
            if(request.getParameter("btnGuardar") != null){
                res = productoDAO.insertarProducto(p);
                if(res != 0){
                    mensaje = "Registro Agregado";
                }
            }else if(request.getParameter("btnEditar")!= null){
                res = productoDAO.modificarProducto(p);
                if(res != 0){
                    mensaje = "Registro modificado";
                }
            }else if(request.getParameter("btnEliminar")!= null){
                res = productoDAO.eliminarProducto(p);
                if(res != 0){
                    mensaje = "Registro eliminado";
                }
            }
            
            request.setAttribute("message", mensaje);
            request.getRequestDispatcher("/admin/adminProductos.jsp").forward(request, response);
        }catch (Exception e){
            System.out.println("Error "+e.getLocalizedMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
