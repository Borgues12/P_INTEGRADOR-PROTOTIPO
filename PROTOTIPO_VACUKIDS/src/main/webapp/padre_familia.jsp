<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="Model.Usuarios" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Locale" %>

<%
    // Verificar sesión
    Usuarios usuario = (Usuarios) session.getAttribute("usuario");
    String nombreCompleto = (String) session.getAttribute("nombreCompleto");

    if (usuario == null) {
        response.sendRedirect("Controlador?action=login");
        return;
    }

    // Formatear fecha actual
    SimpleDateFormat sdf = new SimpleDateFormat("d 'de' MMMM, yyyy", new Locale("es", "ES"));
    String fechaActual = sdf.format(new Date());

    // Crear iniciales del usuario
    String iniciales = "";
    if (usuario.getPrimerNombre() != null && !usuario.getPrimerNombre().isEmpty()) {
        iniciales += usuario.getPrimerNombre().charAt(0);
    }
    if (usuario.getPrimerApellido() != null && !usuario.getPrimerApellido().isEmpty()) {
        iniciales += usuario.getPrimerApellido().charAt(0);
    }
    iniciales = iniciales.toUpperCase();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VACUKIDS - Seguimiento de Vacunación Infantil</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/padre_familia.css">
</head>
<body>
<!-- Cabezal -->
<header class="header">
    <div class="header__brand">
        <div class="logo-circle">
            <div class="heart"></div>
        </div>
        <h1 class="header__appname">VACUKIDS</h1>
        <div class="user-welcome" style="color: #666; font-size: 14px; margin-left: 10px;">
            Bienvenido, <%= usuario.getPrimerNombre() %>
        </div>
    </div>

    <div class="menu-toggle" id="menuToggle">
        <i class="fas fa-bars"></i>
    </div>


    <nav class="nav-wrapper">
        <div class="dropdown-wrapper">
            <button class="icon-button" id="userIcon">
                <i class="fas fa-user"></i>
            </button>
            <div class="dropdown-menu" id="userMenu">
                <div style="padding: 8px 12px; border-bottom: 1px solid #eee; font-size: 12px; color: #666;">
                    <%= nombreCompleto %>
                </div>
                <a href="Controlador?action=logout">Cerrar sesión</a>
            </div>
        </div>
    </nav>
</header>

<!-- Botón para móviles -->

<!-- Panel lateral -->
<div class="sidebar" id="sidebar">
    <div class="vaccine-menu">
        <div class="menu-item active">
            <div class="menu-icon">
                <i class="fas fa-home"></i>
            </div>
            <div class="menu-text">
                <h3 class="menu-title">Inicio</h3>
                <p class="menu-desc">Panel principal de vacunación</p>
            </div>
        </div>

        <div class="menu-item" id="btnAgendarVacuna">
            <div class="menu-icon">
                <i class="fas fa-syringe"></i>
            </div>
            <div class="menu-text">
                <h3 class="menu-title">Agendar Vacuna</h3>
                <p class="menu-desc">Agregar nueva vacuna al historial</p>
            </div>
        </div>

        <div class="menu-item menu-item-historial">
            <div class="menu-icon">
                <i class="fas fa-history"></i>
            </div>
            <div class="menu-text">
                <h3 class="menu-title">Historial</h3>
                <p class="menu-desc">Ver registro completo de vacunas</p>
            </div>
        </div>

        <div class="menu-item menu-item-calendar">
            <div class="menu-icon">
                <i class="fas fa-calendar-alt"></i>
            </div>
            <div class="menu-text">
                <h3 class="menu-title">Calendario</h3>
                <p class="menu-desc">Próximas vacunas programadas</p>
            </div>
        </div>

        <!-- Botón Información de Vacunas -->
        <div class="menu-item menu-item-vacuna">
            <div class="menu-icon">
                <i class="fas fa-info-circle"></i>
            </div>
            <div class="menu-text">
                <h3 class="menu-title">Información de Vacunas</h3>
                <p class="menu-desc">Detalles sobre cada tipo de vacuna</p>
            </div>
        </div>


        <div class="menu-item" id="abrir-centros-btn">
            <div class="menu-icon">
                <i class="fas fa-map-marker-alt"></i>
            </div>
            <div class="menu-text">
                <h3 class="menu-title">Centros de Vacunación</h3>
                <p class="menu-desc">Encuentra centros cerca de ti</p>
            </div>
        </div>

    </div>
