{{
    config(
        tags=['basic', 'staging']
    )
}}

WITH stageProject as (
    select * from {{ ref('prep_projects')}}
),
stageProjects as (
    select 
    projectname  ,
    projectid,
    startdate,
    enddate
    from stageProject
)

select * from stageProjects