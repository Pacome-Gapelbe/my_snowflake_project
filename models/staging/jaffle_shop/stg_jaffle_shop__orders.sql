{{
  config(
    materialized='incremental',
    unique_key='order_id'

  )
}}
with 

source as (

    select * from {{ source('jaffle_shop', 'orders') }}

),

transformed as (

  select

    id as order_id,
    user_id as customer_id,
    order_date as order_placed_at,
    status as order_status,

    case 
        when status not in ('returned','return_pending') 
        then order_date 
    end as valid_order_date ,
    _ETL_LOADED_AT as update_at_timestamp

  from source
  {% if is_incremental() %}
   where _ETL_LOADED_AT > (select max(update_at_timestamp) from {{this}})

  {% endif %}

)

select * from transformed