{{ config(
    materialized='incremental',
    unique_key='store_id',
    incremental_strategy='merge'
) }}

SELECT
    s.Store_id,
    s.Store_type,
    s.Store_size,
    CASE
        WHEN t.Store_id IS NULL THEN CURRENT_TIMESTAMP
        WHEN (
            t.Store_type != s.Store_type OR
            t.Store_size != s.Store_size
        ) THEN CURRENT_TIMESTAMP
        ELSE t.updated_at
    END AS updated_at
FROM {{ ref('silver_stores') }} s
LEFT JOIN {{ this }} t
    ON s.Store_id = t.Store_id
