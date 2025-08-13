package Interfaces;

import Model.Centro_salud;

import java.util.List;

public interface CrudCentroSalud {
    public List listar();
    public Centro_salud list(int id);
    public List<Centro_salud> buscar(String termino);
    public boolean add(Centro_salud f);
    public boolean edit(Centro_salud f);
    boolean cambiar_estado(int idCentroSalud);
}
