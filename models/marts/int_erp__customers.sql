WITH erp_customers_cleansed AS (
    SELECT * 
    FROM 
        {{ ref('stg_erp__customers') }}
)
SELECT
    customer_key,
    CASE
        WHEN customer_key LIKE 'NAS%' THEN SUBSTRING(customer_key, 4, LEN(customer_key)) 
        -- Remove 'NAS' prefix in customer_key if present
        ELSE customer_key
    END AS customer_key_cleaned,
    birthdate,
    CASE
        WHEN birthdate > GETDATE() THEN NULL
        ELSE birthdate
    END AS birthdate_cleansed, 
    -- Set future birthdates to NULL
    gender
FROM 
    erp_customers_cleansed