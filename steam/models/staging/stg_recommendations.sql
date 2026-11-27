-- Pretypovanie a deduplikacia recenzii
with typed as (
    select
        review_id::bigint            as review_id,
        app_id::integer              as app_id,
        user_id::bigint              as user_id,
        date::date                   as review_date,
        is_recommended::boolean      as is_recommended,
        hours::numeric(10, 1)        as hours,
        helpful::numeric::integer    as helpful_votes,
        funny::numeric::integer      as funny_votes
    from {{ source('bronze', 'recommendations') }}
),

deduplicated as (
    select *, row_number() over (partition by review_id order by review_date desc) as rn
    from typed
)

select
    review_id, app_id, user_id, review_date, is_recommended, hours,
    helpful_votes, funny_votes
from deduplicated
where rn = 1
