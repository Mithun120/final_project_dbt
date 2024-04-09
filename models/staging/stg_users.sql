{{
    config(
        tags=['basic', 'staging']
    )
}}

WITH stageData as (
    select * from {{ ref('prep_users')}}
),
stageUsers as (
    select 
    name as name  ,
    email,
    usertype,
    role
    from stageData
)

select * from stageUsers