</div>

<!-- Contenido principal -->
<div class="main-content">
    <!-- Información de usuario -->
    <div class="user-info-card">
        <div class="user-avatar"><%= iniciales %></div>
        <div class="user-text">
            <div class="user-name"><%= nombreCompleto %></div>
            <div class="user-role">
                <i class="fas fa-child"></i> Padre/Madre de Familia
            </div>
        </div>
        <div class="today-date">
            <i class="fas fa-calendar-day"></i> <%= fechaActual %>
        </div>
    </div>

    <!-- Vacunas pendientes -->
    <h2 class="section-title">Vacunas Pendientes</h2>

    <div class="vaccine-grid">
        <div class="vaccine-card">
            <div class="card-header">
                <div class="vaccine-icon">
                    <i class="fas fa-syringe"></i>
                </div>
                <div>
                    <div class="vaccine-name">Influenza Estacional</div>
                    <div class="vaccine-status">Pendiente</div>
                </div>
            </div>
            <div class="card-body">
                <p class="vaccine-desc">Vacuna anual para prevenir la gripe estacional y sus complicaciones.</p>

                <div class="vaccine-info">
                    <div class="info-item">
                        <div class="info-label">Niño</div>
                        <div class="info-value">Juan Pérez</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Dosis</div>
                        <div class="info-value">1/1</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Edad</div>
                        <div class="info-value">4 años</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Fecha límite</div>
                        <div class="info-value">15 Jul 2025</div>
                    </div>
                </div>

                <button class="btn-vaccine">
                    <i class="fas fa-calendar-plus"></i> Programar Vacuna
                </button>
            </div>
        </div>

        <div class="vaccine-card">
            <div class="card-header">
                <div class="vaccine-icon">
                    <i class="fas fa-virus"></i>
                </div>
                <div>
                    <div class="vaccine-name">COVID-19 Refuerzo</div>
                    <div class="vaccine-status">Pendiente</div>
                </div>
            </div>
            <div class="card-body">
                <p class="vaccine-desc">Refuerzo anual para mantener la protección contra nuevas variantes.</p>

                <div class="vaccine-info">
                    <div class="info-item">
                        <div class="info-label">Niño</div>
                        <div class="info-value">Ana Pérez</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Dosis</div>
                        <div class="info-value">3/4</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Edad</div>
                        <div class="info-value">2 años</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Fecha límite</div>
                        <div class="info-value">20 Jul 2025</div>
                    </div>
                </div>

                <button class="btn-vaccine">
                    <i class="fas fa-calendar-check"></i> Agendar Cita
                </button>
            </div>
        </div>

        <div class="vaccine-card">
            <div class="card-header">
                <div class="vaccine-icon">
                    <i class="fas fa-lungs-virus"></i>
                </div>
                <div>
                    <div class="vaccine-name">Neumocócica</div>
                    <div class="vaccine-status">Pendiente</div>
                </div>
            </div>
            <div class="card-body">
                <p class="vaccine-desc">Protege contra infecciones neumocócicas como neumonía y meningitis.</p>

                <div class="vaccine-info">
                    <div class="info-item">
                        <div class="info-label">Niño</div>
                        <div class="info-value">Juan Pérez</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Dosis</div>
                        <div class="info-value">1/2</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Edad</div>
                        <div class="info-value">4 años</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Fecha límite</div>
                        <div class="info-value">18 Jul 2025</div>
                    </div>
                </div>

                <button class="btn-vaccine">
                    <i class="fas fa-info-circle"></i> Solicitar Información
                </button>
            </div>
        </div>
    </div>

    <!-- Vacunas completadas -->
    <h2 class="section-title">Vacunas Completadas</h2>

    <div class="vaccine-grid">
        <div class="vaccine-card">
            <div class="card-header" style="background: #e8f5e9;">
                <div class="vaccine-icon" style="background: #4caf50;">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div>
                    <div class="vaccine-name">Tétanos - Difteria</div>
                    <div class="vaccine-status" style="color: #4caf50;">Completa</div>
                </div>
            </div>
            <div class="card-body">
                <p class="vaccine-desc">Refuerzo cada 10 años para mantener la protección.</p>

                <div class="vaccine-info">
                    <div class="info-item">
                        <div class="info-label">Niño</div>
                        <div class="info-value">Ana Pérez</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Dosis</div>
                        <div class="info-value">Completa</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Fecha aplicación</div>
                        <div class="info-value">5 Jun 2025</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Próximo refuerzo</div>
                        <div class="info-value">Jun 2035</div>
                    </div>
                </div>

                <button class="btn-vaccine" style="background: #4caf50;">
                    <i class="fas fa-file-pdf"></i> Ver Certificado
                </button>
            </div>
        </div>

        <div class="vaccine-card">
            <div class="card-header" style="background: #e8f5e9;">
                <div class="vaccine-icon" style="background: #4caf50;">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div>
                    <div class="vaccine-name">Hepatitis B</div>
                    <div class="vaccine-status" style="color: #4caf50;">Completa</div>
                </div>
            </div>
            <div class="card-body">
                <p class="vaccine-desc">Protección contra el virus de la hepatitis B.</p>

                <div class="vaccine-info">
                    <div class="info-item">
                        <div class="info-label">Niño</div>
                        <div class="info-value">Juan Pérez</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Dosis</div>
                        <div class="info-value">3/3</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Fecha aplicación</div>
                        <div class="info-value">20 May 2025</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Próximo refuerzo</div>
                        <div class="info-value">Ninguno</div>
                    </div>
                </div>

                <button class="btn-vaccine" style="background: #4caf50;">
                    <i class="fas fa-file-pdf"></i> Ver Certificado
                </button>
            </div>
        </div>
    </div>
