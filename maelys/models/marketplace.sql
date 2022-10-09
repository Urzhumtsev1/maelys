{{ config(materialized='incremental') }}

with source_data as (

   select "_id", marketplace from {{ ref('parsed_data_types') }}

)

select "_id" as id, marketplace as "name" from source_data

