package ModelDao;

import Config.Conexion;
import Interfaces.CrudCentroSalud;
import Model.Centro_salud;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CentroSaludDao implements CrudCentroSalud {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    @Override
    public List listar() {
        ArrayList<Centro_salud> centros_s = new ArrayList<Centro_salud>();
        String sql = "SELECT*FROM centro_salud";
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                Centro_salud f = new Centro_salud();
                f.setIdCentroSalud(rs.getInt(1));
                f.setNombreCentroSalud(rs.getString(2));
                f.setLatitud(rs.getDouble(3));
                f.setLongitud(rs.getDouble(4));
                centros_s.add(f);
            }
        }catch (Exception e){
            System.out.println("Error al listar " + e.getMessage());
        }
        return centros_s;
    }

    @Override
    public Centro_salud list(int idCentroSalud) {
        String sql = "SELECT * FROM centro_salud WHERE ID_CENTRO_SALUD ="+idCentroSalud;
        Centro_salud f = new Centro_salud();
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                f.setIdCentroSalud(rs.getInt(1));
                f.setNombreCentroSalud(rs.getString(2));
                f.setLatitud(rs.getDouble(3));
                f.setLongitud(rs.getDouble(4));
            }
        } catch (Exception e) {
            System.out.println("Error al listar por ID: " + e.getMessage());
        }
        return f;
    }

    @Override
    public boolean add(Centro_salud f) {
        String sql = "INSERT INTO centro_salud (NOMBRE_CENTRO_SALUD, LATITUD, LONGITUD) VALUES (?, ?, ?)";
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, f.getNombreCentroSalud());
            ps.setDouble(2, f.getLatitud());
            ps.setDouble(3, f.getLongitud());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error al agregar: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean edit(Centro_salud f) {
        String sql = "UPDATE centro_salud SET NOMBRE_CENTRO_SALUD = ?, LATITUD = ?, LONGITUD = ? WHERE  ID_CENTRO_SALUD = "+f.getIdCentroSalud();
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, f.getNombreCentroSalud());
            ps.setDouble(2, f.getLatitud());
            ps.setDouble(3, f.getLongitud());
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al editar: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean delete(int idCentroSalud) {
        String sql = "DELETE FROM centro_salud WHERE ID_CENTRO_SALUD = ?"+idCentroSalud;
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
