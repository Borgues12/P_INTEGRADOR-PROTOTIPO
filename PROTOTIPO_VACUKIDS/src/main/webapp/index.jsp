<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VACUKIDS - App de Vacunación</title>
    <link rel="stylesheet" href="css/Style.css">
    <link rel="stylesheet" href="css/index_style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>

<body>
<!-- Acceso rápido a centros -->
<div class="floating-access">
    <a href="Controlador?action=listar_centros" class="tooltip floating-btn" data-tooltip="Ver Centros de Vacunación">
        <i class="fas fa-map-marker-alt"></i>
    </a>
</div>

<!-- Header -->
<header class="header enhanced-header">
    <div class="header__brand">
        <div class="logo-enhanced">
            <img src="css/Imagenes/logo.png" alt="VACUKIDS Logo" class="logo-image">
        </div>
        <h1 class="header__appname gradient-text">VACUKIDS</h1>
    </div>

    <nav class="nav-wrapper">
        <a href="Controlador?action=mostrar_registro" class="nav-link nav-link-enhanced tooltip" data-tooltip="Crear nueva cuenta">
            <i class="fas fa-user-plus"></i>
            Registrarse
        </a>
        <a href="Controlador?action=login" class="nav-link nav-link-enhanced tooltip" data-tooltip="Acceder a tu cuenta">
            <i class="fas fa-sign-in-alt"></i>
            Iniciar Sesión
        </a>
    </nav>
</header>

<!-- Contenedor principal -->
<main class="main-container">
    <!-- Elementos flotantes decorativos -->
    <div class="floating-elements">
        <i class="fas fa-heartbeat floating-icon"></i>
        <i class="fas fa-shield-alt floating-icon"></i>
        <i class="fas fa-user-md floating-icon"></i>
        <i class="fas fa-baby floating-icon"></i>
    </div>

    <!-- Sección Hero -->
    <section class="hero hero-enhanced">
        <div class="hero__content">
            <h2 class="hero__title enhanced-title">Registro fácil y <span class="gradient-text">vacúnate</span></h2>
            <p class="hero__description enhanced-description">
                <strong>VACUKIDS</strong> te ofrece un registro sencillo para vacunarte en el servicio de vacunación más cercano a tu ubicación.
                Accesible en móvil y online para todos. Tu salud es nuestra prioridad.
            </p>
            <div class="hero__divider"></div>

            <div class="hero__actions">
                <a href="Controlador?action=login" class="btn btn--primary btn-enhanced pulse-effect">
                    <i class="fas fa-sign-in-alt"></i>
                    Iniciar sesión
                </a>
                <a href="Controlador?action=mostrar_registro" class="btn btn--secondary btn-enhanced">
                    <i class="fas fa-user-plus"></i>
                    ¿Eres nuevo? Regístrate
                </a>
            </div>

            <!-- Estadísticas -->
            <div class="hero__stats">
                <div class="stat-item">
                    <div class="stat-number gradient-text">1000+</div>
                    <div class="stat-label">Niños vacunados</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number gradient-text">50+</div>
                    <div class="stat-label">Centros disponibles</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number gradient-text">24/7</div>
                    <div class="stat-label">Soporte disponible</div>
                </div>
            </div>
        </div>

        <div class="hero__image">
            <img src="css/Imagenes/nnn.JPG" alt="Ilustración de vacunación">
        </div>
    </section>

    <!-- Sección de Pasos -->
    <section class="section steps section-enhanced">
        <div class="container">
            <h2 class="section-title">Pasos para <span class="highlight gradient-text">vacunarte</span></h2>
            <div class="section-divider"></div>
            <p class="section-description">
                Sigue estos sencillos pasos para garantizar que tu hijo reciba la vacunación adecuada en el momento oportuno.
            </p>

            <div class="steps__grid">
                <div class="card step-card step-card-enhanced fade-in-up">
                    <div class="step-number step-number-enhanced">1</div>
                    <div class="step-icon">
                        <img src="css/Imagenes/step1.png" alt="Conoce tu vacuna">
                    </div>
                    <h3 class="card__title gradient-text">Conoce la vacuna</h3>
                    <p class="card__description">Infórmate sobre los tipos de vacuna, beneficios y sus posibles efectos secundarios para una decisión informada.</p>
                    <div class="card__feature">
                        <i class="fas fa-check"></i>
                        <span>Información verificada</span>
                    </div>
                </div>

                <div class="card step-card step-card-enhanced fade-in-up">
                    <div class="step-number step-number-enhanced">2</div>
                    <div class="step-icon">
                        <img src="css/Imagenes/ubicacion.png" alt="Ubicación centro">
                    </div>
                    <h3 class="card__title gradient-text">Encuentra el centro más cercano</h3>
                    <p class="card__description">Consulta la ubicación, horarios y disponibilidad del servicio de vacunación más conveniente para ti.</p>
                    <div class="card__feature">
                        <i class="fas fa-map-marker-alt"></i>
                        <span>Geolocalización activa</span>
                    </div>
                </div>

                <div class="card step-card step-card-enhanced fade-in-up">
                    <div class="step-number step-number-enhanced">3</div>
                    <div class="step-icon">
                        <img src="css/Imagenes/registro.png" alt="Icono de Registro">
                    </div>
                    <h3 class="card__title gradient-text">Regístrate</h3>
                    <p class="card__description">Completa tu registro con los datos necesarios y adjunta la documentación requerida de forma segura.</p>
                    <div class="card__feature">
                        <i class="fas fa-lock"></i>
                        <span>Datos protegidos</span>
                    </div>
                </div>

                <div class="card step-card step-card-enhanced fade-in-up">
                    <div class="step-number step-number-enhanced">4</div>
                    <div class="step-icon">
                        <img src="css/Imagenes/inyeccion.png" alt="Icono vacunación">
                    </div>
                    <h3 class="card__title gradient-text">Vacúnate</h3>
                    <p class="card__description">Acude al centro de vacunación en tu cita programada y recibe tu dosis con personal especializado.</p>
                    <div class="card__feature">
                        <i class="fas fa-certificate"></i>
                        <span>Certificado digital</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Sección de Beneficios -->
    <section class="section benefits section-enhanced">
        <div class="container">
            <h2 class="section-title">¿Por qué elegir <span class="gradient-text">VACUKIDS</span>?</h2>
            <div class="section-divider"></div>

            <div class="benefits__grid">
                <div class="card benefit-card fade-in-up">
                    <div class="card__icon">
                        <i class="fas fa-mobile-alt"></i>
                    </div>
                    <h3 class="card__title">Acceso Móvil</h3>
                    <p class="card__description">Disponible en cualquier dispositivo, en cualquier momento y lugar.</p>
                </div>

                <div class="card benefit-card fade-in-up">
                    <div class="card__icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <h3 class="card__title">Ahorra Tiempo</h3>
                    <p class="card__description">Registro rápido y citas programadas sin largas esperas.</p>
                </div>

                <div class="card benefit-card fade-in-up">
                    <div class="card__icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3 class="card__title">Seguro y Confiable</h3>
                    <p class="card__description">Datos protegidos y centros de vacunación certificados.</p>
                </div>
            </div>
        </div>
    </section>
