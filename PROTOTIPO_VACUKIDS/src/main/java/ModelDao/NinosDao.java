package ModelDao;

import Config.Conexion;
import Interfaces.CrudNinos;
import Model.Ninos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NinosDao implements CrudNinos {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    @Override
    public List listar() {
        ArrayList<Ninos> ninos_r = new ArrayList<Ninos>();
        String sql = "SELECT*FROM ninos";
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                Ninos f = new Ninos();
                f.setIdNino(rs.getInt(1));
                f.setIdUser(rs.getInt(2));
                f.setPrimerNombre(rs.getString(3));
                f.setPrimerApellido(rs.getString(4));
                f.setSegundoNombre(rs.getString(5));
                f.setSegundoApellido(rs.getString(6));
                f.setCedulaNino(rs.getString(7));
                f.setFechaNacimiento(rs.getDate(8));
                ninos_r.add(f);
            }
        }catch (Exception e){
            System.out.println("Error al listar " + e.getMessage());
        }
        return ninos_r;
    }

    @Override
    public Ninos list(int idNino) {
        String sql = "SELECT * FROM ninos WHERE ID_NINO ="+idNino;
        Ninos f = new Ninos();
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                f.setIdNino(rs.getInt(1));
                f.setIdUser(rs.getInt(2));
                f.setPrimerNombre(rs.getString(3));
                f.setSegundoNombre(rs.getString(4));
                f.setPrimerApellido(rs.getString(5));
                f.setSegundoApellido(rs.getString(6));
                f.setCedulaNino(rs.getString(7));
                f.setFechaNacimiento(rs.getDate(8));
            }
        } catch (Exception e) {
            System.out.println("Error al listar por ID: " + e.getMessage());
        }
        return f;
    }

    @Override
    public boolean add(Ninos f) {
        String sql = "{INSERT INTO ninos (ID_NINO, ID_USUARIO, P_NOMBRE, S_NOMBRE, P_APELLIDO, S_APELLIDO, CEDULA_NINO, FECHA_NACIMIENTO) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setInt(1, f.getIdNino());
            ps.setInt(2, f.getIdUser());
            ps.setString(3, f.getPrimerNombre());
            ps.setString(4, f.getSegundoNombre());
            ps.setString(5, f.getPrimerApellido());
            ps.setString(6, f.getSegundoApellido());
            ps.setString(7, f.getCedulaNino());
            ps.setDate(8, new java.sql.Date(f.getFechaNacimiento().getTime()));
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error al agregar: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean edit(Ninos f) {
        String sql = "UPDATE ninos SET ID_NINO = ?, ID_USUARIO = ?, P_NOMBRE = ?, S_NOMBRE = ?, P_APELLIDO = ?, S_APELLIDO = ?, CEDULA_NINO = ?, FECHA_NACIMIENTO = ? WHERE  ID_NINO = "+f.getIdNino();
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setInt(1, f.getIdNino());
            ps.setInt(2, f.getIdUser());
            ps.setString(3, f.getPrimerNombre());
            ps.setString(4, f.getSegundoNombre());
            ps.setString(5, f.getPrimerApellido());
            ps.setString(6, f.getSegundoApellido());
            ps.setString(7, f.getCedulaNino());
            ps.setDate(8, new java.sql.Date(f.getFechaNacimiento().getTime()));
            ps.setInt(9, f.getIdNino());
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al editar: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean delete(int idNino) {
        String sql = "DELETE FROM ninos WHERE ID_NINO = ?"+idNino;
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
