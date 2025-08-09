package Interfaces;

import Model.Usuarios_CentroSalud;

import java.util.List;

public interface CrudUsuarios_CentroSalud {
    public List listar();
    public Usuarios_CentroSalud list_centro (int idCentroSalud);
    public Usuarios_CentroSalud list_user( int idUser);
    public boolean add(Usuarios_CentroSalud f);
    public boolean edit_centro(Usuarios_CentroSalud f);
    public boolean edit_user(Usuarios_CentroSalud f);
    public boolean delete_centro(int idCentroSalud);
    public boolean delete_user(int idUser);
}
