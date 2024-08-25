WITH CategorySales AS (
	SELECT 
		p.category,
		SUM(s.sales_amount) AS total_sales
	FROM
		sales s
	JOIN products p ON
		s.product_id = p.product_id
	GROUP BY
		p.category
),
EmployeeSales AS (
	SELECT 
		e.employee_name,
		SUM(s.sales_amount) AS total_sales_handled
	FROM
		sales s 
	JOIN sales_team st ON
		s.sales_id = st.sales_id 
	JOIN employees e ON
		st.employee_id = e.employee_id
	GROUP BY
		e.employee_name
),
TopCategory AS (
	SELECT
		category, total_sales
	FROM CategorySales
	ORDER BY total_sales DESC
	LIMIT 1
)

SELECT 
	cs.category AS 'Product Category',
	cs.total_sales AS 'Total Sales by Category',
	es.employee_name AS 'Employee',
	es.total_sales_handled AS 'Total Sales Handled',
	tc.category AS 'Top-Selling Category',
	tc.total_sales AS 'Top Category Sales'
FROM
	CategorySales cs
JOIN
	EmployeeSales es ON 1=1
JOIN
	TopCategory tc ON 1=1;
