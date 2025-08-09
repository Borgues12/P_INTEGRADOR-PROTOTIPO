<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Verificar Correo - MiSaludApp</title>

  <!-- Fuente Poppins desde Google Fonts y estilos -->
  <link rel="stylesheet" href="css/Style.css">
  <link rel="stylesheet" href="css/alert-styles.css"> <%-- Asumo que tienes un alert-styles.css separado para mensajes --%>
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

    <div class="login__title">Verificar Correo Electrónico</div>

    <!-- FORMULARIO DE VERIFICACIÓN DE CORREO -->
    <%
      // Obtener el correo y el estado de mostrarCodigo
      String correoActual = (String) request.getAttribute("correo");
      boolean mostrarCodigo = request.getAttribute("mostrarCodigo") != null ? (Boolean) request.getAttribute("mostrarCodigo") : false;
    %>

    <form class="form" method="post" action="Controlador">
      <% if (!mostrarCodigo) { %>
      <input type="hidden" name="action" value="verificar_correo">

      <div class="form__group">
        <label class="form__label" for="correo">Correo Electrónico</label>
        <div class="form__input-wrapper">
          <i class="fas fa-envelope form__icon"></i>
          <input type="email"
                 class="form__input"
                 id="correo"
                 name="correo"
                 placeholder="Ingrese su correo"
                 value="<%= correoActual != null ? correoActual : "" %>"
                 required>
        </div>
      </div>
      <button class="form__button" type="submit">Enviar Código de Verificación</button>
      <% } else { %>
      <input type="hidden" name="action" value="confirmar_codigo">
      <input type="hidden" name="correo" value="<%= correoActual != null ? correoActual : "" %>">

      <div class="form__group">
        <label class="form__label" for="codigo">Código de Verificación</label>
        <div class="form__input-wrapper">
          <i class="fas fa-key form__icon"></i>
          <input type="text"
                 class="form__input"
                 id="codigo"
                 name="codigo"
                 placeholder="Ingrese el código"
                 required>
        </div>
      </div>
      <button class="form__button" type="submit">Confirmar Código</button>
      <% } %>
    </form>

    <div class="register">
      <p>
        <a href="Controlador?action=login" class="register__link">Volver al Inicio de Sesión</a>
      </p>
    </div>
  </div>
</div>

</body>
</html>
