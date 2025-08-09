package Model;
import java.util.Date;
public class Ninos {
    private int idNino;
    private int idUser;
    private String primerNombre;
    private String segundoNombre;
    private String primerApellido;
    private String segundoApellido;
    private String cedulaNino; //Advertencia
    private Date fechaNacimiento;
    private boolean Estado;

    public Ninos() {
    }
    //Advertencia: no se coloca el idNino


    public Ninos(int idUser, String primerNombre, String segundoNombre, String primerApellido, String segundoApellido, String cedulaNino, Date fechaNacimiento, boolean estado) {
        this.idUser = idUser;
        this.primerNombre = primerNombre;
        this.segundoNombre = segundoNombre;
        this.primerApellido = primerApellido;
        this.segundoApellido = segundoApellido;
        this.cedulaNino = cedulaNino;
        this.fechaNacimiento = fechaNacimiento;
        Estado = estado;
    }


    public int getIdNino() {
        return idNino;
    }

    public void setIdNino(int idNino) {
        this.idNino = idNino;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getPrimerNombre() {
        return primerNombre;
    }

    public void setPrimerNombre(String primerNombre) {
        this.primerNombre = primerNombre;
    }

    public String getSegundoNombre() {
        return segundoNombre;
    }

    public void setSegundoNombre(String segundoNombre) {
        this.segundoNombre = segundoNombre;
    }

    public String getPrimerApellido() {
        return primerApellido;
    }

    public void setPrimerApellido(String primerApellido) {
        this.primerApellido = primerApellido;
    }

    public String getSegundoApellido() {
        return segundoApellido;
    }

    public void setSegundoApellido(String segundoApellido) {
        this.segundoApellido = segundoApellido;
    }

    public String getCedulaNino() {
        return cedulaNino;
    }

    public void setCedulaNino(String cedulaNino) {
        this.cedulaNino = cedulaNino;
    }

    public Date getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public boolean isEstado() {
        return Estado;
    }

    public void setEstado(boolean estado) {
        Estado = estado;
    }
}