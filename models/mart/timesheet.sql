{{
    config(
        tags=['main','mart']
    )
}}

WITH dailyActivity AS (
    SELECT
        *
    FROM {{ ref('stg_timesheets') }}
),

averageDailyActivity AS (
    SELECT
        UID,
        email,
        AVG(mon + tue + wed + thur + fri + sat + sun) AS avg_daily_activity
    FROM dailyActivity
    GROUP BY UID, email
)

SELECT
    UID,
    email,
    avg_daily_activity
FROM averageDailyActivity
