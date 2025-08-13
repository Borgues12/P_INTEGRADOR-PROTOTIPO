package Controller;

import Model.Centro_salud;
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

@WebServlet(name = "CentroSaludController", urlPatterns = {"/CentroSaludController"})
public class CentroSaludController extends HttpServlet {

    private final CentroSaludDao centroSaludDao = new CentroSaludDao();
    private final String LISTAR_CENTROS_PAGE = "centro_salud/listar_centros.jsp";
    private final String DASHBOARD_ADMIN = "administrador.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String acceso = LISTAR_CENTROS_PAGE;

        switch (action != null ? action : "") {
            case "listar_centros":
                acceso = LISTAR_CENTROS_PAGE;
                break;

            case "listar_centros_admin":
                if (isValidAdminSession(request, response)) {
                    listarCentrosAdmin(request);
                    acceso = DASHBOARD_ADMIN;
                }
                break;

            case "buscar_centro":
                if (isValidAdminSession(request, response)) {
                    buscarCentro(request);
                    acceso = DASHBOARD_ADMIN;
                }
                break;

            case "editar_centro":
                if (isValidAdminSession(request, response)) {
                    editarCentro(request);
                    acceso = DASHBOARD_ADMIN;
                }
                break;

            default:
                acceso = LISTAR_CENTROS_PAGE;
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

        if (!isValidAdminSession(request, response)) {
            return;
        }

        switch (action != null ? action : "") {
            case "crear_centro":
                crearCentro(request);
                break;

            case "actualizar_centro":
                actualizarCentro(request);
                break;

            case "cambiar_estado_centro":
                cambiarEstadoCentro(request);
                break;
        }

        if (!response.isCommitted()) {
            RequestDispatcher vista = request.getRequestDispatcher(DASHBOARD_ADMIN);
            vista.forward(request, response);
        }
    }

    private void listarCentrosAdmin(HttpServletRequest request) {
        List<Centro_salud> centros = centroSaludDao.listar();
        request.setAttribute("centros", centros);
        request.setAttribute("accion", "listar_centros");
    }

    private void buscarCentro(HttpServletRequest request) {
        String nombreCentro = request.getParameter("nombre");

        if (nombreCentro != null && !nombreCentro.isEmpty()) {
            try {
                List<Centro_salud> centrosEncontrados = centroSaludDao.buscar(nombreCentro);
                request.setAttribute("centros", centrosEncontrados);
                request.setAttribute("accion", "listar_centros");
            } catch (Exception e) {
                request.setAttribute("error", "Error al buscar centros: " + e.getMessage());
                return;
            }
        } else {
            request.setAttribute("error", "Por favor ingrese un término de búsqueda.");
        }
    }

    private void editarCentro(HttpServletRequest request) {
        String idEditarStr = request.getParameter("id");

        if (idEditarStr != null) {
            int idEditar = Integer.parseInt(idEditarStr);
            Centro_salud centroEditar = centroSaludDao.list(idEditar);
            request.setAttribute("centroEditar", centroEditar);
        }

        List<Centro_salud> centros = centroSaludDao.listar();
        request.setAttribute("centros", centros);
        request.setAttribute("accion", "listar_centros");
    }

    private void crearCentro(HttpServletRequest request) {
        try {
            Centro_salud nuevoCentro = buildCentroFromRequest(request);

            if (centroSaludDao.add(nuevoCentro)) {
                request.setAttribute("exito", "Centro creado exitosamente");
            } else {
                request.setAttribute("error", "Error al crear el centro");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
        }

        listarCentrosAdmin(request);
    }

    private void actualizarCentro(HttpServletRequest request) {
        try {
            Centro_salud centroActualizar = buildCentroFromRequest(request);
            centroActualizar.setIdCentroSalud(Integer.parseInt(request.getParameter("id")));

            if (centroSaludDao.edit(centroActualizar)) {
                request.setAttribute("exito", "Centro actualizado exitosamente");
            } else {
                request.setAttribute("error", "Error al actualizar el centro");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
        }

        listarCentrosAdmin(request);
    }

    private void cambiarEstadoCentro(HttpServletRequest request) {
        try {
            int idCentro = Integer.parseInt(request.getParameter("id"));
            if (centroSaludDao.cambiar_estado(idCentro)) {
                request.setAttribute("exito", "Estado del centro cambiado exitosamente");
            } else {
                request.setAttribute("error", "Error al cambiar el estado del centro");
        }
            listarCentrosAdmin(request); // Actualiza la lista de centros en el dashboard
        }
        catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
        }
    }

        private Centro_salud buildCentroFromRequest(HttpServletRequest request) throws Exception {
        String nombre = request.getParameter("nombre");
        String latitudStr = request.getParameter("latitud");
        String longitudStr = request.getParameter("longitud");
        String estadoStr = request.getParameter("estado");

        if (nombre == null || nombre.trim().isEmpty()) {
            throw new Exception("El nombre es obligatorio");
        }

        Centro_salud centro = new Centro_salud();
        centro.setNombreCentroSalud(nombre);
        centro.setLatitud(Double.parseDouble(latitudStr));
        centro.setLongitud(Double.parseDouble(longitudStr));
        centro.setEstado(estadoStr);

        return centro;
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