</div>


<!-- Fondo oscuro -->
<div id="calendarOverlay" class="calendar-overlay"></div>

<!-- Ventana flotante del calendario -->
<div class="calendar-modal" id="calendarModal">
    <div class="calendar-header">
        <div class="calendar-nav">
            <button id="prevMonth"><i class="fas fa-chevron-left"></i></button>
            <button id="nextMonth"><i class="fas fa-chevron-right"></i></button>
        </div>
        <div class="calendar-month" id="currentMonth">Mes</div>
        <div class="calendar-year" id="currentYear">Año</div>
    </div>

    <div class="calendar-weekdays">
        <div>L</div><div>M</div><div>X</div><div>J</div><div>V</div><div>S</div><div>D</div>
    </div>

    <div class="calendar-days" id="calendarDays"></div>

    <div class="calendar-events">
        <h3><i class="fas fa-syringe"></i> Próximas Vacunas</h3>
        <div class="event-item">
            <div class="event-date">15</div>
            <div class="event-info">
                <h4>Vacuna COVID-19 (Refuerzo)</h4>
                <p>Centro de Salud Norte - 9:00 AM</p>
            </div>
        </div>
        <div class="event-item">
            <div class="event-date">22</div>
            <div class="event-info">
                <h4>Vacuna contra la Influenza</h4>
                <p>Hospital Central - 10:30 AM</p>
            </div>
        </div>
    </div>
</div>

<!-- FONDO OSCURO Y CONTENEDOR MODAL -->
<div id="vacunaModal" class="vacuna-modal-container">
    <div class="vacuna-modal">
        <button class="close-btn">&times;</button>
        <input type="text" class="vacuna-search-input" placeholder="Buscar vacuna...">

        <h1>Poliomielitis</h1>
        <h2>Vacuna contra la polio</h2>
        <div class="content">
            <div class="info-box">
                <div class="info-item">
                    <strong>Descripción</strong>
                    La vacuna de poliomielitis protege contra la infección por poliovirus.
                </div>
                <div class="info-item">
                    <strong>Enfermedades que previene</strong>
                    Poliomielitis (parálisis infantil)
                </div>
                <div class="info-item">
                    <strong>Público objetivo</strong>
                    Niños menores de 5 años
                </div>
                <div class="info-item">
                    <strong>Advertencias</strong>
                    No administrar en personas inmunocomprometidas
                </div>
            </div>
            <div class="vaccine-image">
                <img src="frasco-polio.png" alt="Frasco Vacuna">
            </div>
            <div class="info-box">
                <div class="info-item">
                    <strong>Funcionalidad</strong>
                    Estimula la producción de anticuerpos para combatir el poliovirus.
                </div>
                <div class="info-item">
                    <strong>Uso</strong>
                    Indispensable en la inmunización infantil y para erradicar la polio.
                </div>
                <div class="info-item">
                    <strong>Dosis</strong>
                    Requiere múltiples dosis siguiendo un calendario de vacunación.
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Ventana flotante para agendar vacuna -->
<div class="overlay-agendar" id="agendarOverlay" style="display: none">
    <div class="modal-agendar" id="agendarModal">
        <button class="close-btn-agendar" id="closeAgendar">&times;</button>
        <h1>Agendar Vacuna</h1>
        <h2>Registrar nueva vacuna en el historial</h2>

        <form id="agendarForm">
            <div class="form-group">
                <label for="nombreVacuna">Nombre de la vacuna</label>
                <input type="text" id="nombreVacuna" placeholder="Ej. Poliomielitis" required />
            </div>

            <div class="form-group">
                <label for="fechaVacuna">Fecha de aplicación</label>
                <input type="date" id="fechaVacuna" required />
            </div>

            <div class="form-group">
                <label for="centroVacuna">Centro de salud</label>
                <input type="text" id="centroVacuna" placeholder="Ej. Centro de Salud Norte" />
            </div>

            <div class="form-group">
                <label for="nota">Observaciones</label>
                <textarea id="nota" rows="3" placeholder="Detalles adicionales..."></textarea>
            </div>

            <button type="submit" class="btn-submit-agendar">Guardar</button>
        </form>
    </div>
