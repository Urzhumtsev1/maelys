{{
  config(
    materialized='view',
  )
}}

with source_data as (

   select id, order_city, order_state, order_postal 
   from {{ ref('transactions') }}
   where order_city is not null

),
cities as (
  select 
    id, 
    case when order_city is null then 'NO DATA' else upper(order_city) end as order_city, 
    case when order_state is null then 'NO DATA' else upper(order_state) end as order_state,
    case when order_postal is null then 'NO DATA' else upper(order_postal) end as order_postal
  from source_data
)

select * from cities
