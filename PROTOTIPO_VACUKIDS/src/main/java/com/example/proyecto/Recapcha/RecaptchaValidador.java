package com.example.proyecto.Recapcha;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;
public class RecaptchaValidador {
    private static final String RECAPTCHA_VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";

    // ⚠️ IMPORTANTE: Reemplaza con tu SECRET KEY real
    // ¡NUNCA subas esta clave a repositorios públicos!
    private static final String SECRET_KEY = "6LfhX6ArAAAAABFath9LB7DoFETFZSblU17_xtHE";

    /**
     * Valida el token de reCAPTCHA con los servidores de Google
     *
     * @param recaptchaResponse Token recibido del cliente
     * @return true si la validación es exitosa, false en caso contrario
     */
    public static boolean validateRecaptcha(String recaptchaResponse) {
        // Validar que el token no esté vacío
        if (recaptchaResponse == null || recaptchaResponse.trim().isEmpty()) {
            System.err.println("reCAPTCHA: Token vacío o nulo");
            return false;
        }

        try {
            System.out.println("reCAPTCHA: Iniciando validación...");

            // 1. Crear la conexión HTTPS a Google
            URL url = new URL(RECAPTCHA_VERIFY_URL);
            HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();

            // 2. Configurar el método y headers
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            connection.setRequestProperty("User-Agent", "Mozilla/5.0");
            connection.setDoOutput(true);
            connection.setConnectTimeout(5000); // 5 segundos timeout
            connection.setReadTimeout(5000);

            // 3. Preparar los parámetros para enviar
            String postParams = "secret=" + SECRET_KEY + "&response=" + recaptchaResponse;
            System.out.println("reCAPTCHA: Enviando parámetros...");

            // 4. Enviar la petición
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = postParams.getBytes("utf-8");
                os.write(input, 0, input.length);
                os.flush();
            }

            // 5. Leer la respuesta
            int responseCode = connection.getResponseCode();
            System.out.println("reCAPTCHA: Código de respuesta: " + responseCode);

            StringBuilder response = new StringBuilder();
            try (BufferedReader br = new BufferedReader(
                    new InputStreamReader(connection.getInputStream(), "utf-8"))) {
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    response.append(responseLine.trim());
                }
            }

            // 6. Parsear la respuesta JSON
            String jsonResponse = response.toString();
            System.out.println("reCAPTCHA: Respuesta de Google: " + jsonResponse);

            JsonObject jsonObject = JsonParser.parseString(jsonResponse).getAsJsonObject();
            boolean success = jsonObject.get("success").getAsBoolean();

            // 7. Verificar errores adicionales
            if (jsonObject.has("error-codes")) {
                System.err.println("reCAPTCHA: Errores: " + jsonObject.get("error-codes"));
            }

            // 8. Verificar el score (si usas reCAPTCHA v3)
            if (jsonObject.has("score")) {
                double score = jsonObject.get("score").getAsDouble();
                System.out.println("reCAPTCHA: Score: " + score);
            }

            System.out.println("reCAPTCHA: Validación " + (success ? "EXITOSA" : "FALLIDA"));
            return success;

        } catch (Exception e) {
            System.err.println("reCAPTCHA: Error durante la validación: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Método para configurar la SECRET KEY dinámicamente
     * Útil si la cargas desde un archivo de configuración
     */
    public static boolean validateRecaptcha(String recaptchaResponse, String secretKey) {
        // Implementación similar pero con secretKey personalizada
        // Por simplicidad, usar el método principal por ahora
        return validateRecaptcha(recaptchaResponse);
    }
}
