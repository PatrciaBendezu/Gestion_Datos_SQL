USE UCDATASCIENCE

-- 1. ¿Cual es el crecimiento interanual de inscripciones entre periodos 2024-1 y 2025-1?
WITH InscripcionesPeriodo AS (
    SELECT 
        p.Periodo,
        COUNT(i.Id_Inscripcion) as TotalInscripciones
    FROM G1.INSCRIPCIONES i
    JOIN G1.INTERES int ON i.Id_interes = int.Id_Interes
    JOIN G1.PERIODOS p ON int.Id_Periodo = p.id_periodo
    WHERE p.Periodo IN ('2024-1', '2025-1')
    GROUP BY p.Periodo
)
SELECT 
    (SELECT TotalInscripciones FROM InscripcionesPeriodo WHERE Periodo = '2025-1') as Inscripciones_2025_1,
    (SELECT TotalInscripciones FROM InscripcionesPeriodo WHERE Periodo = '2024-1') as Inscripciones_2024_1,
    CAST(
        ((CAST((SELECT TotalInscripciones FROM InscripcionesPeriodo WHERE Periodo = '2025-1') AS FLOAT) /
          CAST((SELECT TotalInscripciones FROM InscripcionesPeriodo WHERE Periodo = '2024-1') AS FLOAT)) - 1) * 100 
        AS DECIMAL(10,2)
    ) as Crecimiento_Porcentual


-- 2. ¿Qué porcentaje de prospectos no completan las nscripciones en el periodo 2024-1?
WITH Estadisticas AS (
    SELECT 
        COUNT(DISTINCT p.id_Prospecto) as TotalProspectos,
        COUNT(DISTINCT i.Id_Inscripcion) as TotalInscripciones
    FROM G1.PROSPECTOS p
    JOIN G1.INTERES int ON p.id_Prospecto = int.Id_Prospecto
    LEFT JOIN G1.INSCRIPCIONES i ON int.Id_Interes = i.Id_interes
    JOIN G1.PERIODOS per ON int.Id_Periodo = per.id_periodo
    WHERE per.Periodo = '2024-1'
)
SELECT 
    TotalProspectos,
    TotalInscripciones,
    CAST((1 - (CAST(TotalInscripciones AS FLOAT) / CAST(TotalProspectos AS FLOAT))) * 100 AS DECIMAL(10,2)) 
    as Porcentaje_Sin_Inscripcion
FROM Estadisticas


-- 3. ¿Cuál es el top 3 de sedes que tiene la mayor cantidad de inscripciones en el año 2024?
SELECT TOP 3
    s.Sede,
    COUNT(i.Id_Inscripcion) as Total_Inscripciones,
    CAST(COUNT(i.Id_Inscripcion) * 100.0 / 
        (SELECT COUNT(*) FROM G1.INSCRIPCIONES i2 
         JOIN G1.INTERES int2 ON i2.Id_interes = int2.Id_Interes
         JOIN G1.PERIODOS p2 ON int2.Id_Periodo = p2.id_periodo
         WHERE p2.Periodo LIKE '2024%') AS DECIMAL(10,2)) as Porcentaje
FROM G1.INSCRIPCIONES i
JOIN G1.INTERES int ON i.Id_interes = int.Id_Interes
JOIN G1.SEDES s ON int.Id_Sede = s.id_Sede
JOIN G1.PERIODOS p ON int.Id_Periodo = p.id_periodo
WHERE p.Periodo LIKE '2024%'
GROUP BY s.Sede
ORDER BY Total_Inscripciones DESC


-- 4. ¿Cuál es la modalidad de estudios que tiene mayor cantidad de inscripciones en el año 2024?
SELECT TOP 1
    me.Mod_Estudio,
    COUNT(i.Id_Inscripcion) as Total_Inscripciones,
    CAST(COUNT(i.Id_Inscripcion) * 100.0 / 
        (SELECT COUNT(*) FROM G1.INSCRIPCIONES i2 
         JOIN G1.INTERES int2 ON i2.Id_interes = int2.Id_Interes
         JOIN G1.PERIODOS p2 ON int2.Id_Periodo = p2.id_periodo
         WHERE p2.Periodo LIKE '2024%') AS DECIMAL(10,2)) as Porcentaje
FROM G1.INSCRIPCIONES i
JOIN G1.INTERES its ON i.Id_interes = its.Id_Interes
JOIN G1.MOD_ESTUDIOS me ON its.Id_Mod_Estudio = me.id_Mod_Estudio
JOIN G1.PERIODOS p ON its.Id_Periodo = p.id_periodo
WHERE p.Periodo LIKE '2024%'
GROUP BY me.Mod_Estudio
ORDER BY Total_Inscripciones DESC


-- 5. ¿Cuál es la carrera con mayor cantidad de prospectos en el periodo 2025-1?
SELECT TOP 1
    c.Carrera,
    COUNT(DISTINCT p.id_Prospecto) as Total_Prospectos,
    CAST(COUNT(DISTINCT p.id_Prospecto) * 100.0 / 
        (SELECT COUNT(DISTINCT p2.id_Prospecto) 
         FROM G1.PROSPECTOS p2
         JOIN G1.INTERES int2 ON p2.id_Prospecto = int2.Id_Prospecto
         JOIN G1.PERIODOS per2 ON int2.Id_Periodo = per2.id_periodo
         WHERE per2.Periodo = '2025-1') AS DECIMAL(10,2)) as Porcentaje
