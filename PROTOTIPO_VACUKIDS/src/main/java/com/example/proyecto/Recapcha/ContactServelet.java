package com.example.proyecto.Recapcha;
import com.example.proyecto.Recapcha.RecaptchaValidador;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ContactServlet", urlPatterns = {"/contact"})
public class ContactServelet extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Configurar la respuesta como JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Para debugging
        System.out.println("ContactServlet: Recibiendo petición POST");

        try (PrintWriter out = response.getWriter()) {

            // 1. Obtener parámetros del formulario
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String message = request.getParameter("message");
            String recaptchaResponse = request.getParameter("g-recaptcha-response");

            // Debug: Mostrar parámetros recibidos
            System.out.println("Parámetros recibidos:");
            System.out.println("- Nombre: " + name);
            System.out.println("- Email: " + email);
            System.out.println("- Mensaje: " + message);
            System.out.println("- reCAPTCHA token: " + (recaptchaResponse != null ? "Presente" : "Ausente"));

            // 2. Validar campos básicos
            if (name == null || name.trim().isEmpty()) {
                sendErrorResponse(response, out, 400, "El nombre es obligatorio");
                return;
            }

            if (email == null || email.trim().isEmpty()) {
                sendErrorResponse(response, out, 400, "El email es obligatorio");
                return;
            }

            if (message == null || message.trim().isEmpty()) {
                sendErrorResponse(response, out, 400, "El mensaje es obligatorio");
                return;
            }

            // 3. Validar formato de email (básico)
            if (!isValidEmail(email)) {
                sendErrorResponse(response, out, 400, "El formato del email no es válido");
                return;
            }

            // 4. Validar reCAPTCHA
            System.out.println("Validando reCAPTCHA...");
            if (!RecaptchaValidador.validateRecaptcha(recaptchaResponse)) {
                sendErrorResponse(response, out, 400,
                        "Verificación reCAPTCHA fallida. Por favor, inténtelo de nuevo.");
                return;
            }

            // 5. Procesar el formulario
            System.out.println("reCAPTCHA válido. Procesando formulario...");
            boolean processed = processContactForm(name.trim(), email.trim(), message.trim());

            // 6. Enviar respuesta
            if (processed) {
                System.out.println("Formulario procesado exitosamente");
                response.setStatus(200);
                out.println("{\"success\": true, \"message\": \"¡Mensaje enviado exitosamente!\"}");
            } else {
                System.err.println("Error procesando el formulario");
                sendErrorResponse(response, out, 500, "Error interno del servidor");
            }

        } catch (Exception e) {
            System.err.println("Error en ContactServlet: " + e.getMessage());
            e.printStackTrace();

            response.setStatus(500);
            try (PrintWriter out = response.getWriter()) {
                out.println("{\"success\": false, \"error\": \"Error procesando la solicitud\"}");
            }
        }
    }

    /**
     * Procesa el formulario de contacto
     * Aquí implementas tu lógica específica
     */
    private boolean processContactForm(String name, String email, String message) {
        try {
            System.out.println("=== PROCESANDO CONTACTO ===");
            System.out.println("Nombre: " + name);
            System.out.println("Email: " + email);
            System.out.println("Mensaje: " + message);
            System.out.println("Timestamp: " + new java.util.Date());

            // AQUÍ IMPLEMENTAS TU LÓGICA:
            // - Guardar en base de datos
            // - Enviar email
            // - Registrar en logs
            // - Etc.

            // Ejemplo: Guardar en base de datos
            // ContactDAO dao = new ContactDAO();
            // Contact contact = new Contact(name, email, message);
            // dao.save(contact);

            // Ejemplo: Enviar email
            // EmailService.sendContactNotification(name, email, message);

            // Simular procesamiento
            Thread.sleep(500);

            System.out.println("=== CONTACTO PROCESADO EXITOSAMENTE ===");
            return true;

        } catch (Exception e) {
            System.err.println("Error procesando contacto: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Validación básica de email
     */
    private boolean isValidEmail(String email) {
        return email != null &&
                email.contains("@") &&
                email.contains(".") &&
                email.length() > 5;
    }

    /**
     * Envía una respuesta de error JSON
     */
    private void sendErrorResponse(HttpServletResponse response, PrintWriter out,
                                   int statusCode, String errorMessage) {
        response.setStatus(statusCode);
        out.println("{\"success\": false, \"error\": \"" + errorMessage + "\"}");
        System.err.println("Error response: " + errorMessage);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Redirigir GET requests o mostrar información
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body>");
            out.println("<h2>Contact Servlet</h2>");
            out.println("<p>Este servlet maneja formularios POST con reCAPTCHA.</p>");
            out.println("<p>Para probar, usa el formulario HTML.</p>");
            out.println("</body></html>");
        }
    }
}
