/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.modelo;

import com.conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ninoj
 */
public class ProductoDAO extends Conexion{
    public ArrayList<Producto> mostrarProductos(){
        ArrayList<Producto> listap = new ArrayList<>();
        try{
            this.conectar();
            String sql = "SELECT * FROM producto";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            ResultSet rs;
            rs = pre.executeQuery();
            
            while(rs.next()){
                Producto p = new Producto();
                p.setId(rs.getInt(1));
                p.setNombre(rs.getString(2));
                p.setDescripcion(rs.getString(3));
                p.setPrecio(rs.getDouble(4));
                p.setCantidad(rs.getInt(5));
                listap.add(p);
            }
            
        }catch(SQLException e){
            System.out.println("Error al mostrar" +e.getMessage());
        } finally{
            this.desconectar();
        }
        return listap;
    }
    
    public int insertarProducto(Producto p){
        int res = 0;
        try{
            this.conectar();
            String sql = "INSERT INTO producto(id, nombre, descripcion, precio, cantidad) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, p.getId());
            pre.setString(2, p.getNombre());
            pre.setString(3, p.getDescripcion());
            pre.setDouble(4, p.getPrecio());
            pre.setInt(5, p.getCantidad());
            res = pre.executeUpdate();
        }catch(SQLException e){
            System.out.println("Error al insertar" +e.getMessage());
        }finally{
            this.desconectar();
        }
        return res;
    }
    
    public int modificarProducto(Producto p){
        int res = 0;
        try{
            this.conectar();
            String sql = "UPDATE producto SET nombre=?, descripcion=?, precio=?, cantidad=? WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, p.getNombre());
            pre.setString(2, p.getDescripcion());
            pre.setDouble(3, p.getPrecio());
            pre.setInt(4, p.getCantidad());
            pre.setInt(5, p.getId());
            res = pre.executeUpdate();
        }catch(SQLException e){
            System.out.println("Error al modificar" +e.getMessage());
        }finally{
            this.desconectar();
        }
        return res;
    }
    
    public int eliminarProducto(Producto p){
        int res = 0;
        try{
            this.conectar();
            String sql = "DELETE FROM producto WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, p.getId());
            res = pre.executeUpdate();
        }catch(SQLException e){
            System.out.println("Error al eliminar" +e.getMessage());
        }finally{
            this.desconectar();
        }
        return res;
    }
    
    public void actualizarCantidadProductos(int idProducto, int nuevaCantidad) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Conexion conexion = new Conexion();
            conexion.conectar();
            conn = conexion.getCon();

            String query = "UPDATE producto SET cantidad = ? WHERE id = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, nuevaCantidad);
            stmt.setInt(2, idProducto);
            stmt.executeUpdate();
        } catch (SQLException e) {
            // Manejar excepciones de SQL
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
