-- Drop the view 'veh_prod_cust_v' if it already exists to avoid conflicts
DROP VIEW IF EXISTS veh_prod_cust_v;

-- Create a new view 'veh_prod_cust_v' which combines customer, order, and product details
CREATE VIEW veh_prod_cust_v AS
    -- Select customer, order, and product details to display in the view
    SELECT 
        cust.CUSTOMER_ID,
        cust.CUSTOMER_NAME,
        cust.CREDIT_CARD_TYPE,
        cust.STATE,
        -- Order details
        ord.ORDER_ID,
        ord.CUSTOMER_FEEDBACK,
        -- Product details
        prod.PRODUCT_ID,
        prod.VEHICLE_MAKER,
        prod.VEHICLE_MODEL,
        prod.VEHICLE_COLOR,
        prod.VEHICLE_MODEL_YEAR
    FROM
        -- Join order table 'order_t' with customer table 'customer_t'
        order_t ord
            JOIN
        customer_t cust ON ord.CUSTOMER_ID = cust.CUSTOMER_ID
            JOIN
        -- Join product table 'product_t' with order table 'order_t'
        product_t prod ON prod.PRODUCT_ID = ord.PRODUCT_ID;