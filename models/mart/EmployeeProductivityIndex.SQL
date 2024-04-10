{{ config(
    tags=['mart', 'main']
)}}

WITH joinedData AS (
    SELECT
        ts.email AS employee_email,
        SUM(ts.mon + ts.tue + ts.wed + ts.thur + ts.fri + ts.sat + ts.sun) AS total_hours_worked,
        pa.allocation_start,
        pa.allocation_end
    FROM {{ ref('stg_timesheets') }} ts
    JOIN {{ ref('stg_allocates') }} pa
    ON ts.projectid = pa.projectid AND ts.email = pa.email
    GROUP BY ts.email, pa.allocation_start, pa.allocation_end
)
SELECT
    employee_email,
    CASE
        WHEN total_hours_worked IS NOT NULL AND (allocation_end - allocation_start) != 0 THEN
            ROUND((total_hours_worked / ((allocation_end - allocation_start) + 1)) * 100, 2)
        ELSE 0
    END AS epi
FROM joinedData
