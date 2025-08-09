<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Usuarios" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Vacunate CTM</title>
    <link rel="stylesheet" href="css/Style.css">
    <link rel="stylesheet" href="css/dashboard-styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>

<body>
<%
    Usuarios usuario = (Usuarios) session.getAttribute("usuario");
    String nombreCompleto = (String) session.getAttribute("nombreCompleto");

    // Verificar que hay sesión
    if (usuario == null) {
        response.sendRedirect("Controlador?action=login");
        return;
    }
%>

<!-- Header Principal -->
<header class="header">
    <div class="header__brand">
        <div class="logo-circle">
            <div class="heart"></div>
        </div>
        <h1 class="header__appname">Vacunate CTM</h1>
    </div>

    <nav class="nav-wrapper">
        <a href="#" class="nav-link active">
            <i class="fas fa-home"></i>
            Inicio
        </a>
        <a href="#" class="nav-link">
            <i class="fas fa-syringe"></i>
            Mis Vacunas
        </a>
        <a href="#" class="nav-link">
            <i class="fas fa-baby"></i>
            Hijos
        </a>
        <a href="Controlador?action=listar_centros" class="nav-link">
            <i class="fas fa-hospital"></i>
            Centros
        </a>
        <a href="#" class="nav-link">
            <i class="fas fa-certificate"></i>
            Certificados
        </a>
    </nav>

    <div class="header__user">
        <div class="user-dropdown">
            <button class="user-dropdown__trigger" id="userDropdown">
                <i class="fas fa-user-circle"></i>
                <span class="user-name"><%= nombreCompleto %></span>
                <i class="fas fa-chevron-down"></i>
            </button>
            <div class="user-dropdown__menu" id="userDropdownMenu">
                <div class="user-dropdown__header">
                    <h4>Información del Usuario</h4>
                </div>
                <div class="user-dropdown__info">
                    <p><strong>Cédula:</strong> <%= usuario.getCedula_usuario() %></p>
                    <p><strong>Email:</strong> <%= usuario.getCorreo() %></p>
                    <p><strong>Usuario:</strong> <%= usuario.getLogin() %></p>
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

<!-- Topbar con información de bienvenida -->
<div class="topbar">
    <div class="topbar__left">
        <h2 class="topbar__title">
            Bienvenido, <span class="username"><%= nombreCompleto %></span>
        </h2>
        <p class="topbar__subtitle">
            <i class="fas fa-calendar-check"></i>
            Panel de control principal
        </p>
    </div>
    <div class="topbar__right">
        <div class="quick-stats">
            <div class="stat-item">
                <i class="fas fa-syringe"></i>
                <span>Vacunas: 12</span>
            </div>
            <div class="stat-item">
                <i class="fas fa-baby"></i>
                <span>Niños: 3</span>
            </div>
            <div class="stat-item">
                <i class="fas fa-calendar"></i>
                <span>Citas: 2</span>
            </div>
        </div>
    </div>
</div>

<!-- Contenido Principal -->
<div class="main-container">
    <div class="container">
        <!-- Cards de funcionalidades -->
        <div class="dashboard-grid">
            <div class="dashboard-card">
                <div class="dashboard-card__icon">
                    <i class="fas fa-baby"></i>
                </div>
                <div class="dashboard-card__content">
                    <h3 class="dashboard-card__title">Gestión de Niños</h3>
                    <p class="dashboard-card__description">
                        Registrar y gestionar información de niños
                    </p>
                    <a href="#" class="btn btn--primary">
                        <i class="fas fa-plus"></i>
                        Acceder
                    </a>
                </div>
            </div>

            <div class="dashboard-card">
                <div class="dashboard-card__icon dashboard-card__icon--success">
                    <i class="fas fa-syringe"></i>
                </div>
                <div class="dashboard-card__content">
                    <h3 class="dashboard-card__title">Gestión de Vacunas</h3>
                    <p class="dashboard-card__description">
                        Administrar vacunas y dosis
                    </p>
                    <a href="#" class="btn btn--primary">
                        <i class="fas fa-vial"></i>
                        Acceder
                    </a>
                </div>
            </div>

            <div class="dashboard-card">
                <div class="dashboard-card__icon dashboard-card__icon--info">
                    <i class="fas fa-hospital"></i>
                </div>
                <div class="dashboard-card__content">
                    <h3 class="dashboard-card__title">Centros de Salud</h3>
                    <p class="dashboard-card__description">
                        Gestionar centros de salud
                    </p>
                    <a href="Controlador?action=listar_centros" class="btn btn--primary">
                        <i class="fas fa-building"></i>
                        Acceder
                    </a>
                </div>
            </div>

            <div class="dashboard-card">
                <div class="dashboard-card__icon dashboard-card__icon--warning">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <div class="dashboard-card__content">
                    <h3 class="dashboard-card__title">Citas Médicas</h3>
                    <p class="dashboard-card__description">
                        Programar y gestionar citas
                    </p>
                    <a href="#" class="btn btn--primary">
                        <i class="fas fa-calendar-plus"></i>
                        Acceder
                    </a>
                </div>
            </div>

            <div class="dashboard-card">
                <div class="dashboard-card__icon dashboard-card__icon--purple">
                    <i class="fas fa-chart-bar"></i>
                </div>
                <div class="dashboard-card__content">
                    <h3 class="dashboard-card__title">Reportes</h3>
                    <p class="dashboard-card__description">
                        Ver estadísticas y reportes
                    </p>
                    <a href="#" class="btn btn--primary">
                        <i class="fas fa-chart-line"></i>
                        Acceder
                    </a>
                </div>
            </div>

            <div class="dashboard-card">
                <div class="dashboard-card__icon dashboard-card__icon--orange">
                    <i class="fas fa-certificate"></i>
                </div>
                <div class="dashboard-card__content">
                    <h3 class="dashboard-card__title">Certificados</h3>
                    <p class="dashboard-card__description">
                        Generar certificados de vacunación
                    </p>
                    <a href="#" class="btn btn--primary">
                        <i class="fas fa-file-pdf"></i>
                        Acceder
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <p>&copy; 2024 Vacunate CTM. Todos los derechos reservados.</p>
    </div>
</footer>

<!-- JavaScript -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Dropdown de usuario
        const userDropdown = document.getElementById('userDropdown');
        const userDropdownMenu = document.getElementById('userDropdownMenu');

        if (userDropdown && userDropdownMenu) {
            userDropdown.addEventListener('click', function(e) {
                e.preventDefault();
                userDropdownMenu.classList.toggle('show');
            });

            // Cerrar dropdown al hacer clic fuera
            document.addEventListener('click', function(e) {
                if (!userDropdown.contains(e.target)) {
                    userDropdownMenu.classList.remove('show');
                }
            });
        }

        // Animación de las cards
        const cards = document.querySelectorAll('.dashboard-card');
        cards.forEach((card, index) => {
            card.style.animationDelay = `${index * 0.1}s`;
            card.classList.add('fade-in-up');
        });
    });
</script>
</body>
</html>
