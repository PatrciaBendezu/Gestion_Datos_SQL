USE UCDATASCIENCE

--******************************************************
--KPIS
--******************************************************

-- 1. Tasa de Conversión de Prospectos a Inscritos
SELECT 
    p.Periodo, 
    COUNT(DISTINCT i.Id_Prospecto) as total_prospectos,
    COUNT(DISTINCT ins.Id_Inscripcion) as total_inscritos,
    CAST(COUNT(DISTINCT ins.Id_Inscripcion) * 100.0 / COUNT(DISTINCT i.Id_Prospecto) AS DECIMAL(5,2)) as tasa_conversion
FROM G1.INTERES i
JOIN G1.PERIODOS p ON i.Id_Periodo = p.id_periodo
LEFT JOIN G1.INSCRIPCIONES ins ON i.Id_Interes = ins.Id_interes
GROUP BY p.id_periodo, p.Periodo
ORDER BY p.id_periodo;

-- 2. Efectividad de Modalidades de Admisión
SELECT 
    ma.Mod_Admision,
    COUNT(DISTINCT e.Id_Evaluacion) as total_evaluaciones,
    COUNT(DISTINCT CASE WHEN e.Ingresante = 'SI' THEN e.Id_Evaluacion END) as total_ingresantes,
    CAST(COUNT(DISTINCT CASE WHEN e.Ingresante = 'SI' THEN e.Id_Evaluacion END) * 100.0 / 
         COUNT(DISTINCT e.Id_Evaluacion) AS DECIMAL(5,2)) as tasa_exito
FROM G1.MOD_ADMISION ma
JOIN G1.INTERES i ON ma.id_Mod_Admision = i.Id_Mod_Admision
JOIN G1.INSCRIPCIONES ins ON i.Id_Interes = ins.Id_interes
JOIN G1.EVALUACIONES e ON ins.Id_Inscripcion = e.Id_Inscripcion
GROUP BY ma.Mod_Admision
ORDER BY tasa_exito DESC;

-- 3. Análisis de Demanda por Carrera y Sede
SELECT 
    c.Carrera,
    s.Sede,
    COUNT(DISTINCT i.Id_Interes) as total_interesados,
    COUNT(DISTINCT ins.Id_Inscripcion) as total_inscritos,
    ISNULL(ROUND(AVG(e.Puntaje),2),0) as promedio_puntaje
FROM G1.CARRERAS c
JOIN G1.INTERES i ON c.Id_Carrera = i.Id_Carrera
JOIN G1.SEDES s ON i.Id_Sede = s.id_Sede
LEFT JOIN G1.INSCRIPCIONES ins ON i.Id_Interes = ins.Id_interes
LEFT JOIN G1.EVALUACIONES e ON ins.Id_Inscripcion = e.Id_Inscripcion
GROUP BY c.Carrera, s.Sede
ORDER BY total_interesados DESC;

-- 4. Análisis Financiero de Inscripciones
SELECT 
    DATEPART(MONTH, p.Fecha_Pago) as mes,
    COUNT(DISTINCT p.Id_Inscripcion) as total_pagos,
    SUM(p.Abono) as total_ingresos,
    AVG(p.Descuento) as promedio_descuento,
    SUM(p.Deuda) as deuda_pendiente
FROM G1.PAGOS p
GROUP BY DATEPART(MONTH, p.Fecha_Pago)
ORDER BY mes;

-- 5. Eficiencia del Proceso de Inscripción
SELECT 
    AVG(DATEDIFF(DAY, i.Fecha_Inscripcion, e.Fecha_Evaluacion)) as promedio_dias_hasta_evaluacion,
    AVG(DATEDIFF(DAY, i.Fecha_Inscripcion, p.Fecha_Pago)) as promedio_dias_hasta_pago
FROM G1.INSCRIPCIONES i
LEFT JOIN G1.EVALUACIONES e ON i.Id_Inscripcion = e.Id_Inscripcion
LEFT JOIN G1.PAGOS p ON i.Id_Inscripcion = p.Id_Inscripcion;

-- 6. Distribución Geográfica de Prospectos
SELECT 
    p.Departamento,
    p.Provincia,
    COUNT(DISTINCT p.id_Prospecto) as total_prospectos,
    COUNT(DISTINCT i.Id_Inscripcion) as convertidos_inscritos,
    CAST(COUNT(DISTINCT i.Id_Inscripcion) * 100.0 / 
         COUNT(DISTINCT p.id_Prospecto) AS DECIMAL(5,2)) as tasa_conversion_regional
