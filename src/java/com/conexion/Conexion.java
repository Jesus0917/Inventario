package com.conexion;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author ninoj
 */
public class Conexion {
    private Connection con;

    public Connection getCon() {
        return con;
    }

    public void setCon(Connection con) {
        this.con = con;
    }
    
    public void conectar(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/inventario", "root", "");
        }catch(Exception e){
            System.out.println("Error al conectar"+e.getMessage());
        }
    }
    
    public void desconectar(){
        try{
            if(!con.isClosed()){
                con.close();
            }
        }catch(Exception e){
            System.out.println("Error al cerrar"+e.getMessage());
        }
    }
}
