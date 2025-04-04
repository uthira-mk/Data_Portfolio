 -- This function calculates the total revenue from vehicle sales after applying a discount.
 -- Returns:The total revenue after applying the discount.

USE vehdb;
DROP FUNCTION IF EXISTS calc_revenue_f;
DELIMITER $$  
CREATE FUNCTION calc_revenue_f(QUANTITY INT, VEHICLE_PRICE DECIMAL(10,2), DISCOUNT DECIMAL(4,2))  
RETURNS DECIMAL(10,2)
DETERMINISTIC  
BEGIN  
    DECLARE discount_value DECIMAL(10,2);
	DECLARE discounted_price DECIMAL(10,2);
	DECLARE calc_revenue_f DECIMAL(10,2);
    set discount_value = (VEHICLE_PRICE * DISCOUNT)/100;
	set discounted_price = VEHICLE_PRICE - discount_value;
	set calc_revenue_f = discounted_price * QUANTITY;
	RETURN(calc_revenue_f);
END;