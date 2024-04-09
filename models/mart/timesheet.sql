{{
    config(
        tags=['main','mart']
    )
}}
-- average daily activity
WITH dailyActivity AS (
    SELECT
        *
    FROM {{ ref('stg_timesheets') }}
),

averageDailyActivity AS (
    SELECT
        UID,
        email,
    start_period,
    end_period,
        AVG(mon + tue + wed + thur + fri + sat + sun) AS avg_daily_activity
    FROM dailyActivity
    GROUP BY UID, email, start_period, end_period
)

SELECT
    UID,
    email,
    start_period,
    end_period,
    avg_daily_activity
FROM averageDailyActivity

