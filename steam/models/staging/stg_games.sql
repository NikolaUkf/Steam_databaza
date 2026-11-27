-- Pretypovanie, cistenie textu a deduplikacia hier
with source as (
    select * from {{ source('bronze', 'games') }}
),

typed as (
    select
        app_id::integer                        as app_id,
        nullif(trim(title), '')                as title,
        nullif(date_release, '')::date         as release_date,
        win::boolean                           as is_windows,
        mac::boolean                           as is_mac,
        linux::boolean                         as is_linux,
        steam_deck::boolean                    as is_steam_deck,
        nullif(trim(rating), '')               as rating,
        positive_ratio::numeric::integer       as positive_ratio,
        user_reviews::numeric::integer         as total_user_reviews,
        price_final::numeric(10, 2)            as price_final,
        price_original::numeric(10, 2)         as price_original,
        discount::numeric(5, 2)                as discount
    from source
),

deduplicated as (
    select *, row_number() over (partition by app_id order by release_date desc) as rn
    from typed
)

select
    app_id, title, release_date, is_windows, is_mac, is_linux, is_steam_deck,
    rating, positive_ratio, total_user_reviews, price_final, price_original, discount
from deduplicated
where rn = 1
