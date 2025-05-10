with payment as (
    select * from {{ ref('stg_stripe__payments') }}
)
select
    order_id,
    sum(amount) as payment_amount
from payment
group by 1
having sum(amount) < 0
