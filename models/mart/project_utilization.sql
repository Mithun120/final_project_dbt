{{ config(
    tags=['mart', 'kpi']
)}}

WITH ProjectUtilization AS (
    SELECT
        projectId,
        COUNT(DISTINCT email) AS uniqueEmployees,
        DATEDIFF('day', MIN(start_period), MAX(end_period)) AS totalDays,
        COUNT(*) AS totalEntries
    FROM {{ ref('stg_timesheets') }}
    WHERE visible = true  
    GROUP BY projectId
)

SELECT
    p.projectId,
    p.projectName,
    p.startDate,
    p.endDate,
    pu.uniqueEmployees,
    pu.totalDays,
    pu.totalEntries,
    CASE
        WHEN pu.totalDays > 0 THEN (CAST(pu.totalEntries AS float) / pu.totalDays) * 100
        ELSE 0
    END AS utilizationRate
FROM ProjectUtilization pu
JOIN {{ ref('stg_projects') }} p
ON pu.projectId = p.projectId
ORDER BY utilizationRate DESC
