-- Pretypovanie a deduplikacia pouzivatelov
with typed as (
    select
        user_id::bigint              as user_id,
        products::numeric::integer   as products_owned,
        reviews::numeric::integer    as reviews_written
    from {{ source('bronze', 'users') }}
),

deduplicated as (
    select *, row_number() over (partition by user_id order by reviews_written desc) as rn
    from typed
)

select user_id, products_owned, reviews_written
from deduplicated
where rn = 1