FROM G1.PROSPECTOS p
JOIN G1.INTERES its ON p.id_Prospecto = its.Id_Prospecto
JOIN G1.CARRERAS c ON its.Id_Carrera = c.Id_Carrera
JOIN G1.PERIODOS per ON its.Id_Periodo = per.id_periodo
WHERE per.Periodo = '2025-1'
GROUP BY c.Carrera
ORDER BY Total_Prospectos DESC


-- 6. ¿Cuál es el tiempo promedio en días que tarda un prospecto en decidir su inscripción en el año 2024?
SELECT 
    CAST(AVG(DATEDIFF(DAY, its.Id_Prospecto, i.Fecha_Inscripcion)) AS DECIMAL(10,1)) as Promedio_Dias,
    MIN(DATEDIFF(DAY, its.Id_Prospecto, i.Fecha_Inscripcion)) as Minimo_Dias,
    MAX(DATEDIFF(DAY, its.Id_Prospecto, i.Fecha_Inscripcion)) as Maximo_Dias
FROM G1.INSCRIPCIONES i
JOIN G1.INTERES its ON i.Id_interes = its.Id_Interes
JOIN G1.PERIODOS p ON its.Id_Periodo = p.id_periodo
WHERE p.Periodo LIKE '2024%'


-- 7. ¿Cuál es la cantidad de inscripciones y porcentaje de participacion por edad en el año 2024?
WITH EdadProspectos AS (
    SELECT 
        DATEDIFF(YEAR, p.Fecha_Nacimiento, i.Fecha_Inscripcion) as Edad,
        i.Id_Inscripcion
    FROM G1.INSCRIPCIONES i
    JOIN G1.INTERES int ON i.Id_interes = int.Id_Interes
    JOIN G1.PROSPECTOS p ON int.Id_Prospecto = p.id_Prospecto
    JOIN G1.PERIODOS per ON int.Id_Periodo = per.id_periodo
    WHERE per.Periodo LIKE '2024%'
)
SELECT 
    CASE 
        WHEN Edad < 18 THEN 'Menor de 18'
        WHEN Edad BETWEEN 18 AND 20 THEN '18-20'
        WHEN Edad BETWEEN 21 AND 25 THEN '21-25'
        WHEN Edad BETWEEN 26 AND 30 THEN '26-30'
        ELSE 'Mayor de 30'
    END as Rango_Edad,
    COUNT(*) as Total_Inscripciones,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(10,2)) as Porcentaje
FROM EdadProspectos
GROUP BY 
    CASE 
        WHEN Edad < 18 THEN 'Menor de 18'
        WHEN Edad BETWEEN 18 AND 20 THEN '18-20'
        WHEN Edad BETWEEN 21 AND 25 THEN '21-25'
        WHEN Edad BETWEEN 26 AND 30 THEN '26-30'
        ELSE 'Mayor de 30'
    END
ORDER BY 1


-- 8. ¿Cual es la cantidad de inscripciones y porcentaje de participacion por departamento en los periodos 2024-1, 2024-2 y 2025-1?
WITH InscritosDepartamento AS (
    SELECT 
        p.Departamento,
        pe.Periodo,
        COUNT(*) as CantidadInscritos,
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY pe.Periodo) as PorcentajeParticipacion
    FROM G1.INSCRIPCIONES i
    JOIN G1.INTERES int ON i.Id_interes = int.Id_Interes
    JOIN G1.PROSPECTOS p ON int.Id_Prospecto = p.id_Prospecto
    JOIN G1.PERIODOS pe ON int.Id_Periodo = pe.id_periodo
    WHERE pe.Periodo IN ('2024-1', '2024-2', '2025-1')
    GROUP BY p.Departamento, pe.Periodo
)
SELECT 
    Departamento,
    Periodo,
    CantidadInscritos,
    CAST(PorcentajeParticipacion as decimal(5,2)) as PorcentajeParticipacion
FROM InscritosDepartamento
ORDER BY Periodo, PorcentajeParticipacion DESC;


-- 9. ¿Cuál es la cantidad de inscripciones y porcentaje de participación por género en el periodo 2024-1?
SELECT 
    p.Genero,
    COUNT(*) as CantidadInscritos,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() as decimal(5,2)) as PorcentajeParticipacion
FROM G1.INSCRIPCIONES i
JOIN G1.INTERES int ON i.Id_interes = int.Id_Interes
JOIN G1.PROSPECTOS p ON int.Id_Prospecto = p.id_Prospecto
JOIN G1.PERIODOS pe ON int.Id_Periodo = pe.id_periodo
WHERE pe.Periodo = '2024-1'
GROUP BY p.Genero
ORDER BY CantidadInscritos DESC;


-- 10. ¿Cuál es el interes que tiene la mayor cantidad de inscripciones en el año 2024?
SELECT TOP 1
    ni.Nivel_Interes,
    COUNT(i.Id_Inscripcion) as Total_Inscripciones,
    CAST(COUNT(i.Id_Inscripcion) * 100.0 / 
        (SELECT COUNT(*) FROM G1.INSCRIPCIONES i2 
         JOIN G1.INTERES int2 ON i2.Id_interes = int2.Id_Interes
         JOIN G1.PERIODOS p2 ON int2.Id_Periodo = p2.id_periodo
         WHERE p2.Periodo LIKE '2024%') AS DECIMAL(10,2)) as Porcentaje
FROM G1.INSCRIPCIONES i
JOIN G1.INTERES int ON i.Id_interes = int.Id_Interes
JOIN G1.NIVEL_INTERES ni ON int.Id_Nivel_Interes = ni.id_Nivel_Interes
JOIN G1.PERIODOS p ON int.Id_Periodo = p.id_periodo
WHERE p.Periodo LIKE '2024%'
GROUP BY ni.Nivel_Interes
ORDER BY Total_Inscripciones DESC