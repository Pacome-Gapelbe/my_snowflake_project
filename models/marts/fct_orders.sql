{{
config(
    materialized='table'
)

}}

with orders as  (
    select * from {{ ref ('stg_jaffle_shop__orders' )}}
),

payments as (
    select * from {{ ref ('stg_stripe__payments') }}
),

order_payments as (
    select
        order_id,
        sum (case when payment_status = 'success' then payment_amount end) as amount

    from payments
    group by 1
),

 final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_placed_at,
        coalesce (order_payments.amount, 0) as amount,
        orders.update_at_timestamp

    from orders
    left join order_payments using (order_id)
)

select * from final
