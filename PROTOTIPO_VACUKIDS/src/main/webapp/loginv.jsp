<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - MiSaludApp</title>

    <!-- Fuente Poppins desde Google Fonts -->
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

    <!-- Mostrar mensajes -->
    <% if (request.getAttribute("mensaje") != null) { %>
    <div class="alert alert-success" role="alert">
        <i class="fas fa-check-circle"></i>
        <%= request.getAttribute("mensaje") %>
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

        <div class="login__title">Bienvenido/a</div>

        <!-- FORMULARIO CORREGIDO: Agregado method="post" y action="Controlador" -->
        <form class="form" method="post" action="Controlador">
            <input type="hidden" name="action" value="validar_login">

            <!-- Campo de usuario -->
            <div class="form__group">
                <label class="form__label" for="login">Correo o Usuario</label>
                <div class="form__input-wrapper">
                    <i class="fas fa-user form__icon"></i>
                    <input type="text"
                           class="form__input"
                           id="login"
                           name="login"
                           placeholder="Ingrese su usuario"
                           value="<%= request.getAttribute("login") != null ? request.getAttribute("login") : "" %>"
                           required>
                </div>
            </div>

            <!-- Campo de contraseña -->
            <div class="form__group">
                <label class="form__label" for="password">Contraseña</label>
                <div class="form__input-wrapper">
                    <i class="fas fa-lock form__icon"></i>
                    <input type="password"
                           class="form__input"
                           id="password"
                           name="contrasena"
                           placeholder="Ingrese su contraseña"
                           required>
                    <i class="far fa-eye form__toggle" id="togglePassword" title="Mostrar/Ocultar contraseña"></i>
                </div>
            </div>

            <button class="form__button" type="submit">Iniciar sesión</button>
        </form>

        <div class="actions">
            <!-- Botón "Recordarme" eliminado -->
            <a href="Controlador?action=mostrar_verificar_correo" class="actions__button">¿Olvidaste tu contraseña?</a>
        </div>

        <div class="register">
            <p>¿No tienes cuenta?
                <a href="Controlador?action=mostrar_registro" class="register__link">Regístrate aquí</a>
            </p>
        </div>
    </div>
</div>

<!-- JavaScript para funcionalidad de mostrar/ocultar contraseña -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const togglePassword = document.getElementById('togglePassword');
        const passwordField = document.getElementById('password');

        if (togglePassword && passwordField) {
            togglePassword.addEventListener('click', function() {
                const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordField.setAttribute('type', type);
                this.classList.toggle('fa-eye');
                this.classList.toggle('fa-eye-slash');
            });
        }
    });
</script>

</body>
</html>