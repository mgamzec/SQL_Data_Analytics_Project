CREATE OR REPLACE VIEW cohort_analysis AS
WITH customer_revenue AS (
	SELECT
		s.customerkey,
		s.orderdate,
		SUM(s.quantity * s.netprice * s.exchangerate) AS total_net_revenue,
		COUNT(s.orderkey) AS num_orders,
		c.countryfull,
		c.age,
		c.givenname,
		c.surname
	FROM sales s 
	LEFT JOIN customer c ON c.customerkey = s.customerkey
	GROUP BY
		s.customerkey,
		s.orderdate,
		c.countryfull,
		c.age,
		c.givenname,
		c.surname
),

cohort_data AS (
	SELECT
		cr.*,
		MIN(cr.orderdate) OVER (PARTITION BY cr.customerkey) AS first_purchase_date,
		EXTRACT(YEAR FROM MIN(cr.orderdate) OVER (PARTITION BY cr.customerkey)) AS cohort_year
	FROM customer_revenue cr 
)

SELECT
    cd.customerkey, 
    cd.cohort_year,
    CONCAT(TRIM(cd.givenname), ' ', TRIM(cd.surname)) AS cleaned_name, 
    COALESCE(cd.num_orders, 0) AS num_orders,
    COALESCE(cd.total_net_revenue, 0) AS total_net_revenue,
    cd.countryfull,
    cd.age,
    cd.first_purchase_date,
    cd.orderdate
FROM cohort_data cd;