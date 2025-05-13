with 

source as (

    select * from {{ source('stripe', 'payment') }}

),

transformed as (

  select

    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    created as payment_created_at,
    status as payment_status,
    {{ cents_to_dollar('amount', 3) }} as payment_amount

  from source

)

select * from transformed