WITH erp_customers AS (
    SELECT * 
    FROM 
        SALES_DB.RAW.ERP_CUST_AZ12
)
SELECT
    cid AS customer_key,
    bdate AS birthdate,
    gen AS gender
FROM 
    erp_customers