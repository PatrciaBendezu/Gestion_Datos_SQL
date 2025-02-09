USE UCDATASCIENCE

DROP TABLE IF EXISTS G1.CARRERAS
DROP TABLE IF EXISTS G1.ESTADO
DROP TABLE IF EXISTS G1.EVAUACIONES
DROP TABLE IF EXISTS G1.INSCRIPCIONES
DROP TABLE IF EXISTS G1.INTERES
DROP TABLE IF EXISTS G1.MOD_ADMISION
DROP TABLE IF EXISTS G1.MOD_ESTUDIOS
DROP TABLE IF EXISTS G1.NIVEL_INTERES
DROP TABLE IF EXISTS G1.PAGOS
DROP TABLE IF EXISTS G1.PERIODOS
DROP TABLE IF EXISTS G1.PROSPECTOS
DROP TABLE IF EXISTS G1.SECCIONES
DROP TABLE IF EXISTS G1.SEDES
DROP TABLE IF EXISTS G1.TIPIFICACIONES

GO

CREATE TABLE G1.CARRERAS
(
	[Id_Carrera] [int] NOT NULL,
	[Carrera] [varchar](50)
)

CREATE TABLE G1.ESTADO
(
	[Id_Estado] [int] NOT NULL,
	[Nombre] [varchar](20)
)

CREATE TABLE G1.EVALUACIONES
(
	[Id_Evaluacion] [int] NOT NULL,
	[Id_Inscripcion] [int],
	[Ingresante] [varchar](2),
	[Puntaje] [float],
	[Fecha_Evaluacion] [date],
	[Hora_Evaluacion] [datetime],
	[Id_Seccion] [int]
)

CREATE TABLE G1.INSCRIPCIONES
(
	[Id_Inscripcion] [int] NOT NULL,
	[Id_interes] [int],
	[Fecha_Inscripción] [date],
	[Hora_Inscripción] [datetime],
	[Estado_Inscripción] [varchar](30),
	[Id_Seccion] [int]
)

CREATE TABLE G1.INTERES
(
	[Id_Interes] [int] NOT NULL,
	[Id_Prospecto] [int],
	[Id_Periodo] [int],
	[Id_Sede] [int],
	[Id_Mod_Estudios] [int],
	[Id_Carrera] [int],
	[Id_Mod_Admision] [int],
	[Id_Nivel_Interes] [int],
	[Id_Estado] [int],
	[Id_Tipificacion] [int]
)

CREATE TABLE G1.MOD_ADMISION
(
	[id_Mod_Admision] [int] NOT NULL,
	[Mod_Admision] [varchar](50)
)

CREATE TABLE G1.MOD_ESTUDIOS
(
	[id_Mod_Estudio] [int] NOT NULL,
	[Mod_Estudio] [varchar](30)
)

CREATE TABLE G1.NIVEL_INTERES
(
	[id_Nivel_Interes] [int] NOT NULL,
	[Nivel_Interes] [varchar](20)
)

CREATE TABLE G1.PAGOS
(
	[Id_Pago] [int] NOT NULL,
	[Id_Inscripcion] [int],
	[Fecha_Pago] [date],
	[Hora_Pago] [datetime],
	[Concepto] [varchar](100),
	[Cargo] [float],
	[Descuento] [float],
	[Abono] [float],
	[Deuda] [float]
)

CREATE TABLE G1.PERIODOS
(
	[id_periodo] [int] NOT NULL,
	[Periodo] [varchar](6)
)

CREATE TABLE G1.PROSPECTOS
(
	[id_Prospecto] [int] NOT NULL,
	[Tipo_Documento] [varchar](5),
	[Num_Documento] [varchar](10),
	[Nombre] [varchar](15),
	[Apellidos] [varchar](15),
	[Genero] [varchar](15),
	[Estado_Civil] [varchar](15),
	[Fecha_Nacimiento] [date],
	[Colegio] [varchar](50),
	[Nacionalidad] [varchar](30),
	[Departamento] [varchar](30),
	[Provincia] [varchar](30),
	[Distrito] [varchar](30),
	[Telefono_Movil] [int],
	[Correo_Electronico] [varchar](60)
)

CREATE TABLE G1.SECCIONES
(
	[Id_Seccion] [int] NOT NULL,
	[Seccion] [varchar](5),
	[Turno] [varchar](30)
)

CREATE TABLE G1.SEDES
(
	[id_Sede] [int] NOT NULL,
	[Sede] [varchar](30)
)

CREATE TABLE G1.TIPIFICACIONES
(
	[id_Tipificacion] [int] NOT NULL,
	[Tipificacion] [varchar](50)
)

--SELECT * FROM G1.INTERES

GO

ALTER TABLE G1.CARRERAS ADD CONSTRAINT PK_CARRERAS PRIMARY KEY (Id_Carrera)
ALTER TABLE G1.ESTADO ADD CONSTRAINT PK_ESTADO PRIMARY KEY (Id_Estado)
ALTER TABLE G1.EVALUACIONES ADD CONSTRAINT PK_EVALUACIONES PRIMARY KEY (Id_Evaluacion)
ALTER TABLE G1.INSCRIPCIONES ADD CONSTRAINT PK_INSCRIPCIONES PRIMARY KEY (Id_Inscripcion)
ALTER TABLE G1.INTERES ADD CONSTRAINT PK_INTERES PRIMARY KEY (Id_Interes)
ALTER TABLE G1.MOD_ADMISION ADD CONSTRAINT PK_MOD_ADMISION PRIMARY KEY (id_Mod_Admision)
ALTER TABLE G1.MOD_ESTUDIOS ADD CONSTRAINT PK_MOD_ESTUDIOS PRIMARY KEY (id_Mod_Estudio)
ALTER TABLE G1.NIVEL_INTERES ADD CONSTRAINT PK_NIVEL_INTERES PRIMARY KEY (id_Nivel_Interes)
ALTER TABLE G1.PAGOS ADD CONSTRAINT PK_PAGOS PRIMARY KEY (Id_Pago)
ALTER TABLE G1.PERIODOS ADD CONSTRAINT PK_PERIODOS PRIMARY KEY (id_periodo)
ALTER TABLE G1.PROSPECTOS ADD CONSTRAINT PK_PROSPECTOS PRIMARY KEY (id_Prospecto)
ALTER TABLE G1.SECCIONES ADD CONSTRAINT PK_SECCIONES PRIMARY KEY (Id_Seccion)
ALTER TABLE G1.SEDES ADD CONSTRAINT PK_SEDES PRIMARY KEY (id_Sede)
ALTER TABLE G1.TIPIFICACIONES ADD CONSTRAINT PK_TIPIFICACIONES PRIMARY KEY (id_Tipificacion)


