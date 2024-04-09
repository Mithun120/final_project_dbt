with events as(
    select * from {{source('final_project_data_engineeering','ALLOCATEPROJECTS')}}
)

select * from events