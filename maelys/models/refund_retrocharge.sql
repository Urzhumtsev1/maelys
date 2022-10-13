{{ config(materialized='table') }}

with source_data as (

   select * from {{ ref('parsed_data_types') }}

)
-- too much to do
-- checkpoint: first create stage tables for Marketplace, Payment
select 
    order_id,
    "_id" as marketplace_id,
    1 as payment_id
from source_data


