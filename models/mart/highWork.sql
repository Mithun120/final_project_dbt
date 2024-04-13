{{ config(
    materialized='table',
    tags=['mart', 'main']
)}}

WITH employeeHours AS (
    SELECT
        ts.email,
        SUM(ts.mon + ts.tue + ts.wed + ts.thur + ts.fri + ts.sat + ts.sun) AS total_hours_worked
    FROM
        {{ ref('stg_timesheets') }} ts
    GROUP BY
        ts.email
)
SELECT
    eh.email,
    u.role,
    eh.total_hours_worked
FROM
    employeeHours eh
JOIN
    {{ ref('stg_users') }} u ON eh.email = u.email
ORDER BY
    eh.total_hours_worked DESC
