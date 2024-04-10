SELECT
    u.NAME,
    u.EMAIL,
    u.USERTYPE,
    u.ROLE,
    p.projectName AS PROJECT_NAME,
    p.projectId,
    p.startDate AS PROJECT_start_period,
    p.enddate AS PROJECT_end_period,
    p.CATEGORY,
    ap.ALLOCATION_START,
    ap.ALLOCATION_END,
    t.start_period,
    t.end_period,
    t.ACTIVITY,
    t.COMMENTS,
    t.MON,
    t.TUE,
    t.WED,
    t.THUR,
    t.FRI,
    t.SAT,
    t.SUN,
    f.START_PERIOD AS FEEDBACK_START_PERIOD,
    f.END_PERIOD AS FEEDBACK_END_PERIOD,
    f.Q1,
    f.Q2,
    f.Q3,
    f.Q4,
    f.Q5,
    f.Q6,
    f.COMMENTS AS FEEDBACK_COMMENTS
FROM
    {{ref("stg_users")}} u
JOIN
    {{ref("stg_allocates")}} ap ON u.EMAIL = ap.EMAIL
JOIN
    {{ref("stg_projects")}} p ON ap.projectId = p.projectId
LEFT JOIN
    {{ref("stg_timesheets")}} t ON p.projectId = t.projectId
LEFT JOIN
    {{ref("stg_feedbacks")}} f ON u.EMAIL = f.EMAIL
ORDER BY
    u.EMAIL, p.projectId, t.start_period, f.START_PERIOD

