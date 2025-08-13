package Model;

public class Usuarios {
    private int idUser;
    private int idTipoUsuario;
    private String cedula_usuario;
    private String primerNombre;
    private String primerApellido;
    private String segundoNombre;
    private String segundoApellido;
    private String correo;
    private String login;
    private String contrasena;
    private boolean estado;

    public Usuarios() {
    }

    public Usuarios(int idUser, int idTipoUsuario, String cedula_usuario, String primerNombre,
                    String primerApellido, String segundoNombre, String segundoApellido, String correo,
                    String login, String contrasena, boolean estado) {
        this.idUser = idUser;
        this.idTipoUsuario = idTipoUsuario;
        this.cedula_usuario = cedula_usuario;
        this.primerNombre = primerNombre;
        this.primerApellido = primerApellido;
        this.segundoNombre = segundoNombre;
        this.segundoApellido = segundoApellido;
        this.correo = correo;
        this.login = login;
        this.contrasena = contrasena;
        this.estado = estado;
    }
    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public int getIdTipoUsuario() {
        return idTipoUsuario;
    }

    public void setIdTipoUsuario(int idTipoUsuario) {
        this.idTipoUsuario = idTipoUsuario;
    }

    public String getCedula_usuario() {
        return cedula_usuario;
    }

    public void setCedula_usuario(String cedula_usuario) {
        this.cedula_usuario = cedula_usuario;
    }

    public String getPrimerNombre() {
        return primerNombre;
    }

    public void setPrimerNombre(String primerNombre) {
        this.primerNombre = primerNombre;
    }

    public String getSegundoNombre() {
        return segundoNombre;
    }

    public void setSegundoNombre(String segundoNombre) {
        this.segundoNombre = segundoNombre;
    }

    public String getPrimerApellido() {
        return primerApellido;
    }

    public void setPrimerApellido(String primerApellido) {
        this.primerApellido = primerApellido;
    }

    public String getSegundoApellido() {
        return segundoApellido;
    }

    public void setSegundoApellido(String segundoApellido) {
        this.segundoApellido = segundoApellido;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }
}
