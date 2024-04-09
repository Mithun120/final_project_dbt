
{% macro feedback_kpi(q1, q2, q3, q4, q5, q6) %}
    CASE 
        WHEN {{ q1 }} > 3 AND {{ q2 }} > 3 AND {{ q3 }} > 3 AND {{ q4 }} > 3 AND {{ q5 }} > 3 AND {{ q6 }} > 3 THEN 'Met KPI'
        ELSE 'Did not meet KPI'
    END
{% endmacro %}
