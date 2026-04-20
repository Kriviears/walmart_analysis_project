SELECT
    f.Store_id
    ,f.Department_id
    ,d.fuel_price
    ,f.Store_Temperature
    ,d.unemployment
    ,f.CPI    
FROM {{ ref('silver_facts') }} f
JOIN {{ ref('store_snapshot') }} d
  ON f.store_id = d.store_id
 AND f.date BETWEEN d.dbt_valid_from
               AND COALESCE(d.dbt_valid_to, '9999-12-31')