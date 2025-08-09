package Interfaces;

import Model.Vacunas;

import java.util.List;

public interface CrudVacunas {
    public List listar();
    public Vacunas list (int idVacuna);
    public boolean add(Vacunas f);
    public boolean edit(Vacunas f);
    public boolean delete(int idVacuna);
}
