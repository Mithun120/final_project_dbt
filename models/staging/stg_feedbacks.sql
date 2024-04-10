{{ config(
    tags=['basic', 'staging']
)}}

WITH stageFeedback AS (
    SELECT * FROM {{ ref('prep_feedbacks') }}
),
stageFeedbacks AS (
    SELECT  
        email,
        TRY_CAST(q1 AS int) AS q1,
        TRY_CAST(q2 AS int) AS q2,
        TRY_CAST(q3 AS int) AS q3,
        TRY_CAST(q4 AS int) AS q4,
        TRY_CAST(q5 AS int) AS q5,
        TRY_CAST(q6 AS int) AS q6,
        comments,
        CASE 
            WHEN start_period IS NOT NULL AND start_period != '' THEN DATE(start_period) 
        END AS start_period,
        CASE 
            WHEN end_period IS NOT NULL AND end_period != '' THEN DATE(end_period) 
        END AS end_period
    FROM stageFeedback
)

SELECT * FROM stageFeedbacks
