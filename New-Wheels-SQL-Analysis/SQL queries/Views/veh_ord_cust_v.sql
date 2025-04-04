-- Drop the view 'veh_ord_cust_v' if it already exists to avoid conflicts
DROP VIEW IF EXISTS veh_ord_cust_v;

-- Create a view named 'veh_ord_cust_v' that combines data from 'order_t' and 'customer_t'
CREATE VIEW veh_ord_cust_v AS
    SELECT 
        -- Select the customer ID, name, city, state, and credit card type from 'customer_t'
        cust.CUSTOMER_ID,
        cust.CUSTOMER_NAME,
        cust.CITY,
        cust.STATE,
        cust.CREDIT_CARD_TYPE,
        
        -- Select the order ID, shipper ID, product ID, quantity, vehicle price, and other order details from 'order_t'        
        ord.ORDER_ID,
        ord.SHIPPER_ID,
        ord.PRODUCT_ID,
        ord.QUANTITY,
        ord.VEHICLE_PRICE,
        ord.ORDER_DATE,
        ord.SHIP_DATE,
        ord.DISCOUNT,
        ord.CUSTOMER_FEEDBACK,
        ord.QUARTER_NUMBER
     -- Join 'order_t' and 'customer_t' tables on the customer ID field to combine customer and order data
    FROM
        order_t ord
            JOIN
        customer_t cust ON ord.CUSTOMER_ID = cust.CUSTOMER_ID;