ALTER TABLE G1.INTERES ADD CONSTRAINT FK_INTERES_PROSPECTOS FOREIGN KEY (id_Prospecto) REFERENCES G1.PROSPECTOS (id_Prospecto) --OK
ALTER TABLE G1.INTERES ADD CONSTRAINT FK_INTERES_PERIODOS FOREIGN KEY (id_periodo) REFERENCES G1.PERIODOS (id_periodo)--OK
ALTER TABLE G1.INTERES ADD CONSTRAINT FK_INTERES_SEDES FOREIGN KEY (id_Sede) REFERENCES G1.SEDES (id_Sede)--PK
ALTER TABLE G1.INTERES ADD CONSTRAINT FK_INTERES_MOD_ESTUDIOS FOREIGN KEY (id_Mod_Estudio) REFERENCES G1.MOD_ESTUDIOS (id_Mod_Estudio)--OK
ALTER TABLE G1.INTERES ADD CONSTRAINT FK_INTERES_CARRERAS FOREIGN KEY (Id_Carrera) REFERENCES G1.CARRERAS (Id_Carrera) --OK
ALTER TABLE G1.INTERES ADD CONSTRAINT FK_INTERES_MOD_ADMISION FOREIGN KEY (id_Mod_Admision) REFERENCES G1.MOD_ADMISION (id_Mod_Admision)--OK
ALTER TABLE G1.INTERES ADD CONSTRAINT FK_INTERES_NIVEL_INTERES FOREIGN KEY (id_Nivel_Interes) REFERENCES G1.NIVEL_INTERES (id_Nivel_Interes)--OK
ALTER TABLE G1.INTERES ADD CONSTRAINT FK_INTERES_ESTADO FOREIGN KEY (Id_Estado) REFERENCES G1.ESTADO (Id_Estado) --OK
ALTER TABLE G1.INTERES ADD CONSTRAINT FK_INTERES_TIPIFICACIONES FOREIGN KEY (id_Tipificacion) REFERENCES G1.TIPIFICACIONES (id_Tipificacion)--OK
ALTER TABLE G1.INSCRIPCIONES ADD CONSTRAINT FK_INSCRIPCIONES_INTERES FOREIGN KEY (Id_Interes) REFERENCES G1.INTERES (Id_Interes)
ALTER TABLE G1.PAGOS ADD CONSTRAINT FK_PAGOS_INSCRIPCIONES FOREIGN KEY (Id_Inscripcion) REFERENCES G1.INSCRIPCIONES (Id_Inscripcion)
ALTER TABLE G1.EVALUACIONES ADD CONSTRAINT FK_EVALUACIONES_INSCRIPCIONES FOREIGN KEY (Id_Inscripcion) REFERENCES G1.INSCRIPCIONES (Id_Inscripcion)
ALTER TABLE G1.EVALUACIONES ADD CONSTRAINT FK_EVALUACIONES_SECCIONES FOREIGN KEY (Id_Seccion) REFERENCES G1.SECCIONES (Id_Seccion)

--SELECT * FROM sys.objects WHERE name LIKE 'FK_EVALU%'

GO

--INSERTAR DATOS DE PRUEBA

INSERT INTO G1.CARRERAS (Id_Carrera, Carrera) VALUES
(1, 'Ingeniería de Sistemas'),
(2, 'Administración'),
(3, 'Psicología'),
(4, 'Contabilidad'),
(5, 'Marketing');

INSERT INTO G1.ESTADO (Id_Estado, Nombre) VALUES
(1, 'Activo'),
(2, 'Inactivo'),
(3, 'Pendiente');

