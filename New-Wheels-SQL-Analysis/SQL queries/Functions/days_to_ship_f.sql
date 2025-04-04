-- This function calculates the number of days taken to ship an order.
-- Returns: The number of days between the order date and the shipping date. 

USE vehdb;
DROP FUNCTION IF EXISTS days_to_ship_f;
DELIMITER $$  
CREATE FUNCTION days_to_ship_f(SHIP_DATE DATE, ORDER_DATE DATE)  
RETURNS INT  
DETERMINISTIC  
BEGIN  
    DECLARE days_to_ship INT;
    set days_to_ship = datediff(SHIP_DATE, ORDER_DATE)
	RETURN(days_to_ship);

END;	
