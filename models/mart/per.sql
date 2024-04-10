WITH project_hours AS (
    SELECT
        p.projectId,
        SUM(t.mon + t.tue + t.wed + t.thur + t.fri + t.sat + t.sun) AS total_hours
    FROM
        {{ ref('stg_projects') }} p
    JOIN
        timesheets t ON p.projectId = t.projectId
    GROUP BY
        p.projectId
),
project_duration AS (
    SELECT
        projectId,
        DATEDIFF(day, MIN(startDate), MAX(endDate)) AS duration_days
    FROM
        {{ ref('stg_projects') }}
    GROUP BY
        projectId
)
SELECT
    p.projectName,
    p.startDate,
    p.endDate,
    ph.total_hours / pd.duration_days AS project_efficiency_ratio
FROM
    {{ ref('stg_projects') }} p
JOIN
    project_hours ph ON p.projectId = ph.projectId
JOIN
    project_duration pd ON p.projectId = pd.projectId
