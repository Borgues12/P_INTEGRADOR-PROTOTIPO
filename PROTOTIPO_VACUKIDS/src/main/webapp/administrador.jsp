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
    <link rel="stylesheet" href="css/admin_styles.css">
</head>
<body>

<%
    Usuarios usuario = (Usuarios) session.getAttribute("usuario");
    String nombre = usuario.getPrimerNombre();
    String primerApellido = usuario.getPrimerApellido();
    String nombreCompleto = nombre + " " + primerApellido;

    if (usuario == null) {
        response.sendRedirect("AuthController?action=login");
        return;
    }

    List<Centro_salud> centros = (List<Centro_salud>) request.getAttribute("centros");
    List<Usuarios> usuarios = (List<Usuarios>) request.getAttribute("usuarios");
    List<Tipo_usuario> tiposUsuario = (List<Tipo_usuario>) request.getAttribute("tiposUsuario");

    Centro_salud centroEditar = (Centro_salud) request.getAttribute("centroEditar");
    String accion = (String) request.getAttribute("accion");

    String exito = (String) request.getAttribute("exito");
    String error = (String) request.getAttribute("error");
    String mensaje = (String) request.getAttribute("mensaje");
%>

<!-- Nueva estructura con sidebar lateral -->
<div class="admin-layout">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <div class="logo">
                <div class="logo-icon">🏥</div>
                <h2>IESS Admin</h2>
            </div>
        </div>

        <nav class="sidebar-nav">
            <div class="nav-section">
                <h3>Gestión de Datos</h3>
                <ul>
                    <li>
                        <a href="CentroSaludController" class="nav-item" data-table="centros">
                            <span class="nav-icon">🏥</span>
                            <span>Centros de Salud</span>
                        </a>
                    </li>
                    <li>
                        <a href="UserController" class="nav-item" data-table="usuarios">
                            <span class="nav-icon">👥</span>
                            <span>Usuarios</span>
                        </a>
                    </li>
                    <li>
                        <a href="UserController" class="nav-item" data-table="tipos-usuario">
                            <span class="nav-icon">🏷️</span>
                            <span>Tipos de Usuario</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="nav-item" data-table="menores">
                            <span class="nav-icon">👶</span>
                            <span>Menores</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="nav-item" data-table="vacunas">
                            <span class="nav-icon">💉</span>
                            <span>Vacunas</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="nav-item" data-table="dosis">
                            <span class="nav-icon">📊</span>
                            <span>Dosis</span>
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <div class="sidebar-footer">
            <div class="user-profile">
                <div class="user-avatar">👤</div>
                <div class="user-info">
                    <div class="user-name"><%= nombreCompleto %></div>
                    <div class="user-role">Administrador</div>
                </div>
            </div>
            <a href="AuthController?action=logout" class="logout-btn">
                <span>🚪</span> Cerrar Sesión
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Header -->
        <header class="main-header">
            <div class="header-left">
                <h1 id="page-title">Panel de Administración</h1>
                <p class="header-subtitle">Sistema de Vacunación IESS</p>
            </div>
            <div class="header-right">
                <div class="user-badge">
                    <strong>Cédula:</strong> <%= usuario.getCedula_usuario() %> |
                    <strong>Email:</strong> <%= usuario.getCorreo() %>
                </div>
            </div>
        </header>

        <!-- Mensajes de Estado -->
        <% if (exito != null) { %>
        <div class="alert alert-success">✅ <%= exito %></div>
        <% } %>
        <% if (error != null) { %>
        <div class="alert alert-danger">❌ <%= error %></div>
        <% } %>
        <% if (mensaje != null) { %>
        <div class="alert alert-success">ℹ️ <%= mensaje %></div>
        <% } %>

        <!-- Content Area -->

        <div class="content-area">
            <!-- Default Dashboard View -->
            <div id="dashboard-view" class="table-view active" >
                <div class="welcome-card">
                    <h2>🎯 Bienvenido al Panel de Administración</h2>
                    <p>Selecciona una opción del menú lateral para gestionar los datos del sistema.</p>
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-icon">🏥</div>
                            <div class="stat-info">
                                <h3>Centros de Salud</h3>
                                <p>Gestiona los centros médicos</p>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon">👥</div>
                            <div class="stat-info">
                                <h3>Usuarios</h3>
                                <p>Administra usuarios del sistema</p>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon">💉</div>
                            <div class="stat-info">
                                <h3>Vacunas</h3>
                                <p>Control de vacunas disponibles</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Centros de Salud View -->
            <div id="centros-view" class="table-view <% if("listar_centros".equals(accion)) { %>active<% } %>">
                <div class="table-header">
                    <h2>🏥 Gestión de Centros de Salud</h2>
                    <div class="table-actions">
                        <button class="btn btn-primary" onclick="toggleForm('crear-centro-form')">➕ Nuevo Centro</button>
                        <form method="GET" action="CentroSaludController" class="search-form" style="display: inline-block;">
                            <input type="hidden" name="action" value="buscar_centro">
                            <div class="search-box">
                                <input type="text" name="nombre" placeholder="🔍 Buscar centro..." class="search-input" required>
                                <button type="submit" class="search-btn">Buscar</button>
                            </div>
                        </form>
                        <a href="CentroSaludController?action=listar_centros_admin" class="btn btn-secondary">📋 Ver Todos</a>
                    </div>
                </div>

                <!-- Formulario para crear nuevo centro -->
                <div id="crear-centro-form" class="form-container" style="display: none;">
                    <div class="form-card">
                        <h3>➕ Crear Nuevo Centro de Salud</h3>
                        <form method="POST" action="CentroSaludController">
                            <input type="hidden" name="action" value="crear_centro">
                            <div class="form-group">
                                <label for="nombre">Nombre del Centro:</label>
                                <input type="text" id="nombre" name="nombre" required class="form-control">
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="latitud">Latitud:</label>
                                    <input type="number" id="latitud" name="latitud" step="any" required class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="longitud">Longitud:</label>
                                    <input type="number" id="longitud" name="longitud" step="any" required class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="estado">Estado:</label>
                                <select id="estado" name="estado" required class="form-control">
                                    <option value="Activo">Activo</option>
                                    <option value="Inactivo">Inactivo</option>
                                </select>
                            </div>
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">💾 Guardar Centro</button>
                                <button type="button" class="btn btn-secondary" onclick="toggleForm('crear-centro-form')">❌ Cancelar</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Formulario para editar centro (solo se muestra cuando hay centroEditar) -->
                <% if (centroEditar != null) { %>
                <div id="editar-centro-form" class="form-container">
                    <div class="form-card">
                        <h3>✏️ Editar Centro de Salud</h3>
                        <form method="POST" action="CentroSaludController">
                            <input type="hidden" name="action" value="actualizar_centro">
                            <input type="hidden" name="id" value="<%= centroEditar.getIdCentroSalud() %>">
                            <div class="form-group">
                                <label for="edit-nombre">Nombre del Centro:</label>
                                <input type="text" id="edit-nombre" name="nombre" value="<%= centroEditar.getNombreCentroSalud() %>" required class="form-control">
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="edit-latitud">Latitud:</label>
                                    <input type="number" id="edit-latitud" name="latitud" value="<%= centroEditar.getLatitud() %>" step="any" required class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="edit-longitud">Longitud:</label>
                                    <input type="number" id="edit-longitud" name="longitud" value="<%= centroEditar.getLongitud() %>" step="any" required class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="edit-estado">Estado:</label>
                                <select id="edit-estado" name="estado" required class="form-control">
                                    <option value="Activo" <%= "Activo".equals(centroEditar.getEstado()) ? "selected" : "" %>>Activo</option>
                                    <option value="Inactivo" <%= "Inactivo".equals(centroEditar.getEstado()) ? "selected" : "" %>>Inactivo</option>
                                </select>
                            </div>
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">💾 Actualizar Centro</button>
                                <a href="CentroSaludController?action=listar_centros_admin" class="btn btn-secondary">❌ Cancelar</a>
                            </div>
                        </form>
                    </div>
                </div>
                <% } %>

                <!-- Tabla con datos reales del controlador -->
                <div class="table-container">
                    <% if (centros != null && !centros.isEmpty()) { %>
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre del Centro</th>
                            <th>Ubicación (Lat, Lng)</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% for (Centro_salud centro : centros) { %>
                        <tr>
                            <td><%= centro.getIdCentroSalud() %></td>
                            <td><%= centro.getNombreCentroSalud() %></td>
                            <td><%= centro.getLatitud() %>, <%= centro.getLongitud() %></td>
                            <td>
                                <% if ("Activo".equals(centro.getEstado())) { %>
                                <span class="status active">✅ Activo</span>
                                <% } else { %>
                                <span class="status inactive">❌ Inactivo</span>
                                <% } %>
                            </td>
                            <td>
                                <a href="CentroSaludController?action=editar_centro&id=<%= centro.getIdCentroSalud() %>" class="btn-action edit">✏️ Editar</a>
                                <form method="POST" action="CentroSaludController" style="display: inline;">
                                    <input type="hidden" name="action" value="cambiar_estado_centro">
                                    <input type="hidden" name="id" value="<%= centro.getIdCentroSalud() %>">
                                    <button type="submit" class="btn-action toggle" onclick="return confirm('¿Está seguro de cambiar el estado de este centro?')">🔄 Estado</button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                    <% } else { %>
                    <div class="empty-state">
                        <div class="empty-icon">🏥</div>
                        <h3>No hay centros de salud registrados</h3>
                        <p>Haz clic en "Nuevo Centro" para agregar el primer centro de salud.</p>
                        <a href="CentroSaludController?action=listar_centros_admin" class="btn btn-primary">🔄 Cargar Centros</a>
                    </div>
                    <% } %>
                </div>
            </div>

            <!-- Usuarios View -->
            <div id="usuarios-view" class="table-view">
                <div class="table-header">
                    <h2>👥 Gestión de Usuarios</h2>
                    <div class="table-actions">
                        <button class="btn btn-primary">➕ Nuevo Usuario</button>
                        <div class="search-box">
                            <input type="text" placeholder="🔍 Buscar usuario..." class="search-input">
                            <button class="search-btn">Buscar</button>
                        </div>
                    </div>
                </div>

                <div class="table-container">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Cédula</th>
                            <th>Nombre Completo</th>
                            <th>Email</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>001</td>
                            <td>1234567890</td>
                            <td>Juan Pérez García</td>
                            <td>juan.perez@iess.gob.ec</td>
                            <td><span class="status active">✅ Activo</span></td>
                            <td>
                                <button class="btn-action edit">✏️ Editar</button>
                                <button class="btn-action toggle">🔄 Estado</button>
                            </td>
                        </tr>
                        <tr>
                            <td>002</td>
                            <td>0987654321</td>
                            <td>María González López</td>
                            <td>maria.gonzalez@iess.gob.ec</td>
                            <td><span class="status active">✅ Activo</span></td>
                            <td>
                                <button class="btn-action edit">✏️ Editar</button>
                                <button class="btn-action toggle">🔄 Estado</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Tipos de Usuario View -->
            <div id="tipos-usuario-view" class="table-view">
                <div class="table-header">
                    <h2>🏷️ Gestión de Tipos de Usuario</h2>
                    <div class="table-actions">
                        <button class="btn btn-primary">➕ Nuevo Tipo</button>
                        <div class="search-box">
                            <input type="text" placeholder="🔍 Buscar tipo..." class="search-input">
                            <button class="search-btn">Buscar</button>
                        </div>
                    </div>
                </div>

                <div class="table-container">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre del Tipo</th>
                            <th>Descripción</th>
                            <th>Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>001</td>
                            <td>Administrador</td>
                            <td>Acceso completo al sistema</td>
                            <td>
                                <button class="btn-action edit">✏️ Editar</button>
                                <button class="btn-action toggle">🔄 Estado</button>
                            </td>
                        </tr>
                        <tr>
                            <td>002</td>
                            <td>Médico</td>
                            <td>Gestión de pacientes y vacunas</td>
                            <td>
                                <button class="btn-action edit">✏️ Editar</button>
                                <button class="btn-action toggle">🔄 Estado</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Menores View -->
            <div id="menores-view" class="table-view">
                <div class="table-header">
                    <h2>👶 Gestión de Menores</h2>
                    <div class="table-actions">
                        <button class="btn btn-primary">➕ Nuevo Menor</button>
                        <div class="search-box">
                            <input type="text" placeholder="🔍 Buscar menor..." class="search-input">
                            <button class="search-btn">Buscar</button>
                        </div>
                    </div>
                </div>

                <div class="table-container">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre Completo</th>
                            <th>Fecha Nacimiento</th>
                            <th>Representante</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>001</td>
                            <td>Ana Sofía Morales</td>
                            <td>15/03/2020</td>
                            <td>Carmen Morales</td>
                            <td><span class="status active">✅ Activo</span></td>
                            <td>
                                <button class="btn-action edit">✏️ Editar</button>
                                <button class="btn-action toggle">🔄 Estado</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Vacunas View -->
            <div id="vacunas-view" class="table-view">
                <div class="table-header">
                    <h2>💉 Gestión de Vacunas</h2>
                    <div class="table-actions">
                        <button class="btn btn-primary">➕ Nueva Vacuna</button>
                        <div class="search-box">
                            <input type="text" placeholder="🔍 Buscar vacuna..." class="search-input">
                            <button class="search-btn">Buscar</button>
                        </div>
                    </div>
                </div>

                <div class="table-container">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre de la Vacuna</th>
                            <th>Tipo</th>
                            <th>Edad Recomendada</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>001</td>
                            <td>BCG</td>
                            <td>Tuberculosis</td>
                            <td>Recién nacido</td>
                            <td><span class="status active">✅ Activo</span></td>
                            <td>
                                <button class="btn-action edit">✏️ Editar</button>
                                <button class="btn-action toggle">🔄 Estado</button>
                            </td>
                        </tr>
                        <tr>
                            <td>002</td>
                            <td>Pentavalente</td>
                            <td>Múltiple</td>
                            <td>2-4-6 meses</td>
                            <td><span class="status active">✅ Activo</span></td>
                            <td>
                                <button class="btn-action edit">✏️ Editar</button>
                                <button class="btn-action toggle">🔄 Estado</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Dosis View -->
            <div id="dosis-view" class="table-view">
                <div class="table-header">
                    <h2>📊 Gestión de Dosis</h2>
                    <div class="table-actions">
                        <button class="btn btn-primary">➕ Nueva Dosis</button>
                        <div class="search-box">
                            <input type="text" placeholder="🔍 Buscar dosis..." class="search-input">
                            <button class="search-btn">Buscar</button>
                        </div>
                    </div>
                </div>

                <div class="table-container">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Paciente</th>
                            <th>Vacuna</th>
                            <th>Fecha Aplicación</th>
                            <th>Centro de Salud</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>001</td>
                            <td>Ana Sofía Morales</td>
                            <td>BCG</td>
                            <td>20/03/2020</td>
                            <td>Hospital General Quito</td>
                            <td><span class="status active">✅ Aplicada</span></td>
                            <td>
                                <button class="btn-action edit">✏️ Editar</button>
                                <button class="btn-action toggle">🔄 Estado</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Script mejorado para navegación y formularios -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const navItems = document.querySelectorAll('.nav-item');
        const tableViews = document.querySelectorAll('.table-view');
        const pageTitle = document.getElementById('page-title');

        // Navegación del sidebar
        navItems.forEach(item => {
            item.addEventListener('click', function(e) {
                e.preventDefault();

                navItems.forEach(nav => nav.classList.remove('active'));
                this.classList.add('active');

                tableViews.forEach(view => view.classList.remove('active'));

                const table = this.getAttribute('data-table');

                if (table === 'centros') {
                    window.location.href = 'CentroSaludController?action=listar_centros_admin';
                    return;
                }

                const targetView = document.getElementById(table + '-view');
                if (targetView) {
                    targetView.classList.add('active');
                    pageTitle.textContent = this.textContent.trim();
                }
            });
        });
    });

    function toggleForm(formId) {
        const form = document.getElementById(formId);
        if (form.style.display === 'none' || form.style.display === '') {
            form.style.display = 'block';
            form.scrollIntoView({ behavior: 'smooth' });
        } else {
            form.style.display = 'none';
        }
    }
</script>

</body>
</html>
