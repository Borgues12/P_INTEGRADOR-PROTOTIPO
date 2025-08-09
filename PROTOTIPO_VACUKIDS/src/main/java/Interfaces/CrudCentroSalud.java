package Interfaces;

import Model.Centro_salud;

import java.util.List;

public interface CrudCentroSalud {
    public List listar();
    public Centro_salud list (int idCentroSalud);
    public boolean add(Centro_salud f);
    public boolean edit(Centro_salud f);
    public boolean delete(int idCentroSalud);

}
