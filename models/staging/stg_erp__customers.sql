WITH erp_customers AS (
    SELECT * 
    FROM 
        {{ source('sales_db', 'erp_customers') }}
)
SELECT
    cid AS customer_key,
    bdate AS birthdate,
    gen AS gender
FROM 
    erp_customers