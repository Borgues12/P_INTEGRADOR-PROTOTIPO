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

@WebServlet(name = "Controlador", urlPatterns = {"/Controlador"})
public class Controlador extends HttpServlet {

    String acceso = "";
    String listar_centros = "centro_salud/listar_centros.jsp";
    String login = "loginv.jsp";
    String registro = "registro.jsp";
    String dashboard = "dashboard.jsp";
    String dashboard_administrador = "administrador.jsp";
    String dashboard_usuario = "padre_familia.jsp";
    String dashboard_personal_salud = "medico.jsp";
    String verificar_correo = "verificar_correo.jsp";
    String cambiar_contrasena = "cambiar_contrasena.jsp";
    // <!-- NUEVA PÁGINA -->

    // DAOs
    UsuariosDao usuariosDao = new UsuariosDao();
    Tipo_usuarioDao tipoUsuarioDao = new Tipo_usuarioDao();
    CentroSaludDao centroSaludDao = new CentroSaludDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            acceso = login;
        } else {
            switch (action) {
                case "login":
                    acceso = login;
                    break;

                case "mostrar_registro":
                    // Cargar listas para los selects
                    List<Tipo_usuario> tiposUsuario = tipoUsuarioDao.listar();
                    List<Centro_salud> centrosSalud = centroSaludDao.listar();

                    request.setAttribute("tiposUsuario", tiposUsuario);
                    request.setAttribute("centrosSalud", centrosSalud);
                    acceso = registro;
                    break;

                // CRUD Centros de Salud
                case "listar_centros_admin":
                    HttpSession sessionListarCentros = request.getSession(false);
                    if (sessionListarCentros == null || sessionListarCentros.getAttribute("usuario") == null) {
                        response.sendRedirect("Controlador?action=login");
                        return;
                    }
                    List<Centro_salud> centros = centroSaludDao.listar();
                    request.setAttribute("centros", centros);
                    request.setAttribute("accion", "listar_centros");
                    acceso = dashboard_administrador;
                    break;

                case "buscar_centro":
                    HttpSession sessionBuscarCentro = request.getSession(false);
                    if (sessionBuscarCentro == null || sessionBuscarCentro.getAttribute("usuario") == null) {
                        response.sendRedirect("Controlador?action=login");
                        return;
                    }
                    String idCentroStr = request.getParameter("id");
                    if (idCentroStr != null && !idCentroStr.trim().isEmpty()) {
                        try {
                            int idCentro = Integer.parseInt(idCentroStr);
                            Centro_salud centro = centroSaludDao.list(idCentro);
                            if (centro.getIdCentroSalud() > 0) {
                                List<Centro_salud> centroEncontrado = new ArrayList<>();
                                centroEncontrado.add(centro);
                                request.setAttribute("centros", centroEncontrado);
                                request.setAttribute("mensaje", "Centro encontrado");
                            } else {
                                request.setAttribute("error", "Centro no encontrado");
                                request.setAttribute("centros", new ArrayList<>());
                            }
                        } catch (NumberFormatException e) {
                            request.setAttribute("error", "ID inválido");
                            request.setAttribute("centros", new ArrayList<>());
                        }
                    } else {
                        List<Centro_salud> todosCentros = centroSaludDao.listar();
                        request.setAttribute("centros", todosCentros);
                    }
                    request.setAttribute("accion", "listar_centros");
                    acceso = dashboard_administrador;
                    break;

                case "editar_centro":
                    HttpSession sessionEditarCentro = request.getSession(false);
                    if (sessionEditarCentro == null || sessionEditarCentro.getAttribute("usuario") == null) {
                        response.sendRedirect("Controlador?action=login");
                        return;
                    }
                    String idEditarStr = request.getParameter("id");
                    if (idEditarStr != null) {
                        int idEditar = Integer.parseInt(idEditarStr);
                        Centro_salud centroEditar = centroSaludDao.list(idEditar);
                        request.setAttribute("centroEditar", centroEditar);
                    }
                    List<Centro_salud> centrosEditar = centroSaludDao.listar();
                    request.setAttribute("centros", centrosEditar);
                    request.setAttribute("accion", "listar_centros");
                    acceso = dashboard_administrador;
                    break;

// CRUD Usuarios
                case "listar_usuarios_admin":
                    HttpSession sessionListarUsuarios = request.getSession(false);
                    if (sessionListarUsuarios == null || sessionListarUsuarios.getAttribute("usuario") == null) {
                        response.sendRedirect("Controlador?action=login");
                        return;
                    }
                    List<Usuarios> usuarios = usuariosDao.listar();
                    request.setAttribute("usuarios", usuarios);
                    request.setAttribute("accion", "listar_usuarios");
                    acceso = dashboard_administrador;
                    break;

// CRUD Tipos de Usuario
                case "listar_tipos_usuario_admin":
                    HttpSession sessionListarTipos = request.getSession(false);
                    if (sessionListarTipos == null || sessionListarTipos.getAttribute("usuario") == null) {
                        response.sendRedirect("Controlador?action=login");
                        return;
                    }
                    List<Tipo_usuario> tp = tipoUsuarioDao.listar();
                    request.setAttribute("tiposUsuario", tp);
                    request.setAttribute("accion", "listar_tipos_usuario");
                    acceso = dashboard_administrador;
                    break;

                case "listar_centros":
                    acceso = listar_centros;
                    break;
                case "cambiar_contrasena":
                    acceso = cambiar_contrasena;
                    break;

                case "logout":
                    HttpSession sessionLogout = request.getSession(false);
                    if (sessionLogout != null) {
                        sessionLogout.invalidate();
                    }
                    response.sendRedirect("Controlador?action=login");
                    return;

                case "dashboard":
                    HttpSession sessionDashboard = request.getSession(false);
                    if (sessionDashboard == null || sessionDashboard.getAttribute("usuario") == null) {
                        response.sendRedirect("Controlador?action=login");
                        return;
                    }
                    acceso = dashboard;
                    break;

                case "dashboard_administrador":
                    HttpSession sessionAdmin = request.getSession(false);
                    if (sessionAdmin == null || sessionAdmin.getAttribute("usuario") == null) {
                        response.sendRedirect("Controlador?action=login");
                        return;
                    }
                    acceso = dashboard_administrador;
                    break;

                case "dashboard_usuario":
                    HttpSession sessionUsuario = request.getSession(false);
                    if (sessionUsuario == null || sessionUsuario.getAttribute("usuario") == null) {
                        response.sendRedirect("Controlador?action=login");
                        return;
                    }
                    acceso = dashboard_usuario;
                    break;

                case "dashboard_personal_salud":
                    HttpSession sessionMedico = request.getSession(false);
                    if (sessionMedico == null || sessionMedico.getAttribute("usuario") == null) {
                        response.sendRedirect("Controlador?action=login");
                        return;
                    }
                    acceso = dashboard_personal_salud;
                    break;

                // <!-- NUEVA ACCIÓN: Mostrar página de verificación de correo -->
                case "mostrar_verificar_correo":
                    acceso = verificar_correo;
                    break;

                // <!-- NUEVA ACCIÓN: Desbloquear usuario (solo administradores) -->
                case "desbloquear_usuario":
                    desbloquearUsuario(request, response);
                    return;

                default:
                    acceso = login;
                    break;
            }
        }
        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            acceso = login;
        } else {
            switch (action) {
                case "validar_login":
                    validarLogin(request, response);
                    break;

                case "registrar_usuario":
                    registrarUsuario(request, response);
                    break;

                // <!-- NUEVA ACCIÓN: Verificar correo electrónico -->
                case "verificar_correo":
                    verificarCorreo(request, response);
                    break;

                // <!-- NUEVA ACCIÓN: Confirmar código de verificación -->
                case "confirmar_codigo":
                    confirmarCodigoVerificacion(request, response);
                    break;

                // <!-- NUEVA ACCIÓN: Cambiar contraseña -->

                case "crear_centro":
                    HttpSession sessionCrearCentro = request.getSession(false);
                    if (sessionCrearCentro == null || sessionCrearCentro.getAttribute("usuario") == null) {
                        response.sendRedirect("Controlador?action=login");
                        return;
                    }
                    try {
                        String nombre = request.getParameter("nombre");
                        String latitudStr = request.getParameter("latitud");
                        String longitudStr = request.getParameter("longitud");

                        if (nombre == null || nombre.trim().isEmpty()) {
                            throw new Exception("El nombre es obligatorio");
                        }

                        double latitud = Double.parseDouble(latitudStr);
                        double longitud = Double.parseDouble(longitudStr);

                        Centro_salud nuevoCentro = new Centro_salud();
                        nuevoCentro.setNombreCentroSalud(nombre);
                        nuevoCentro.setLatitud(latitud);
                        nuevoCentro.setLongitud(longitud);

                        if (centroSaludDao.add(nuevoCentro)) {
                            request.setAttribute("exito", "Centro creado exitosamente");
                        } else {
                            request.setAttribute("error", "Error al crear el centro");
                        }
                    } catch (Exception e) {
                        request.setAttribute("error", "Error: " + e.getMessage());
                    }

                    List<Centro_salud> centrosCrear = centroSaludDao.listar();
                    request.setAttribute("centros", centrosCrear);
                    request.setAttribute("accion", "listar_centros");
                    acceso = dashboard_administrador;
                    break;

                case "actualizar_centro":
                    HttpSession sessionActualizarCentro = request.getSession(false);
                    if (sessionActualizarCentro == null || sessionActualizarCentro.getAttribute("usuario") == null) {
                        response.sendRedirect("Controlador?action=login");
                        return;
                    }
                    try {
                        int id = Integer.parseInt(request.getParameter("id"));
                        String nombre = request.getParameter("nombre");
                        double latitud = Double.parseDouble(request.getParameter("latitud"));
                        double longitud = Double.parseDouble(request.getParameter("longitud"));

                        Centro_salud centroActualizar = new Centro_salud();
                        centroActualizar.setIdCentroSalud(id);
                        centroActualizar.setNombreCentroSalud(nombre);
                        centroActualizar.setLatitud(latitud);
                        centroActualizar.setLongitud(longitud);

                        if (centroSaludDao.edit(centroActualizar)) {
                            request.setAttribute("exito", "Centro actualizado exitosamente");
                        } else {
                            request.setAttribute("error", "Error al actualizar el centro");
                        }
                    } catch (Exception e) {
                        request.setAttribute("error", "Error: " + e.getMessage());
                    }

                    List<Centro_salud> centrosActualizar = centroSaludDao.listar();
                    request.setAttribute("centros", centrosActualizar);
                    request.setAttribute("accion", "listar_centros");
                    acceso = dashboard_administrador;
                    break;

                case "eliminar_centro":
                    HttpSession sessionEliminarCentro = request.getSession(false);
                    if (sessionEliminarCentro == null || sessionEliminarCentro.getAttribute("usuario") == null) {
                        response.sendRedirect("Controlador?action=login");
                        return;
                    }
                    try {
                        int idEliminar = Integer.parseInt(request.getParameter("id"));
                        if (centroSaludDao.delete(idEliminar)) {
                            request.setAttribute("exito", "Centro eliminado exitosamente");
                        } else {
                            request.setAttribute("error", "Error al eliminar el centro");
                        }
                    } catch (Exception e) {
                        request.setAttribute("error", "Error: " + e.getMessage());
                    }

                    List<Centro_salud> centrosEliminar = centroSaludDao.listar();
                    request.setAttribute("centros", centrosEliminar);
                    request.setAttribute("accion", "listar_centros");
                    acceso = dashboard_administrador;
                    break;

                default:
                    acceso = login;
                    break;
            }
        }

        if (!response.isCommitted()) {
            RequestDispatcher vista = request.getRequestDispatcher(acceso);
            vista.forward(request, response);
        }
    }

    // <!-- MÉTODO MEJORADO: Validación de login con control de bloqueos -->
    private void validarLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String login = request.getParameter("login");
        String contrasena = request.getParameter("contrasena");

        if (login == null || login.trim().isEmpty() ||
                contrasena == null || contrasena.trim().isEmpty()) {
            request.setAttribute("error", "Por favor complete todos los campos");
            request.setAttribute("login", login);
            acceso = this.login;
            return;
        }

        // Verificar si el usuario está bloqueado
        if (usuariosDao.usuarioBloqueado(login)) {
            request.setAttribute("error", "Su cuenta ha sido bloqueada por múltiples intentos fallidos. Contacte al administrador.");
            request.setAttribute("login", login);
            acceso = this.login;
            return;
        }

        // Obtener intentos fallidos actuales
        int intentosFallidos = usuariosDao.obtenerIntentosFallidos(login);

        Usuarios usuario = usuariosDao.validarUsuario(login, contrasena);

        if (usuario != null && usuario.getIdUser() > 0) {
            // Login exitoso
            HttpSession session = request.getSession(true);
            session.setAttribute("usuario", usuario);

            // Crear nombre completo
            String nombreCompleto = usuario.getPrimerNombre();
            if (usuario.getSegundoNombre() != null && !usuario.getSegundoNombre().isEmpty()) {
                nombreCompleto += " " + usuario.getSegundoNombre();
            }
            nombreCompleto += " " + usuario.getPrimerApellido();
            if (usuario.getSegundoApellido() != null && !usuario.getSegundoApellido().isEmpty()) {
                nombreCompleto += " " + usuario.getSegundoApellido();
            }

            session.setAttribute("nombreCompleto", nombreCompleto);
            int tipoUsuario = usuario.getIdTipoUsuario();
            String redirectUrl = "";

            switch (tipoUsuario) {
                case 1: // Administrador
                    redirectUrl = "Controlador?action=dashboard_administrador";
                    break;
                case 2: // Usuario (Padre de familia)
                    redirectUrl = "Controlador?action=dashboard_usuario";
                    break;
                case 3: // Personal de Salud (Médico)
                    redirectUrl = "Controlador?action=dashboard_personal_salud";
                    break;
                default:
                    redirectUrl = "Controlador?action=dashboard_usuario";
                    break;
            }

            response.sendRedirect(redirectUrl);
        } else {
            // Credenciales incorrectas - AQUÍ incrementamos los intentos
            usuariosDao.incrementarIntentosFallidos(login);

            // Obtener los nuevos intentos después del incremento
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
            acceso = this.login;
        }
    }

    // <!-- MÉTODO MEJORADO: Registro de usuario con verificación mejorada -->
    private void registrarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Obtener parámetros
            String cedula = request.getParameter("cedula");
            String correo = request.getParameter("correo");
            String primerNombre = request.getParameter("primerNombre");
            String segundoNombre = request.getParameter("segundoNombre");
            String primerApellido = request.getParameter("primerApellido");
            String segundoApellido = request.getParameter("segundoApellido");
            String tipoUsuario = request.getParameter("tipoUsuario");
            String[] centrosSalud = request.getParameterValues("centroSalud");
            String login = request.getParameter("login");
            String contrasena = request.getParameter("contrasena");
            String confirmarContrasena = request.getParameter("confirmarContrasena");

            // Validaciones básicas
            if (!contrasena.equals(confirmarContrasena)) {
                throw new Exception("Las contraseñas no coinciden");
            }

            if (contrasena.length() < 6) {
                throw new Exception("La contraseña debe tener al menos 6 caracteres");
            }

            if (login.length() < 4) {
                throw new Exception("El nombre de usuario debe tener al menos 4 caracteres");
            }

            // Verificación mejorada de duplicación
            String mensajeDuplicacion = usuariosDao.verificarDuplicacion(login, cedula, correo);
            if (!mensajeDuplicacion.isEmpty()) {
                throw new Exception(mensajeDuplicacion);
            }

            // Crear objeto usuario
            Usuarios nuevoUsuario = new Usuarios();
            nuevoUsuario.setCedula_usuario(cedula);
            nuevoUsuario.setCorreo(correo);
            nuevoUsuario.setPrimerNombre(primerNombre);
            nuevoUsuario.setSegundoNombre(segundoNombre);
            nuevoUsuario.setPrimerApellido(primerApellido);
            nuevoUsuario.setSegundoApellido(segundoApellido);
            nuevoUsuario.setIdTipoUsuario(Integer.parseInt(tipoUsuario));
            nuevoUsuario.setLogin(login);
            nuevoUsuario.setContrasena(contrasena);

            // Registrar usuario y obtener su ID
            int idUsuarioCreado = usuariosDao.addAndGetId(nuevoUsuario);

            if (idUsuarioCreado > 0) {
                // Convertir array a lista
                List<Integer> listaCentros = new ArrayList<>();
                for (String centroId : centrosSalud) {
                    listaCentros.add(Integer.parseInt(centroId));
                }

                // Asociar usuario a centros
                boolean asociado = usuariosDao.asociarUsuarioACentros(idUsuarioCreado, listaCentros);

                if (asociado) {
                    request.setAttribute("exito", "Usuario registrado exitosamente. Puede iniciar sesión.");
                    acceso = this.login;
                } else {
                    throw new Exception("Error al asociar centros de salud");
                }
            } else {
                throw new Exception("Error al registrar el usuario");
            }

        } catch (Exception e) {
            // Mantener datos en caso de error
            request.setAttribute("error", e.getMessage());
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
            List<Tipo_usuario> tiposUsuario = tipoUsuarioDao.listar();
            List<Centro_salud> centrosSalud = centroSaludDao.listar();
            request.setAttribute("tiposUsuario", tiposUsuario);
            request.setAttribute("centrosSalud", centrosSalud);

            acceso = registro;
        }
    }

    // <!-- MÉTODO NUEVO: Verificar correo electrónico -->
    private void verificarCorreo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");

        if (correo == null || correo.trim().isEmpty()) {
            request.setAttribute("error", "Por favor ingrese un correo electrónico");
            acceso = verificar_correo;
            return;
        }

        // Verificar que el correo existe en la base de datos
        if (!usuariosDao.existeUsuario("", "", correo)) {
            request.setAttribute("error", "El correo electrónico no está registrado en el sistema");
            acceso = verificar_correo;
            return;
        }

        // Enviar código de verificación
        if (usuariosDao.verificarCorreoAutentico(correo)) {
            request.setAttribute("exito", "Se ha enviado un código de verificación a su correo electrónico");
            request.setAttribute("correo", correo);
            request.setAttribute("mostrarCodigo", true);
        } else {
            request.setAttribute("error", "Error al enviar el código de verificación. Intente nuevamente.");
        }

        acceso = verificar_correo;
    }

    // <!-- MÉTODO NUEVO: Confirmar código de verificación -->
    private void confirmarCodigoVerificacion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String codigo = request.getParameter("codigo");

        if (correo == null || correo.trim().isEmpty() || codigo == null || codigo.trim().isEmpty()) {
            request.setAttribute("error", "Por favor complete todos los campos");
            request.setAttribute("correo", correo);
            request.setAttribute("mostrarCodigo", true);
            acceso = verificar_correo;
            return;
        }

        if (usuariosDao.verificarCodigoVerificacion(correo, codigo)) {
            // Código válido - redirigir a página de cambio de contraseña
            HttpSession session = request.getSession(true);
            session.setAttribute("correoVerificado", correo);
            response.sendRedirect("cambiar_contrasena.jsp"); // Crear esta página
        } else {
            request.setAttribute("error", "Código de verificación inválido o expirado");
            request.setAttribute("correo", correo);
            request.setAttribute("mostrarCodigo", true);
            acceso = verificar_correo;
        }
    }

    // <!-- MÉTODO NUEVO: Desbloquear usuario (solo administradores) -->
    private void desbloquearUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Verificar que el usuario actual es administrador
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("Controlador?action=login");
            return;
        }

        Usuarios usuarioActual = (Usuarios) session.getAttribute("usuario");
        if (usuarioActual.getIdTipoUsuario() != 1) { // No es administrador
            request.setAttribute("error", "No tiene permisos para realizar esta acción");
            response.sendRedirect("Controlador?action=dashboard");
            return;
        }

        String loginDesbloquear = request.getParameter("login");
        if (loginDesbloquear == null || loginDesbloquear.trim().isEmpty()) {
            request.setAttribute("error", "Debe especificar el usuario a desbloquear");
            response.sendRedirect("Controlador?action=dashboard_administrador");
            return;
        }

        if (usuariosDao.desbloquearUsuario(loginDesbloquear)) {
            request.setAttribute("exito", "Usuario " + loginDesbloquear + " desbloqueado exitosamente");
        } else {
            request.setAttribute("error", "Error al desbloquear el usuario");
        }

        response.sendRedirect("Controlador?action=dashboard_administrador");
    }

    // <!-- MÉTODO NUEVO: Cambiar Contraseña -->


}