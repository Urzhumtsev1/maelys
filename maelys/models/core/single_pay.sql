{{
  config(
    materialized="incremental",
    unique_key="pay_id||'-'||pay_type"
  )
}}

/* -- Create enum type for pay_type
create type pay_type as enum (
	'product_sales', 'product_sales_tax', 
    'shipping_credits', 'shipping_credits_tax', 
    'gift_wrap_credits', 'giftwrap_credits_tax', 
    'regulatory_fee', 'tax_on_regulatory_fee', 
    'promotional_rebates', 'promotional_rebates_tax', 
    'marketplace_withheld_tax', 'selling_fees', 
    'fba_fees', 'other_transaction_fees', 'other'
)
*/

with source_data as (

    select 
      id as pay_id, product_sales, product_sales_tax, shipping_credits,
      shipping_credits_tax, gift_wrap_credits, giftwrap_credits_tax,
      regulatory_fee, tax_on_regulatory_fee,
      promotional_rebates, promotional_rebates_tax,
      marketplace_withheld_tax, selling_fees,
      fba_fees, other_transaction_fees, other
    from {{ ref('transactions') }}

)
 
select pay_id, product_sales as amount, 'product_sales'::pay_type as pay_type 
from source_data
where product_sales != 0
union
select pay_id, product_sales_tax as amount, 'product_sales_tax'::pay_type as pay_type 
from source_data
where product_sales_tax != 0
union
select pay_id, shipping_credits as amount, 'shipping_credits'::pay_type as pay_type  
from source_data
where shipping_credits != 0
union
select pay_id, shipping_credits_tax as amount, 'shipping_credits_tax'::pay_type as pay_type 
from source_data
where shipping_credits_tax != 0
union
select pay_id, gift_wrap_credits as amount, 'gift_wrap_credits'::pay_type as pay_type  
from source_data
where gift_wrap_credits != 0
union
select pay_id, giftwrap_credits_tax as amount, 'giftwrap_credits_tax'::pay_type as pay_type
from source_data
where giftwrap_credits_tax != 0
union
select pay_id, regulatory_fee as amount, 'regulatory_fee'::pay_type as pay_type 
from source_data
where regulatory_fee != 0
union
select pay_id, tax_on_regulatory_fee as amount, 'tax_on_regulatory_fee'::pay_type as pay_type 
from source_data
where tax_on_regulatory_fee != 0
union
select pay_id, promotional_rebates as amount, 'promotional_rebates'::pay_type as pay_type  
from source_data
where promotional_rebates != 0
union
select pay_id, promotional_rebates_tax as amount, 'promotional_rebates_tax'::pay_type as pay_type  
from source_data
where promotional_rebates_tax != 0
union
select pay_id, marketplace_withheld_tax as amount, 'marketplace_withheld_tax'::pay_type as pay_type  
from source_data
where marketplace_withheld_tax != 0
union
select pay_id, selling_fees as amount, 'selling_fees'::pay_type as pay_type  
from source_data
where selling_fees != 0
union
select pay_id, fba_fees as amount, 'fba_fees'::pay_type as pay_type  
from source_data
where fba_fees != 0
union
select pay_id, other_transaction_fees as amount, 'other_transaction_fees'::pay_type as pay_type  
from source_data
where other_transaction_fees != 0
union
select pay_id, other as amount, 'other'::pay_type as pay_type  
from source_data
where other != 0


