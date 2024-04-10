{{ config(
    materialized='table',
    tags=['main', 'mart']
)}}
with 
stg_feedbacks AS (
    SELECT
        *
    FROM {{ ref('stg_feedbacks') }}
),
stg_users as (
     SELECT
        *
    FROM {{ ref('stg_users') }}
),
merge as (
    select a.email,a.role,b.Q1 from stg_users a right join stg_feedbacks b on a.email=b.email
),
final as (
    select role as Role,count(Q1) as Feedback_Count from merge group by role
)
select * from final