INSERT INTO G1.EVALUACIONES ([Id_Evaluacion], [Id_Inscripcion], [Ingresante], [Puntaje], [Fecha_Evaluacion], [Hora_Evaluacion], [Id_seccion]) VALUES
(1, 1, 'SI', 15, '2024-08-27', CONVERT(DATETIME, '2024-08-27 10:00:00',120), 8),
(2, 2, 'NO', 9, '2023-11-30', CONVERT(DATETIME, '2023-11-30 10:00:00',120), 7),
(3, 3, 'SI', 20, '2024-03-06', CONVERT(DATETIME, '2024-03-06 10:00:00',120), 9),
(4, 4, 'NO', 10, '2024-05-05', CONVERT(DATETIME, '2024-05-05 10:00:00',120), 6),
(5, 5, 'SI', 13, '2024-01-24', CONVERT(DATETIME, '2024-01-24 10:00:00',120), 4),
(6, 6, 'NO', 10, '2024-02-28', CONVERT(DATETIME, '2024-02-28 10:00:00',120), 2),
(7, 7, 'NO', 10, '2024-07-22', CONVERT(DATETIME, '2024-07-22 10:00:00',120), 4),
(8, 8, 'SI', 14, '2024-03-11', CONVERT(DATETIME, '2024-03-11 10:00:00',120), 8),
(9, 9, 'NO', 9, '2024-03-08', CONVERT(DATETIME, '2024-03-08 10:00:00',120), 2),
(10, 10, 'SI', 15, '2023-09-23', CONVERT(DATETIME, '2023-09-23 10:00:00',120), 5),
(11, 11, 'NO', 9, '2023-11-25', CONVERT(DATETIME, '2023-11-25 10:00:00',120), 4),
(12, 12, 'SI', 16, '2024-06-21', CONVERT(DATETIME, '2024-06-21 10:00:00',120), 5),
(13, 13, 'NO', 9, '2024-08-05', CONVERT(DATETIME, '2024-08-05 10:00:00',120), 4),
(14, 14, 'NO', 10, '2023-11-18', CONVERT(DATETIME, '2023-11-18 10:00:00',120), 3),
(15, 15, 'SI', 18, '2024-08-21', CONVERT(DATETIME, '2024-08-21 10:00:00',120), 7),
(16, 16, 'NO', 10, '2024-09-15', CONVERT(DATETIME, '2024-09-15 10:00:00',120), 9),
(17, 17, 'SI', 12, '2023-10-24', CONVERT(DATETIME, '2023-10-24 10:00:00',120), 5),
(18, 18, 'SI', 14, '2024-11-27', CONVERT(DATETIME, '2024-11-27 10:00:00',120), 9),
(19, 19, 'SI', 17, '2023-12-23', CONVERT(DATETIME, '2023-12-23 10:00:00',120), 8),
(20, 20, 'NO', 9, '2024-12-19', CONVERT(DATETIME, '2024-12-19 10:00:00',120), 6),
(21, 21, 'NO', 9, '2024-07-17', CONVERT(DATETIME, '2024-07-17 10:00:00',120), 9),
(22, 22, 'NO', 10, '2023-08-18', CONVERT(DATETIME, '2023-08-18 10:00:00',120), 8),
(23, 23, 'SI', 11, '2023-08-14', CONVERT(DATETIME, '2023-08-14 10:00:00',120), 3),
(24, 24, 'NO', 9, '2024-09-12', CONVERT(DATETIME, '2024-09-12 10:00:00',120), 8),
(25, 25, 'SI', 16, '2024-11-26', CONVERT(DATETIME, '2024-11-26 10:00:00',120), 6),
(26, 26, 'SI', 19, '2024-11-27', CONVERT(DATETIME, '2024-11-27 10:00:00',120), 8),
(27, 27, 'NO', 9, '2023-12-11', CONVERT(DATETIME, '2023-12-11 10:00:00',120), 5),
(28, 28, 'SI', 20, '2024-07-27', CONVERT(DATETIME, '2024-07-27 10:00:00',120), 3),
(29, 29, 'SI', 15, '2024-03-18', CONVERT(DATETIME, '2024-03-18 10:00:00',120), 9),
(30, 30, 'NO', 10, '2024-08-22', CONVERT(DATETIME, '2024-08-22 10:00:00',120), 6),
(31, 31, 'SI', 12, '2024-04-18', CONVERT(DATETIME, '2024-04-18 10:00:00',120), 3),
(32, 32, 'NO', 9, '2023-08-16', CONVERT(DATETIME, '2023-08-16 10:00:00',120), 4),
(33, 33, 'SI', 19, '2024-06-09', CONVERT(DATETIME, '2024-06-09 10:00:00',120), 4),
(34, 34, 'NO', 10, '2024-05-16', CONVERT(DATETIME, '2024-05-16 10:00:00',120), 2),
(35, 35, 'SI', 12, '2024-04-05', CONVERT(DATETIME, '2024-04-05 10:00:00',120), 5),
(36, 36, 'SI', 12, '2024-11-06', CONVERT(DATETIME, '2024-11-06 10:00:00',120), 4),
(37, 37, 'SI', 15, '2024-01-03', CONVERT(DATETIME, '2024-01-03 10:00:00',120), 1),
(38, 38, 'SI', 19, '2023-08-08', CONVERT(DATETIME, '2023-08-08 10:00:00',120), 8),
(39, 39, 'SI', 20, '2024-08-08', CONVERT(DATETIME, '2024-08-08 10:00:00',120), 7),
(40, 40, 'SI', 18, '2024-11-17', CONVERT(DATETIME, '2024-11-17 10:00:00',120), 4),
(41, 41, 'NO', 9, '2024-09-18', CONVERT(DATETIME, '2024-09-18 10:00:00',120), 5),
(42, 42, 'NO', 10, '2024-03-29', CONVERT(DATETIME, '2024-03-29 10:00:00',120), 5),
(43, 43, 'NO', 10, '2024-10-28', CONVERT(DATETIME, '2024-10-28 10:00:00',120), 8),
(44, 44, 'SI', 13, '2024-01-22', CONVERT(DATETIME, '2024-01-22 10:00:00',120), 6),
(45, 45, 'SI', 12, '2024-06-25', CONVERT(DATETIME, '2024-06-25 10:00:00',120), 8),
(46, 46, 'SI', 18, '2023-11-02', CONVERT(DATETIME, '2023-11-02 10:00:00',120), 5),
(47, 47, 'NO', 10, '2024-11-14', CONVERT(DATETIME, '2024-11-14 10:00:00',120), 2),
(48, 48, 'NO', 10, '2024-12-04', CONVERT(DATETIME, '2024-12-04 10:00:00',120), 7),
(49, 49, 'SI', 17, '2024-01-31', CONVERT(DATETIME, '2024-01-31 10:00:00',120), 6),
(50, 50, 'NO', 10, '2024-10-26', CONVERT(DATETIME, '2024-10-26 10:00:00',120), 6);

--FROM G1.EVALUACIONES
SELECT * FROM G1.EVALUACIONES

