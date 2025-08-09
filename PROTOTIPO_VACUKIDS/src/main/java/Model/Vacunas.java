package Model;

public class Vacunas {
    private int idVacuna;
    private String nombreVacuna;
    private int numeroDosis;

    public Vacunas() {
    }

    public Vacunas(String nombreVacuna, int numeroDosis) {
        this.nombreVacuna = nombreVacuna;
        this.numeroDosis = numeroDosis;
    }

    public int getIdVacuna() {
        return idVacuna;
    }

    public void setIdVacuna(int idVacuna) {
        this.idVacuna = idVacuna;
    }

    public String getNombreVacuna() {
        return nombreVacuna;
    }

    public void setNombreVacuna(String nombreVacuna) {
        this.nombreVacuna = nombreVacuna;
    }

    public int getNumeroDosis() {
        return numeroDosis;
    }

    public void setNumeroDosis(int numeroDosis) {
        this.numeroDosis = numeroDosis;
    }
}
