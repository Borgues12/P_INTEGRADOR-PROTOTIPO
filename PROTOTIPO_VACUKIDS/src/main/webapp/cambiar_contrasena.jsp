<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cambiar Contraseña - MiSaludApp</title>

    <!-- Fuente Poppins desde Google Fonts y estilos -->
    <link rel="stylesheet" href="css/Style.css">
    <link rel="stylesheet" href="css/alert-styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>

<div class="layout">
    <!-- Mostrar errores -->
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger" role="alert">
        <i class="fas fa-exclamation-triangle"></i>
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <!-- Mostrar mensajes de éxito -->
    <% if (request.getAttribute("exito") != null) { %>
    <div class="alert alert-success" role="alert">
        <i class="fas fa-check-circle"></i>
        <%= request.getAttribute("exito") %>
    </div>
    <% } %>

    <!-- Panel izquierdo con logo -->
    <div class="layout__panel layout__panel--left">
        <div class="logo-enhanced">
            <img src="css/Imagenes/logo.png" alt="VACUKIDS Logo" class="logo-image" width="200" height="100"><br><br>
            <p style="font-family: 'Fredoka One'; font-size: 24px; color: #2196f3; margin-bottom: 0;">
                Cuidando tu salud<br>con amor y ciencia
            </p>
        </div>
    </div>

    <div class="layout__panel layout__panel--right">
        <div class="brand-container">
            <div class="brand">Vacunate CTM</div>
        </div>

        <div class="login__title">Restablecer Contraseña</div>

        <%
            // Obtener el correo verificado de la sesión
            String correoVerificado = (String) session.getAttribute("correoVerificado");
            if (correoVerificado == null || correoVerificado.isEmpty()) {
                // Si no hay correo verificado en sesión, redirigir al inicio del flujo
                response.sendRedirect("PasswordRecoveryController?action=mostrar_verificar_correo");
                return;
            }
        %>

        <form class="form" method="post" action="Controlador">
            <input type="hidden" name="action" value="cambiar_contrasena">
            <input type="hidden" name="correo" value="<%= correoVerificado %>">

            <!-- Campo de Nueva Contraseña -->
            <div class="form__group">
                <label class="form__label" for="nuevaContrasena">Nueva Contraseña</label>
                <div class="form__input-wrapper">
                    <i class="fas fa-lock form__icon"></i>
                    <input type="password"
                           class="form__input"
                           id="nuevaContrasena"
                           name="nuevaContrasena"
                           placeholder="Ingrese su nueva contraseña"
                           required>
                    <i class="far fa-eye form__toggle" id="togglePassword1" title="Mostrar/Ocultar contraseña"></i>
                </div>
            </div>

            <!-- Campo de Confirmar Nueva Contraseña -->
            <div class="form__group">
                <label class="form__label" for="confirmarNuevaContrasena">Confirmar Nueva Contraseña</label>
                <div class="form__input-wrapper">
                    <i class="fas fa-lock form__icon"></i>
                    <input type="password"
                           class="form__input"
                           id="confirmarNuevaContrasena"
                           name="confirmarNuevaContrasena"
                           placeholder="Confirme su nueva contraseña"
                           required>
                    <i class="far fa-eye form__toggle" id="togglePassword2" title="Mostrar/Ocultar contraseña"></i>
                </div>
            </div>

            <button class="form__button" type="submit">Cambiar Contraseña</button>
        </form>

        <div class="register">
            <p>
                <a href="Controlador?action=login" class="register__link">Volver al Inicio de Sesión</a>
            </p>
        </div>
    </div>
</div>

<!-- JavaScript para funcionalidad de mostrar/ocultar contraseña -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const togglePassword1 = document.getElementById('togglePassword1');
        const passwordField1 = document.getElementById('nuevaContrasena');
        const togglePassword2 = document.getElementById('togglePassword2');
        const passwordField2 = document.getElementById('confirmarNuevaContrasena');

        if (togglePassword1 && passwordField1) {
            togglePassword1.addEventListener('click', function() {
                const type = passwordField1.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordField1.setAttribute('type', type);
                this.classList.toggle('fa-eye');
                this.classList.toggle('fa-eye-slash');
            });
        }
        if (togglePassword2 && passwordField2) {
            togglePassword2.addEventListener('click', function() {
                const type = passwordField2.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordField2.setAttribute('type', type);
                this.classList.toggle('fa-eye');
                this.classList.toggle('fa-eye-slash');
            });
        }
    });
</script>

</body>
</html>
