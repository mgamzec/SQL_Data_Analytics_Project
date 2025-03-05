WITH customer_last_purchase AS (
    SELECT
        customerkey,
        orderdate,
        ROW_NUMBER() OVER (PARTITION BY customerkey ORDER BY orderdate DESC) AS rn,
        MIN(orderdate) OVER (PARTITION BY customerkey) AS first_purchase_date,
        EXTRACT(YEAR FROM MIN(orderdate) OVER (PARTITION BY customerkey)) AS cohort_year
    FROM cohort_analysis
),
churned_customers AS (
    SELECT
        customerkey,
        orderdate AS last_purchase_date,
        cohort_year,
        CASE
            WHEN orderdate < '2024-04-20'::date - INTERVAL '6 months' THEN 'Churned'
            ELSE 'Active'
        END AS customer_status
    FROM customer_last_purchase
    WHERE rn = 1
        AND first_purchase_date < '2024-04-20'::date - INTERVAL '6 months'
)
SELECT
    cohort_year,
    customer_status,
    COUNT(DISTINCT customerkey) AS num_customers,
    ROUND(COUNT(DISTINCT customerkey) / SUM(COUNT(DISTINCT customerkey)) OVER(PARTITION BY cohort_year), 2) AS cohort_percentage
FROM churned_customers
GROUP BY
    cohort_year,
    customer_status
ORDER BY
    cohort_year,
    customer_status;