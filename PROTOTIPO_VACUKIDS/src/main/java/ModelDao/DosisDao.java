package ModelDao;

import Config.Conexion;
import Interfaces.CrudDosis;
import Model.Dosis;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import java.util.List;

public class DosisDao implements CrudDosis{
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    @Override
    public List listar() {
        ArrayList<Dosis> usuarios = new ArrayList<Dosis>();
        String sql = "SELECT*FROM dosis";
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                Dosis f = new Dosis();
                f.setIdDosis(rs.getInt(1));
                f.setIdNino(rs.getInt(2));
                f.setIdVacuna(rs.getInt(3));
                f.setIdVacunador(rs.getInt(4));
                f.setIdCentroSalud(rs.getInt(5));
                f.setFecha_dosis(rs.getDate(6));
                f.setAplicada(rs.getBoolean(7));
                f.setDosis_administrada(rs.getInt(8));
                usuarios.add(f);
            }
        }catch (Exception e){
            System.out.println("Error al listar " + e.getMessage());
        }
        return usuarios;
    }

    @Override
    public Dosis list(int idDosis) {
        String sql = "SELECT * FROM dosis WHERE ID_DOSIS ="+idDosis;
        Dosis f = new Dosis();
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                f.setIdDosis(rs.getInt(1));
                f.setIdNino(rs.getInt(2));
                f.setIdVacuna(rs.getInt(3));
                f.setIdVacunador(rs.getInt(4));
                f.setIdCentroSalud(rs.getInt(5));
                f.setFecha_dosis(rs.getDate(6));
                f.setAplicada(rs.getBoolean(7));
                f.setDosis_administrada(rs.getInt(8));
            }
        } catch (Exception e) {
            System.out.println("Error al listar por ID: " + e.getMessage());
        }
        return f;
    }

    @Override
    public boolean add(Dosis f) {
        String sql = "INSERT INTO dosis (ID_NINO, ID_VACUNA, ID_USUARIO, ID_CENTRO_SALUD, FECHA_DOSIS, APLICADA, DOSIS_ADMIN) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setInt(1, f.getIdNino());
            ps.setInt(2, f.getIdVacuna());
            ps.setInt(3, f.getIdVacunador());
            ps.setInt(4, f.getIdCentroSalud());
            ps.setDate(5, new java.sql.Date(f.getFecha_dosis().getTime()));
            ps.setBoolean(6, f.isAplicada());
            ps.setInt(7, f.getDosis_administrada());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error al agregar: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean edit(Dosis f) {
        String sql = "UPDATE dosis SET ID_NINO = ?, ID_VACUNA = ?, ID_USUARIO = ?, ID_CENTRO_SALUD = ?, FECHA_DOSIS = ?, APLICADA = ?, DOSIS_ADMIN = ?  WHERE  ID_DOSIS = "+f.getIdDosis();
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setInt(1, f.getIdNino());
            ps.setInt(2, f.getIdVacuna());
            ps.setInt(3, f.getIdVacunador());
            ps.setInt(4, f.getIdCentroSalud());
            ps.setDate(5, new java.sql.Date(f.getFecha_dosis().getTime()));
            ps.setBoolean(6, f.isAplicada());
            ps.setInt(7, f.getDosis_administrada());
            ps.setInt(8, f.getIdDosis());
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al editar: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean delete(int idDosis) {
        String sql = "DELETE FROM dosis WHERE ID_DOSIS = ?"+idDosis;
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

