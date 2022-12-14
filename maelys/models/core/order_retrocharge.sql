{{
  config(
    materialized='incremental',
    unique_key='order_id'
  )
}}

with source_data as (

   select * from {{ ref('transactions') }} where "type" = 'Order_Retrocharge'

),
marketplace_pre_selection as (
    select s.id, s.marketplace, m.id as marketplace_id 
    from source_data as s
    inner join {{ ref('marketplace') }} as m on m."name" = s.marketplace
)

select 
    s.id as id,
    s.order_id,
    m.marketplace_id,
    s.id as payment_id
from source_data as s
inner join marketplace_pre_selection as m on m.id = s.id


