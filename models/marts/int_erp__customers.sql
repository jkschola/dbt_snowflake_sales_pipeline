WITH erp_customers_cleansed AS (
    SELECT * 
    FROM 
        {{ ref('stg_erp__customers') }}
)
SELECT
    CASE
        WHEN customer_key LIKE 'NAS%' THEN SUBSTRING(customer_key, 4, LEN(customer_key)) 
        ELSE customer_key
    END AS customer_key,
    -- Remove 'NAS' prefix in customer_key if present
    CASE
        WHEN birthdate > GETDATE() THEN NULL
        ELSE birthdate
    END AS birthdate, 
    -- Set future birthdates to NULL
    CASE
        WHEN UPPER(TRIM(gender)) IN ('F', 'FEMALE') THEN 'Female'
        WHEN UPPER(TRIM(gender)) IN ('M', 'MALE') THEN 'Male'
        ELSE 'n/a'
    END AS gender
    -- Normalize gender values and handle unknown cases
FROM 
    erp_customers_cleansed