</main>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="footer__container">
            <div class="footer__column">
                <h4>VACUKIDS</h4>
                <p>Proporcionamos un registro fácil para vacunarte en el centro más cercano. Disponible en móvil y web para todos.</p>
            </div>

            <div class="footer__column">
                <h4>Sobre Nosotros</h4>
                <ul>
                    <li><a href="#">Quiénes somos</a></li>
                    <li><a href="#">Blog</a></li>
                    <li><a href="#">Servicios</a></li>
                    <li><a href="#">App</a></li>
                </ul>
            </div>

            <div class="footer__column">
                <h4>Servicios</h4>
                <ul>
                    <li><a href="#">Información de vacunas</a></li>
                    <li><a href="#">Ubicación de vacunación</a></li>
                    <li><a href="#">Llamadas de emergencia</a></li>
                    <li><a href="#">Certificado QR</a></li>
                </ul>
            </div>

            <div class="footer__column">
                <h4>Ayuda</h4>
                <ul>
                    <li><a href="#">Centro de ayuda</a></li>
                    <li><a href="#">Contacto</a></li>
                    <li><a href="#">Instrucciones</a></li>
                    <li><a href="#">Cómo funciona</a></li>
                </ul>
            </div>
        </div>

        <div class="footer-copyright">
            <p>&copy; 2024 VACUKIDS. Todos los derechos reservados.</p>
        </div>
    </div>
</footer>

<script>
    // Animaciones básicas
    document.addEventListener('DOMContentLoaded', function() {
        // Animación de entrada para las tarjetas
        const cards = document.querySelectorAll('.fade-in-up');
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        });

        cards.forEach(card => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(card);
        });

        // Tooltips
        const tooltips = document.querySelectorAll('.tooltip');
        tooltips.forEach(tooltip => {
            tooltip.addEventListener('mouseenter', function() {
                const tooltipText = this.getAttribute('data-tooltip');
                const tooltipElement = document.createElement('div');
                tooltipElement.className = 'tooltip-text';
                tooltipElement.textContent = tooltipText;
                this.appendChild(tooltipElement);
            });

            tooltip.addEventListener('mouseleave', function() {
                const tooltipElement = this.querySelector('.tooltip-text');
                if (tooltipElement) {
                    tooltipElement.remove();
                }
            });
        });
    });
</script>
</body>
</html>