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
                f.setEstado(rs.getString(5));
                centros_s.add(f);
            }
        }catch (Exception e){
            System.out.println("Error al listar " + e.getMessage());
        }
        return centros_s;
    }

    @Override
    public Centro_salud list(int id) {
        Centro_salud f = new Centro_salud();
        String sql = "SELECT * FROM centro_salud WHERE ID_CENTRO_SALUD="+id;
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                f.setIdCentroSalud(rs.getInt(1));
                f.setNombreCentroSalud(rs.getString(2));
                f.setLatitud(rs.getDouble(3));
                f.setLongitud(rs.getDouble(4));
                f.setEstado(rs.getString(5));
            }
        }catch (Exception e){
            System.out.println("Error al listar por id: " + e.getMessage());
        }
            return f;
        }

    @Override
    public List<Centro_salud> buscar(String termino) {
        List<Centro_salud> centros = new ArrayList<>();
        try {
            con = cn.getCon();
            ps = con.prepareStatement("SELECT * FROM centro_salud WHERE NOMBRE_CENTRO_SALUD LIKE ?");
            ps.setString(1,"%"+termino+"%");
            rs = ps.executeQuery();
            while(rs.next()){
                Centro_salud centro = new Centro_salud();
                centro.setIdCentroSalud(rs.getInt(1));
                centro.setNombreCentroSalud(rs.getString(2));
                centro.setLatitud(rs.getDouble(3));
                centro.setLongitud(rs.getDouble(4));
                centro.setEstado(rs.getString(5));
                centros.add(centro);
            }
        }catch (Exception e){
            System.out.println("Error al buscar: " + e.getMessage());
            return null;
        }
        return centros;
    }



    @Override
    public boolean add(Centro_salud f) {
        String sql = "INSERT INTO centro_salud (NOMBRE_CENTRO_SALUD, LATITUD, LONGITUD, ESTADO) VALUES (?, ?, ?, ?)";
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, f.getNombreCentroSalud());
            ps.setDouble(2, f.getLatitud());
            ps.setDouble(3, f.getLongitud());
            ps.setString(4, f.getEstado());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error al agregar: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean edit(Centro_salud f) {
        String sql = "UPDATE centro_salud SET NOMBRE_CENTRO_SALUD = ?, LATITUD = ?, LONGITUD = ?, ESTADO = ? WHERE  ID_CENTRO_SALUD = "+f.getIdCentroSalud();
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, f.getNombreCentroSalud());
            ps.setDouble(2, f.getLatitud());
            ps.setDouble(3, f.getLongitud());
            ps.setString(4,f.getEstado());
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al editar: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean cambiar_estado(int idCentroSalud) {
        String sql = "UPDATE centro_salud SET ESTADO = CASE WHEN ESTADO = 'Activo' THEN 'Inactivo' ELSE 'Activo' END WHERE ID_CENTRO_SALUD = ?";
        try{
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setInt(1,idCentroSalud);
            ps.executeUpdate();
        }catch(Exception e){
            System.out.println(e.getMessage());
            return false;
        }
        return true;
    }
}
