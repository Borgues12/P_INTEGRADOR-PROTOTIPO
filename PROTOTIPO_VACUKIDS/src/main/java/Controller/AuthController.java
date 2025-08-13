package Controller;

import Model.Usuarios;
import ModelDao.UsuariosDao;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AuthController", urlPatterns = {"/AuthController"})
public class AuthController extends HttpServlet {

    private final UsuariosDao usuariosDao = new UsuariosDao();

    // Rutas de páginas
    private final String LOGIN_PAGE = "loginv.jsp";
    private final String DASHBOARD_ADMIN = "administrador.jsp";
    private final String DASHBOARD_USER = "padre_familia.jsp";
    private final String DASHBOARD_MEDIC = "medico.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String acceso = LOGIN_PAGE;

        switch (action != null ? action : "") {
            case "login":
                acceso = LOGIN_PAGE;
                break;

            case "logout":
                logout(request, response);
                return;

            case "dashboard_administrador":
                if (isValidSession(request, response)) {
                    acceso = DASHBOARD_ADMIN;
                }
                break;

            case "dashboard_usuario":
                if (isValidSession(request, response)) {
                    acceso = DASHBOARD_USER;
                }
                break;

            case "dashboard_personal_salud":
                if (isValidSession(request, response)) {
                    acceso = DASHBOARD_MEDIC;
                }
                break;

            case "desbloquear_usuario":
                desbloquearUsuario(request, response);
                return;

            default:
                acceso = LOGIN_PAGE;
                break;
        }

        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("validar_login".equals(action)) {
            validarLogin(request, response);
        } else {
            RequestDispatcher vista = request.getRequestDispatcher(LOGIN_PAGE);
            vista.forward(request, response);
        }
    }

    private void validarLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String login = request.getParameter("login");
        String contrasena = request.getParameter("contrasena");

        if (login == null || login.trim().isEmpty() ||
                contrasena == null || contrasena.trim().isEmpty()) {
            request.setAttribute("error", "Por favor complete todos los campos");
            request.setAttribute("login", login);
            RequestDispatcher vista = request.getRequestDispatcher(LOGIN_PAGE);
            vista.forward(request, response);
            return;
        }

        // Verificar si el usuario está bloqueado
        if (usuariosDao.usuarioBloqueado(login)) {
            request.setAttribute("error", "Su cuenta ha sido bloqueada por múltiples intentos fallidos. Contacte al administrador.");
            request.setAttribute("login", login);
            RequestDispatcher vista = request.getRequestDispatcher(LOGIN_PAGE);
            vista.forward(request, response);
            return;
        }

        Usuarios usuario = usuariosDao.validarUsuario(login, contrasena);

        if (usuario != null && usuario.getIdUser() > 0) {
            // Login exitoso
            HttpSession session = request.getSession(true);
            session.setAttribute("usuario", usuario);

            String nombreCompleto = buildFullName(usuario);
            session.setAttribute("nombreCompleto", nombreCompleto);

            String redirectUrl = getRedirectUrlByUserType(usuario.getIdTipoUsuario());
            response.sendRedirect(redirectUrl);
        } else {
            handleFailedLogin(request, response, login);
        }
    }

    private void handleFailedLogin(HttpServletRequest request, HttpServletResponse response, String login)
            throws ServletException, IOException {

        usuariosDao.incrementarIntentosFallidos(login);
        int nuevosIntentos = usuariosDao.obtenerIntentosFallidos(login);
        String mensaje = "Usuario o contraseña incorrectos";

        if (nuevosIntentos >= 3) {
            mensaje += ". Su cuenta ha sido bloqueada por seguridad.";
        } else {
            int intentosRestantes = 3 - nuevosIntentos;
            mensaje += ". Le quedan " + intentosRestantes + " intento(s) antes de que su cuenta sea bloqueada.";
        }

        request.setAttribute("error", mensaje);
        request.setAttribute("login", login);
        RequestDispatcher vista = request.getRequestDispatcher(LOGIN_PAGE);
        vista.forward(request, response);
    }

    private String buildFullName(Usuarios usuario) {
        StringBuilder nombreCompleto = new StringBuilder(usuario.getPrimerNombre());

        if (usuario.getSegundoNombre() != null && !usuario.getSegundoNombre().isEmpty()) {
            nombreCompleto.append(" ").append(usuario.getSegundoNombre());
        }

        nombreCompleto.append(" ").append(usuario.getPrimerApellido());

        if (usuario.getSegundoApellido() != null && !usuario.getSegundoApellido().isEmpty()) {
            nombreCompleto.append(" ").append(usuario.getSegundoApellido());
        }

        return nombreCompleto.toString();
    }

    private String getRedirectUrlByUserType(int tipoUsuario) {
        switch (tipoUsuario) {
            case 1: return "AuthController?action=dashboard_administrador";
            case 2: return "AuthController?action=dashboard_usuario";
            case 3: return "AuthController?action=dashboard_personal_salud";
            default: return "AuthController?action=dashboard_usuario";
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("AuthController?action=login");
    }

    private boolean isValidSession(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("AuthController?action=login");
            return false;
        }
        return true;
    }

    private void desbloquearUsuario(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("AuthController?action=login");
            return;
        }

        Usuarios usuarioActual = (Usuarios) session.getAttribute("usuario");
        if (usuarioActual.getIdTipoUsuario() != 1) {
            response.sendRedirect("AuthController?action=dashboard_administrador");
            return;
        }

        String loginDesbloquear = request.getParameter("login");
        if (loginDesbloquear != null && !loginDesbloquear.trim().isEmpty()) {
            usuariosDao.desbloquearUsuario(loginDesbloquear);
        }

        response.sendRedirect("AuthController?action=dashboard_administrador");
    }
}
