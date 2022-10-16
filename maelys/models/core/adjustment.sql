{{
  config(
    materialized='incremental',
    unique_key='id'
  )
}}

with source_data as (

   select id, order_id 
   from {{ ref('transactions') }}
   where "type" = 'Adjustment'

)

select 
    id,
    case when order_id is null then 'NO DATA' else order_id end as order_id,
    id as payment_id,
    id as sku_id
from source_data