</div>

<!-- Fondo oscuro -->
<div id="historialOverlay" class="calendar-overlay"></div>

<!-- Ventana flotante del historial -->
<div class="historial-modal" id="historialModal">
    <div class="historial-container">
        <button class="close-btn" onclick="cerrarHistorial()">×</button>
        <h1>📋 Historial de Vacunas</h1>
        <p class="historial-desc">Consulta todas las vacunas registradas en tu historial.</p>

        <div class="historial-registros">
            <div class="registro-item">
                <h3>COVID-19</h3>
                <p><strong>Fecha:</strong> 15/03/2024</p>
                <p><strong>Dosis:</strong> Refuerzo</p>
                <p><strong>Lugar:</strong> Centro de Salud Sur</p>
            </div>
            <div class="registro-item">
                <h3>Influenza</h3>
                <p><strong>Fecha:</strong> 10/10/2023</p>
                <p><strong>Dosis:</strong> Única</p>
                <p><strong>Lugar:</strong> Hospital Municipal</p>
            </div>
            <!-- Puedes duplicar .registro-item para más registros -->
        </div>
    </div>
</div>

<!-- Ventana flotante: Centros de Vacunación -->
<div id="ventana-centros" class="ventana-flotante oculto">
    <!-- Botón para cerrar -->
    <div id="cerrar-centros" class="cerrar-btn">
        <i class="fas fa-times"></i>
    </div>

    <!-- Contenido de la ventana -->
    <div class="centers-container">
        <div class="centers-header">
            <h2><i class="fas fa-map-marker-alt"></i> Centros cercanos</h2>
        </div>
        <div class="centers-list">
            <!-- Centro 1 -->
            <div class="center-item active">
                <div class="center-header">
                    <h3 class="center-name">Centro de Salud Norte</h3>
                    <span class="center-distance">1.2 km</span>
                </div>
                <p class="center-address">
                    <i class="fas fa-map-pin"></i> Av. Principal 123, Ciudad
                </p>
                <div class="center-info">
                    <div class="info-item">
                        <i class="fas fa-phone"></i> (123) 456-7890
                    </div>
                    <div class="info-item">
                        <i class="fas fa-syringe"></i> Todas las vacunas
                    </div>
                </div>
                <div class="center-hours">
                    <span class="today">Abierto hoy:</span> 8:00 AM - 6:00 PM
                </div>
            </div>

            <!-- Centro 2 -->
            <div class="center-item">
                <div class="center-header">
                    <h3 class="center-name">Hospital Central</h3>
                    <span class="center-distance">2.5 km</span>
                </div>
                <p class="center-address">
                    <i class="fas fa-map-pin"></i> Calle Central 456, Ciudad
                </p>
                <div class="center-info">
                    <div class="info-item">
                        <i class="fas fa-phone"></i> (123) 789-0123
                    </div>
                    <div class="info-item">
                        <i class="fas fa-syringe"></i> Vacunas infantiles
                    </div>
                </div>
                <div class="center-hours">
                    <span class="today">Abierto hoy:</span> 7:00 AM - 8:00 PM
                </div>
            </div>

            <!-- Centro 3 -->
            <div class="center-item">
                <div class="center-header">
                    <h3 class="center-name">Clínica del Sur</h3>
                    <span class="center-distance">3.1 km</span>
                </div>
                <p class="center-address">
                    <i class="fas fa-map-pin"></i> Av. Sur 789, Ciudad
                </p>
                <div class="center-info">
                    <div class="info-item">
                        <i class="fas fa-phone"></i> (123) 234-5678
                    </div>
                    <div class="info-item">
                        <i class="fas fa-syringe"></i> Vacunas COVID-19
                    </div>
                </div>
                <div class="center-hours">
                    <span class="today">Abierto hoy:</span> 9:00 AM - 5:00 PM
                </div>
            </div>

            <!-- Centro 4 -->
            <div class="center-item">
                <div class="center-header">
                    <h3 class="center-name">Centro Médico Este</h3>
                    <span class="center-distance">4.3 km</span>
                </div>
                <p class="center-address">
                    <i class="fas fa-map-pin"></i> Calle Este 101, Ciudad
                </p>
                <div class="center-info">
                    <div class="info-item">
                        <i class="fas fa-phone"></i> (123) 567-8901
                    </div>
                    <div class="info-item">
                        <i class="fas fa-syringe"></i> Vacunas para adultos
                    </div>
                </div>
                <div class="center-hours">
                    <span class="today">Abierto hoy:</span> 8:30 AM - 7:30 PM
                </div>
            </div>

            <!-- Centro 5 -->
            <div class="center-item">
                <div class="center-header">
                    <h3 class="center-name">Farmacia Vacunación</h3>
                    <span class="center-distance">5.0 km</span>
                </div>
                <p class="center-address">
                    <i class="fas fa-map-pin"></i> Av. Comercial 202, Ciudad
                </p>
                <div class="center-info">
                    <div class="info-item">
                        <i class="fas fa-phone"></i> (123) 345-6789
                    </div>
                    <div class="info-item">
                        <i class="fas fa-syringe"></i> Vacunas comunes
                    </div>
                </div>
                <div class="center-hours">
                    <span class="today">Abierto hoy:</span> 9:00 AM - 9:00 PM
                </div>
            </div>
        </div>
    </div>
