{{ config(materialized='view') }}

select
    event_id,
    customer_id,
    event_type,
    event_time::timestamp as event_time
from {{ source('staging', 'app_events') }}