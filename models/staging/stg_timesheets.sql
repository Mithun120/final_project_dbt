{{
    config(
        tags=['basic', 'staging']
    )
}}

WITH stageTimesheet
 as (
    select * from {{ ref('prep_timesheets')}}
),
stageTimesheets as (
    select  
    UID,
    email,
    projectid,
    activity,
    comments,
    DATE(start_period) as start_period,
    DATE(end_period) AS end_period,
    TRY_CAST (mon as int) as mon,
    TRY_CAST (tue as int) as tue,
    TRY_CAST (wed as int) as wed,
    TRY_CAST (thur as int) as thur,
    TRY_CAST (fri as int) as fri,
    TRY_CAST (sat as int) as sat,
    TRY_CAST (sun as int) as sun
    from stageTimesheet

)

select * from stageTimesheets