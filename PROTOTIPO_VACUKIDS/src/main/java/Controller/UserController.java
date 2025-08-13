package Controller;

import Model.Usuarios;
import Model.Tipo_usuario;
import Model.Centro_salud;
import ModelDao.UsuariosDao;
import ModelDao.Tipo_usuarioDao;
import ModelDao.CentroSaludDao;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    private final UsuariosDao usuariosDao = new UsuariosDao();
    private final Tipo_usuarioDao tipoUsuarioDao = new Tipo_usuarioDao();
    private final CentroSaludDao centroSaludDao = new CentroSaludDao();

    private final String REGISTRO_PAGE = "registro.jsp";
    private final String LOGIN_PAGE = "loginv.jsp";
    private final String DASHBOARD_ADMIN = "administrador.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String acceso = LOGIN_PAGE;

        switch (action != null ? action : "") {
            case "mostrar_registro":
                mostrarFormularioRegistro(request);
                acceso = REGISTRO_PAGE;
                break;

            case "listar_usuarios_admin":
                if (isValidAdminSession(request, response)) {
                    listarUsuarios(request);
                    acceso = DASHBOARD_ADMIN;
                }
                break;

            case "listar_tipos_usuario_admin":
                if (isValidAdminSession(request, response)) {
                    listarTiposUsuario(request);
                    acceso = DASHBOARD_ADMIN;
                }
                break;

            default:
                acceso = LOGIN_PAGE;
                break;
        }

        if (!response.isCommitted()) {
            RequestDispatcher vista = request.getRequestDispatcher(acceso);
            vista.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("registrar_usuario".equals(action)) {
            registrarUsuario(request, response);
        }

        if (!response.isCommitted()) {
            RequestDispatcher vista = request.getRequestDispatcher(LOGIN_PAGE);
            vista.forward(request, response);
        }
    }

    private void mostrarFormularioRegistro(HttpServletRequest request) {
        List<Tipo_usuario> tiposUsuario = tipoUsuarioDao.listar();
        List<Centro_salud> centrosSalud = centroSaludDao.listar();

        request.setAttribute("tiposUsuario", tiposUsuario);
        request.setAttribute("centrosSalud", centrosSalud);
    }

    private void listarUsuarios(HttpServletRequest request) {
        List<Usuarios> usuarios = usuariosDao.listar();
        request.setAttribute("usuarios", usuarios);
        request.setAttribute("accion", "listar_usuarios");
    }

    private void listarTiposUsuario(HttpServletRequest request) {
        List<Tipo_usuario> tiposUsuario = tipoUsuarioDao.listar();
        request.setAttribute("tiposUsuario", tiposUsuario);
        request.setAttribute("accion", "listar_tipos_usuario");
    }

    private void registrarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Validar parámetros
            validateRegistrationParameters(request);

            // Crear usuario
            Usuarios nuevoUsuario = buildUserFromRequest(request);

            // Verificar duplicación
            String mensajeDuplicacion = usuariosDao.verificarDuplicacion(
                    nuevoUsuario.getLogin(),
                    nuevoUsuario.getCedula_usuario(),
                    nuevoUsuario.getCorreo()
            );

            if (!mensajeDuplicacion.isEmpty()) {
                throw new Exception(mensajeDuplicacion);
            }

            // Registrar usuario
            int idUsuarioCreado = usuariosDao.addAndGetId(nuevoUsuario);

            if (idUsuarioCreado > 0) {
                // Asociar centros de salud
                String[] centrosSalud = request.getParameterValues("centroSalud");
                List<Integer> listaCentros = new ArrayList<>();
                for (String centroId : centrosSalud) {
                    listaCentros.add(Integer.parseInt(centroId));
                }

                boolean asociado = usuariosDao.asociarUsuarioACentros(idUsuarioCreado, listaCentros);

                if (asociado) {
                    request.setAttribute("exito", "Usuario registrado exitosamente. Puede iniciar sesión.");
                    RequestDispatcher vista = request.getRequestDispatcher(LOGIN_PAGE);
                    vista.forward(request, response);
                    return;
                } else {
                    throw new Exception("Error al asociar centros de salud");
                }
            } else {
                throw new Exception("Error al registrar el usuario");
            }

        } catch (Exception e) {
            handleRegistrationError(request, e);
            RequestDispatcher vista = request.getRequestDispatcher(REGISTRO_PAGE);
            vista.forward(request, response);
        }
    }

    private void validateRegistrationParameters(HttpServletRequest request) throws Exception {
        String contrasena = request.getParameter("contrasena");
        String confirmarContrasena = request.getParameter("confirmarContrasena");
        String login = request.getParameter("login");

        if (!contrasena.equals(confirmarContrasena)) {
            throw new Exception("Las contraseñas no coinciden");
        }

        if (contrasena.length() < 6) {
            throw new Exception("La contraseña debe tener al menos 6 caracteres");
        }

        if (login.length() < 4) {
            throw new Exception("El nombre de usuario debe tener al menos 4 caracteres");
        }
    }

    private Usuarios buildUserFromRequest(HttpServletRequest request) {
        Usuarios usuario = new Usuarios();
        usuario.setCedula_usuario(request.getParameter("cedula"));
        usuario.setCorreo(request.getParameter("correo"));
        usuario.setPrimerNombre(request.getParameter("primerNombre"));
        usuario.setSegundoNombre(request.getParameter("segundoNombre"));
        usuario.setPrimerApellido(request.getParameter("primerApellido"));
        usuario.setSegundoApellido(request.getParameter("segundoApellido"));
        usuario.setIdTipoUsuario(Integer.parseInt(request.getParameter("tipoUsuario")));
        usuario.setLogin(request.getParameter("login"));
        usuario.setContrasena(request.getParameter("contrasena"));
        return usuario;
    }

    private void handleRegistrationError(HttpServletRequest request, Exception e) {
        request.setAttribute("error", e.getMessage());

        // Mantener datos del formulario
        request.setAttribute("cedula", request.getParameter("cedula"));
        request.setAttribute("correo", request.getParameter("correo"));
        request.setAttribute("primerNombre", request.getParameter("primerNombre"));
        request.setAttribute("segundoNombre", request.getParameter("segundoNombre"));
        request.setAttribute("primerApellido", request.getParameter("primerApellido"));
        request.setAttribute("segundoApellido", request.getParameter("segundoApellido"));
        request.setAttribute("login", request.getParameter("login"));
        request.setAttribute("tipoUsuarioSeleccionado", request.getParameter("tipoUsuario"));
        request.setAttribute("centroSaludSeleccionado", request.getParameter("centroSalud"));

        // Recargar listas
        mostrarFormularioRegistro(request);
    }

    private boolean isValidAdminSession(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("AuthController?action=login");
            return false;
        }
        return true;
    }
}
