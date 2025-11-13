Customer Analytics SQL Project

This project showcases end-to-end SQL analytics using realistic SaaS company datasets. It includes customer profiles, product usage activity, subscription lifecycle data, and support tickets. The goal is to demonstrate practical SQL skills in data modeling, analysis, and deriving business insights such as churn risk, product adoption, and support trends.

📁 Project Structure
project-root/
│
├── data/
│   ├── customers.csv
│   ├── product_usage.csv
│   ├── subscriptions.csv
│   └── support_tickets.csv
│
├── sql/
│   └── 01_tables.sql
│
└── README.md

🧱 Dataset Overview
1. customers.csv
Customer details
Columns: customer_id, company_name, industry, signup_date, region

2. product_usage.csv
Daily usage metrics
Columns: usage_id, customer_id, product_module, usage_date, active_users, errors, minutes_used

3. support_tickets.csv
Customer support interactions
Columns: ticket_id, customer_id, issue_type, created_at, resolved_at, resolution_time_hrs, status

4. subscriptions.csv
Subscription lifecycle data
Columns: customer_id, start_date, end_date, plan_type, monthly_fee, is_active

🗄️ SQL Components

The 01_tables.sql script includes:

✔️ Table Creation
Customers
Product Usage
Support Tickets
Subscriptions
All relationships are defined with foreign keys.

✔️ Analytical SQL Queries
Top product modules by industry
Most common support issues + average resolution time
Churn-risk identification using usage drop-off
Support load by region
Aggregations, joins, CTEs, and business-focused KPIs

📊 Key Insights Generated
Using SQL analytics, this project answers important business questions:
Which industries use the product most actively?
Which product modules have the highest adoption?
What support issues create the highest load?
How fast are customer queries resolved?
Which customers are at high churn risk due to usage decline?
These analyses mimic real SaaS company workflows for customer success and product teams.
