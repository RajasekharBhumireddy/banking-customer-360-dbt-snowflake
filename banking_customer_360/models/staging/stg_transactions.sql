{{ config(materialized='view') }}

select
    txn_id,
    customer_id,
    txn_date::timestamp as txn_date,
    amount,
    txn_type
from {{ source('staging', 'transactions') }}