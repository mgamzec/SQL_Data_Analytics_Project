--Title: Customer Revenue by Cohort (NOT adjusted for time in market)
SELECT
    cohort_year,
    SUM(total_net_revenue) AS total_revenue,
    COUNT(DISTINCT customerkey) AS total_customers,
    SUM(total_net_revenue) / COUNT(DISTINCT customerkey) AS customer_revenue
FROM cohort_analysis
GROUP BY 
    cohort_year;

-- Title: Customer Revenue by Cohort (Adjusted for time in market)
WITH purchase_days AS (
    SELECT
        customerkey,
        total_net_revenue,
        orderdate - MIN(orderdate) OVER (PARTITION BY customerkey) AS days_since_first_purchase
    FROM cohort_analysis
)

SELECT
    days_since_first_purchase,
    SUM(total_net_revenue) as total_revenue,
    SUM(total_net_revenue) / (SELECT SUM(total_net_revenue) FROM cohort_analysis) * 100 as percentage_of_total_revenue,
    SUM(SUM(total_net_revenue) / (SELECT SUM(total_net_revenue) FROM cohort_analysis) * 100) OVER (ORDER BY days_since_first_purchase) as cumulative_percentage_of_total_revenue
FROM purchase_days
GROUP BY days_since_first_purchase
ORDER BY days_since_first_purchase;

-- Title: Customer Revenue by Cohort (Adjusted for time in market) - Only First Purchase Date
SELECT
    cohort_year,
    SUM(total_net_revenue) AS total_revenue,
    COUNT(DISTINCT customerkey) AS total_customers,
    SUM(total_net_revenue) / COUNT(DISTINCT customerkey) AS customer_revenue
FROM cohort_analysis
WHERE orderdate = first_purchase_date
GROUP BY 
    cohort_year;

-- Title: Investigate Monthly Revenue & Customer Trends
SELECT
    DATE_TRUNC('month', ca.orderdate)::date AS year_month,
    SUM(total_net_revenue) AS total_revenue,
    COUNT(DISTINCT ca.customerkey) AS total_customers,
    SUM(total_net_revenue) / COUNT(DISTINCT ca.customerkey) AS customer_revenue
FROM cohort_analysis ca
GROUP BY    
    year_month
ORDER BY
    year_month;

-- Title: Investigate Monthly Revenue & Customer Trends (3 Month Rolling Average)
WITH monthly_metrics AS (
    SELECT
        DATE_TRUNC('month', ca.orderdate)::date AS year_month,
        SUM(total_net_revenue) AS total_revenue,
        COUNT(DISTINCT ca.customerkey) AS total_customers,
        SUM(total_net_revenue) / COUNT(DISTINCT ca.customerkey) AS customer_revenue
    FROM cohort_analysis ca
    GROUP BY    
        year_month
    ORDER BY
        year_month
)
SELECT 
    year_month,
    total_revenue,
    AVG(total_revenue) OVER (
        ORDER BY year_month 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS rolling_3mo_total_revenue,
    AVG(total_customers) OVER (
        ORDER BY year_month 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS rolling_3mo_total_customers,
    AVG(customer_revenue) OVER (
        ORDER BY year_month 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS rolling_3mo_customer_revenue
FROM monthly_metrics
ORDER BY
    year_month;