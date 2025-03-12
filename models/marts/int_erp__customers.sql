WITH erp_customers AS (
    SELECT * 
    FROM 
        {{ ref('stg_erp__customers') }}
)
SELECT
    cid AS customer_key,
    bdate AS birthdate,
    gen AS gender
FROM 
    erp_customers