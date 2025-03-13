WITH erp_customer_locations AS (
    SELECT * 
    FROM 
        {{ ref('stg_erp__customer_locations') }}
)
SELECT
    customer_key,
    country
FROM 
    erp_customer_locations