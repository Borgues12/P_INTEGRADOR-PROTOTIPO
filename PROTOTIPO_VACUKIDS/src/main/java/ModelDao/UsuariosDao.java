package ModelDao;
import java.math.BigInteger; //añadido
import Config.Conexion;
import Interfaces.CrudUsuarios;
import Model.Usuarios;

import java.security.Security;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.util.Random;

public class UsuariosDao implements CrudUsuarios {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    @Override
    public List listar() {
        ArrayList<Usuarios> users = new ArrayList<Usuarios>();
        String sql = "SELECT * FROM usuarios";

        try{
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                Usuarios f = new Usuarios();
                f.setIdUser(rs.getInt(1));
                f.setIdTipoUsuario(rs.getInt(2));
                f.setCedula_usuario(rs.getString(3));
                f.setPrimerNombre(rs.getString(4));
                f.setSegundoNombre(rs.getString(5));
                f.setPrimerApellido(rs.getString(6));
                f.setSegundoApellido(rs.getString(7));
                f.setCorreo(rs.getString(8));
                f.setLogin(rs.getString(9));
                f.setEstado(rs.getBoolean(10));
                users.add(f);
            }
        } catch (Exception e) {
            System.out.println("Error al listar usuarios: " + e.getMessage());
        }
        return users;
    }

    @Override
    public Usuarios list(int idUser) {
        String sql = "SELECT * FROM usuarios WHERE ID_USUARIO = ?";
        Usuarios f = new Usuarios();

        try{
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idUser); //añadido
            rs = ps.executeQuery();
            while (rs.next()) {
                f.setIdUser(rs.getInt(1));
                f.setIdTipoUsuario(rs.getInt(2));
                f.setCedula_usuario(rs.getString(3));
                f.setPrimerNombre(rs.getString(4));
                f.setSegundoNombre(rs.getString(5));
                f.setPrimerApellido(rs.getString(6));
                f.setSegundoApellido(rs.getString(7));
                f.setCorreo(rs.getString(8));
                f.setLogin(rs.getString(9));
                f.setContrasena(rs.getString(10));
                f.setEstado(rs.getBoolean(11));
            }
        } catch (Exception e) {
            System.out.println("Error al listar por ID: " + e.getMessage());
        }
        return f;
    }

    @Override
    public boolean add(Usuarios f) {
        String sql = "INSERT INTO usuarios (ID_TIPO_USUARIO, CEDULA_USUARIOS, P_NOMBRE, S_NOMBRE, P_APELLIDO, S_APELLIDO, CORREO_USUARIO, LOGIN, CLAVE, ESTADO) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";

        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setInt(1, f.getIdTipoUsuario());
            ps.setString(2, f.getCedula_usuario());
            ps.setString(3, f.getPrimerNombre());
            ps.setString(4, f.getSegundoNombre());
            ps.setString(5, f.getPrimerApellido());
            ps.setString(6, f.getSegundoApellido());
            ps.setString(7, f.getCorreo());
            ps.setString(8, f.getLogin());
            ps.setString(9, encriptarMD5(f.getContrasena()));
            ps.setBoolean(10, true); //Estado activo por defecto
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al agregar usuario: " + e.getMessage());
        }
        return true;
    }

    public int addAndGetId(Usuarios f) {
        String sql = "INSERT INTO usuarios (ID_TIPO_USUARIO, CEDULA_USUARIOS, P_NOMBRE, S_NOMBRE, P_APELLIDO, S_APELLIDO, CORREO_USUARIO, LOGIN, CLAVE, ESTADO, INTENTOS_FALLIDOS) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";

        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, f.getIdTipoUsuario());
            ps.setString(2, f.getCedula_usuario());
            ps.setString(3, f.getPrimerNombre());
            ps.setString(4, f.getSegundoNombre());
            ps.setString(5, f.getPrimerApellido());
            ps.setString(6, f.getSegundoApellido());
            ps.setString(7, f.getCorreo());
            ps.setString(8, f.getLogin());
            ps.setString(9, encriptarMD5(f.getContrasena()));
            ps.setBoolean(10, f.isEstado());
            ps.executeUpdate();

            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            }

        } catch (Exception e) {
            System.out.println("Error al agregar usuario: " + e.getMessage());
        }
        return 0;
    }

    @Override
    public boolean edit(Usuarios f) {
        String sql = "UPDATE usuarios SET ID_TIPO_USUARIO = ?, CEDULA_USUARIOS = ?, P_NOMBRE = ?, S_NOMBRE = ?, P_APELLIDO = ?, S_APELLIDO = ?, CORREO_USUARIO = ?, LOGIN = ?, ESTADO = ? WHERE ID_USUARIO = ?"+f.getIdUser();

        try  {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setInt(1, f.getIdTipoUsuario());
            ps.setString(2, f.getCedula_usuario());
            ps.setString(3, f.getPrimerNombre());
            ps.setString(4, f.getSegundoNombre());
            ps.setString(5, f.getPrimerApellido());
            ps.setString(6, f.getSegundoApellido());
            ps.setString(7, f.getCorreo());
            ps.setString(8, f.getLogin());
            ps.setString(9, encriptarMD5(f.getContrasena()));
            ps.setBoolean(10, f.isEstado());
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al editar usuario: " + e.getMessage());
        }
        return true;
    }

    @Override
    public boolean delete(int idUser) {
        String sql = "DELETE FROM usuarios WHERE ID_USUARIO = ?"+idUser;
        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al eliminar usuario: " + e.getMessage());
        }
        return false;
    }
    //AÑADIDO
    private String encriptarMD5(String texto) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(texto.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    //MODIFICADO PARA INTENTOS DE FALLO
    public Usuarios validarUsuario(String login, String contrasena) {
        String sql = "SELECT * FROM usuarios WHERE LOGIN = ? AND CLAVE = ? AND ESTADO = true";
        Usuarios usuario = new Usuarios();

        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, login);
            ps.setString(2, encriptarMD5(contrasena));
            rs = ps.executeQuery();

            if (rs.next()) {
                // Usuario válido - resetear intentos fallidos
                resetearIntentosFallidos(login);

                usuario.setIdUser(rs.getInt(1));
                usuario.setIdTipoUsuario(rs.getInt(2));
                usuario.setCedula_usuario(rs.getString(3));
                usuario.setPrimerNombre(rs.getString(4));
                usuario.setSegundoNombre(rs.getString(5));
                usuario.setPrimerApellido(rs.getString(6));
                usuario.setSegundoApellido(rs.getString(7));
                usuario.setCorreo(rs.getString(8));
                usuario.setLogin(rs.getString(9));
                usuario.setContrasena(rs.getString(10));
                usuario.setEstado(rs.getBoolean(11));
            }
            // NO incrementar intentos aquí - se hace en el controlador

        } catch (Exception e) {
            System.out.println("Error al validar usuario: " + e.getMessage());
        }
        return usuario;
    }

    public boolean existeUsuario(String login, String cedula_usuario, String correo) {
        String sql = "SELECT COUNT(*) FROM usuarios WHERE LOGIN = ? OR CEDULA_USUARIOS = ? OR CORREO_USUARIO = ?";

        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, login);
            ps.setString(2, cedula_usuario);
            ps.setString(3, correo);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            System.out.println("Error al verificar existencia de usuario: " + e.getMessage());
        }
        return false;
    }

    //AÑADIDO
    public String verificarDuplicacion(String login, String cedula, String correo) {
        String mensaje = "";

        try {
            con = cn.getCon();

            // Verificar login
            String sqlLogin = "SELECT COUNT(*) FROM usuarios WHERE LOGIN = ?";
            ps = con.prepareStatement(sqlLogin);
            ps.setString(1, login);
            rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                mensaje += "El nombre de usuario ya está en uso. ";
            }

            // Verificar cédula
            String sqlCedula = "SELECT COUNT(*) FROM usuarios WHERE CEDULA_USUARIOS = ?";
            ps = con.prepareStatement(sqlCedula);
            ps.setString(1, cedula);
            rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                mensaje += "La cédula ya está registrada. ";
            }

            // Verificar correo
            String sqlCorreo = "SELECT COUNT(*) FROM usuarios WHERE CORREO_USUARIO = ?";
            ps = con.prepareStatement(sqlCorreo);
            ps.setString(1, correo);
            rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                mensaje += "El correo electrónico ya está registrado. ";
            }

        } catch (Exception e) {
            System.out.println("Error al verificar duplicación: " + e.getMessage());
            return "Error al verificar datos";
        }

        return mensaje.trim();
    }


    public boolean asociarUsuarioACentros(int idUser, List<Integer> idCentroSalud) {
        String sql = "INSERT INTO usuario_centrosalud (ID_USUARIO, ID_CENTRO_SALUD) VALUES (?, ?)";

        try {
            con = cn.getCon();
            con.setAutoCommit(false);
            ps = con.prepareStatement(sql);

            for (Integer idCentro : idCentroSalud) {
                ps.setInt(1, idUser);
                ps.setInt(2, idCentro);
                ps.addBatch();
            }
            ps.executeBatch();
            con.commit();
            return true;

        } catch (Exception e) {
            System.out.println("Error al asociar usuario a centros: " + e.getMessage());
            return false;
        }
    }

    // <!-- MÉTODO NUEVO: Verificación de autenticidad de correo -->
    public boolean verificarCorreoAutentico(String correo) {
        String codigoVerificacion = generarCodigoVerificacion();

        // Guardar código en base de datos temporalmente
        if (guardarCodigoVerificacion(correo, codigoVerificacion)) {
            return enviarCorreoVerificacion(correo, codigoVerificacion);
        }
        return false;
    }

    // <!-- MÉTODO NUEVO: Generar código de verificación -->
    private String generarCodigoVerificacion() {
        Random random = new Random();
        int codigo = 100000 + random.nextInt(900000); // Código de 6 dígitos
        return String.valueOf(codigo);
    }

    // <!-- MÉTODO NUEVO: Guardar código de verificación en BD -->
    private boolean guardarCodigoVerificacion(String correo, String codigo) {
        String sql = "INSERT INTO codigos_verificacion (CORREO, CODIGO, FECHA_CREACION, USADO) VALUES (?, ?, NOW(), false) " +
                "ON DUPLICATE KEY UPDATE CODIGO = ?, FECHA_CREACION = NOW(), USADO = false";

        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, codigo);
            ps.setString(3, codigo);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println("Error al guardar código de verificación: " + e.getMessage());
            return false;
        }
    }

    // <!-- MÉTODO NUEVO: Enviar correo de verificación -->
    private boolean enviarCorreoVerificacion(String correo, String codigo) {
        try {
            // ===== [0] TRUSTMANAGER PERSONALIZADO PARA IGNORAR SSL ===== //
            TrustManager[] trustAllCerts = new TrustManager[]{
                    new X509TrustManager() {
                        public java.security.cert.X509Certificate[] getAcceptedIssuers() { return null; }
                        public void checkClientTrusted(java.security.cert.X509Certificate[] certs, String authType) {}
                        public void checkServerTrusted(java.security.cert.X509Certificate[] certs, String authType) {}
                    }
            };

            SSLContext sc = SSLContext.getInstance("TLSv1.2");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            javax.net.ssl.SSLSocketFactory sslSocketFactory = sc.getSocketFactory();

            // ===== [1] CONFIGURACIÓN SEGURA PARA JAVA 8u202 ===== //
            System.setProperty("jdk.tls.client.protocols", "TLSv1.2");
            System.setProperty("https.protocols", "TLSv1.2");
            Security.setProperty("crypto.policy", "unlimited");

            // ===== [2] PROPIEDADES SMTP ===== //
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.starttls.required", "true");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");

            // Inyectar socket factory que ignora validación SSL
            props.put("mail.smtp.ssl.socketFactory", sslSocketFactory);
            props.put("mail.smtp.ssl.checkserveridentity", "false");

            // Timeouts
            props.put("mail.smtp.connectiontimeout", "5000");
            props.put("mail.smtp.timeout", "5000");
            props.put("mail.smtp.writetimeout", "5000");

            // ===== [3] CREDENCIALES ===== //
            String username = "jampaex12@gmail.com";
            String password = "vynp mdsh pelb gkdw"; // ¡Usar variable de entorno en producción!

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

            session.setDebug(true); // Habilitar log en consola

            // ===== [4] CONSTRUCCIÓN DEL MENSAJE ===== //
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(correo));
            message.setSubject("Código de Verificación - VACUKIDS");
            message.setText("Su código es: " + codigo + "\n\nExpira en 15 minutos.");

            // ===== [5] ENVÍO DEL CORREO ===== //
            Transport transport = session.getTransport("smtp");
            try {
                transport.connect("smtp.gmail.com", username, password);
                transport.sendMessage(message, message.getAllRecipients());
                return true;
            } finally {
                transport.close();
            }

        } catch (AuthenticationFailedException e) {
            System.err.println("[ERROR] Credenciales incorrectas. Verifica la contraseña de aplicación.");
            e.printStackTrace();
        } catch (MessagingException e) {
            System.err.println("[ERROR SMTP] Detalles técnicos:");
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("[ERROR INESPERADO] " + e.getMessage());
        }
        return false;
    }

    // <!-- MÉTODO NUEVO: Verificar código de verificación -->
    public boolean verificarCodigoVerificacion(String correo, String codigo) {
        String sql = "SELECT COUNT(*) FROM codigos_verificacion WHERE CORREO = ? AND CODIGO = ? " +
                "AND USADO = false AND FECHA_CREACION > DATE_SUB(NOW(), INTERVAL 15 MINUTE)";

        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, codigo);
            rs = ps.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                // Marcar código como usado
                marcarCodigoComoUsado(correo, codigo);
                return true;
            }
        } catch (Exception e) {
            System.out.println("Error al verificar código: " + e.getMessage());
        }
        return false;
    }

    // <!-- MÉTODO NUEVO: Marcar código como usado -->
    private void marcarCodigoComoUsado(String correo, String codigo) {
        String sql = "UPDATE codigos_verificacion SET USADO = true WHERE CORREO = ? AND CODIGO = ?";

        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, codigo);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error al marcar código como usado: " + e.getMessage());
        }
    }

    // <!-- MÉTODO NUEVO: Incrementar intentos fallidos -->
    public void incrementarIntentosFallidos(String login) {
        String sql = "UPDATE usuarios SET INTENTOS_FALLIDOS = INTENTOS_FALLIDOS + 1 WHERE LOGIN = ?";

        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, login);
            ps.executeUpdate();

            // Verificar si debe bloquearse
            verificarYBloquearUsuario(login);

        } catch (Exception e) {
            System.out.println("Error al incrementar intentos fallidos: " + e.getMessage());
        }
    }

    // <!-- MÉTODO NUEVO: Verificar y bloquear usuario después de 3 intentos -->
    private void verificarYBloquearUsuario(String login) {
        String sqlVerificar = "SELECT INTENTOS_FALLIDOS FROM usuarios WHERE LOGIN = ?";

        try {
            con = cn.getCon();
            ps = con.prepareStatement(sqlVerificar);
            ps.setString(1, login);
            rs = ps.executeQuery();

            if (rs.next() && rs.getInt(1) >= 3) {
                // Bloquear usuario
                String sqlBloquear = "UPDATE usuarios SET ESTADO = false WHERE LOGIN = ?";
                ps = con.prepareStatement(sqlBloquear);
                ps.setString(1, login);
                ps.executeUpdate();

                System.out.println("Usuario " + login + " bloqueado por exceder intentos fallidos");
            }

        } catch (Exception e) {
            System.out.println("Error al verificar y bloquear usuario: " + e.getMessage());
        }
    }

    // <!-- MÉTODO NUEVO: Resetear intentos fallidos -->
    private void resetearIntentosFallidos(String login) {
        String sql = "UPDATE usuarios SET INTENTOS_FALLIDOS = 0 WHERE LOGIN = ?";

        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, login);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error al resetear intentos fallidos: " + e.getMessage());
        }
    }

    // <!-- MÉTODO NUEVO: Verificar si usuario está bloqueado -->
    public boolean usuarioBloqueado(String login) {
        String sql = "SELECT ESTADO FROM usuarios WHERE LOGIN = ?";

        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, login);
            rs = ps.executeQuery();

            if (rs.next()) {
                return !rs.getBoolean(1); // Si estado es false, está bloqueado
            }
        } catch (Exception e) {
            System.out.println("Error al verificar bloqueo de usuario: " + e.getMessage());
        }
        return false;
    }

    // <!-- MÉTODO NUEVO: Obtener intentos fallidos -->
    public int obtenerIntentosFallidos(String login) {
        String sql = "SELECT INTENTOS_FALLIDOS FROM usuarios WHERE LOGIN = ?";

        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, login);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("Error al obtener intentos fallidos: " + e.getMessage());
        }
        return 0;
    }

    // <!-- MÉTODO NUEVO: Desbloquear usuario (para administradores) -->
    // <!-- MÉTODO NUEVO: Desbloquear usuario (para administradores) -->
    public boolean desbloquearUsuario(String login) {
        String sql = "UPDATE usuarios SET ESTADO = true, INTENTOS_FALLIDOS = 0 WHERE LOGIN = ?";

        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, login);
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            System.out.println("Error al desbloquear usuario: " + e.getMessage());
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
    }

    // <!-- MÉTODO NUEVO: Desbloquear contraseña -->
    public boolean desbloquearContrasena(String login, String nuevaContrasena) {
        String sql = "UPDATE usuarios SET CLAVE = ?, ESTADO = true, INTENTOS_FALLIDOS = 0 WHERE LOGIN = ?";

        try {
            con = cn.getCon();
            ps = con.prepareStatement(sql);
            ps.setString(1, encriptarMD5(nuevaContrasena));
            ps.setString(2, login);
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            System.out.println("Error al desbloquear contraseña: " + e.getMessage());
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
    }

    // <!-- MÉTODO NUEVO: Cambiar contraseña con verificación -->
    public boolean cambiarContrasenaConVerificacion(String login, String contrasenaActual, String nuevaContrasena) {
        String sqlVerificar = "SELECT COUNT(*) FROM usuarios WHERE LOGIN = ? AND CLAVE = ?";
        String sqlActualizar = "UPDATE usuarios SET CLAVE = ? WHERE LOGIN = ?";

        try {
            con = cn.getCon();

            // Verificar contraseña actual
            ps = con.prepareStatement(sqlVerificar);
            ps.setString(1, login);
            ps.setString(2, encriptarMD5(contrasenaActual));
            rs = ps.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                // Actualizar contraseña
                ps = con.prepareStatement(sqlActualizar);
                ps.setString(1, encriptarMD5(nuevaContrasena));
                ps.setString(2, login);
                int filasAfectadas = ps.executeUpdate();
                return filasAfectadas > 0;
            }
            return false;

        } catch (Exception e) {
            System.out.println("Error al cambiar contraseña: " + e.getMessage());
            return false;
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
    }

    // <!-- MÉTODO NUEVO: Recuperar contraseña por correo -->
    public boolean recuperarContrasena(String correo) {
        String sqlBuscar = "SELECT LOGIN FROM usuarios WHERE CORREO_USUARIO = ?";
        String nuevaContrasena = generarContrasenaAleatoria();

        try {
            con = cn.getCon();
            ps = con.prepareStatement(sqlBuscar);
            ps.setString(1, correo);
            rs = ps.executeQuery();

            if (rs.next()) {
                String login = rs.getString(1);

                // Actualizar contraseña
                if (desbloquearContrasena(login, nuevaContrasena)) {
                    // Enviar nueva contraseña por correo
                    return enviarNuevaContrasena(correo, nuevaContrasena);
                }
            }
            return false;

        } catch (Exception e) {
            System.out.println("Error al recuperar contraseña: " + e.getMessage());
            return false;
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
    }

    // <!-- MÉTODO AUXILIAR: Generar contraseña aleatoria -->
    private String generarContrasenaAleatoria() {
        String caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$%";
        Random random = new Random();
        StringBuilder contrasena = new StringBuilder();

        for (int i = 0; i < 8; i++) {
            contrasena.append(caracteres.charAt(random.nextInt(caracteres.length())));
        }
        return contrasena.toString();
    }

    // <!-- MÉTODO AUXILIAR: Enviar nueva contraseña por correo -->
    private boolean enviarNuevaContrasena(String correo, String nuevaContrasena) {
        try {
            // Configuración similar al método enviarCorreoVerificacion
            TrustManager[] trustAllCerts = new TrustManager[]{
                    new X509TrustManager() {
                        public java.security.cert.X509Certificate[] getAcceptedIssuers() { return null; }
                        public void checkClientTrusted(java.security.cert.X509Certificate[] certs, String authType) {}
                        public void checkServerTrusted(java.security.cert.X509Certificate[] certs, String authType) {}
                    }
            };

            SSLContext sc = SSLContext.getInstance("TLSv1.2");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            javax.net.ssl.SSLSocketFactory sslSocketFactory = sc.getSocketFactory();

            System.setProperty("jdk.tls.client.protocols", "TLSv1.2");
            System.setProperty("https.protocols", "TLSv1.2");
            Security.setProperty("crypto.policy", "unlimited");

            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.starttls.required", "true");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.smtp.ssl.socketFactory", sslSocketFactory);
            props.put("mail.smtp.ssl.checkserveridentity", "false");
            props.put("mail.smtp.connectiontimeout", "5000");
            props.put("mail.smtp.timeout", "5000");
            props.put("mail.smtp.writetimeout", "5000");

            String username = "jampaex12@gmail.com";
            String password = "vynp mdsh pelb gkdw";

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(correo));
            message.setSubject("Recuperación de Contraseña - VACUKIDS");
            message.setText("Su nueva contraseña temporal es: " + nuevaContrasena +
                    "\n\nPor seguridad, le recomendamos cambiar esta contraseña después de iniciar sesión.");

            Transport transport = session.getTransport("smtp");
            try {
                transport.connect("smtp.gmail.com", username, password);
                transport.sendMessage(message, message.getAllRecipients());
                return true;
            } finally {
                transport.close();
            }

        } catch (Exception e) {
            System.out.println("Error al enviar nueva contraseña: " + e.getMessage());
            return false;
        }
    }

}