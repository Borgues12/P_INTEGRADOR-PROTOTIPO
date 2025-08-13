package Config;
import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
    Connection con;
    public Conexion() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vacukidsv?useSSL=false", "root", "Jac171225.");
        } catch (Exception e) {
            System.err.println("Error al conectar a la base de datos: " + e.toString());
        }
    }
    public Connection getCon() {
        return con;
    }
}
