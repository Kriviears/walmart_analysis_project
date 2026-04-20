WITH TypesCasted AS(
SELECT
    TRY_TO_NUMBER(Store_id) AS Store_id,
    TO_VARCHAR(Store_type) AS Store_type,
    TRY_TO_NUMBER(Store_size) AS Store_size
FROM {{ ref('bronze_stores')}}
)
SELECT
    *
    ,current_timestamp AS Insert_date
FROM  TypesCasted
WHERE Store_id IS NOT NULL
    AND Store_type IS NOT NULL
    AND Store_size IS NOT NULL