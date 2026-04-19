SELECT
    Store as Store_id
    ,Dept as Department_id
    ,Date
    ,Weekly_Sales as weekly_sales
    ,IsHoliday as is_holiday
FROM {{ source('walmart_data', 'DEPARTMENT_SOURCE') }}