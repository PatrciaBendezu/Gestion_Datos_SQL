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
	[Estado_Inscripción] [varchar](30)
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

GO
