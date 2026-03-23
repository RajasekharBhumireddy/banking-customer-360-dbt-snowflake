{{ config(materialized='view') }}

select
    customer_id,
    name,
    age,
    gender,
    city,
    signup_date::date as signup_date
from {{ source('staging', 'customers') }}