/*==============================================================*/
/* DBMS name:      MySQL 5.0 - VERSIÓN COMPATIBLE              */
/* Created on:     08/07/2025 01:39:31 p. m.                    */
/* ACTUALIZADO: Compatible con MySQL 5.0+                      */
/*==============================================================*/

-- Crear esquema si no existe
CREATE SCHEMA IF NOT EXISTS vacukidsv;
USE vacukidsv;

/*==============================================================*/
/* ELIMINAR TABLAS EXISTENTES SI ES NECESARIO (CUIDADO!)       */
/*==============================================================*/
-- Descomenta estas líneas solo si necesitas recrear todo
-- SET FOREIGN_KEY_CHECKS = 0;
-- DROP TABLE IF EXISTS HISTORIAL_ACCESOS;
-- DROP TABLE IF EXISTS CODIGOS_VERIFICACION;
-- DROP TABLE IF EXISTS DOSIS;
-- DROP TABLE IF EXISTS USUARIO_CENTROSALUD;
-- DROP TABLE IF EXISTS NINOS;
-- DROP TABLE IF EXISTS USUARIOS;
-- DROP TABLE IF EXISTS VACUNAS;
-- DROP TABLE IF EXISTS CENTRO_SALUD;
-- DROP TABLE IF EXISTS TIPO_USUARIO;
-- SET FOREIGN_KEY_CHECKS = 1;

/*==============================================================*/
/* Table: CENTRO_SALUD                                          */
/*==============================================================*/
CREATE TABLE IF NOT EXISTS CENTRO_SALUD
(
   ID_CENTRO_SALUD      int auto_increment not null,
   NOMBRE_CENTRO_SALUD  varchar(150) not null,
   LATITUD              decimal(15,10) not null,
   LONGITUD             decimal(15,10) not null,
   primary key (ID_CENTRO_SALUD)
);

/*==============================================================*/
/* Table: TIPO_USUARIO                                          */
/*==============================================================*/
CREATE TABLE IF NOT EXISTS TIPO_USUARIO
(
   ID_TIPO_USUARIO      int auto_increment not null,
   NOMBRE_TIPO_USUARIO   varchar(50) not null,
   primary key (ID_TIPO_USUARIO)
);

/*==============================================================*/
/* Table: USUARIOS - ACTUALIZADA                               */
/*==============================================================*/
CREATE TABLE IF NOT EXISTS USUARIOS
(
   ID_USUARIO           int auto_increment not null,
   ID_TIPO_USUARIO      int,
   CEDULA_USUARIOS      char(15) not null,
   P_NOMBRE             varchar(50) not null,
   P_APELLIDO           varchar(50) not null,
   S_NOMBRE             varchar(50),
   S_APELLIDO           varchar(50),
   CORREO_USUARIO       varchar(100) not null,
   LOGIN                varchar(20) not null,
   CLAVE                varchar(50) not null,
   ESTADO               BOOLEAN NOT NULL DEFAULT TRUE,
   INTENTOS_FALLIDOS    int DEFAULT 0,
   FECHA_CREACION       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   FECHA_ULTIMO_ACCESO  TIMESTAMP NULL,
   primary key (ID_USUARIO)
);

/*==============================================================*/
/* Table: NINOS                                                 */
/*==============================================================*/
CREATE TABLE IF NOT EXISTS NINOS
(
   ID_NINO              int auto_increment not null,
   ID_USUARIO           int,
   P_NOMBRE             varchar(50) not null,
   P_APELLIDO           varchar(50) not null,
   S_NOMBRE             varchar(50),
   S_APELLIDO           varchar(50),
   CEDULA_NINOS         char(15) not null,
   FECHA_NACIMIENTO     date not null,
   ESTADO               BOOLEAN NOT NULL DEFAULT TRUE,
   primary key (ID_NINO)
);

/*==============================================================*/
/* Table: VACUNAS                                               */
/*==============================================================*/
CREATE TABLE IF NOT EXISTS VACUNAS
(
   ID_VACUNA            int auto_increment not null,
   NOMBRE_VACUNA        varchar(50) not null,
   NUMERO_DOSIS         int,
   primary key (ID_VACUNA)
);

