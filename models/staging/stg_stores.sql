SELECT
    Store as Store_id
    ,Type as Store_type
    ,Size as Store_size
from
    {{ source('walmart_data', 'STORES_SOURCE') }}