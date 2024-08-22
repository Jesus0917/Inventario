/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.modelo;

import com.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author ninoj
 */
public class UsuarioDAO extends Conexion{
    public ArrayList<Usuario> mostrarUsuarios(){
        ArrayList<Usuario> listaU = new ArrayList<>();
        try{
            this.conectar();
            String sql = "SELECT * FROM usuario WHERE rol='usuario'";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            ResultSet rs;
            rs = pre.executeQuery();
            
            while(rs.next()){
                Usuario u = new Usuario();
                u.setId(rs.getInt(1));
                u.setUsername(rs.getString(2));
                u.setPassword(rs.getString(3));
                u.setRol(rs.getString(4));
                listaU.add(u);
            }
            
        }catch(SQLException e){
            System.out.println("Error al mostrar" +e.getMessage());
        } finally{
            this.desconectar();
        }
        return listaU;
    }
    public int insertarUsuario(Usuario u){
        int res = 0;
        try{
            this.conectar();
            String sql = "INSERT INTO usuario(id, username, password, rol) VALUES (NULL, ?, ?, ?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pre.setString(1, u.getUsername());
            pre.setString(2, u.getPassword());
            pre.setString(3, u.getRol());
            res = pre.executeUpdate();
            // Recuperar el ID generado automáticamente
            ResultSet generatedKeys = pre.getGeneratedKeys();
            if (generatedKeys.next()) {
                int generatedId = generatedKeys.getInt(1);
                u.setId(generatedId); // Establecer el ID generado en el objeto Usuario
            } else {
                System.out.println("No se pudo obtener el ID generado");
            }
        }catch(SQLException e){
            System.out.println("Error al insertar" +e.getMessage());
        }finally{
            this.desconectar();
        }
        return res;
    }
    public int modificarUsuario(Usuario u){
        int res = 0;
        try{
            this.conectar();
            String sql = "UPDATE usuario SET username=?, password=?, rol=? WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, u.getUsername());
            pre.setString(2, u.getPassword());
            pre.setString(3, u.getRol());
            pre.setInt(4, u.getId());
            res = pre.executeUpdate();
        }catch(SQLException e){
            System.out.println("Error al modificar" +e.getMessage());
        }finally{
            this.desconectar();
        }
        return res;
    }
    public int eliminarUsuario(Usuario u){
        int res = 0;
        try{
            this.conectar();
            String sql = "DELETE FROM usuario WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, u.getId());
            res = pre.executeUpdate();
        }catch(SQLException e){
            System.out.println("Error al eliminar" +e.getMessage());
        }finally{
            this.desconectar();
        }
        return res;
    }
    public Usuario obtenerUsuarioPorCredenciales(String username, String password) {
        Usuario usuario = null;

        try {
            this.conectar();
            String sql = "SELECT * FROM usuario WHERE username = ? AND password = ?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, username);
            pre.setString(2, password);

            ResultSet rs = pre.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setUsername(rs.getString("username"));
                usuario.setPassword(rs.getString("password"));
                usuario.setRol(rs.getString("rol"));
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener usuario por credenciales: " + e.getMessage());
        } finally {
            this.desconectar();
        }

        return usuario;
    }
}
