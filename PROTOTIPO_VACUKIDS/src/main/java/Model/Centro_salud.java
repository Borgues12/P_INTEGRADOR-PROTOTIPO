package Model;

public class Centro_salud {
    private int idCentroSalud;
    private String nombreCentroSalud;
    private double latitud;
    private double longitud;

    public Centro_salud() {
    }
     //No se coloca el idCentroSalud en el constructor
    public Centro_salud(String nombreCentroSalud, double latitud, double longitud) {
        this.nombreCentroSalud = nombreCentroSalud;
        this.latitud = latitud;
        this.longitud = longitud;
    }

    //Getters y Setters

    public int getIdCentroSalud() {
        return idCentroSalud;
    }

    public void setIdCentroSalud(int idCentroSalud) {
        this.idCentroSalud = idCentroSalud;
    }

    public String getNombreCentroSalud() {
        return nombreCentroSalud;
    }

    public void setNombreCentroSalud(String nombreCentroSalud) {
        this.nombreCentroSalud = nombreCentroSalud;
    }

    public double getLatitud() {
        return latitud;
    }

    public void setLatitud(double latitud) {
        this.latitud = latitud;
    }

    public double getLongitud() {
        return longitud;
    }
    public void setLongitud(double longitud) {
        this.longitud = longitud;
    }
}

