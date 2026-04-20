{{ config(
    materialized='incremental',
    unique_key='Date_id',
    incremental_strategy='merge'
)}}
SELECT
    s.Date_id
    ,s.Store_date
    ,s.is_holiday
{% if is_incremental()%}
    ,COALESCE(s.Insert_date, CURRENT_TIMESTAMP) AS Insert_date
    ,CASE
        WHEN t.Date_id IS NULL THEN CURRENT_TIMESTAMP
        WHEN t.is_holiday != s.is_holiday THEN CURRENT_TIMESTAMP
        ELSE s.Insert_date
    END AS Update_date
{% endif %}
FROM {{ ref('silver_dates') }} s
{% if is_incremental()%}
LEFT JOIN {{ this }} t
    ON s.Date_id = t.Date_id
{% endif %}