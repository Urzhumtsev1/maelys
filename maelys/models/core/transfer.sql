{{
  config(
    materialized='incremental',
    unique_key='id'
  )
}}

with source_data as (

   select id 
   from {{ ref('transactions') }}
   where "type" = 'Transfer'

)

select 
    id,
    id as payment_id
from source_data