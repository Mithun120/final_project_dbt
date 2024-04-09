{{ config(
    materialized='table',
    tags=['mart', 'mart']
)}}

WITH 
cleanedFeedback AS (
    SELECT
        *
    FROM {{ ref('stg_feedbacks') }}
),
users as (
     SELECT
        *
    FROM {{ ref('stg_users') }}
),
merge as (
    select b.name,a.email,
        CASE 
            WHEN a.feedback_status = 'Feedback not filled' THEN 1  -- You can use 1 or any other value as per your requirement
            ELSE 0
        END AS feedback_not_filled
    from stg_feedbacks a 
    left join stg_users b on a.email = b.email
),
feedback_count as (
    select name, count(feedback_not_filled) as feedback_not_filled_count 
    from merge 
    group by name 
    having sum(feedback_not_filled) > 0  -- Filter for feedbacks that are not filled
)
select * from feedback_count
