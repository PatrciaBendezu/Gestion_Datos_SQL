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
	[Id_Evaluación] [int] NOT NULL,
	[Id_Inscripcion] [int],
	[Ingresante] [varchar](2),
	[Puntaje] [float],
	[Fecha_Evaluacion] [date],
	[Hora_Evaluacion] [datetime] 
)

CREATE TABLE G1.INSCRIPCIONES
(
	[Id_Inscripcion] [int] NOT NULL,
	[Id_interes] [int],
	[Id_Prospecto] [int],
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
	[Fecha_Evaluación] [date],
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

--SELECT * FROM G1.TIPIFICACIONES

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
ALTER TABLE G1.INSCRIPCIONES ADD CONSTRAINT FK_INSCRIPCIONES_SECCIONES FOREIGN KEY (Id_Seccion) REFERENCES G1.SECCIONES (Id_Seccion)
ALTER TABLE G1.PAGOS ADD CONSTRAINT FK_PAGOS_INSCRIPCIONES FOREIGN KEY (Id_Inscripcion) REFERENCES G1.INSCRIPCIONES (Id_Inscripcion)
ALTER TABLE G1.EVALUACIONES ADD CONSTRAINT FK_EVALUACIONES_INSCRIPCIONES FOREIGN KEY (Id_Inscripcion) REFERENCES G1.INSCRIPCIONES (Id_Inscripcion)

--SELECT * FROM sys.objects WHERE name LIKE 'FK_EVALU%'

GO

--INSERTAR DATOS DE PRUEBA

INSERT INTO G1.PERIODOS (id_periodo, Periodo) VALUES 
(1, '2024-1'),
(2, '2024-2'),
(3, '2025-1');

INSERT INTO G1.SEDES (id_Sede, Sede) VALUES
(1, 'Lima Norte'),
(2, 'Lima Sur'),
(3, 'Lima Este'),
(4, 'Lima Centro');

INSERT INTO G1.MOD_ESTUDIOS (id_Mod_Estudio, Mod_Estudio) VALUES
(1, 'Presencial'),
(2, 'Semipresencial'),
(3, 'Virtual');

INSERT INTO G1.CARRERAS (Id_Carrera, Carrera) VALUES
(1, 'Ingeniería de Sistemas'),
(2, 'Administración'),
(3, 'Psicología'),
(4, 'Contabilidad'),
(5, 'Marketing');

INSERT INTO G1.MOD_ADMISION (id_Mod_Admision, Mod_Admision) VALUES
(1, 'Examen Regular'),
(2, 'Examen Extraordinario'),
(3, 'Talento');

INSERT INTO G1.NIVEL_INTERES (id_Nivel_Interes, Nivel_Interes) VALUES
(1, 'Alto'),
(2, 'Medio'),
(3, 'Bajo');

INSERT INTO G1.ESTADO (Id_Estado, Nombre) VALUES
(1, 'Activo'),
(2, 'Inactivo'),
(3, 'Pendiente');

INSERT INTO G1.TIPIFICACIONES (id_Tipificacion, Tipificacion) VALUES
(1, 'Interesado'),
(2, 'En evaluación'),
(3, 'No interesado');


--GENERAR DATOS DE PRUEBA

INSERT INTO G1.PROSPECTOS 
SELECT TOP 1000
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as id_Prospecto,
    'DNI' as Tipo_Documento,
    CAST(40000000 + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as varchar) as Num_Documento,
    'Nombre' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as varchar) as Nombre,
    'Apellido' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as varchar) as Apellidos,
    CASE WHEN ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) % 2 = 0 THEN 'Masculino' ELSE 'Femenino' END as Genero,
    'Soltero' as Estado_Civil,
    DATEADD(day, -CAST(RAND(CHECKSUM(NEWID())) * 3650 as int), '2006-01-01') as Fecha_Nacimiento,
    'Colegio' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as varchar) as Colegio,
    'Peruana' as Nacionalidad,
    'Lima' as Departamento,
    'Lima' as Provincia,
    'Lima' as Distrito,
    900000000 + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as Telefono_Movil,
    'correo' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as varchar) + '@mail.com' as Correo_Electronico
FROM sys.objects a
CROSS JOIN sys.objects b;

--SELECT TOP 10 * FROM G1.PROSPECTOS 

INSERT INTO G1.INTERES (Id_Interes, Id_Prospecto, Id_Periodo, Id_Sede, Id_Mod_Estudios, Id_Carrera, Id_Mod_Admision, Id_Nivel_Interes, Id_Estado, id_Tipificacion)
SELECT 
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    p.id_Prospecto,
    ABS(CHECKSUM(NEWID()) % 3) + 1,
    ABS(CHECKSUM(NEWID()) % 3) + 1,
    ABS(CHECKSUM(NEWID()) % 3) + 1,
    ABS(CHECKSUM(NEWID()) % 4) + 1,
    ABS(CHECKSUM(NEWID()) % 3) + 1,
    ABS(CHECKSUM(NEWID()) % 3) + 1,
    ABS(CHECKSUM(NEWID()) % 3) + 1,
    ABS(CHECKSUM(NEWID()) % 3) + 1
