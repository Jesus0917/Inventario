/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controlador;

import com.modelo.Usuario;
import com.modelo.UsuarioDAO;
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
public class UserServlet extends HttpServlet {

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
            String idParameter = request.getParameter("txtId");
            int id = 0; // Valor por defecto o manejo de error
            if (idParameter != null && !idParameter.isEmpty()) {
                try {
                    id = Integer.parseInt(idParameter);
                } catch (NumberFormatException e) {
                // Manejar la excepción según sea necesario
                }
            }
            String username = request.getParameter("txtUsername");
            String password = request.getParameter("txtPassword");
            String rol = request.getParameter("txtRol");
            String mensaje = "Error";
            int res;
            
            Usuario u = new Usuario(id, username, password, rol);
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            
            if(request.getParameter("btnGuardar") != null){
                res = usuarioDAO.insertarUsuario(u);
                if(res != 0){
                    mensaje = "Registro Agregado";
                }
            }else if(request.getParameter("btnEditar")!= null){
                res = usuarioDAO.modificarUsuario(u);
                if(res != 0){
                    mensaje = "Registro modificado";
                }
            }else if(request.getParameter("btnEliminar")!= null){
                res = usuarioDAO.eliminarUsuario(u);
                if(res != 0){
                    mensaje = "Registro eliminado";
                }
            }
            
            request.setAttribute("message", mensaje);
            request.getRequestDispatcher("/admin/adminUser.jsp").forward(request, response);
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