FROM G1.PROSPECTOS p
LEFT JOIN G1.INTERES int ON p.id_Prospecto = int.Id_Prospecto
LEFT JOIN G1.INSCRIPCIONES i ON int.Id_Interes = i.Id_interes
GROUP BY p.Departamento, p.Provincia
ORDER BY total_prospectos DESC;

-- 7. Rendimiento por Turnos y Secciones
SELECT 
    s.Turno,
    s.Seccion,
    COUNT(DISTINCT e.Id_Evaluacion) as total_evaluaciones,
    ROUND(AVG(e.Puntaje),2) as promedio_puntaje,
    COUNT(DISTINCT CASE WHEN e.Ingresante = 'SI' THEN e.Id_Evaluacion END) as total_ingresantes
FROM G1.SECCIONES s
JOIN G1.EVALUACIONES e ON s.Id_Seccion = e.Id_Seccion
GROUP BY s.Turno, s.Seccion
ORDER BY promedio_puntaje DESC;

-- 8. Análisis de Nivel de Interés y Conversión
SELECT 
    ni.Nivel_Interes,
    COUNT(DISTINCT i.Id_Interes) as total_interesados,
    COUNT(DISTINCT ins.Id_Inscripcion) as convertidos,
    ROUND(AVG(e.Puntaje),2) as promedio_puntaje_evaluacion,
    CAST(COUNT(DISTINCT ins.Id_Inscripcion) * 100.0 / 
         COUNT(DISTINCT i.Id_Interes) AS DECIMAL(5,2)) as tasa_conversion
FROM G1.NIVEL_INTERES ni
JOIN G1.INTERES i ON ni.id_Nivel_Interes = i.Id_Nivel_Interes
LEFT JOIN G1.INSCRIPCIONES ins ON i.Id_Interes = ins.Id_interes
LEFT JOIN G1.EVALUACIONES e ON ins.Id_Inscripcion = e.Id_Inscripcion
GROUP BY ni.Nivel_Interes
ORDER BY tasa_conversion DESC;

-- 9. Efectividad de Modalidad de Estudios
SELECT 
    me.Mod_Estudio,
    COUNT(DISTINCT i.Id_Interes) as total_interesados,
    COUNT(DISTINCT ins.Id_Inscripcion) as total_inscritos,
    COUNT(DISTINCT CASE WHEN e.Ingresante = 'SI' THEN e.Id_Evaluacion END) as total_ingresantes,
    AVG(p.Abono) as promedio_pago
FROM G1.MOD_ESTUDIOS me
JOIN G1.INTERES i ON me.id_Mod_Estudio = i.Id_Mod_Estudio
LEFT JOIN G1.INSCRIPCIONES ins ON i.Id_Interes = ins.Id_interes
LEFT JOIN G1.EVALUACIONES e ON ins.Id_Inscripcion = e.Id_Inscripcion
LEFT JOIN G1.PAGOS p ON ins.Id_Inscripcion = p.Id_Inscripcion
GROUP BY me.Mod_Estudio;

-- 10. Análisis de Perfil Demográfico
SELECT 
    p.Genero,
    p.Estado_Civil,
    DATEDIFF(YEAR, p.Fecha_Nacimiento, GETDATE()) as rango_edad,
    COUNT(DISTINCT p.id_Prospecto) as total_prospectos,
    COUNT(DISTINCT CASE WHEN e.Ingresante = 'SI' THEN e.Id_Evaluacion END) as total_ingresantes,
    ROUND(AVG(e.Puntaje),2) as promedio_puntaje
FROM G1.PROSPECTOS p
JOIN G1.INTERES i ON p.id_Prospecto = i.Id_Prospecto
LEFT JOIN G1.INSCRIPCIONES ins ON i.Id_Interes = ins.Id_interes
LEFT JOIN G1.EVALUACIONES e ON ins.Id_Inscripcion = e.Id_Inscripcion
GROUP BY p.Genero, p.Estado_Civil, DATEDIFF(YEAR, p.Fecha_Nacimiento, GETDATE())
ORDER BY total_prospectos DESC;