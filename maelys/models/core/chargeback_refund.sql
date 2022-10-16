{{
  config(
    materialized='incremental',
    unique_key='id'
  )
}}

with source_data as (

   select id, order_id, fulfillment, tax_collection_model, marketplace 
   from {{ ref('transactions') }}
   where "type" = 'Chargeback Refund'

),
final as (
    select s.*, m.id as marketplace_id 
    from source_data as s
    inner join {{ ref('marketplace') }} as m on m."name" = s.marketplace
)

select 
    s.id, s.order_id, s.fulfillment, s.tax_collection_model,
    s.id as sku_id,
    s.id as city_id,
    s.id as payment_id,
    m.marketplace_id 
from source_data as s
inner join final as m on m.id = s.id