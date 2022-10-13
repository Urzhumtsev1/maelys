{{
  config(
    materialized='incremental',
    unique_key='name'
  )
}}

with source_data as (

   select id, marketplace from {{ ref('transactions') }}

)

select 
   row_number() over() as id, 
   marketplace as "name"
from source_data
group by marketplace

