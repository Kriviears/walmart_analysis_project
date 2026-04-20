SELECT
    {{ dbt_utils.generate_surrogate_key(['store_id', 'department_id', 'date']) }} AS Date_id
    ,Date AS Store_date
    ,is_holiday
    ,CURRENT_TIMESTAMP AS Insert_date
FROM {{ ref('silver_departments') }}