/*==============================================================*/
/* Table: DOSIS                                                 */
/*==============================================================*/
CREATE TABLE IF NOT EXISTS DOSIS
(
   ID_DOSIS             int auto_increment not null,
   ID_NINO              int,
   ID_VACUNA            int,
   ID_USUARIO           int,
   ID_CENTRO_SALUD      int,
   FECHA_DOSIS          date not null,
   APLICADA             bool not null,
   DOSIS_ADMIN          int not null,
   primary key (ID_DOSIS)
);

/*==============================================================*/
/* Table: USUARIO_CENTROSALUD                                   */
/*==============================================================*/
CREATE TABLE IF NOT EXISTS USUARIO_CENTROSALUD
(
   ID_CENTRO_SALUD      int,
   ID_USUARIO           int,
   FECHA_ASIGNACION     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/*==============================================================*/
/* NUEVA TABLA: CODIGOS_VERIFICACION                           */
/*==============================================================*/
CREATE TABLE IF NOT EXISTS CODIGOS_VERIFICACION (
    ID                   INT AUTO_INCREMENT PRIMARY KEY,
    CORREO               VARCHAR(100) NOT NULL,
    CODIGO               VARCHAR(6) NOT NULL,
    FECHA_CREACION       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    USADO                BOOLEAN DEFAULT FALSE,
    TIPO_CODIGO          ENUM('VERIFICACION', 'RECUPERACION') DEFAULT 'VERIFICACION'
);

/*==============================================================*/
/* NUEVA TABLA: HISTORIAL_ACCESOS                              */
/*==============================================================*/
CREATE TABLE IF NOT EXISTS HISTORIAL_ACCESOS (
    ID                   INT AUTO_INCREMENT PRIMARY KEY,
    ID_USUARIO           INT,
    LOGIN_INTENTO        VARCHAR(20) NOT NULL,
    IP_ADDRESS           VARCHAR(45),
    USER_AGENT           TEXT,
    FECHA_INTENTO        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    EXITOSO              BOOLEAN NOT NULL,
    MOTIVO_FALLO         VARCHAR(100)
);

/*==============================================================*/
/* INSERTAR DATOS INICIALES                                    */
/*==============================================================*/

-- Insertar centros de salud
INSERT IGNORE INTO CENTRO_SALUD (NOMBRE_CENTRO_SALUD, LATITUD, LONGITUD) VALUES
('Hospital General de la Ciudad', 40.4167754, -3.7037902),
('Centro de Salud Norte', 40.4234123, -3.7123456),
('Clínica Santa María', 40.4309876, -3.6987654),
('Policlínico San Juan', 40.4198765, -3.6890123),
('Centro Médico del Este', 40.4101234, -3.6789012);

-- Insertar tipos de usuario
INSERT IGNORE INTO TIPO_USUARIO (NOMBRE_TIPO_USUARIO) VALUES
('Administrador'),
('Usuario'),
('Personal de Salud');

-- Insertar vacunas
INSERT IGNORE INTO VACUNAS (NOMBRE_VACUNA, NUMERO_DOSIS) VALUES
('BCG', 1),
('Hepatitis B', 3),
('Pentavalente', 3),
('Polio', 3),
('Rotavirus', 2),
('Neumococo', 3),
('Triple Viral (SRP)', 2),
('Varicela', 1),
('Hepatitis A', 1),
('Fiebre Amarilla', 1);

/*==============================================================*/
/* AGREGAR CONSTRAINTS - Compatible con MySQL 5.0             */
/*==============================================================*/

-- Deshabilitar verificación de claves foráneas temporalmente
SET FOREIGN_KEY_CHECKS = 0;

-- Eliminar constraints existentes si existen (evitar errores)
-- ALTER TABLE USUARIOS DROP FOREIGN KEY FK_USUARIOS_TIPOUSUAR_TIPO_USU;
-- ALTER TABLE NINOS DROP FOREIGN KEY FK_NINOS_RELATIONS_USUARIOS;
-- ALTER TABLE DOSIS DROP FOREIGN KEY FK_DOSIS_CENTROSAL_CENTRO_S;
-- ALTER TABLE DOSIS DROP FOREIGN KEY FK_DOSIS_DOSISUSUA_USUARIOS;
-- ALTER TABLE DOSIS DROP FOREIGN KEY FK_DOSIS_DOSIS_VAC_VACUNAS;
-- ALTER TABLE DOSIS DROP FOREIGN KEY FK_DOSIS_NINOS_DOS_NINOS;
-- ALTER TABLE USUARIO_CENTROSALUD DROP FOREIGN KEY FK_USUARIO_CENTROSAL_CENTRO_S;
-- ALTER TABLE USUARIO_CENTROSALUD DROP FOREIGN KEY FK_USUARIO_USUARIOCE_USUARIOS;
-- ALTER TABLE HISTORIAL_ACCESOS DROP FOREIGN KEY FK_HISTORIAL_USUARIOS;

-- Agregar constraints
ALTER TABLE USUARIOS 
ADD CONSTRAINT FK_USUARIOS_TIPOUSUAR_TIPO_USU 
FOREIGN KEY (ID_TIPO_USUARIO) REFERENCES TIPO_USUARIO (ID_TIPO_USUARIO) 
ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE NINOS 
ADD CONSTRAINT FK_NINOS_RELATIONS_USUARIOS 
FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS (ID_USUARIO) 
ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE DOSIS 
ADD CONSTRAINT FK_DOSIS_CENTROSAL_CENTRO_S 
FOREIGN KEY (ID_CENTRO_SALUD) REFERENCES CENTRO_SALUD (ID_CENTRO_SALUD) 
ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE DOSIS 
ADD CONSTRAINT FK_DOSIS_DOSISUSUA_USUARIOS 
FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS (ID_USUARIO) 
ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE DOSIS 
ADD CONSTRAINT FK_DOSIS_DOSIS_VAC_VACUNAS 
FOREIGN KEY (ID_VACUNA) REFERENCES VACUNAS (ID_VACUNA) 
ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE DOSIS 
ADD CONSTRAINT FK_DOSIS_NINOS_DOS_NINOS 
FOREIGN KEY (ID_NINO) REFERENCES NINOS (ID_NINO) 
ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE USUARIO_CENTROSALUD 
ADD CONSTRAINT FK_USUARIO_CENTROSAL_CENTRO_S 
FOREIGN KEY (ID_CENTRO_SALUD) REFERENCES CENTRO_SALUD (ID_CENTRO_SALUD) 
ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE USUARIO_CENTROSALUD 
ADD CONSTRAINT FK_USUARIO_USUARIOCE_USUARIOS 
FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS (ID_USUARIO) 
ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE HISTORIAL_ACCESOS 
ADD CONSTRAINT FK_HISTORIAL_USUARIOS 
FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS (ID_USUARIO) 
ON DELETE SET NULL ON UPDATE RESTRICT;

-- Rehabilitar verificación de claves foráneas
SET FOREIGN_KEY_CHECKS = 1;

/*==============================================================*/
/* CREAR ÍNDICES - Compatible con MySQL 5.0                   */
/*==============================================================*/

-- Eliminar índices si existen (para evitar errores)
-- DROP INDEX idx_usuarios_login ON USUARIOS;
-- DROP INDEX idx_usuarios_cedula ON USUARIOS;
-- DROP INDEX idx_usuarios_correo ON USUARIOS;
-- DROP INDEX idx_ninos_cedula ON NINOS;

-- Crear índices únicos
CREATE UNIQUE INDEX idx_usuarios_login ON USUARIOS(LOGIN);
CREATE UNIQUE INDEX idx_usuarios_cedula ON USUARIOS(CEDULA_USUARIOS);
CREATE UNIQUE INDEX idx_usuarios_correo ON USUARIOS(CORREO_USUARIO);
CREATE UNIQUE INDEX idx_ninos_cedula ON NINOS(CEDULA_NINOS);

-- Crear índices de búsqueda
CREATE INDEX idx_usuarios_estado ON USUARIOS(ESTADO);
CREATE INDEX idx_usuarios_tipo ON USUARIOS(ID_TIPO_USUARIO);
CREATE INDEX idx_ninos_usuario ON NINOS(ID_USUARIO);
CREATE INDEX idx_dosis_nino ON DOSIS(ID_NINO);
CREATE INDEX idx_dosis_fecha ON DOSIS(FECHA_DOSIS);
CREATE INDEX idx_codigos_correo ON CODIGOS_VERIFICACION(CORREO);
CREATE INDEX idx_historial_usuario ON HISTORIAL_ACCESOS(ID_USUARIO);
CREATE INDEX idx_historial_login ON HISTORIAL_ACCESOS(LOGIN_INTENTO);
CREATE INDEX idx_historial_fecha ON HISTORIAL_ACCESOS(FECHA_INTENTO);

/*==============================================================*/
/* USUARIOS DE PRUEBA                                          */
/*==============================================================*/

-- Usuario administrador por defecto (contraseña: admin123)
INSERT IGNORE INTO USUARIOS (ID_TIPO_USUARIO, CEDULA_USUARIOS, P_NOMBRE, P_APELLIDO, CORREO_USUARIO, LOGIN, CLAVE, ESTADO, INTENTOS_FALLIDOS) 
VALUES (1, '12345678', 'Administrador', 'Sistema', 'admin@vacukids.com', 'admin', MD5('admin123'), TRUE, 0);

-- Usuario de prueba (contraseña: user123)
INSERT IGNORE INTO USUARIOS (ID_TIPO_USUARIO, CEDULA_USUARIOS, P_NOMBRE, P_APELLIDO, CORREO_USUARIO, LOGIN, CLAVE, ESTADO, INTENTOS_FALLIDOS) 
VALUES (2, '87654321', 'Juan', 'Pérez', 'juan.perez@email.com', 'jperez', MD5('user123'), TRUE, 0);

-- Personal de salud de prueba (contraseña: medico123)
INSERT IGNORE INTO USUARIOS (ID_TIPO_USUARIO, CEDULA_USUARIOS, P_NOMBRE, P_APELLIDO, CORREO_USUARIO, LOGIN, CLAVE, ESTADO, INTENTOS_FALLIDOS) 
VALUES (3, '11223344', 'María', 'González', 'maria.gonzalez@hospital.com', 'mgonzalez', MD5('medico123'), TRUE, 0);

-- Asociar usuarios a centros de salud
INSERT IGNORE INTO USUARIO_CENTROSALUD (ID_USUARIO, ID_CENTRO_SALUD) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(2, 1), (2, 2),
(3, 1), (3, 3);

/*==============================================================*/
/* VERIFICACIÓN FINAL                                          */
/*==============================================================*/

SELECT 'Base de datos VACUKIDS creada exitosamente - MySQL 5.0 Compatible' as RESULTADO;

-- Mostrar resumen
SELECT 'CENTROS_SALUD' as TABLA, COUNT(*) as REGISTROS FROM CENTRO_SALUD
UNION ALL
SELECT 'TIPO_USUARIO', COUNT(*) FROM TIPO_USUARIO
UNION ALL
SELECT 'USUARIOS', COUNT(*) FROM USUARIOS
UNION ALL
SELECT 'NINOS', COUNT(*) FROM NINOS
UNION ALL
SELECT 'VACUNAS', COUNT(*) FROM VACUNAS
UNION ALL
SELECT 'DOSIS', COUNT(*) FROM DOSIS
UNION ALL
SELECT 'USUARIO_CENTROSALUD', COUNT(*) FROM USUARIO_CENTROSALUD
UNION ALL
SELECT 'CODIGOS_VERIFICACION', COUNT(*) FROM CODIGOS_VERIFICACION
UNION ALL
SELECT 'HISTORIAL_ACCESOS', COUNT(*) FROM HISTORIAL_ACCESOS;
