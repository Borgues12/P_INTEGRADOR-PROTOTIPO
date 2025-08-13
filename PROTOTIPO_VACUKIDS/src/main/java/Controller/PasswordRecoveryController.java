package Controller;

import ModelDao.UsuariosDao;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "PasswordRecoveryController", urlPatterns = {"/PasswordRecoveryController"})
public class PasswordRecoveryController extends HttpServlet {

    private final UsuariosDao usuariosDao = new UsuariosDao();
    private final String VERIFICAR_CORREO_PAGE = "verificar_correo.jsp";
    private final String CAMBIAR_CONTRASENA_PAGE = "cambiar_contrasena.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String acceso = VERIFICAR_CORREO_PAGE;

        switch (action != null ? action : "") {
            case "mostrar_verificar_correo":
                acceso = VERIFICAR_CORREO_PAGE;
                break;

            case "cambiar_contrasena":
                acceso = CAMBIAR_CONTRASENA_PAGE;
                break;

            default:
                acceso = VERIFICAR_CORREO_PAGE;
                break;
        }

        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String acceso = VERIFICAR_CORREO_PAGE;

        switch (action != null ? action : "") {
            case "verificar_correo":
                verificarCorreo(request, response);
                return;

            case "confirmar_codigo":
                confirmarCodigoVerificacion(request, response);
                return;

            case "cambiar_contrasena":
                cambiarContrasena(request, response);
                return;

            default:
                acceso = VERIFICAR_CORREO_PAGE;
                break;
        }

        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
    }

    private void verificarCorreo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");

        if (correo == null || correo.trim().isEmpty()) {
            request.setAttribute("error", "Por favor ingrese un correo electrónico");
            RequestDispatcher vista = request.getRequestDispatcher(VERIFICAR_CORREO_PAGE);
            vista.forward(request, response);
            return;
        }

        if (!usuariosDao.existeUsuario("", "", correo)) {
            request.setAttribute("error", "El correo electrónico no está registrado en el sistema");
            RequestDispatcher vista = request.getRequestDispatcher(VERIFICAR_CORREO_PAGE);
            vista.forward(request, response);
            return;
        }

        if (usuariosDao.verificarCorreoAutentico(correo)) {
            request.setAttribute("exito", "Se ha enviado un código de verificación a su correo electrónico");
            request.setAttribute("correo", correo);
            request.setAttribute("mostrarCodigo", true);
        } else {
            request.setAttribute("error", "Error al enviar el código de verificación. Intente nuevamente.");
        }

        RequestDispatcher vista = request.getRequestDispatcher(VERIFICAR_CORREO_PAGE);
        vista.forward(request, response);
    }

    private void confirmarCodigoVerificacion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String codigo = request.getParameter("codigo");

        if (correo == null || correo.trim().isEmpty() || codigo == null || codigo.trim().isEmpty()) {
            request.setAttribute("error", "Por favor complete todos los campos");
            request.setAttribute("correo", correo);
            request.setAttribute("mostrarCodigo", true);
            RequestDispatcher vista = request.getRequestDispatcher(VERIFICAR_CORREO_PAGE);
            vista.forward(request, response);
            return;
        }

        if (usuariosDao.verificarCodigoVerificacion(correo, codigo)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("correoVerificado", correo);
            response.sendRedirect("PasswordRecoveryController?action=cambiar_contrasena");
        } else {
            request.setAttribute("error", "Código de verificación inválido o expirado");
            request.setAttribute("correo", correo);
            request.setAttribute("mostrarCodigo", true);
            RequestDispatcher vista = request.getRequestDispatcher(VERIFICAR_CORREO_PAGE);
            vista.forward(request, response);
        }
    }

    private void cambiarContrasena(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("correoVerificado") == null) {
            response.sendRedirect("PasswordRecoveryController?action=mostrar_verificar_correo");
            return;
        }

        String correo = (String) session.getAttribute("correoVerificado");
        String nuevaContrasena = request.getParameter("nuevaContrasena");
        String confirmarContrasena = request.getParameter("confirmarContrasena");

        if (nuevaContrasena == null || nuevaContrasena.trim().isEmpty() ||
                confirmarContrasena == null || confirmarContrasena.trim().isEmpty()) {
            request.setAttribute("error", "Por favor complete todos los campos");
            RequestDispatcher vista = request.getRequestDispatcher(CAMBIAR_CONTRASENA_PAGE);
            vista.forward(request, response);
            return;
        }

        if (!nuevaContrasena.equals(confirmarContrasena)) {
            request.setAttribute("error", "Las contraseñas no coinciden");
            RequestDispatcher vista = request.getRequestDispatcher(CAMBIAR_CONTRASENA_PAGE);
            vista.forward(request, response);
            return;
        }

        if (nuevaContrasena.length() < 6) {
            request.setAttribute("error", "La contraseña debe tener al menos 6 caracteres");
            RequestDispatcher vista = request.getRequestDispatcher(CAMBIAR_CONTRASENA_PAGE);
            vista.forward(request, response);
            return;
        }

        if (usuariosDao.cambiarContrasenaConVerificacion(correo, nuevaContrasena, "")) {
            session.removeAttribute("correoVerificado");
            request.setAttribute("exito", "Contraseña cambiada exitosamente. Puede iniciar sesión.");
            RequestDispatcher vista = request.getRequestDispatcher("loginv.jsp");
            vista.forward(request, response);
        } else {
            request.setAttribute("error", "Error al cambiar la contraseña. Intente nuevamente.");
            RequestDispatcher vista = request.getRequestDispatcher(CAMBIAR_CONTRASENA_PAGE);
            vista.forward(request, response);
        }
    }
}
