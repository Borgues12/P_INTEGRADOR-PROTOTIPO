package Interfaces;

import Model.Tipo_usuario;

import java.util.List;

public interface CrudTipo_usuario {
    public List listar();
    public Tipo_usuario list (int idTipoUsuario);
    public boolean add(Tipo_usuario f);
    public boolean edit(Tipo_usuario f);
    public boolean delete(int idTipoUsuario);
}

