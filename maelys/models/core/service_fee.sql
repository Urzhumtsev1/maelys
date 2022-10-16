{{
  config(
    materialized='incremental',
    unique_key='id'
  )
}}

with source_data as (

   select id, marketplace 
   from {{ ref('transactions') }}
   where "type" = 'Service Fee'

),
final as (
    select s.*, m.id as marketplace_id 
    from source_data as s
    inner join {{ ref('marketplace') }} as m on m."name" = s.marketplace
)

select 
    s.id,
    s.id as payment_id,
    m.marketplace_id 
from source_data as s
inner join final as m on m.id = s.id