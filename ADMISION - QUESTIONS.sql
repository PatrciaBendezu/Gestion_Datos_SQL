USE UCDATASCIENCE

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