INSERT INTO G1.INSCRIPCIONES ([Id_Inscripcion], [Id_interes], [Fecha_Inscripción], [Hora_Inscripción], [Estado_Inscripción], [Id_Seccion]) VALUES
(1, 4, '2024-08-25', CONVERT(DATETIME, '2024-08-25 12:07:28',120), 'Pendiente', 0),
(2, 15, '2023-11-28', CONVERT(DATETIME, '2023-11-28 17:45:11',120), 'Confirmado', 0),
(3, 29, '2024-03-05', CONVERT(DATETIME, '2024-03-05 17:46:17',120), 'Confirmado', 0),
(4, 34, '2024-04-30', CONVERT(DATETIME, '2024-04-30 12:20:32',120), 'Confirmado', 0),
(5, 48, '2024-01-17', CONVERT(DATETIME, '2024-01-17 13:48:48',120), 'Pendiente', 0),
(6, 50, '2024-02-26', CONVERT(DATETIME, '2024-02-26 10:25:44',120), 'Confirmado', 0),
(7, 9, '2024-07-15', CONVERT(DATETIME, '2024-07-15 10:49:23',120), 'Pendiente', 0),
(8, 10, '2024-03-08', CONVERT(DATETIME, '2024-03-08 10:03:29',120), 'Confirmado', 0),
(9, 43, '2024-03-03', CONVERT(DATETIME, '2024-03-03 12:39:27',120), 'Confirmado', 0),
(10, 36, '2023-09-21', CONVERT(DATETIME, '2023-09-21 08:51:02',120), 'Pendiente', 0),
(11, 1, '2023-11-22', CONVERT(DATETIME, '2023-11-22 08:37:42',120), 'Confirmado', 0),
(12, 5, '2024-06-18', CONVERT(DATETIME, '2024-06-18 08:47:06',120), 'Pendiente', 0),
(13, 18, '2024-08-03', CONVERT(DATETIME, '2024-08-03 13:40:39',120), 'Confirmado', 0),
(14, 10, '2023-11-15', CONVERT(DATETIME, '2023-11-15 13:43:16',120), 'Pendiente', 0),
(15, 19, '2024-08-16', CONVERT(DATETIME, '2024-08-16 08:26:52',120), 'Confirmado', 0),
(16, 33, '2024-09-12', CONVERT(DATETIME, '2024-09-12 15:59:25',120), 'Confirmado', 0),
(17, 5, '2023-10-22', CONVERT(DATETIME, '2023-10-22 11:13:38',120), 'Confirmado', 0),
(18, 34, '2024-11-22', CONVERT(DATETIME, '2024-11-22 17:57:40',120), 'Pendiente', 0),
(19, 47, '2023-12-22', CONVERT(DATETIME, '2023-12-22 15:36:54',120), 'Pendiente', 0),
(20, 40, '2024-12-12', CONVERT(DATETIME, '2024-12-12 14:20:47',120), 'Confirmado', 0),
(21, 6, '2024-07-12', CONVERT(DATETIME, '2024-07-12 13:20:07',120), 'Confirmado', 0),
(22, 29, '2023-08-12', CONVERT(DATETIME, '2023-08-12 10:08:32',120), 'Confirmado', 0),
(23, 42, '2023-08-08', CONVERT(DATETIME, '2023-08-08 08:45:38',120), 'Confirmado', 0),
(24, 4, '2024-09-10', CONVERT(DATETIME, '2024-09-10 12:15:10',120), 'Confirmado', 0),
(25, 24, '2024-11-20', CONVERT(DATETIME, '2024-11-20 12:56:57',120), 'Pendiente', 0),
(26, 27, '2024-11-20', CONVERT(DATETIME, '2024-11-20 14:27:43',120), 'Confirmado', 0),
(27, 14, '2023-12-10', CONVERT(DATETIME, '2023-12-10 09:22:26',120), 'Pendiente', 0),
(28, 43, '2024-07-23', CONVERT(DATETIME, '2024-07-23 13:28:20',120), 'Pendiente', 0),
(29, 20, '2024-03-16', CONVERT(DATETIME, '2024-03-16 15:19:57',120), 'Pendiente', 0),
(30, 3, '2024-08-17', CONVERT(DATETIME, '2024-08-17 10:11:08',120), 'Confirmado', 0),
(31, 2, '2024-04-15', CONVERT(DATETIME, '2024-04-15 14:34:31',120), 'Pendiente', 0),
(32, 28, '2023-08-14', CONVERT(DATETIME, '2023-08-14 14:36:37',120), 'Confirmado', 0),
(33, 45, '2024-06-08', CONVERT(DATETIME, '2024-06-08 15:38:49',120), 'Pendiente', 0),
(34, 49, '2024-05-09', CONVERT(DATETIME, '2024-05-09 12:58:58',120), 'Pendiente', 0),
(35, 27, '2024-04-01', CONVERT(DATETIME, '2024-04-01 09:38:52',120), 'Pendiente', 0),
(36, 31, '2024-11-04', CONVERT(DATETIME, '2024-11-04 16:26:15',120), 'Pendiente', 0),
(37, 13, '2023-12-29', CONVERT(DATETIME, '2023-12-29 13:40:12',120), 'Confirmado', 0),
(38, 20, '2023-08-02', CONVERT(DATETIME, '2023-08-02 10:26:25',120), 'Confirmado', 0),
(39, 34, '2024-08-05', CONVERT(DATETIME, '2024-08-05 09:19:21',120), 'Confirmado', 0),
(40, 29, '2024-11-13', CONVERT(DATETIME, '2024-11-13 11:16:56',120), 'Pendiente', 0),
(41, 32, '2024-09-13', CONVERT(DATETIME, '2024-09-13 17:55:51',120), 'Pendiente', 0),
(42, 47, '2024-03-25', CONVERT(DATETIME, '2024-03-25 09:45:16',120), 'Confirmado', 0),
(43, 38, '2024-10-26', CONVERT(DATETIME, '2024-10-26 14:53:07',120), 'Confirmado', 0),
(44, 8, '2024-01-17', CONVERT(DATETIME, '2024-01-17 09:53:06',120), 'Confirmado', 0),
(45, 41, '2024-06-24', CONVERT(DATETIME, '2024-06-24 14:20:07',120), 'Confirmado', 0),
(46, 17, '2023-10-29', CONVERT(DATETIME, '2023-10-29 16:30:37',120), 'Pendiente', 0),
(47, 43, '2024-11-08', CONVERT(DATETIME, '2024-11-08 14:20:07',120), 'Pendiente', 0),
(48, 47, '2024-11-29', CONVERT(DATETIME, '2024-11-29 16:55:30',120), 'Confirmado', 0),
(49, 49, '2024-01-30', CONVERT(DATETIME, '2024-01-30 12:33:32',120), 'Pendiente', 0),
(50, 49, '2024-10-22', CONVERT(DATETIME, '2024-10-22 12:38:27',120), 'Pendiente', 0);

--DELETE FROM G1.INSCRIPCIONES
SELECT * FROM G1.INSCRIPCIONES

--*****************************************************
--INSERT INTO G1.INTERES (Id_Interes, Id_Prospecto, Id_Periodo, Id_Sede, Id_Mod_Estudios, Id_Carrera, Id_Mod_Admision, Id_Nivel_Interes, Id_Estado, id_Tipificacion)
--SELECT 
--    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
--    p.id_Prospecto,
--    ABS(CHECKSUM(NEWID()) % 3) + 1,
--    ABS(CHECKSUM(NEWID()) % 3) + 1,
--    ABS(CHECKSUM(NEWID()) % 3) + 1,
--    ABS(CHECKSUM(NEWID()) % 4) + 1,
--    ABS(CHECKSUM(NEWID()) % 3) + 1,
--    ABS(CHECKSUM(NEWID()) % 3) + 1,
--    ABS(CHECKSUM(NEWID()) % 3) + 1,
--    ABS(CHECKSUM(NEWID()) % 3) + 1
--FROM G1.PROSPECTOS p;
--*****************************************************

