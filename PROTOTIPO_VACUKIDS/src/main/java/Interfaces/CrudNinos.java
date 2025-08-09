package Interfaces;

import Model.Ninos;

import java.util.List;

public interface CrudNinos {
    public List listar();
    public Ninos list (int idNino);
    public boolean add(Ninos f);
    public boolean edit(Ninos f);
    public boolean delete(int idNino);
}
