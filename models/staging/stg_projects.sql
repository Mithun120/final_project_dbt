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
    category,
    DATE(startdate) AS startdate,
        DATE(enddate) AS enddate
    from stageProject
)

select * from stageProjects