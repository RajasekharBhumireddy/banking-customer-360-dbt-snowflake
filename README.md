# 🏦 Banking Customer 360 Analytics (dbt + Snowflake)

## 📌 Project Overview

This project builds a **Customer 360 data model** using dbt and Snowflake, integrating multiple data sources like transactions, app usage, and support tickets.

## 🚀 Tech Stack

* Snowflake (Data Warehouse)
* dbt (Data Transformation)
* SQL
* Power BI (Dashboard)

## 📊 Data Model

* **Staging Layer**: Cleaned raw data
* **Marts Layer**: Business-level aggregated model (Customer 360)

## 🔥 Key Features

* Customer segmentation (High / Medium / Low value)
* RFM Metrics (Recency, Frequency, Monetary)
* Churn risk detection
* Engagement score calculation

## ✅ Data Quality

* Implemented dbt tests:

  * Not Null checks
  * Uniqueness constraints

## 📈 Dashboard Insights

* Revenue per customer
* Customer segmentation
* Churn risk distribution

## 📷 Screenshots

(Add screenshots here)

## 🎯 Business Impact

This model enables:

* Targeted marketing
* Customer retention strategies
* Revenue optimization

## 📌 How to Run

```bash
dbt run
dbt test
dbt docs serve
```

