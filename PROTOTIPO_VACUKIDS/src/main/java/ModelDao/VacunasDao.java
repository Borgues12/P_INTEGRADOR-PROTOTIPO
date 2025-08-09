package ModelDao;

import Config.Conexion;
import Model.Vacunas;
import Interfaces.CrudVacunas;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class VacunasDao implements CrudVacunas{
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    @Override
    public List listar() {
        ArrayList<Vacunas> vacu = new ArrayList<Vacunas>();
        String sql = "SELECT*FROM vacunas";
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                Vacunas f = new Vacunas();
                f.setIdVacuna(rs.getInt(1));
                f.setNombreVacuna(rs.getString(2));
                f.setNumeroDosis(rs.getInt(3));
                vacu.add(f);
            }
        }catch (Exception e){
            System.out.println("Error al listar " + e.getMessage());
        }
        return vacu;
    }

    @Override
    public Vacunas list(int idVacuna) {
        String sql = "SELECT * FROM vacunas WHERE ID_VACUNA ="+idVacuna;
        Vacunas f = new Vacunas();
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                f.setIdVacuna(rs.getInt(1));
                f.setNombreVacuna(rs.getString(2));
                f.setNumeroDosis(rs.getInt(3));
            }
        } catch (Exception e) {
            System.out.println("Error al listar por ID: " + e.getMessage());
        }
        return f;
    }

    @Override
    public boolean add(Vacunas f) {
        String sql = "INSERT INTO vacunas (NOMBRE_VACUNA, NUMERO_DOSIS) VALUES (?, ?)";
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, f.getNombreVacuna());
            ps.setInt(2, f.getNumeroDosis());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error al agregar: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean edit(Vacunas f) {
        String sql = "UPDATE vacunas SET NOMBRE_VACUNA = ?, NUMERO_DOSIS = ? WHERE  ID_VACUNA = "+f.getIdVacuna();
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, f.getNombreVacuna());
            ps.setInt(2, f.getNumeroDosis());
            ps.setInt(3, f.getIdVacuna());
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al editar: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean delete(int idVacuna) {
        String sql = "DELETE FROM vacunas WHERE ID_VACUNA = ?"+idVacuna;
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
