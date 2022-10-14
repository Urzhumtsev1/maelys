{{
  config(
    materialized='incremental',
    unique_key='id'
  )
}}

with source_data as (

   select * from {{ ref('parsed_data_types') }}

)

select 
    "_id" as id, date_time, settlement_id, "type", 
    order_id, sku, description, quantity, 
    case 
      when marketplace is null 
      then 'marketplace unknown' 
      else marketplace 
      end as marketplace, 
    account_type, fulfillment, 
    order_city, order_state, order_postal, 
    tax_collection_model, "product)sales", 
    product_sales_tax, shipping_credits, 
    shipping_credits_tax, gift_wrap_credits, 
    giftwrap_credits_tax, "Regulatory_Fee", 
    "Tax_On_Regulatory_Fee", promotional_rebates, 
    promotional_rebates_tax, marketplace_withheld_tax, 
    selling_fees, fba_fees, other_transaction_fees, 
    other::numeric(10,2), 
    total
from source_data