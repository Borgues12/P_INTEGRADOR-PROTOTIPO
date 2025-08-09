package Model;

import java.util.Date;

public class Dosis {
    private int idDosis;
    private int idNino;
    private int idVacuna;
    private int idVacunador;
    private int idCentroSalud;
    private Date fecha_dosis;
    private boolean aplicada;
    private int dosis_administrada;

    public Dosis() {
    }

    public Dosis(int idNino, int idVacuna, int idVacunador, int idCentroSalud, Date fecha_dosis, boolean aplicada, int dosis_administrada) {
        this.idNino = idNino;
        this.idVacuna = idVacuna;
        this.idVacunador = idVacunador;
        this.idCentroSalud = idCentroSalud;
        this.fecha_dosis = fecha_dosis;
        this.aplicada = aplicada;
        this.dosis_administrada = dosis_administrada;
    }

    public int getIdDosis() {
        return idDosis;
    }

    public void setIdDosis(int idDosis) {
        this.idDosis = idDosis;
    }

    public int getIdNino() {
        return idNino;
    }

    public void setIdNino(int idNino) {
        this.idNino = idNino;
    }

    public int getIdVacuna() {
        return idVacuna;
    }

    public void setIdVacuna(int idVacuna) {
        this.idVacuna = idVacuna;
    }

    public int getIdVacunador() {
        return idVacunador;
    }

    public void setIdVacunador(int idVacunador) {
        this.idVacunador = idVacunador;
    }

    public int getIdCentroSalud() {
        return idCentroSalud;
    }

    public void setIdCentroSalud(int idCentroSalud) {
        this.idCentroSalud = idCentroSalud;
    }

    public Date getFecha_dosis() {
        return fecha_dosis;
    }

    public void setFecha_dosis(Date fecha_dosis) {
        this.fecha_dosis = fecha_dosis;
    }

    public boolean isAplicada() {
        return aplicada;
    }

    public void setAplicada(boolean aplicada) {
        this.aplicada = aplicada;
    }

    public int getDosis_administrada() {
        return dosis_administrada;
    }

    public void setDosis_administrada(int dosis_administrada) {
        this.dosis_administrada = dosis_administrada;
    }
}