INSERT INTO G1.INTERES (Id_Interes, Id_Prospecto, Id_Periodo, Id_Sede, Id_Mod_Estudio, Id_Carrera, Id_Mod_Admision, Id_Nivel_Interes, Id_Estado, id_Tipificacion) VALUES
(1, 18, 3, 3, 1, 3, 2, 3, 1, 3),
(2, 10, 2, 3, 2, 3, 3, 3, 2, 2),
(3, 17, 2, 1, 2, 5, 2, 2, 3, 1),
(4, 2, 2, 2, 2, 2, 1, 3, 3, 1),
(5, 15, 3, 3, 3, 3, 3, 3, 3, 2),
(6, 5, 2, 4, 1, 2, 3, 3, 2, 3),
(7, 15, 2, 1, 1, 1, 3, 3, 3, 3),
(8, 17, 2, 1, 2, 2, 1, 2, 1, 1),
(9, 17, 1, 1, 1, 1, 3, 1, 2, 1),
(10, 1, 1, 4, 2, 1, 3, 1, 3, 1),
(11, 18, 1, 4, 2, 3, 1, 1, 3, 2),
(12, 11, 2, 3, 3, 1, 1, 3, 1, 3),
(13, 16, 3, 4, 2, 2, 3, 1, 3, 2),
(14, 4, 1, 3, 1, 2, 1, 1, 1, 2),
(15, 6, 1, 4, 3, 4, 3, 2, 2, 3),
(16, 14, 3, 2, 1, 5, 3, 1, 2, 2),
(17, 13, 3, 1, 1, 2, 3, 1, 3, 3),
(18, 19, 2, 2, 3, 5, 1, 3, 1, 1),
(19, 14, 3, 2, 3, 2, 3, 2, 3, 3),
(20, 17, 1, 3, 2, 2, 3, 2, 3, 3),
(21, 15, 1, 1, 2, 1, 3, 3, 3, 1),
(22, 19, 2, 4, 2, 4, 2, 1, 3, 2),
(23, 4, 2, 4, 3, 2, 2, 3, 1, 3),
(24, 16, 1, 1, 1, 5, 3, 3, 2, 3),
(25, 9, 1, 2, 2, 1, 2, 3, 3, 2),
(26, 16, 3, 1, 1, 5, 1, 3, 1, 3),
(27, 6, 2, 2, 2, 1, 2, 2, 3, 1),
(28, 10, 2, 2, 1, 4, 2, 2, 1, 2),
(29, 1, 2, 1, 3, 1, 1, 2, 1, 1),
(30, 5, 3, 3, 2, 3, 3, 2, 2, 3),
(31, 7, 3, 2, 2, 2, 3, 3, 3, 1),
(32, 10, 1, 3, 1, 2, 1, 3, 2, 1),
(33, 13, 1, 1, 2, 2, 2, 2, 1, 2),
(34, 16, 2, 2, 2, 2, 2, 3, 1, 3),
(35, 14, 3, 3, 2, 2, 1, 2, 2, 2),
(36, 18, 3, 2, 2, 5, 1, 2, 2, 1),
(37, 4, 3, 3, 1, 4, 3, 3, 3, 3),
(38, 15, 1, 4, 3, 2, 3, 3, 1, 2),
(39, 4, 2, 4, 3, 3, 1, 2, 1, 2),
(40, 13, 1, 4, 3, 4, 2, 1, 2, 2),
(41, 7, 2, 2, 2, 5, 3, 3, 1, 2),
(42, 3, 2, 4, 1, 1, 2, 1, 3, 3),
(43, 1, 1, 4, 3, 4, 1, 2, 2, 2),
(44, 10, 2, 4, 1, 5, 1, 2, 3, 1),
(45, 13, 2, 3, 3, 3, 3, 1, 3, 1),
(46, 19, 3, 1, 1, 5, 3, 2, 1, 1),
(47, 6, 3, 1, 2, 5, 2, 2, 1, 2),
(48, 3, 3, 4, 1, 5, 3, 2, 2, 3),
(49, 3, 2, 3, 2, 1, 1, 3, 2, 3),
(50, 15, 2, 1, 3, 2, 2, 1, 3, 3);

--DELETE FROM G1.INTERES
SELECT * FROM G1.INTERES

INSERT INTO G1.MOD_ADMISION (id_Mod_Admision, Mod_Admision) VALUES
(1, 'Examen Regular'),
(2, 'Examen Extraordinario'),
(3, 'Talento');

INSERT INTO G1.MOD_ESTUDIOS (id_Mod_Estudio, Mod_Estudio) VALUES
(1, 'Presencial'),
(2, 'Semipresencial'),
(3, 'Virtual');

SELECT * FROM G1.MOD_ESTUDIOS

INSERT INTO G1.NIVEL_INTERES (id_Nivel_Interes, Nivel_Interes) VALUES
(1, 'Alto'),
(2, 'Medio'),
(3, 'Bajo');