FROM G1.PROSPECTOS p;

--SELECT TOP 10 * FROM G1.INTERES 

--VALIDAR DATOS

--SELECT TOP 2 * FROM G1.CARRERAS
--SELECT TOP 2 * FROM G1.ESTADO
--SELECT TOP 2 * FROM G1.EVALUACIONES -- >> FALTA INGRESAR DATOS
--SELECT TOP 2 * FROM G1.INSCRIPCIONES -- >> FALTA INGRESAR DATOS
--SELECT TOP 2 * FROM G1.INTERES
--SELECT TOP 2 * FROM G1.MOD_ADMISION
--SELECT TOP 2 * FROM G1.MOD_ESTUDIOS
--SELECT TOP 2 * FROM G1.NIVEL_INTERES
--SELECT TOP 2 * FROM G1.PAGOS -- >> FALTA INGRESAR DATOS
--SELECT TOP 2 * FROM G1.PERIODOS
--SELECT TOP 2 * FROM G1.PROSPECTOS
--SELECT TOP 2 * FROM G1.SECCIONES -- >> FALTA INGRESAR DATOS
--SELECT TOP 2 * FROM G1.SEDES
--SELECT TOP 2 * FROM G1.TIPIFICACIONES


--PREGUNTAS

-- 1. Tiempo promedio que tarda un prospecto en decidir su inscripción en 2024-1
SELECT AVG(DATEDIFF(DAY, i.Fecha_Inscripción, GETDATE())) as DiasPromedio
FROM G1.INSCRIPCIONES i
JOIN G1.INTERES int ON i.Id_Interes = int.Id_Interes
JOIN G1.PERIODOS p ON int.Id_Periodo = p.id_periodo
WHERE p.Periodo = '2024-1';

-- 2. Porcentaje de crecimiento entre periodos espejo (2024-1 y 2025-1)
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

-- 3. Porcentaje de abandonos antes de completar inscripción en 2024-1
SELECT 
    (COUNT(CASE WHEN i.Id_Estado = 3 THEN 1 END) * 100.0 / COUNT(*)) as PorcentajeAbandono
FROM G1.INTERES i
JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
WHERE p.Periodo = '2024-1';

-- 4. Sede predominante en 2024-1
SELECT TOP 1
    s.Sede,
    COUNT(*) as Total
FROM G1.INTERES i
JOIN G1.SEDES s ON i.Id_Sede = s.id_Sede
JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
WHERE p.Periodo = '2024-1'
GROUP BY s.Sede
ORDER BY Total DESC;

-- 5. Modalidad de estudios predominante en 2024-1
SELECT TOP 1
    me.Mod_Estudio,
    COUNT(*) as Total
FROM G1.INTERES i
JOIN G1.MOD_ESTUDIOS me ON i.Id_Mod_Estudios = me.id_Mod_Estudio
JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
WHERE p.Periodo = '2024-1'
GROUP BY me.Mod_Estudio
ORDER BY Total DESC;

-- 6. Carrera más demandada en 2025-1
SELECT TOP 1
    c.Carrera,
    COUNT(*) as Total
FROM G1.INTERES i
JOIN G1.CARRERAS c ON i.Id_Carrera = c.Id_Carrera
JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
WHERE p.Periodo = '2025-1'
GROUP BY c.Carrera
ORDER BY Total DESC;

-- 7. Modalidad de estudios más demandada en 2025-1
SELECT TOP 1
    me.Mod_Estudio,
    COUNT(*) as Total
FROM G1.INTERES i
JOIN G1.MOD_ESTUDIOS me ON i.Id_Mod_Estudios = me.id_Mod_Estudio
JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
WHERE p.Periodo = '2025-1'
GROUP BY me.Mod_Estudio
ORDER BY Total DESC;

-- 8. Carrera y modalidad de estudios más demandada en 2025-1
SELECT TOP 1
    c.Carrera,
    me.Mod_Estudio,
    COUNT(*) as Total
FROM G1.INTERES i
JOIN G1.CARRERAS c ON i.Id_Carrera = c.Id_Carrera
JOIN G1.MOD_ESTUDIOS me ON i.Id_Mod_Estudios = me.id_Mod_Estudio
JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
WHERE p.Periodo = '2025-1'
GROUP BY c.Carrera, me.Mod_Estudio
ORDER BY Total DESC;

-- 9. Sede con más prospectos en 2024-1
SELECT TOP 1
    s.Sede,
    COUNT(*) as Total
FROM G1.INTERES i
JOIN G1.SEDES s ON i.Id_Sede = s.id_Sede
JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
WHERE p.Periodo = '2024-1'
GROUP BY s.Sede
ORDER BY Total DESC;