WITH erp_customer_locations AS (
    SELECT * 
    FROM 
        {{ source('sales_db', 'erp_customer_locations') }}
)
SELECT
    cid AS customer_key,
    cntry AS country
FROM 
    erp_customer_locations