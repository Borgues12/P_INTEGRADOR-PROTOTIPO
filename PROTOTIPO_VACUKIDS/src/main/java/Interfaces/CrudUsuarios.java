package Interfaces;
import Model.Usuarios;
import java.util.List;

public interface CrudUsuarios {
    public List listar();
    public Usuarios list (int idUser);
    public boolean add(Usuarios f);
    public boolean edit(Usuarios f);
    public boolean delete(int isUser);
}