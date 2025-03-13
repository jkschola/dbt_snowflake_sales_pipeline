WITH crm_customers_cleansed AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY create_date DESC) AS flag_last
    FROM 
        {{ ref('stg_crm__customers') }}
)
SELECT
    customer_id,
    customer_key,
    TRIM(first_name) AS first_name,
    TRIM(last_name) AS last_name,
    CASE
        WHEN marital_status = 'S' THEN 'Single'
        WHEN marital_status = 'M' THEN 'Married'
        ELSE 'n/a'
    END AS marital_status,
    -- Normalize marital status values to readable format
    CASE
        WHEN gender = 'M' THEN 'Male'
        WHEN gender = 'F' THEN 'Female'
        ELSE 'n/a'
    END AS gender,
    -- Normalize gender values to readable format       
    create_date,
    flag_last
FROM
    crm_customers_cleansed
WHERE 
    customer_id IS NOT NULL
    AND flag_last = 1
    -- Select the most recent record per customer
