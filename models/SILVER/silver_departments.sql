WITH TypesCasted AS (
SELECT
    TRY_TO_NUMBER(Store_id) Store_id,
    TRY_TO_NUMBER(Department_id) AS Department_id,
    TRY_TO_DATE(Date) AS Date,
    weekly_sales,
    TO_BOOLEAN(is_holiday) AS is_holiday
FROM {{ref('bronze_departments')}}
    WHERE Store_id IS NOT NULL
        AND Department_id IS NOT NULL
        AND Date IS NOT NULL
        AND Weekly_Sales IS NOT NULL
)
SELECT
    Store_id
    ,Department_id
    ,Date
    ,weekly_sales
    ,CASE
        WHEN is_holiday = TRUE THEN 1
        ELSE 0 END
    AS is_holiday
FROM TypesCasted