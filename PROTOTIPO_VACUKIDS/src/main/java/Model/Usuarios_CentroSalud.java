package Model;

public class Usuarios_CentroSalud {
    private int idCentroSalud;
    private int idUser;

    public Usuarios_CentroSalud() {
    }

    public Usuarios_CentroSalud(int idCentroSalud, int idUser) {
        this.idCentroSalud = idCentroSalud;
        this.idUser = idUser;
    }

    public int getIdCentroSalud() {
        return idCentroSalud;
    }

    public void setIdCentroSalud(int idCentroSalud) {
        this.idCentroSalud = idCentroSalud;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }
}
