{{
  config(
    materialized='incremental',
    unique_key='id'
  )
}}

with source_data as (

   select id, sku, quantity 
   from {{ ref('transactions') }}

)
-- Better to make distinct SKU model (only 9 positions) without quantity
-- as I did for marketplace model. Made so for simplicity
select 
    id, 
    case when sku is null then 'NO DATA' else upper(sku) end as "name", 
    quantity 
from source_data
