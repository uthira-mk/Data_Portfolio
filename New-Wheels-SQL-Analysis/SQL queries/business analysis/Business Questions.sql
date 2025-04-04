/* QUESTIONS RELATED TO CUSTOMERS */


-- [Q1] What is the distribution of customers across states?
		--This query counts the number of unique customers in each state  
		-- and orders the results in descending order of customer count. 
		SELECT 
			state, 
			COUNT(customer_id) AS CUSTOMER_COUNT
		FROM
			veh_prod_cust_v
		GROUP BY 1
		ORDER BY 2 DESC;


-- [Q2]* What is the average rating in each quarter?
-- Very Bad is 1, Bad is 2, Okay is 3, Good is 4, Very Good is 5.
		-- Converts qualitative customer feedback into a numerical rating (1-5 scale)  
		-- and calculates the average rating for each quarter.  
		SELECT 
			quarter_number,
			AVG((CASE customer_feedback
				WHEN 'Very Bad' THEN 1
				WHEN 'Bad' THEN 2
				WHEN 'Okay' THEN 3
				WHEN 'Good' THEN 4
				WHEN 'Very Good' THEN 5
			END)) AS AVERAGE_CUSTOMER_RATING
		FROM
			veh_ord_cust_v
		GROUP BY quarter_number
		ORDER BY quarter_number;


-- [Q3]* Are customers getting more dissatisfied over time?
		-- Calculates the percentage of each feedback category per quarter  
		-- to analyze whether dissatisfaction is increasing. 
		WITH cte AS (
		SELECT 
			*,COUNT(customer_feedback) AS NUMBER_OF_RATINGS
		FROM
			veh_ord_cust_v
		GROUP BY quarter_number, customer_feedback
		ORDER BY quarter_number
		)
		 SELECT 
			 quarter_number,
			 customer_feedback,  
			 ROUND(NUMBER_OF_RATINGS * 100.0 / (SELECT SUM(NUMBER_OF_RATINGS) FROM cte s WHERE s.quarter_number=m.quarter_number),2) AS PERCENTAGE 
		 FROM cte m;


-- [Q4] Which are the top 5 vehicle makers preferred by the customer.
		-- Counts the number of customers for each vehicle maker  
		-- and returns the top 5 most preferred ones.
		SELECT 
			vehicle_maker, 
			COUNT(customer_id) AS NUMBER_OF_CUSTOMERS
		FROM
			veh_prod_cust_v
		GROUP BY 1
		ORDER BY 2 DESC
		LIMIT 5;


-- [Q5]* What is the most preferred vehicle make in each state?
		-- Uses `ROW_NUMBER()` to identify the most preferred vehicle maker  
		-- in each state based on the number of customers. 
		WITH cte1 AS(
			SELECT 
				state,vehicle_maker,COUNT(customer_id) AS number_of_customers
			FROM veh_prod_cust_v
			GROUP BY state, vehicle_maker),
		cte2 AS (
			SELECT *, ROW_NUMBER() OVER (PARTITION BY state ORDER BY number_of_customers DESC) AS row_num
			FROM cte1 
			)
		SELECT state, vehicle_maker
		FROM cte2
		WHERE row_num = 1
	

/* QUESTIONS RELATED TO REVENUE and ORDERS */


-- [Q6] What is the trend of number of orders by quarters?
		-- Calculates the number of orders per quarter and  
		-- determines whether the trend is increasing or decreasing.
		SELECT 
			quarter_number,
			COUNT(order_id) AS NUMBER_OF_ORDERS,
			COALESCE((CASE
				WHEN COUNT(order_id) > LAG(COUNT(order_id)) OVER(ORDER BY quarter_number) THEN 'Orders Increased'
				WHEN COUNT(order_id) < LAG(COUNT(order_id)) OVER(ORDER BY quarter_number) THEN 'Orders Decreased'
			END), '-')  AS TREND
		FROM 
			veh_ord_cust_v
		GROUP BY quarter_number
		ORDER BY quarter_number;


-- [Q7]* What is the quarter over quarter % change in revenue?
		-- Calculates the revenue for each quarter and computes the QoQ % change  
		-- using the `LAG()` function. 
		WITH cte AS
		(
		SELECT
			quarter_number,
			SUM(calc_revenue_f(quantity, vehicle_price, discount)) AS REVENUE
		FROM 
			veh_ord_cust_v
		GROUP BY quarter_number
		ORDER BY quarter_number
		)
		SELECT
			quarter_number,
			revenue AS QUARTERLY_REVENUE,
			ROUND(COALESCE((revenue - LAG(revenue) OVER (ORDER BY quarter_number)) / LAG(REVENUE) OVER (ORDER BY quarter_number)*100,0),2) AS 'QOQ (%)'
		FROM
			cte;


--  [Q8] What is the trend of revenue and orders by quarters?
		-- Retrieves the total number of orders and total revenue for each quarter  
		-- to analyze trends.  
		SELECT quarter_number, COUNT(ORDER_ID) AS NUMBER_OF_ORDERS, SUM(calc_revenue_f(quantity,vehicle_price,discount)) AS REVENUE
		FROM veh_ord_cust_v
		GROUP BY quarter_number
		ORDER BY quarter_number;


/* QUESTIONS RELATED TO SHIPPING */


-- [Q9] What is the average discount offered for different types of credit cards?
		-- Computes the average discount percentage for each credit card type. 
		SELECT 
			credit_card_type, 
			ROUND(AVG(discount),2) AS AVERAGE_DISCOUNT
		FROM
			veh_ord_cust_v
		GROUP BY 1;


-- [Q10] What is the average time taken to ship the placed orders for each quarters?
		-- Uses the `days_to_ship_f` function to calculate the average shipping time  
		-- for orders placed in each quarter. 
		SELECT 
			quarter_number, 
			ROUND(AVG(days_to_ship_f(ship_date, order_date)),2) AS 'AVERAGE_TIME_TO_SHIP(IN DAYS)'
		FROM
			veh_ord_cust_v
		GROUP BY 1
        ORDER BY 1;
