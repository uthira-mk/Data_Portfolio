--1.  TOTAL REVENUE: 
	-- This query calculates the total revenue by summing the revenue for all orders 
	-- using the `calc_revenue_f` function, which applies discounts before computing revenue. 
SELECT 
	SUM(calc_revenue_f(QUANTITY,VEHICLE_PRICE,DISCOUNT)) AS TOTAL_REVENUE
FROM 
	veh_ord_cust_v;


-- 2. TOTAL ORDERS: This query counts the total number of unique orders placed. 
SELECT 
	COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM 
	veh_ord_cust_v;


-- 3. TOTAL CUSTOMERS: This query counts the total number of unique customers who have placed orders.  
SELECT 
	COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_CUSTOMERS
FROM 
	veh_prod_cust_v;


-- 4. AVG CUSTOMER RATING: 
	-- This query converts qualitative feedback into numerical values (1-5 scale)  
	-- and calculates the average customer rating. 
SELECT 
	AVG((CASE customer_feedback
		WHEN 'Very Bad' THEN 1
		WHEN 'Bad' THEN 2
		WHEN 'Okay' THEN 3
		WHEN 'Good' THEN 4
		WHEN 'Very Good' THEN 5
	END)) AS AVERAGE_CUSTOMER_RATING
FROM
	veh_prod_cust_v

	
-- 5. Last Qtr Revenue: This query calculates the total revenue generated in the last quarter (Q4)
SELECT 
    SUM(CALC_REVENUE_F(QUANTITY, VEHICLE_PRICE, DISCOUNT)) AS LAST_QTR_REVENUE
FROM
    veh_ord_cust_v
WHERE
    quarter_number = 4;


-- 6. Last Qtr Orders: This query counts the total number of unique orders placed in the last quarter (Q4)
SELECT 
	COUNT(DISTINCT ORDER_ID) AS LAST_QTR_ORDERS
FROM 
	veh_ord_cust_v
WHERE 
	quarter_number = 4


-- 7. Avg Days to Ship: 
	-- This query calculates the average time taken to ship an order  
	-- using the `days_to_ship_f` function, which computes the difference  
	-- between `SHIP_DATE` and `ORDER_DATE`.   
SELECT 
	AVG(days_to_ship_f(ship_date,order_date)) AS AVG_DAYS_TO_SHIP
FROM 
	veh_ord_cust_v;


-- 8. % Good Feedback: 
	-- This query calculates the percentage of each customer feedback type  
	-- by dividing the count of each feedback type by the total feedback count. 
WITH cte as 
(SELECT  CUSTOMER_FEEDBACK,
	COUNT((CASE customer_feedback
		WHEN 'Very Bad' THEN 1
		WHEN 'Bad' THEN 2
		WHEN 'Okay' THEN 3
		WHEN 'Good' THEN 4
		WHEN 'Very Good' THEN 5
	END)) AS NUMBER_OF_RATING
FROM
	veh_prod_cust_v
GROUP BY CUSTOMER_FEEDBACK)
SELECT 
	customer_feedback,
	(NUMBER_OF_RATING * 100 / SUM(NUMBER_OF_RATING) OVER()) AS `percent of total` 
FROM cte
