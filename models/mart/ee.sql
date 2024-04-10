-- employee_engagement

WITH satisfaction_scores AS (
    SELECT
        u.role,
        (f.q1 + f.q2 + f.q3 + f.q4 + f.q5 + f.q6) AS total_satisfaction,
        CASE
            WHEN (f.q1 + f.q2 + f.q3 + f.q4 + f.q5 + f.q6) > 0 THEN true
            ELSE false
        END AS filled_feedback
    FROM {{ ref('stg_feedbacks') }} f
    JOIN {{ ref('stg_users') }} u
    ON f.email = u.email
),

employee_engagement_score AS (
    SELECT
        role,
        AVG(total_satisfaction) / COUNT(*) AS score
    FROM satisfaction_scores
    WHERE filled_feedback = true
    GROUP BY role
)

SELECT * FROM employee_engagement_score
