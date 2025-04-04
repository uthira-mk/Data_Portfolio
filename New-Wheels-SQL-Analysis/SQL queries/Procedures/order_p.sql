-- Drop the procedure 'order_p' if it already exists to avoid conflicts
DROP PROCEDURE IF EXISTS order_p;

-- Set the delimiter to $$ to allow multi-line stored procedures 
DELIMITER $$ 

-- Create a stored procedure named 'order_p' with a parameter 'qtr_num'
CREATE PROCEDURE order_p(qtr_num INTEGER)
BEGIN
    -- Insert new order records from 'temp_t' into 'order_t' 
    -- only for the specified quarter number (qtr_num)
	INSERT INTO vehdb.order_t (
		ORDER_ID,
		CUSTOMER_ID,
		SHIPPER_ID,
		PRODUCT_ID,
		QUANTITY,
		VEHICLE_PRICE,
		ORDER_DATE,
		SHIP_DATE,
		DISCOUNT,
		SHIP_MODE,
		SHIPPING,
		CUSTOMER_FEEDBACK,
		QUARTER_NUMBER
	)
	-- Select distinct order records from 'temp_t' (temporary table) 
	SELECT DISTINCT
		ORDER_ID,
		CUSTOMER_ID,
		SHIPPER_ID,
		PRODUCT_ID,
		QUANTITY,
		VEHICLE_PRICE,
		ORDER_DATE,
		SHIP_DATE,
		DISCOUNT,
		SHIP_MODE,
		SHIPPING,
		CUSTOMER_FEEDBACK,
		QUARTER_NUMBER
	FROM vehdb.temp_t 
	WHERE QUARTER_NUMBER = qtr_num;
END;


-- Uncomment next lines to call the procedure and execute it
-- CALL order_p(1);
-- CALL order_p(2);
-- CALL order_p(3);
-- CALL order_p(4);