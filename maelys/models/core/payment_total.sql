{{
  config(
    materialized='view',
  )
}}

with source_data as (

   select * from {{ ref('single_pay') }}

)

select pay_id, sum(amount) as total
from source_data
group by pay_id 
order by pay_id 