INSERT INTO G1.PAGOS ([Id_Pago], [Id_Inscripcion], [Fecha_Pago], [Hora_Pago], [Concepto], [Cargo], [Descuento], [Abono], [Deuda]) VALUES
(1, 1, '2024-08-25', CONVERT(DATETIME, '2024-08-25 10:38:27',120), 'INS', 200, -100, 100, 0),
(2, 2, '2023-11-28', CONVERT(DATETIME, '2023-11-28 13:44:48',120), 'INS', 200, -100, 100, 0),
(3, 3, '2024-03-05', CONVERT(DATETIME, '2024-03-05 10:43:47',120), 'INS', 200, -100, 100, 0),
(4, 4, '2024-04-30', CONVERT(DATETIME, '2024-04-30 12:21:22',120), 'INS', 200, -100, 100, 0),
(5, 5, '2024-01-17', CONVERT(DATETIME, '2024-01-17 10:34:54',120), 'INS', 200, -100, 100, 0),
(6, 6, '2024-02-26', CONVERT(DATETIME, '2024-02-26 08:42:07',120), 'INS', 200, -100, 100, 0),
(7, 7, '2024-07-15', CONVERT(DATETIME, '2024-07-15 09:10:15',120), 'INS', 200, -100, 100, 0),
(8, 8, '2024-03-08', CONVERT(DATETIME, '2024-03-08 12:38:50',120), 'INS', 200, -100, 100, 0),
(9, 9, '2024-03-03', CONVERT(DATETIME, '2024-03-03 10:55:55',120), 'INS', 200, -100, 100, 0),
(10, 10, '2023-09-21', CONVERT(DATETIME, '2023-09-21 10:32:33',120), 'INS', 200, -100, 100, 0),
(11, 11, '2023-11-22', CONVERT(DATETIME, '2023-11-22 08:59:15',120), 'INS', 200, -100, 100, 0),
(12, 12, '2024-06-18', CONVERT(DATETIME, '2024-06-18 09:14:09',120), 'INS', 200, -100, 100, 0),
(13, 13, '2024-08-03', CONVERT(DATETIME, '2024-08-03 08:36:56',120), 'INS', 200, -100, 100, 0),
(14, 14, '2023-11-17', CONVERT(DATETIME, '2023-11-17 08:35:15',120), 'INS', 200, -100, 100, 0),
(15, 15, '2024-08-16', CONVERT(DATETIME, '2024-08-16 08:02:37',120), 'INS', 200, -100, 100, 0),
(16, 16, '2024-09-12', CONVERT(DATETIME, '2024-09-12 12:26:30',120), 'INS', 200, -100, 100, 0),
(17, 17, '2023-10-22', CONVERT(DATETIME, '2023-10-22 13:19:47',120), 'INS', 200, -100, 100, 0),
(18, 18, '2024-11-22', CONVERT(DATETIME, '2024-11-22 10:14:10',120), 'INS', 200, -100, 100, 0),
(19, 19, '2023-12-22', CONVERT(DATETIME, '2023-12-22 11:28:20',120), 'INS', 200, -100, 100, 0),
(20, 20, '2024-12-12', CONVERT(DATETIME, '2024-12-12 13:11:18',120), 'INS', 200, -100, 100, 0),
(21, 21, '2024-07-12', CONVERT(DATETIME, '2024-07-12 12:31:51',120), 'INS', 200, -100, 100, 0),
(22, 22, '2023-08-12', CONVERT(DATETIME, '2023-08-12 09:26:25',120), 'INS', 200, -100, 100, 0),
(23, 23, '2023-08-08', CONVERT(DATETIME, '2023-08-08 09:07:53',120), 'INS', 200, -100, 100, 0),
(24, 24, '2024-09-10', CONVERT(DATETIME, '2024-09-10 11:43:41',120), 'INS', 200, -100, 100, 0),
(25, 25, '2024-11-20', CONVERT(DATETIME, '2024-11-20 13:19:32',120), 'INS', 200, -100, 100, 0),
(26, 26, '2024-11-20', CONVERT(DATETIME, '2024-11-20 13:15:31',120), 'INS', 200, -100, 100, 0),
(27, 27, '2023-12-10', CONVERT(DATETIME, '2023-12-10 12:33:22',120), 'INS', 200, -100, 100, 0),
(28, 28, '2024-07-23', CONVERT(DATETIME, '2024-07-23 12:52:32',120), 'INS', 200, -100, 100, 0),
(29, 29, '2024-03-16', CONVERT(DATETIME, '2024-03-16 11:17:59',120), 'INS', 200, -100, 100, 0),
(30, 30, '2024-08-17', CONVERT(DATETIME, '2024-08-17 08:53:18',120), 'INS', 200, -100, 100, 0),
(31, 31, '2024-04-15', CONVERT(DATETIME, '2024-04-15 10:21:49',120), 'INS', 200, -100, 100, 0),
(32, 32, '2023-08-14', CONVERT(DATETIME, '2023-08-14 12:28:25',120), 'INS', 200, -100, 100, 0),
(33, 33, '2024-06-08', CONVERT(DATETIME, '2024-06-08 10:42:00',120), 'INS', 200, -100, 100, 0),
(34, 34, '2024-05-09', CONVERT(DATETIME, '2024-05-09 08:51:51',120), 'INS', 200, -100, 100, 0),
(35, 35, '2024-04-01', CONVERT(DATETIME, '2024-04-01 10:29:21',120), 'INS', 200, -100, 100, 0),
(36, 36, '2024-11-04', CONVERT(DATETIME, '2024-11-04 09:11:22',120), 'INS', 200, -100, 100, 0),
(37, 37, '2023-12-29', CONVERT(DATETIME, '2023-12-29 11:59:36',120), 'INS', 200, -100, 100, 0),
(38, 38, '2023-08-02', CONVERT(DATETIME, '2023-08-02 08:49:52',120), 'INS', 200, -100, 100, 0),
(39, 39, '2024-08-05', CONVERT(DATETIME, '2024-08-05 09:01:09',120), 'INS', 200, -100, 100, 0),
(40, 40, '2024-11-13', CONVERT(DATETIME, '2024-11-13 10:00:47',120), 'INS', 200, -100, 100, 0),
(41, 41, '2024-09-13', CONVERT(DATETIME, '2024-09-13 10:53:20',120), 'INS', 200, -100, 100, 0),
(42, 42, '2024-03-25', CONVERT(DATETIME, '2024-03-25 09:30:45',120), 'INS', 200, -100, 100, 0),
(43, 43, '2024-10-26', CONVERT(DATETIME, '2024-10-26 10:55:48',120), 'INS', 200, -100, 100, 0),
(44, 44, '2024-01-17', CONVERT(DATETIME, '2024-01-17 13:17:27',120), 'INS', 200, -100, 100, 0),
(45, 45, '2024-06-24', CONVERT(DATETIME, '2024-06-24 13:45:47',120), 'INS', 200, -100, 100, 0),
(46, 46, '2023-10-29', CONVERT(DATETIME, '2023-10-29 12:35:51',120), 'INS', 200, -100, 100, 0),
(47, 47, '2024-11-08', CONVERT(DATETIME, '2024-11-08 08:51:28',120), 'INS', 200, -100, 100, 0),
(48, 48, '2024-11-29', CONVERT(DATETIME, '2024-11-29 12:12:10',120), 'INS', 200, -100, 100, 0),
(49, 49, '2024-01-30', CONVERT(DATETIME, '2024-01-30 13:27:00',120), 'INS', 200, -100, 100, 0),
(50, 50, '2024-10-22', CONVERT(DATETIME, '2024-10-22 11:41:55',120), 'INS', 200, -100, 100, 0);

--DELETE FROM G1.PAGOS
SELECT * FROM G1.PAGOS

INSERT INTO G1.PERIODOS (id_periodo, Periodo) VALUES 
(1, '2024-1'),
(2, '2024-2'),
(3, '2025-1');

SELECT * FROM G1.PERIODOS

