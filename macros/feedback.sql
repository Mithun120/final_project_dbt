
{% macro feedback_kpi(q1, q2, q3, q4, q5, q6) %}
    CASE 
        WHEN {{ q1 }} > 1 AND {{ q2 }} > 1 AND {{ q3 }} > 1 AND {{ q4 }} > 1 AND {{ q5 }} > 1 AND {{ q6 }} > 1 THEN 'Met KPI'
        ELSE 'Did not meet KPI'
    END
{% endmacro %}
