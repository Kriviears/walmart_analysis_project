SELECT
    Store as Store_id
    ,Date
    ,Temperature
    ,Fuel_Price as Fuel_price
    ,MarkDown1
    ,MarkDown2
    ,MarkDown3
    ,MarkDown4
    ,MarkDown5
    ,CPI
    ,Unemployment
    ,IsHoliday as is_holiday
FROM {{ source('walmart_data', 'FACT_SOURCE') }}