--*****************************************************
--INSERT INTO G1.PROSPECTOS 
--SELECT TOP 1000
--    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as id_Prospecto,
--    'DNI' as Tipo_Documento,
--    CAST(40000000 + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as varchar) as Num_Documento,
--    'Nombre' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as varchar) as Nombre,
--    'Apellido' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as varchar) as Apellidos,
--    CASE WHEN ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) % 2 = 0 THEN 'Masculino' ELSE 'Femenino' END as Genero,
--    'Soltero' as Estado_Civil,
--    DATEADD(day, -CAST(RAND(CHECKSUM(NEWID())) * 3650 as int), '2006-01-01') as Fecha_Nacimiento,
--    'Colegio' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as varchar) as Colegio,
--    'Peruana' as Nacionalidad,
--    'Lima' as Departamento,
--    'Lima' as Provincia,
--    'Lima' as Distrito,
--    900000000 + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as Telefono_Movil,
--    'correo' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as varchar) + '@mail.com' as Correo_Electronico
--FROM sys.objects a
--CROSS JOIN sys.objects b;
--*****************************************************

INSERT INTO G1.PROSPECTOS ([id_Prospecto] ,[Tipo_Documento] ,[Num_Documento] ,[Nombre] ,[Apellidos] ,[Genero] ,[Estado_Civil] ,[Fecha_Nacimiento] ,[Colegio]
           ,[Nacionalidad] ,[Departamento] ,[Provincia] ,[Distrito] ,[Telefono_Movil] ,[Correo_Electronico]) VALUES
(1, 'DNI', '45678901', 'Juan', 'Pérez', 'M', 'Soltero', '2000-05-15', 'Colegio San José', 'Peruana', 'Lima', 'Lima', 'Miraflores', '987654321', 'juan.perez@email.com'),
(2, 'DNI', '45678902', 'María', 'García', 'F', 'Soltera', '2001-03-20', 'Colegio Santa María', 'Peruana', 'Lima', 'Lima', 'San Isidro', '987654321', 'maria.garcia@email.com'),
(3, 'CE', 'CE234567', 'Carlos', 'González', 'M', 'Soltero', '2000-08-10', 'Colegio América', 'Venezolana', 'Lima', 'Lima', 'San Borja', '987654321', 'carlos.gonzalez@email.com'),
(4, 'DNI', '45678903', 'Ana', 'Martínez', 'F', 'Soltera', '2001-11-25', 'Colegio Santa Rosa', 'Peruana', 'Lima', 'Lima', 'La Molina', '987654321', 'ana.martinez@email.com'),
(5, 'DNI', '45678904', 'Luis', 'Rodríguez', 'M', 'Soltero', '2000-12-30', 'Colegio San Agustín', 'Peruana', 'Lima', 'Lima', 'Surco', '987654321', 'luis.rodriguez@email.com'),
(6, 'CE', 'CE234568', 'Andrea', 'López', 'F', 'Soltera', '2001-01-15', 'Colegio Internacional', 'Colombiana', 'Lima', 'Lima', 'San Miguel', '987654321', 'andrea.lopez@email.com'),
(7, 'DNI', '45678905', 'Pedro', 'Sánchez', 'M', 'Soltero', '2000-07-22', 'Colegio La Salle', 'Peruana', 'Lima', 'Lima', 'Jesús María', '987654321', 'pedro.sanchez@email.com'),
(8, 'DNI', '45678906', 'Carmen', 'Torres', 'F', 'Soltera', '2001-04-18', 'Colegio María Reina', 'Peruana', 'Lima', 'Lima', 'Pueblo Libre', '987654321', 'carmen.torres@email.com'),
(9, 'CE', 'CE234569', 'Miguel', 'Herrera', 'M', 'Soltero', '2000-09-05', 'Colegio Roosevelt', 'Chilena', 'Lima', 'Lima', 'Magdalena', '987654321', 'miguel.herrera@email.com'),
(10, 'DNI', '45678907', 'Laura', 'Díaz', 'F', 'Soltera', '2001-06-12', 'Colegio Santa Úrsula', 'Peruana', 'Lima', 'Lima', 'San Isidro', '987654321', 'laura.diaz@email.com'),
(11, 'DNI', '45678908', 'Jorge', 'Flores', 'M', 'Soltero', '2000-10-28', 'Colegio San Pablo', 'Peruana', 'Lima', 'Lima', 'Miraflores', '987654321', 'jorge.flores@email.com'),
(12, 'CE', 'CE234570', 'Patricia', 'Vargas', 'F', 'Soltera', '2001-02-14', 'Colegio Cambridge', 'Argentina', 'Lima', 'Lima', 'La Molina', '987654321', 'patricia.vargas@email.com'),
(13, 'DNI', '45678909', 'Ricardo', 'Castro', 'M', 'Soltero', '2000-11-30', 'Colegio San Ignacio', 'Peruana', 'Lima', 'Lima', 'Surco', '987654321', 'ricardo.castro@email.com'),
(14, 'DNI', '45678910', 'Diana', 'Mendoza', 'F', 'Soltera', '2001-07-08', 'Colegio Villa María', 'Peruana', 'Lima', 'Lima', 'San Borja', '987654321', 'diana.mendoza@email.com'),
(15, 'CE', 'CE234571', 'Fernando', 'Ríos', 'M', 'Soltero', '2000-04-25', 'Colegio Newton', 'Ecuatoriana', 'Lima', 'Lima', 'La Molina', '987654321', 'fernando.rios@email.com'),
(16, 'DNI', '45678911', 'Carolina', 'Luna', 'F', 'Soltera', '2001-09-17', 'Colegio Recoleta', 'Peruana', 'Lima', 'Lima', 'San Isidro', '987654321', 'carolina.luna@email.com'),
(17, 'DNI', '45678912', 'Gabriel', 'Ortiz', 'M', 'Soltero', '2000-06-20', 'Colegio La Inmaculada', 'Peruana', 'Lima', 'Lima', 'Miraflores', '987654321', 'gabriel.ortiz@email.com'),
(18, 'CE', 'CE234572', 'Valentina', 'Morales', 'F', 'Soltera', '2001-05-03', 'Colegio Markham', 'Brasileña', 'Lima', 'Lima', 'Surco', '987654321', 'valentina.morales@email.com'),
(19, 'DNI', '45678913', 'Alejandro', 'Paz', 'M', 'Soltero', '2000-03-12', 'Colegio Santa María', 'Peruana', 'Lima', 'Lima', 'San Miguel', '987654321', 'alejandro.paz@email.com'),
(20, 'DNI', '45678914', 'Lucía', 'Rojas', 'F', 'Soltera', '2001-08-29', 'Colegio San José', 'Peruana', 'Lima', 'Lima', 'Jesús María', '987654321', 'lucia.rojas@email.com');

