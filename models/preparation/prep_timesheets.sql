with events as(
    select * from {{source('final_project_data_engineeering','TIMESHEETS')}}
)

select * from events