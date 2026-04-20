WITH TypesCasted AS (
SELECT
    TRY_TO_NUMBER(Store_id) AS Store_id
    ,TRY_TO_DATE(Date) AS Date
    ,Temperature
    ,ROUND(Fuel_Price, 2) AS Fuel_Price
    ,TRY_TO_DECIMAL(MarkDown1, 9, 2) AS MarkDown1
    ,TRY_TO_DECIMAL(MarkDown2, 9, 2) AS MarkDown2
    ,TRY_TO_DECIMAL(MarkDown3, 9, 2) AS MarkDown3
    ,TRY_TO_DECIMAL(MarkDown4, 9, 2) AS MarkDown4
    ,TRY_TO_DECIMAL(MarkDown5, 9, 2) AS MarkDown5
    ,TRY_TO_DECIMAL(CPI, 12, 9) AS CPI
    ,TRY_TO_DECIMAL(Unemployment, 10, 3) AS Unemployment
    ,TO_BOOLEAN(is_holiday) as is_holiday
FROM {{ ref('bronze_facts') }}
), HandleNulls AS(
SELECT
    Store_id
    ,Date
    ,Temperature
    ,Fuel_Price
    ,CASE WHEN MarkDown1 IS NOT NULL THEN MarkDown1 ELSE 0 END AS MarkDown1
    ,CASE WHEN MarkDown2 IS NOT NULL THEN MarkDown2 ELSE 0 END AS MarkDown2
    ,CASE WHEN MarkDown3 IS NOT NULL THEN MarkDown3 ELSE 0 END AS MarkDown3
    ,CASE WHEN MarkDown4 IS NOT NULL THEN MarkDown4 ELSE 0 END AS MarkDown4
    ,CASE WHEN MarkDown5 IS NOT NULL THEN MarkDown5 ELSE 0 END AS MarkDown5
    ,CPI
    ,Unemployment
    ,CASE WHEN is_holiday = TRUE THEN 1 ELSE 0 END AS is_holiday
FROM TypesCasted
), Weekly_Sales_table AS(
SELECT
    Store_id
    ,Department_id
    ,Date
    ,Weekly_sales AS Store_Weekly_Sales
FROM {{ ref('silver_departments')}}
)
SELECT
    H.Store_id
    ,Department_id
    ,Store_Weekly_Sales
    ,H.Date
    ,Fuel_price
    ,Temperature AS Store_Temperature
    ,Unemployment
    ,CPI
    ,Markdown1
    ,Markdown2
    ,Markdown3
    ,Markdown4
    ,Markdown5
FROM HandleNulls H
Right JOIN Weekly_Sales_table W
    ON H.store_id = W.store_id
    AND H.date = W.date