</div>

</div>

<script>

    const abrirCentrosBtn = document.getElementById('abrir-centros-btn');
    const ventanaCentros = document.getElementById('ventana-centros');
    const cerrarCentros = document.getElementById('cerrar-centros');

    abrirCentrosBtn.addEventListener('click', () => {
        ventanaCentros.classList.remove('oculto');
    });

    cerrarCentros.addEventListener('click', () => {
        ventanaCentros.classList.add('oculto');
    });

    const historialBtn = document.querySelector('.menu-item-historial');
    const historialModal = document.getElementById('historialModal');
    const historialOverlay = document.getElementById('historialOverlay');

    historialBtn.addEventListener('click', () => {
        historialModal.classList.add('active');
        historialOverlay.style.display = 'block';
    });

    function cerrarHistorial() {
        historialModal.classList.remove('active');
        historialOverlay.style.display = 'none';
    }

    // También cerrar al hacer clic en el fondo oscuro
    historialOverlay.addEventListener('click', cerrarHistorial);

    // Abrir ventana al dar clic en el botón
    document.getElementById('btnAgendarVacuna').addEventListener('click', () => {
        document.getElementById('agendarOverlay').style.display = 'flex';
    });

    // Cerrar con botón de X
    document.getElementById('closeAgendar').addEventListener('click', () => {
        document.getElementById('agendarOverlay').style.display = 'none';
    });

    // Cerrar al hacer clic fuera del modal
    document.getElementById('agendarOverlay').addEventListener('click', (e) => {
        if (e.target.id === 'agendarOverlay') {
            document.getElementById('agendarOverlay').style.display = 'none';
        }
    });

    // Envío del formulario (simulado)
    document.getElementById('agendarForm').addEventListener('submit', function (e) {
        e.preventDefault();
        alert('✅ Vacuna agendada exitosamente');
        document.getElementById('agendarOverlay').style.display = 'none';
    });

    const vacunaBtn = document.querySelector('.menu-item-vacuna');
    const vacunaModal = document.getElementById('vacunaModal');
    const vacunaClose = vacunaModal.querySelector('.close-btn');

    vacunaBtn.addEventListener('click', () => {
        vacunaModal.classList.add('active');
    });

    vacunaClose.addEventListener('click', () => {
        vacunaModal.classList.remove('active');
    });

    vacunaModal.addEventListener('click', (e) => {
        if (e.target === vacunaModal) {
            vacunaModal.classList.remove('active');
        }
    });

    const calendarBtn = document.querySelector('.menu-item-calendar');
    const overlay = document.getElementById('calendarOverlay');
    const modal = document.getElementById('calendarModal');

    calendarBtn.addEventListener('click', () => {
        overlay.classList.add('active');
        modal.classList.add('active');
    });

    overlay.addEventListener('click', () => {
        overlay.classList.remove('active');
        modal.classList.remove('active');
    });

    // Lógica del calendario
    const prevMonthBtn = document.getElementById('prevMonth');
    const nextMonthBtn = document.getElementById('nextMonth');
    const currentMonthEl = document.getElementById('currentMonth');
    const currentYearEl = document.getElementById('currentYear');
    const calendarDaysEl = document.getElementById('calendarDays');

    let currentDate = new Date();
    let currentMonth = currentDate.getMonth();
    let currentYear = currentDate.getFullYear();

    prevMonthBtn.addEventListener('click', () => {
        currentMonth--;
        if (currentMonth < 0) {
            currentMonth = 11;
            currentYear--;
        }
        renderCalendar();
    });

    nextMonthBtn.addEventListener('click', () => {
        currentMonth++;
        if (currentMonth > 11) {
            currentMonth = 0;
            currentYear++;
        }
        renderCalendar();
    });

    function renderCalendar() {
        const firstDay = new Date(currentYear, currentMonth, 1);
        const lastDay = new Date(currentYear, currentMonth + 1, 0);
        const daysInMonth = lastDay.getDate();
        const startingDay = firstDay.getDay();
        const adjustedStartingDay = startingDay === 0 ? 6 : startingDay - 1;

        currentMonthEl.textContent = firstDay.toLocaleDateString('es-ES', { month: 'long' });
        currentYearEl.textContent = currentYear;
        calendarDaysEl.innerHTML = '';

        for (let i = 0; i < adjustedStartingDay; i++) {
            const emptyDay = document.createElement('div');
            emptyDay.classList.add('calendar-day', 'empty');
            calendarDaysEl.appendChild(emptyDay);
        }

        const today = new Date();
        const vaccineDays = [5, 15, 22, 27];

        for (let i = 1; i <= daysInMonth; i++) {
            const day = document.createElement('div');
            day.classList.add('calendar-day');
            day.textContent = i;

            if (i === today.getDate() && currentMonth === today.getMonth() && currentYear === today.getFullYear()) {
                day.classList.add('today');
            }

            if (vaccineDays.includes(i)) {
                day.classList.add('vaccine-day');
            }

            calendarDaysEl.appendChild(day);
        }
    }

    renderCalendar();

    // Menú desplegable de usuario
    const userIcon = document.getElementById('userIcon');
    const userMenu = document.getElementById('userMenu');

    userIcon.addEventListener('click', function(e) {
        e.stopPropagation();
        userMenu.classList.toggle('show');
    });

    // Cerrar menú al hacer clic fuera
    document.addEventListener('click', function(e) {
        if (!userMenu.contains(e.target) && e.target !== userIcon) {
            userMenu.classList.remove('show');
        }
    });

    // Menú lateral para móviles
    const menuToggle = document.getElementById('menuToggle');
    const sidebar = document.getElementById('sidebar');

    menuToggle.addEventListener('click', function() {
        sidebar.classList.toggle('active');
    });

    // Activar elemento de menú al hacer clic
    document.querySelectorAll('.menu-item').forEach(item => {
        item.addEventListener('click', function() {
            document.querySelectorAll('.menu-item').forEach(i => {
                i.classList.remove('active');
            });
            this.classList.add('active');

            // En móviles, cerrar el menú después de seleccionar
            if (window.innerWidth <= 768) {
                sidebar.classList.remove('active');
            }
        });
    });

    // Animaciones para las tarjetas
    const vaccineCards = document.querySelectorAll('.vaccine-card');
    vaccineCards.forEach((card, index) => {
        card.style.animation = `fadeIn 0.5s ease ${index * 0.1}s forwards`;
        card.style.opacity = '0';
    });

</script>

</body>
</html>