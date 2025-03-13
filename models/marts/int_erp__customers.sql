WITH erp_customers AS (
    SELECT * 
    FROM 
        {{ ref('stg_erp__customers') }}
)
SELECT
    customer_key,
    birthdate,
    gender
FROM 
    erp_customers