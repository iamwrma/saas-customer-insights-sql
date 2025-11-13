-- 1. Customers
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  company_name VARCHAR(100),
  industry VARCHAR(50),
  signup_date DATE,
  region VARCHAR(50)
);

-- 2. Product Usage
CREATE TABLE product_usage (
  usage_id INT PRIMARY KEY,
  customer_id INT,
  product_module VARCHAR(50),
  usage_date DATE,
  active_users INT,
  errors INT,
  minutes_used INT,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 3. Support Tickets
CREATE TABLE support_tickets (
  ticket_id INT PRIMARY KEY,
  customer_id INT,
  issue_type VARCHAR(50),
  created_at DATE,
  resolved_at DATE,
  resolution_time_hrs INT,
  status VARCHAR(20),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 4. Subscriptions
CREATE TABLE subscriptions (
  customer_id INT,
  start_date DATE,
  end_date DATE,
  plan_type VARCHAR(20),
  monthly_fee DECIMAL(10,2),
  is_active BOOLEAN,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

 -- Top-used product modules by industry
 SELECT
  c.industry,
  pu.product_module,
  SUM(pu.active_users) AS total_users
FROM product_usage pu
JOIN customers c ON pu.customer_id = c.customer_id
GROUP BY c.industry, pu.product_module
ORDER BY c.industry, total_users DESC;

-- Top issue types and average resolution time
SELECT
  issue_type,
  COUNT(*) AS ticket_count,
  AVG(resolution_time_hrs) AS avg_resolution_hrs
FROM support_tickets
GROUP BY issue_type
ORDER BY ticket_count DESC;

-- Identify churn-risk customers (usage drop-off)
WITH recent_usage AS (
  SELECT
    customer_id,
    AVG(active_users) AS avg_last_30d
  FROM product_usage
  WHERE usage_date >= CURRENT_DATE - INTERVAL '30' DAY
  GROUP BY customer_id
),
prev_usage AS (
  SELECT
    customer_id,
    AVG(active_users) AS avg_prev_30d
  FROM product_usage
  WHERE usage_date BETWEEN CURRENT_DATE - INTERVAL '60' DAY
                        AND CURRENT_DATE - INTERVAL '31' DAY
  GROUP BY customer_id
)
SELECT
  r.customer_id,
  p.avg_prev_30d,
  r.avg_last_30d,
  CASE
    WHEN r.avg_last_30d < p.avg_prev_30d * 0.6 THEN 'High Risk'
    WHEN r.avg_last_30d < p.avg_prev_30d * 0.8 THEN 'Medium Risk'
    ELSE 'Low Risk'
  END AS churn_risk
FROM recent_usage r
JOIN prev_usage p USING (customer_id);


-- Support load by region
SELECT
  c.region,
  COUNT(st.ticket_id) AS tickets_opened
FROM support_tickets st
JOIN customers c ON st.customer_id = c.customer_id
GROUP BY c.region
ORDER BY tickets_opened DESC;


