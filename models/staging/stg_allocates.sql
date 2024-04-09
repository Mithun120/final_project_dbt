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
    allocation_start,
    allocation_end
    from stageAllocation
)

select * from stageProjectAllocation    