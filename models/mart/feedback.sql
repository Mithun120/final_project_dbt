
{{ config(
    materialized='table',
    tags=['mart', 'mart']
)}}

--average rating in feedback like for the project how the employee is getting satisfied

WITH cleanedFeedback AS (
    SELECT
        *
    FROM {{ ref('stg_feedbacks') }}
),

kpi AS (
    SELECT
        email,
        q1,
        q2,
        q3,
        q4,
        q5,
        q6,
        comments,
        start_period,
        end_period,
        {{ feedback_kpi('q1', 'q2', 'q3', 'q4', 'q5', 'q6') }} AS meetKpi
    FROM cleanedFeedback
)

SELECT
    *
FROM kpi
