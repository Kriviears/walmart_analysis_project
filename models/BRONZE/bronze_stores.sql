{{ config(
    materialized='incremental',
    unique_key='Store_id'
)}}
WITH cleaned AS (
SELECT
    *
FROM {{ref('stg_stores')}}
WHERE Store_id IS NOT NULL
)
SELECT
    *
FROM cleaned