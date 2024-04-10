
{{ config(
    materialized='table',
    tags=['mart', 'main']
)}}

WITH dailyHoursWorked AS (
    SELECT
        email,
        AVG((mon + tue + wed + thur + fri + sat + sun)/7) AS avg_hours_worked_per_day
    FROM {{ ref('stg_timesheets') }}
    GROUP BY email
    order by avg_hours_worked_per_day 
)

SELECT
    email,
    avg_hours_worked_per_day
FROM dailyHoursWorked
