<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Usuarios" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IESS - Panel Médico</title>
    <link rel="stylesheet" href="css/Style.css">
    <link rel="stylesheet" href="css/dashboard-styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>

<body>
<%
    Usuarios usuario = (Usuarios) session.getAttribute("usuario");
    String nombreCompleto = (String) session.getAttribute("nombreCompleto");

    if (usuario == null) {
        response.sendRedirect("Controlador?action=login");
        return;
    }
%>

<!-- Header -->
<header class="header">
    <div class="header__brand">
        <div class="logo-circle">
            <div class="heart"></div>
        </div>
        <h1 class="header__appname">IESS Vacunación</h1>
    </div>

    <div class="header__user">
        <div class="user-dropdown">
            <a href="#" class="user-dropdown__trigger">
                <i class="fas fa-user-md"></i>
                <span class="user-name">Dr./Dra. <%= nombreCompleto %></span>
                <i class="fas fa-chevron-down"></i>
            </a>
            <div class="user-dropdown__menu">
                <div class="user-dropdown__header">
                    <h4>Personal Médico</h4>
                </div>
                <div class="user-dropdown__info">
                    <p><strong>Cédula:</strong> <%= usuario.getCedula_usuario() %></p>
                    <p><strong>Email:</strong> <%= usuario.getCorreo() %></p>
                    <p><strong>Centro:</strong> IESS Quito Norte</p>
                </div>
                <div class="user-dropdown__divider"></div>
                <a href="Controlador?action=logout" class="user-dropdown__item">
                    <i class="fas fa-sign-out-alt"></i>
                    Cerrar Sesión
                </a>
            </div>
        </div>
    </div>
</header>

<!-- Topbar de Bienvenida -->
<div class="topbar">
    <div class="topbar__left">
        <h2 class="topbar__title">
            Dr./Dra. <span class="username"><%= nombreCompleto %></span>
        </h2>
        <p class="topbar__subtitle">
            <i class="fas fa-stethoscope"></i>
            Panel de Control Médico - IESS Quito Norte
        </p>
    </div>
    <div class="topbar__right">
        <div class="quick-stats">
            <div class="stat-item">
                <i class="fas fa-users"></i>
                <span>45 Pacientes</span>
            </div>
            <div class="stat-item">
                <i class="fas fa-syringe"></i>
                <span>23 Vacunas Hoy</span>
            </div>
            <div class="stat-item">
                <i class="fas fa-clock"></i>
                <span>8 Pendientes</span>
            </div>
        </div>
    </div>
</div>

<!-- Contenido Principal -->
<div class="main-container">
    <div class="container">
        <!-- Dashboard Grid -->
        <div class="dashboard-grid">
            <!-- Tarjeta: Buscar Paciente -->
            <div class="dashboard-card fade-in-up">
                <div class="dashboard-card__icon">
                    <i class="fas fa-search"></i>
                </div>
                <h3 class="dashboard-card__title">Buscar Paciente</h3>
                <p class="dashboard-card__description">
                    Busca pacientes por cédula del menor o tutor para consultar historial médico.
                </p>
                <a href="#" class="btn btn--primary">
                    <i class="fas fa-search"></i>
                    Buscar
                </a>
            </div>

            <!-- Tarjeta: Registrar Vacuna -->
            <div class="dashboard-card fade-in-up">
                <div class="dashboard-card__icon dashboard-card__icon--success">
                    <i class="fas fa-plus-circle"></i>
                </div>
                <h3 class="dashboard-card__title">Registrar Vacuna</h3>
                <p class="dashboard-card__description">
                    Aplica y registra nuevas vacunas en el sistema de control.
                </p>
                <a href="#" class="btn btn--primary">
                    <i class="fas fa-plus"></i>
                    Registrar
                </a>
            </div>

            <!-- Tarjeta: Esquemas de Vacunación -->
            <div class="dashboard-card fade-in-up">
                <div class="dashboard-card__icon dashboard-card__icon--info">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <h3 class="dashboard-card__title">Esquemas de Vacunación</h3>
                <p class="dashboard-card__description">
                    Consulta y configura esquemas de vacunación personalizados.
                </p>
                <a href="#" class="btn btn--primary">
                    <i class="fas fa-cogs"></i>
                    Configurar
                </a>
            </div>

            <!-- Tarjeta: Estadísticas -->
            <div class="dashboard-card fade-in-up">
                <div class="dashboard-card__icon dashboard-card__icon--purple">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h3 class="dashboard-card__title">Estadísticas</h3>
                <p class="dashboard-card__description">
                    Ve el progreso de vacunación y genera reportes médicos.
                </p>
                <a href="#" class="btn btn--primary">
                    <i class="fas fa-chart-bar"></i>
                    Ver Reportes
                </a>
            </div>

            <!-- Tarjeta: Citas de Hoy -->
            <div class="dashboard-card fade-in-up">
                <div class="dashboard-card__icon dashboard-card__icon--warning">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <h3 class="dashboard-card__title">Citas de Hoy</h3>
                <div class="dashboard-card__description">
                    <p><strong>10:00 AM</strong> - Sofía Mendez (6 meses) - Rotavirus</p>
                    <p><strong>11:30 AM</strong> - Diego Torres (18 meses) - Varicela</p>
                    <p><strong>2:00 PM</strong> - Isabella López (4 años) - Refuerzo DPT</p>
                </div>
                <a href="#" class="btn btn--primary">
                    <i class="fas fa-calendar"></i>
                    Ver Agenda
                </a>
            </div>

            <!-- Tarjeta: Alertas Médicas -->
            <div class="dashboard-card fade-in-up">
                <div class="dashboard-card__icon dashboard-card__icon--orange">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <h3 class="dashboard-card__title">Alertas Importantes</h3>
                <div class="dashboard-card__description">
                    <p>• 3 pacientes con esquemas atrasados</p>
                    <p>• Stock bajo: Vacuna BCG (5 dosis)</p>
                    <p>• Recordar: Capacitación mañana 2:00 PM</p>
                    <p>• Nueva normativa de registro disponible</p>
                </div>
                <a href="#" class="btn btn--primary">
                    <i class="fas fa-bell"></i>
                    Ver Alertas
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <p>&copy; 2025 IESS - Instituto Ecuatoriano de Seguridad Social. Panel Médico.</p>
    </div>
</footer>

</body>
</html>