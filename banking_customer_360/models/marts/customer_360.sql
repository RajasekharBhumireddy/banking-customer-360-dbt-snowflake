{{ config(materialized='table') }}

with customers as (

    select * from {{ ref('stg_customers') }}

),

transactions as (

    select * from {{ ref('stg_transactions') }}

),

app_events as (

    select * from {{ ref('stg_app_events') }}

),

support_tickets as (

    select * from {{ ref('stg_support_tickets') }}

),

-- 💰 Transaction Aggregation
txn_agg as (

    select
        customer_id,
        count(*) as total_transactions,
        sum(amount) as total_spent,
        avg(amount) as avg_transaction_value,
        max(txn_date) as last_transaction_date
    from transactions
    group by customer_id

),

-- 📱 App Usage Aggregation
app_agg as (

    select
        customer_id,
        count(*) as total_app_events,
        count(distinct event_type) as unique_event_types
    from app_events
    group by customer_id

),

-- 🎫 Support Aggregation
support_agg as (

    select
        customer_id,
        count(*) as total_tickets
    from support_tickets
    group by customer_id

)

-- 🧩 Final Customer 360
select

    c.customer_id,
    c.name,
    c.city,
    c.signup_date,

    -- Transactions
    coalesce(t.total_transactions, 0) as total_transactions,
    coalesce(t.total_spent, 0) as total_spent,
    coalesce(t.avg_transaction_value, 0) as avg_transaction_value,
    t.last_transaction_date,

    -- 📅 Recency (IMPORTANT KPI)
    datediff(day, t.last_transaction_date, current_date) as recency_days,

    -- 📊 App usage
    coalesce(a.total_app_events, 0) as total_app_events,
    coalesce(a.unique_event_types, 0) as unique_event_types,

    -- 🎫 Support
    coalesce(s.total_tickets, 0) as total_tickets,

    -- 💰 Customer Segmentation
    case 
        when t.total_spent > 10000 then 'High Value'
        when t.total_spent > 5000 then 'Medium Value'
        else 'Low Value'
    end as customer_segment,

    -- 🚨 Churn Risk
    case
        when datediff(day, t.last_transaction_date, current_date) > 90 then 'High Risk'
        when datediff(day, t.last_transaction_date, current_date) > 30 then 'Medium Risk'
        else 'Low Risk'
    end as churn_risk,

    -- 📱 Engagement Score
    (
        coalesce(a.total_app_events, 0) * 0.4 +
        coalesce(t.total_transactions, 0) * 0.4 +
        coalesce(s.total_tickets, 0) * -0.2
    ) as engagement_score

from customers c
left join txn_agg t on c.customer_id = t.customer_id
left join app_agg a on c.customer_id = a.customer_id
left join support_agg s on c.customer_id = s.customer_id