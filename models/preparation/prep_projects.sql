with events as(
    select * from {{source('final_project_data_engineeering','PROJECTS')}}
)

select * from events