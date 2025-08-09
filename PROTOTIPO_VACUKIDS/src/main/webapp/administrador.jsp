<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Usuarios" %>
<%@ page import="Model.Centro_salud" %>
<%@ page import="Model.Tipo_usuario" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IESS - Panel Administrativo</title>
    <link rel="stylesheet" href="css/Style.css">
    <style>
        body {
            font-family: var(--font-main);
            margin: 0;
            padding: 20px;
            background: var(--bg-gradient);
            color: var(--text-dark);
            min-height: 100vh;
        }

        .admin-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            padding: 1rem 2rem;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
        }

        .admin-brand {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .admin-title {
            font-family: var(--font-heading);
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--text-dark);
            margin: 0;
        }

        .logout-btn {
            background: var(--primary-color);
            color: white;
            padding: 0.6rem 1.2rem;
            text-decoration: none;
            border-radius: var(--radius-md);
            font-weight: 600;
            transition: var(--transition-normal);
            box-shadow: var(--shadow-sm);
        }

        .logout-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .user-info {
            background: white;
            padding: 1rem 2rem;
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            margin-bottom: 2rem;
            border-left: 4px solid var(--primary-color);
        }

        .crud-section {
            background: white;
            margin-bottom: 1.5rem;
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            border-left: 4px solid var(--primary-color);
        }

        .section-header {
            background: var(--primary-light);
            color: var(--text-dark);
            padding: 1rem 2rem;
            margin: 0;
            font-size: 1.2rem;
            font-weight: 600;
            border-bottom: 1px solid var(--border-color);
        }

        .section-content {
            padding: 1.5rem 2rem;
        }

        .crud-buttons {
            display: flex;
            gap: 0.8rem;
            flex-wrap: wrap;
        }

        .crud-btn {
            background: white;
            color: var(--primary-color);
            padding: 0.6rem 1.2rem;
            text-decoration: none;
            border-radius: var(--radius-md);
            font-size: 0.9rem;
            font-weight: 600;
            border: 2px solid var(--primary-color);
            transition: var(--transition-normal);
            cursor: pointer;
        }

        .crud-btn:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-1px);
            box-shadow: var(--shadow-sm);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Estilos para las tablas CRUD */
        .crud-content {
            background: white;
            margin-top: 2rem;
            padding: 2rem;
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .table th, .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            background: #007bff;
            color: white;
        }

        .table tr:hover {
            background: #f5f5f5;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 12px;
            margin: 2px;
        }

        .btn-primary { background: #007bff; color: white; }
        .btn-success { background: #28a745; color: white; }
        .btn-warning { background: #ffc107; color: black; }
        .btn-danger { background: #dc3545; color: white; }
        .btn-secondary { background: #6c757d; color: white; }

        .form-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .search-section {
            display: flex;
            gap: 10px;
            align-items: end;
            margin-bottom: 20px;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .admin-header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }

            .crud-buttons {
                justify-content: center;
            }

            .crud-btn {
                flex: 1;
                min-width: 80px;
                text-align: center;
            }
        }
    </style>
</head>
<body>

<%
    Usuarios usuario = (Usuarios) session.getAttribute("usuario");
    String nombreCompleto = (String) session.getAttribute("nombreCompleto");

    if (usuario == null) {
        response.sendRedirect("Controlador?action=login");
        return;
    }

    // Obtener datos para las tablas
    @SuppressWarnings("unchecked")
    List<Centro_salud> centros = (List<Centro_salud>) request.getAttribute("centros");
    @SuppressWarnings("unchecked")
    List<Usuarios> usuarios = (List<Usuarios>) request.getAttribute("usuarios");
    @SuppressWarnings("unchecked")
    List<Tipo_usuario> tiposUsuario = (List<Tipo_usuario>) request.getAttribute("tiposUsuario");

    Centro_salud centroEditar = (Centro_salud) request.getAttribute("centroEditar");
    String accion = (String) request.getAttribute("accion");

    String exito = (String) request.getAttribute("exito");
    String error = (String) request.getAttribute("error");
    String mensaje = (String) request.getAttribute("mensaje");
%>

<div class="container">
    <!-- Header con Logo -->
    <div class="admin-header">
        <div class="admin-brand">
            <div class="logo-circle">
                <div class="heart"></div>
            </div>
            <h1 class="admin-title">IESS Vacunación - Administración</h1>
        </div>
        <a href="Controlador?action=logout" class="logout-btn">Cerrar Sesión</a>
    </div>

    <!-- Info del Usuario -->
    <div class="user-info">
        <strong>Administrador:</strong> <%= nombreCompleto %> |
        <strong>Cédula:</strong> <%= usuario.getCedula_usuario() %> |
        <strong>Email:</strong> <%= usuario.getCorreo() %>
    </div>

    <!-- Mensajes -->
    <% if (exito != null) { %>
    <div class="alert alert-success"><%= exito %></div>
    <% } %>
    <% if (error != null) { %>
    <div class="alert alert-danger"><%= error %></div>
    <% } %>
    <% if (mensaje != null) { %>
    <div class="alert alert-success"><%= mensaje %></div>
    <% } %>

    <!-- Secciones CRUD -->
    <div class="crud-section">
        <h2 class="section-header">Centros de Salud</h2>
        <div class="section-content">
            <div class="crud-buttons">
                <a href="Controlador?action=listar_centros_admin" class="crud-btn">LISTAR</a>
                <a href="Controlador?action=listar_centros_admin" class="crud-btn">CREAR</a>
                <a href="Controlador?action=listar_centros_admin" class="crud-btn">EDITAR</a>
                <a href="Controlador?action=listar_centros_admin" class="crud-btn">ELIMINAR</a>
            </div>
        </div>
    </div>

    <div class="crud-section">
        <h2 class="section-header">Usuarios</h2>
        <div class="section-content">
            <div class="crud-buttons">
                <a href="Controlador?action=listar_usuarios_admin" class="crud-btn">LISTAR</a>
                <a href="Controlador?action=listar_usuarios_admin" class="crud-btn">CREAR</a>
                <a href="Controlador?action=listar_usuarios_admin" class="crud-btn">EDITAR</a>
                <a href="Controlador?action=listar_usuarios_admin" class="crud-btn">ELIMINAR</a>
            </div>
        </div>
    </div>

    <div class="crud-section">
        <h2 class="section-header">Tipos de Usuario</h2>
        <div class="section-content">
            <div class="crud-buttons">
                <a href="Controlador?action=listar_tipos_usuario_admin" class="crud-btn">LISTAR</a>
                <a href="Controlador?action=listar_tipos_usuario_admin" class="crud-btn">CREAR</a>
                <a href="Controlador?action=listar_tipos_usuario_admin" class="crud-btn">EDITAR</a>
                <a href="Controlador?action=listar_tipos_usuario_admin" class="crud-btn">ELIMINAR</a>
            </div>
        </div>
    </div>

    <div class="crud-section">
        <h2 class="section-header">Menores</h2>
        <div class="section-content">
            <div class="crud-buttons">
                <a href="#" class="crud-btn">LISTAR</a>
                <a href="#" class="crud-btn">CREAR</a>
                <a href="#" class="crud-btn">EDITAR</a>
                <a href="#" class="crud-btn">ELIMINAR</a>
            </div>
        </div>
    </div>

    <div class="crud-section">
        <h2 class="section-header">Vacunas</h2>
        <div class="section-content">
            <div class="crud-buttons">
                <a href="#" class="crud-btn">LISTAR</a>
                <a href="#" class="crud-btn">CREAR</a>
                <a href="#" class="crud-btn">EDITAR</a>
                <a href="#" class="crud-btn">ELIMINAR</a>
            </div>
        </div>
    </div>

    <div class="crud-section">
        <h2 class="section-header">Dosis</h2>
        <div class="section-content">
            <div class="crud-buttons">
                <a href="#" class="crud-btn">LISTAR</a>
                <a href="#" class="crud-btn">CREAR</a>
                <a href="#" class="crud-btn">EDITAR</a>
                <a href="#" class="crud-btn">ELIMINAR</a>
            </div>
        </div>
    </div>

    <!-- Contenido CRUD Dinámico -->
    <% if ("listar_centros".equals(accion)) { %>
    <div class="crud-content">
        <h3>Gestión de Centros de Salud</h3>

        <!-- Formulario de Búsqueda -->
        <div class="form-section">
            <h4>Buscar Centro</h4>
            <form action="Controlador" method="get" class="search-section">
                <input type="hidden" name="action" value="buscar_centro">
                <div class="form-group" style="margin-bottom: 0;">
                    <label>ID del Centro:</label>
                    <input type="number" name="id" placeholder="Ingrese ID para buscar">
                </div>
                <button type="submit" class="btn btn-primary">Buscar</button>
                <a href="Controlador?action=listar_centros_admin" class="btn btn-secondary">Ver Todos</a>
            </form>
        </div>

        <!-- Formulario de Creación/Edición -->
        <div class="form-section">
            <h4><%= centroEditar != null ? "Editar Centro" : "Crear Nuevo Centro" %></h4>
            <form action="Controlador" method="post">
                <input type="hidden" name="action" value="<%= centroEditar != null ? "actualizar_centro" : "crear_centro" %>">
                <% if (centroEditar != null) { %>
                <input type="hidden" name="id" value="<%= centroEditar.getIdCentroSalud() %>">
                <% } %>

                <div class="form-group">
                    <label>Nombre del Centro:</label>
                    <input type="text" name="nombre" required
                           value="<%= centroEditar != null ? centroEditar.getNombreCentroSalud() : "" %>">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Latitud:</label>
                        <input type="number" step="any" name="latitud" required
                               value="<%= centroEditar != null ? centroEditar.getLatitud() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Longitud:</label>
                        <input type="number" step="any" name="longitud" required
                               value="<%= centroEditar != null ? centroEditar.getLongitud() : "" %>">
                    </div>
                </div>

                <button type="submit" class="btn <%= centroEditar != null ? "btn-warning" : "btn-success" %>">
                    <%= centroEditar != null ? "Actualizar Centro" : "Crear Centro" %>
                </button>
                <% if (centroEditar != null) { %>
                <a href="Controlador?action=listar_centros_admin" class="btn btn-secondary">Cancelar</a>
                <% } %>
            </form>
        </div>

        <!-- Tabla de Centros -->
        <div>
            <h4>Lista de Centros de Salud</h4>
            <% if (centros != null && !centros.isEmpty()) { %>
            <table class="table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Latitud</th>
                    <th>Longitud</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>
                <% for (Centro_salud centro : centros) { %>
                <tr>
                    <td><%= centro.getIdCentroSalud() %></td>
                    <td><%= centro.getNombreCentroSalud() %></td>
                    <td><%= centro.getLatitud() %></td>
                    <td><%= centro.getLongitud() %></td>
                    <td>
                        <a href="Controlador?action=editar_centro&id=<%= centro.getIdCentroSalud() %>"
                           class="btn btn-warning">Editar</a>
                        <form action="Controlador" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="eliminar_centro">
                            <input type="hidden" name="id" value="<%= centro.getIdCentroSalud() %>">
                            <button type="submit" class="btn btn-danger"
                                    onclick="return confirm('¿Está seguro de eliminar este centro?')">
                                Eliminar
                            </button>
                        </form>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <% } else { %>
            <p>No hay centros de salud registrados.</p>
            <% } %>
        </div>
    </div>
    <% } %>

    <!-- Contenido para Usuarios -->
    <% if ("listar_usuarios".equals(accion)) { %>
    <div class="crud-content">
        <h3>Gestión de Usuarios</h3>
        <% if (usuarios != null && !usuarios.isEmpty()) { %>
        <table class="table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Cédula</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Email</th>
                <th>Login</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <% for (Usuarios usr : usuarios) { %>
            <tr>
                <td><%= usr.getIdUser() %></td>
                <td><%= usr.getCedula_usuario() %></td>
                <td><%= usr.getPrimerNombre() %></td>
                <td><%= usr.getPrimerApellido() %></td>
                <td><%= usr.getCorreo() %></td>
                <td><%= usr.getLogin() %></td>
                <td><%= usr.isEstado() ? "Activo" : "Inactivo" %></td>
                <td>
                    <a href="Controlador?action=editar_usuario&id=${u.idUser}" class="btn btn-warning">Editar</a>
                    <a href="Controlador?action=eliminar_usuario&id=${u.idUser}" class="btn btn-danger">Eliminar</a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p>No hay usuarios registrados.</p>
        <% } %>
    </div>
    <% } %>

    <!-- Contenido para Tipos de Usuario -->
    <% if ("listar_tipos_usuario".equals(accion)) { %>
    <div class="crud-content">
        <h3>Gestión de Tipos de Usuario</h3>
        <% if (tiposUsuario != null && !tiposUsuario.isEmpty()) { %>
        <table class="table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Nombre del Tipo</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <% for (Tipo_usuario tipo : tiposUsuario) { %>
            <tr>
                <td><%= tipo.getIdTipoUsuario() %></td>
                <td><%= tipo.getNombreTipoUsuario() %></td>
                <td>
                    <a href="Controlador?action=editar_tipo_usuario&id=${t.idTipoUsuario}" class="btn btn-warning">Editar</a>
                    <a href="Controlador?action=eliminar_tipo_usuario&id=${t.idTipoUsuario}" class="btn btn-danger">Eliminar</a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p>No hay tipos de usuario registrados.</p>
        <% } %>
    </div>
    <% } %>

</div>

</body>
</html>
