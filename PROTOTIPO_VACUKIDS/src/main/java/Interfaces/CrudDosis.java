package Interfaces;
import Model.Dosis;

import java.util.List;

public interface CrudDosis {
    public List listar();
    public Dosis list (int idDosis);
    public boolean add(Dosis f);
    public boolean edit(Dosis f);
    public boolean delete(int idDosis);
}