WITH erp_customer_locations AS (
    SELECT * 
    FROM 
        SALES_DB.RAW.ERP_LOC_A101
)
SELECT
    cid AS customer_key,
    cntry AS country
FROM 
    erp_customer_locations