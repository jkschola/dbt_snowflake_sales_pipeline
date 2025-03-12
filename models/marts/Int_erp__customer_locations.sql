WITH erp_customer_locations AS (
    SELECT * 
    FROM 
        {{ ref('stg_erp__customer_locations') }}
)
SELECT
    cid AS customer_key,
    cntry AS country
FROM 
    erp_customer_locations