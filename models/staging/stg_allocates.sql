{{
    config(
        tags=['basic', 'staging']
    )
}}

WITH stageAllocation as (
    select * from {{ ref('prep_allocate')}} 
),
stageProjectAllocation as (
    select 
    email ,
    projectid,
    DATE(allocation_start) AS allocation_start,
    DATE(allocation_end) AS allocation_end
    from stageAllocation
)

select * from stageProjectAllocation    