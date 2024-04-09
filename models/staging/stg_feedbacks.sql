{{
    config(
        tags=['basic', 'staging']
    )
}}

WITH stageFeedback as (
    select * from {{ ref('prep_feedbacks')}}
),
stageFeedbacks as (
    select  
        email ,
        TRY_CAST (q1 as int) as q1,
        TRY_CAST (q2 as int) as q2,
        TRY_CAST (q3 as int) as q3,
        TRY_CAST (q4 as int) as q4,
        TRY_CAST (q5 as int) as q5,
        TRY_CAST (q6 as int) as q6,
        comments ,
        CASE 
            WHEN start_period IS NOT NULL AND start_period != '' THEN DATE(start_period) 
        END AS start_period,
        CASE 
            WHEN end_period IS NOT NULL AND end_period != '' THEN DATE(end_period) 
        END AS end_period,
        CASE 
            WHEN start_period IS NULL OR start_period = '' THEN 'Feedback not filled' 
            WHEN end_period IS NULL OR end_period = '' THEN 'Feedback not filled'
            ELSE NULL
        END AS feedback_status
    from stageFeedback
)

select * from stageFeedbacks 

