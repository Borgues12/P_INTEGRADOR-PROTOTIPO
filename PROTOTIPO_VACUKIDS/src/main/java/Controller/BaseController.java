package Controller;

import Model.Usuarios;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Clase base con métodos comunes para todos los controladores
 */
public abstract class BaseController {

    protected boolean isValidSession(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("AuthController?action=login");
            return false;
        }
        return true;
    }

    protected boolean isValidAdminSession(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("AuthController?action=login");
            return false;
        }

        Usuarios usuario = (Usuarios) session.getAttribute("usuario");
        if (usuario.getIdTipoUsuario() != 1) { // No es administrador
            response.sendRedirect("AuthController?action=dashboard");
            return false;
        }

        return true;
    }

    protected Usuarios getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (Usuarios) session.getAttribute("usuario");
        }
        return null;
    }

    protected boolean hasAdminRole(HttpServletRequest request) {
        Usuarios usuario = getCurrentUser(request);
        return usuario != null && usuario.getIdTipoUsuario() == 1;
    }

    protected boolean hasUserRole(HttpServletRequest request) {
        Usuarios usuario = getCurrentUser(request);
        return usuario != null && usuario.getIdTipoUsuario() == 2;
    }

    protected boolean hasMedicRole(HttpServletRequest request) {
        Usuarios usuario = getCurrentUser(request);
        return usuario != null && usuario.getIdTipoUsuario() == 3;
    }
}
