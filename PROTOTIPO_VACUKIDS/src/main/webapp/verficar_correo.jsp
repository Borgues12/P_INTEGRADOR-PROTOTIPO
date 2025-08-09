<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verificar Correo - VACUKIDS</title>
    <link rel="stylesheet" href="css/Style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>

<body>
<div class="layout">
    <!-- Mostrar errores -->
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger" role="alert" style="position: fixed; top: 20px; right: 20px; z-index: 1000; background: #ff5252; color: white; padding: 1rem; border-radius: 8px; box-shadow: 0 4px 12px rgba(255, 82, 82, 0.3); max-width: 400px;">
        <i class="fas fa-exclamation-triangle" style="margin-right: 8px;"></i>
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <!-- Mostrar mensajes de éxito -->
    <% if (request.getAttribute("exito") != null) { %>
    <div class="alert alert-success" role="alert" style="position: fixed; top: 20px; right: 20px; z-index: 1000; background: #4caf50; color: white; padding: 1rem; border-radius: 8px; box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3); max-width: 400px;">
        <i class="fas fa-check-circle" style="margin-right: 8px;"></i>
        <%= request.getAttribute("exito") %>
    </div>
    <% } %>

    <!-- Panel izquierdo con logo -->
    <div class="layout__panel layout__panel--left">
        <div class="logo-container">
            <div class="logo-circle">
                <div class="heart large"></div>
            </div>
            <div class="logo-slogan">
                Recupera tu acceso<br>
                de forma segura
            </div>
        </div>
    </div>

    <!-- Panel derecho con formulario -->
    <div class="layout__panel layout__panel--right">
        <div class="brand-container">
            <div class="brand">VACUKIDS</div>
        </div>

        <div class="login__title">
            <i class="fas fa-envelope-open-text" style="color: var(--primary-color); margin-right: 10px;"></i>
            Verificación de Correo
        </div>

        <!-- Información inicial -->
        <% if (request.getAttribute("mostrarCodigo") == null || !(Boolean)request.getAttribute("mostrarCodigo")) { %>
        <div class="card" style="margin-bottom: 2rem; background: var(--primary-light); border-left: 4px solid var(--primary-color);">
            <div style="display: flex; align-items: center; gap: 1rem;">
                <i class="fas fa-info-circle" style="color: var(--primary-color); font-size: 1.5rem;"></i>
                <div>
                    <h4 style="margin: 0 0 0.5rem 0; color: var(--text-dark);">¿Olvidaste tu contraseña?</h4>
                    <p style="margin: 0; color: var(--text-medium); font-size: 0.9rem;">
                        Ingresa tu correo electrónico y te enviaremos un código de verificación para recuperar tu acceso.
                    </p>
                </div>
            </div>
        </div>

        <!-- Formulario para solicitar código -->
        <form class="form" method="post" action="Controlador" id="formVerificarCorreo">
            <input type="hidden" name="action" value="verificar_correo">

            <div class="form__group">
                <label class="form__label" for="correo">
                    <i class="fas fa-envelope" style="color: var(--primary-color); margin-right: 5px;"></i>
                    Correo Electrónico
                </label>
                <div class="form__input-wrapper">
                    <i class="fas fa-envelope form__icon"></i>
                    <input type="email"
                           class="form__input"
                           id="correo"
                           name="correo"
                           placeholder="Ingresa tu correo registrado"
                           value="<%= request.getAttribute("correo") != null ? request.getAttribute("correo") : "" %>"
                           required>
                </div>
                <small style="color: var(--text-medium); font-size: 0.85rem; margin-top: 0.5rem; display: block;">
                    <i class="fas fa-shield-alt" style="margin-right: 4px;"></i>
                    Solo enviaremos el código si el correo está registrado en nuestro sistema
                </small>
            </div>

            <button class="form__button" type="submit">
                <i class="fas fa-paper-plane" style="margin-right: 8px;"></i>
                Enviar Código de Verificación
            </button>
        </form>

        <% } else { %>
        <!-- Formulario para ingresar código -->
        <div class="card" style="margin-bottom: 2rem; background: #e8f5e8; border-left: 4px solid #4caf50;">
            <div style="display: flex; align-items: center; gap: 1rem;">
                <i class="fas fa-check-circle" style="color: #4caf50; font-size: 1.5rem;"></i>
                <div>
                    <h4 style="margin: 0 0 0.5rem 0; color: var(--text-dark);">Código Enviado</h4>
                    <p style="margin: 0; color: var(--text-medium); font-size: 0.9rem;">
                        Hemos enviado un código de 6 dígitos a: <strong><%= request.getAttribute("correo") %></strong>
                    </p>
                </div>
            </div>
        </div>

        <form class="form" method="post" action="Controlador" id="formConfirmarCodigo">
            <input type="hidden" name="action" value="confirmar_codigo">
            <input type="hidden" name="correo" value="<%= request.getAttribute("correo") %>">

            <div class="form__group">
                <label class="form__label" for="codigo">
                    <i class="fas fa-key" style="color: var(--primary-color); margin-right: 5px;"></i>
                    Código de Verificación
                </label>
                <div class="form__input-wrapper">
                    <i class="fas fa-key form__icon"></i>
                    <input type="text"
                           class="form__input"
                           id="codigo"
                           name="codigo"
                           placeholder="Ingresa el código de 6 dígitos"
                           maxlength="6"
                           pattern="[0-9]{6}"
                           style="text-align: center; font-size: 1.2rem; font-weight: 600; letter-spacing: 0.2rem;"
                           required>
                </div>
                <small style="color: var(--text-medium); font-size: 0.85rem; margin-top: 0.5rem; display: block;">
                    <i class="fas fa-clock" style="margin-right: 4px;"></i>
                    El código expira en 15 minutos
                </small>
            </div>

            <button class="form__button" type="submit">
                <i class="fas fa-unlock-alt" style="margin-right: 8px;"></i>
                Verificar Código
            </button>
        </form>

        <!-- Opción para reenviar código -->
        <div style="text-align: center; margin-top: 1.5rem;">
            <p style="color: var(--text-medium); font-size: 0.9rem; margin-bottom: 1rem;">
                ¿No recibiste el código?
            </p>
            <form method="post" action="Controlador" style="display: inline;">
                <input type="hidden" name="action" value="verificar_correo">
                <input type="hidden" name="correo" value="<%= request.getAttribute("correo") %>">
                <button type="submit" class="actions__button" style="border: 1px solid var(--primary-color); background: transparent;">
                    <i class="fas fa-redo-alt" style="margin-right: 5px;"></i>
                    Reenviar Código
                </button>
            </form>
        </div>
        <% } %>

        <!-- Acciones adicionales -->
        <div class="actions" style="margin-top: 2rem;">
            <a href="Controlador?action=login" class="actions__button">
                <i class="fas fa-arrow-left" style="margin-right: 5px;"></i>
                Volver al Login
            </a>

            <a href="Controlador?action=mostrar_registro" class="actions__button">
                <i class="fas fa-user-plus" style="margin-right: 5px;"></i>
                Crear Cuenta
            </a>
        </div>

        <!-- Información de ayuda -->
        <div class="card" style="margin-top: 2rem; background: #fff3cd; border-left: 4px solid #ffc107;">
            <div style="display: flex; align-items: flex-start; gap: 1rem;">
                <i class="fas fa-lightbulb" style="color: #ffc107; font-size: 1.2rem; margin-top: 2px;"></i>
                <div>
                    <h5 style="margin: 0 0 0.5rem 0; color: var(--text-dark);">Consejos de Seguridad</h5>
                    <ul style="margin: 0; padding-left: 1rem; color: var(--text-medium); font-size: 0.85rem;">
                        <li>Revisa tu carpeta de spam si no recibes el correo</li>
                        <li>El código es válido solo por 15 minutos</li>
                        <li>No compartas tu código con nadie</li>
                        <li>Si tienes problemas, contacta al administrador</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Auto-ocultar alertas después de 5 segundos
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            setTimeout(() => {
                alert.style.opacity = '0';
                alert.style.transform = 'translateX(100%)';
                setTimeout(() => alert.remove(), 300);
            }, 5000);
        });

        // Formatear input del código (solo números)
        const codigoInput = document.getElementById('codigo');
        if (codigoInput) {
            codigoInput.addEventListener('input', function(e) {
                // Solo permitir números
                this.value = this.value.replace(/[^0-9]/g, '');

                // Limitar a 6 dígitos
                if (this.value.length > 6) {
                    this.value = this.value.slice(0, 6);
                }
            });

            // Auto-submit cuando se completen 6 dígitos
            codigoInput.addEventListener('input', function(e) {
                if (this.value.length === 6) {
                    // Pequeña pausa para mejor UX
                    setTimeout(() => {
                        document.getElementById('formConfirmarCodigo').submit();
                    }, 500);
                }
            });
        }

        // Validación del formulario de correo
        const formVerificar = document.getElementById('formVerificarCorreo');
        if (formVerificar) {
            formVerificar.addEventListener('submit', function(e) {
                const correo = document.getElementById('correo').value.trim();

                if (!correo) {
                    e.preventDefault();
                    alert('Por favor ingresa tu correo electrónico');
                    return false;
                }

                // Validación básica de email
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(correo)) {
                    e.preventDefault();
                    alert('Por favor ingresa un correo electrónico válido');
                    return false;
                }
            });
        }

        // Validación del formulario de código
        const formCodigo = document.getElementById('formConfirmarCodigo');
        if (formCodigo) {
            formCodigo.addEventListener('submit', function(e) {
                const codigo = document.getElementById('codigo').value.trim();

                if (!codigo || codigo.length !== 6) {
                    e.preventDefault();
                    alert('Por favor ingresa el código completo de 6 dígitos');
                    return false;
                }

                if (!/^\d{6}$/.test(codigo)) {
                    e.preventDefault();
                    alert('El código debe contener solo números');
                    return false;
                }
            });
        }

        // Contador regresivo para expiración del código (opcional)
        <% if (request.getAttribute("mostrarCodigo") != null && (Boolean)request.getAttribute("mostrarCodigo")) { %>
        let tiempoRestante = 15 * 60; // 15 minutos en segundos

        function actualizarContador() {
            const minutos = Math.floor(tiempoRestante / 60);
            const segundos = tiempoRestante % 60;

            const contadorElement = document.querySelector('.countdown');
            if (contadorElement) {
                contadorElement.textContent = `${minutos}:${segundos.toString().padStart(2, '0')}`;
            }

            if (tiempoRestante <= 0) {
                // Código expirado
                const codigoInput = document.getElementById('codigo');
                if (codigoInput) {
                    codigoInput.disabled = true;
                    codigoInput.placeholder = 'Código expirado';
                }

                const submitBtn = document.querySelector('button[type="submit"]');
                if (submitBtn) {
                    submitBtn.disabled = true;
                    submitBtn.innerHTML = '<i class="fas fa-clock"></i> Código Expirado';
                }

                return;
            }

            tiempoRestante--;
            setTimeout(actualizarContador, 1000);
        }

        // Iniciar contador si hay un elemento para mostrarlo
        if (document.querySelector('.countdown')) {
            actualizarContador();
        }
        <% } %>
    });
</script>

<style>
    /* Estilos adicionales específicos para esta página */
    .alert {
        animation: slideInRight 0.3s ease-out;
    }

    @keyframes slideInRight {
        from {
            opacity: 0;
            transform: translateX(100%);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }

    /* Efecto de focus mejorado para el input del código */
    #codigo:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px rgba(0, 188, 212, 0.1);
        background-color: #fff;
    }

    /* Estilo para botones deshabilitados */
    button:disabled {
        opacity: 0.6;
        cursor: not-allowed;
        transform: none !important;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .layout__panel--right {
            padding: 2rem 1.5rem;
        }

        .actions {
            flex-direction: column;
            gap: 0.5rem;
        }

        .actions__button {
            width: 100%;
        }

        .alert {
            position: fixed !important;
            top: 10px !important;
            left: 10px !important;
            right: 10px !important;
            max-width: none !important;
        }
    }
</style>

</body>
</html>
