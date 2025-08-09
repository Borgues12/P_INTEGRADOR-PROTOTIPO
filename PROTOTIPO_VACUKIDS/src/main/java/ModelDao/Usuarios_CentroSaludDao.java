package ModelDao;

import Config.Conexion;
import Model.Usuarios_CentroSalud;
import Interfaces.CrudUsuarios_CentroSalud;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Usuarios_CentroSaludDao implements CrudUsuarios_CentroSalud{
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    @Override
    public List listar() {
        ArrayList<Usuarios_CentroSalud> user_cs = new ArrayList<Usuarios_CentroSalud>();
        String sql = "SELECT*FROM usuario_centrosalud";
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                Usuarios_CentroSalud f = new Usuarios_CentroSalud();
                f.setIdCentroSalud(rs.getInt(1));
                f.setIdUser(rs.getInt(2));
                user_cs.add(f);
            }
        }catch (Exception e){
            System.out.println("Error al listar " + e.getMessage());
        }
        return user_cs;
    }

    @Override
    public Usuarios_CentroSalud list_centro(int idCentroSalud) {
        String sql = "SELECT * FROM usuario_centrosalud WHERE ID_CENTRO_SALUD ="+idCentroSalud;
        Usuarios_CentroSalud f = new Usuarios_CentroSalud();
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                f.setIdCentroSalud(rs.getInt(1));
                f.setIdUser(rs.getInt(2));
            }
        } catch (Exception e) {
            System.out.println("Error al listar por idCentroSalud: " + e.getMessage());
        }
        return f;
    }

    @Override
    public Usuarios_CentroSalud list_user(int idUser) {
        String sql = "SELECT * FROM usuario_centrosalud WHERE ID_USUARIO ="+idUser;
        Usuarios_CentroSalud f = new Usuarios_CentroSalud();
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                f.setIdCentroSalud(rs.getInt(1));
                f.setIdUser(rs.getInt(2));
            }
        } catch (Exception e) {
            System.out.println("Error al listar por idUser: " + e.getMessage());
        }
        return f;
    }

    @Override
    public boolean add(Usuarios_CentroSalud f) {
        String sql = "INSERT INTO usuario_centrosalud (ID_CENTRO_SALUD, ID_USUARIO) VALUES (?, ?)";
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setInt(1, f.getIdCentroSalud());
            ps.setInt(2, f.getIdUser());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error al agregar: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean edit_centro(Usuarios_CentroSalud f) {
        String sql = "UPDATE usuario_centrosalud SET ID_CENTRO_SALUD = ?, ID_USUARIO = ? WHERE  ID_CENTRO_SALUD = "+f.getIdCentroSalud();
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setInt(1, f.getIdCentroSalud());
            ps.setInt(2, f.getIdUser());
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al editar por idCentroSalud: " + e.getMessage());
        }
        return true;
    }
    @Override
    public boolean edit_user(Usuarios_CentroSalud f) {
        String sql = "UPDATE usuario_centrosalud SET ID_CENTRO_SALUD = ?, ID_USUARIO = ? WHERE  ID_USUARIO = " + f.getIdUser();
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setInt(1, f.getIdCentroSalud());
            ps.setInt(2, f.getIdUser());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error al editar por idUser: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean delete_centro(int idCentroSalud) {
        String sql = "DELETE FROM usuario_centrosalud WHERE ID_CENTRO_SALUD = ?"+idCentroSalud;
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error al eliminar por idCentroSalud: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean delete_user(int idUser) {
        String sql = "DELETE FROM usuario_centrosalud WHERE ID_USUARIO = ?"+idUser;
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error al eliminar por idUser: " + e.getMessage());
        }
        return true;
    }
}
