{{ config(materialized='view') }}

select
    ticket_id,
    customer_id,
    issue_type,
    created_at::timestamp as created_at
from {{ source('staging', 'support_tickets') }}