--DELETE FROM G1.PROSPECTOS
SELECT * FROM G1.PROSPECTOS

INSERT INTO G1.SECCIONES ([Id_Seccion], [Seccion], [Turno]) VALUES
(1, 'ADM01', 'Mañana'),
(2, 'ADM02', 'Tarde'),
(3, 'ADM03', 'Noche'),
(4, 'ADM04', 'Mañana'),
(5, 'ADM05', 'Tarde'),
(6, 'ADM06', 'Noche'),
(7, 'ADM07', 'Mañana'),
(8, 'ADM08', 'Tarde'),
(9, 'ADM09', 'Noche');

--DELETE FROM G1.SECCIONES
SELECT * FROM G1.SECCIONES

INSERT INTO G1.SEDES (id_Sede, Sede) VALUES
(1, 'Lima Norte'),
(2, 'Lima Sur'),
(3, 'Lima Este'),
(4, 'Lima Centro');

SELECT * FROM G1.SEDES

INSERT INTO G1.TIPIFICACIONES (id_Tipificacion, Tipificacion) VALUES
(1, 'Interesado'),
(2, 'En evaluación'),
(3, 'No interesado');


--VALIDAR DATOS

--SELECT TOP 2 * FROM G1.CARRERAS
--SELECT TOP 2 * FROM G1.ESTADO
--SELECT TOP 2 * FROM G1.EVALUACIONES
--SELECT TOP 2 * FROM G1.INSCRIPCIONES
--SELECT TOP 2 * FROM G1.INTERES
--SELECT TOP 2 * FROM G1.MOD_ADMISION
--SELECT TOP 2 * FROM G1.MOD_ESTUDIOS
--SELECT TOP 2 * FROM G1.NIVEL_INTERES
--SELECT TOP 2 * FROM G1.PAGOS
--SELECT TOP 2 * FROM G1.PERIODOS
--SELECT TOP 2 * FROM G1.PROSPECTOS
--SELECT TOP 2 * FROM G1.SECCIONES
--SELECT TOP 2 * FROM G1.SEDES
--SELECT TOP 2 * FROM G1.TIPIFICACIONES


--PREGUNTAS

-- 1. Porcentaje de crecimiento entre periodos espejo (2024-1 y 2025-1)
WITH Inscritos AS (
    SELECT p.Periodo, COUNT(*) as Total
    FROM G1.INTERES i
    JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
    WHERE p.Periodo IN ('2024-1', '2025-1')
    GROUP BY p.Periodo
)
SELECT 
    (CAST((SELECT Total FROM Inscritos WHERE Periodo = '2025-1') AS FLOAT) /
     CAST((SELECT Total FROM Inscritos WHERE Periodo = '2024-1') AS FLOAT) - 1) * 100 as PorcentajeCrecimiento;

-- 2. Porcentaje de abandonos antes de completar inscripción en 2024-1
SELECT 
    (COUNT(CASE WHEN i.Id_Estado = 3 THEN 1 END) * 100.0 / COUNT(*)) as PorcentajeAbandono
FROM G1.INTERES i
JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
WHERE p.Periodo = '2024-1';

-- 3. Sede con mayor cantidad de inscritos en 2024
SELECT TOP 1
    s.Sede,
    COUNT(*) as Total
FROM G1.INTERES i
JOIN G1.SEDES s ON i.Id_Sede = s.id_Sede
JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
WHERE p.Periodo in ('2024-1', '2024-2')
GROUP BY s.Sede
ORDER BY Total DESC;

-- 4. Modalidad de estudios con mayor cantidad de inscritos en 2024
SELECT TOP 1
    me.Mod_Estudio,
    COUNT(*) as Total
FROM G1.INTERES i
JOIN G1.MOD_ESTUDIOS me ON i.Id_Mod_Estudio = me.id_Mod_Estudio
JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
WHERE p.Periodo in ('2024-1', '2024-2')
GROUP BY me.Mod_Estudio
ORDER BY Total DESC;

-- 5. Carrera con mayor cantidad de interesados en 2025-1
SELECT TOP 1
    c.Carrera,
    COUNT(*) as Total
FROM G1.INTERES i
JOIN G1.CARRERAS c ON i.Id_Carrera = c.Id_Carrera
JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
WHERE p.Periodo = '2025-1'
GROUP BY c.Carrera
ORDER BY Total DESC;

-- 6. Tiempo promedio en días que tarda un prospecto en decidir su inscripción en el año 2024?
SELECT AVG(DATEDIFF(DAY, i.Fecha_Inscripción, GETDATE())) as DiasPromedio
FROM G1.INSCRIPCIONES i
JOIN G1.INTERES int ON i.Id_Interes = int.Id_Interes
JOIN G1.PERIODOS p ON int.Id_Periodo = p.id_periodo
WHERE p.Periodo IN ('2024-1','2024-2');


-- >> REVISAR

-- Modalidad de estudios más demandada en 2025-1
SELECT TOP 1
    me.Mod_Estudio,
    COUNT(*) as Total
FROM G1.INTERES i
JOIN G1.MOD_ESTUDIOS me ON i.Id_Mod_Estudio = me.id_Mod_Estudio
JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
WHERE p.Periodo = '2025-1'
GROUP BY me.Mod_Estudio
ORDER BY Total DESC;

-- Carrera y modalidad de estudios más demandada en 2025-1
SELECT TOP 1
    c.Carrera,
    me.Mod_Estudio,
    COUNT(*) as Total
FROM G1.INTERES i
JOIN G1.CARRERAS c ON i.Id_Carrera = c.Id_Carrera
JOIN G1.MOD_ESTUDIOS me ON i.Id_Mod_Estudio = me.id_Mod_Estudio
JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
WHERE p.Periodo = '2025-1'
GROUP BY c.Carrera, me.Mod_Estudio
ORDER BY Total DESC;

-- Sede con más prospectos en 2024-1
SELECT TOP 1
    s.Sede,
    COUNT(*) as Total
FROM G1.INTERES i
JOIN G1.SEDES s ON i.Id_Sede = s.id_Sede
JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
WHERE p.Periodo = '2024-1'
GROUP BY s.Sede
ORDER BY Total DESC;

