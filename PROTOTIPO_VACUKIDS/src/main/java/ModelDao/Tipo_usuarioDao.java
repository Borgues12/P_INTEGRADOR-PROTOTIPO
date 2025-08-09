package ModelDao;

import Config.Conexion;
import Model.Tipo_usuario;
import Interfaces.CrudTipo_usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Tipo_usuarioDao implements CrudTipo_usuario {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    @Override
    public List listar() {
        ArrayList<Tipo_usuario> tipos = new ArrayList<Tipo_usuario>();
        String sql = "SELECT*FROM tipo_usuario";
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                Tipo_usuario f = new Tipo_usuario();
                f.setIdTipoUsuario(rs.getInt(1));
                f.setNombreTipoUsuario(rs.getString(2));
                tipos.add(f);
            }
        }catch (Exception e){
            System.out.println("Error al listar " + e.getMessage());
        }
        return tipos;
    }

    @Override
    public Tipo_usuario list(int idTipoUsuario) {
        String sql = "SELECT * FROM tipo_usuario WHERE ID_TIPO_USUARIO ="+idTipoUsuario;
        Tipo_usuario f = new Tipo_usuario();
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                f.setIdTipoUsuario(rs.getInt(1));
                f.setNombreTipoUsuario(rs.getString(2));
            }
        } catch (Exception e) {
            System.out.println("Error al listar por ID: " + e.getMessage());
        }
        return f;
    }

    @Override
    public boolean add(Tipo_usuario f) {
        String sql = "INSERT INTO tipo_usuario (NOMBRE_TIPO_USUARIO) VALUES (?)";
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, f.getNombreTipoUsuario());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error al agregar: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean edit(Tipo_usuario f) {
        String sql = "UPDATE tipo_usuario SET NOMBRE_TIPO_USUARIO = ? WHERE  ID_TIPO_USUARIO = "+f.getIdTipoUsuario();
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, f.getNombreTipoUsuario());
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al editar: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean delete(int idTipoUsuario) {
        String sql = "DELETE FROM tipo_usuario WHERE ID_TIPO_USUARIO = ?"+idTipoUsuario;
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error al eliminar: " + e.getMessage());
        }
        return true;
    }
}

