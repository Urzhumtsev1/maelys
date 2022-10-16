{{
  config(
    materialized='incremental',
    unique_key='id'
  )
}}

with source_data as (

   select id, date_time, settlement_id, "description", account_type 
   from {{ ref('transactions') }}

)

select * from source_data
