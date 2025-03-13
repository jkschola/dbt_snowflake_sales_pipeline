WITH erp_customer_locations AS (
    SELECT * 
    FROM 
        {{ ref('stg_erp__customer_locations') }}
)
SELECT
    REPLACE( customer_key, '-', '') AS customer_key,
    CASE 
        WHEN TRIM(country) = 'DE' THEN 'Germany'
        WHEN TRIM(country) IN ( 'US', 'USA' ) THEN 'United States'
        WHEN TRIM(country) = '' OR country IS NULL THEN 'n/a'
        ELSE TRIM(country)
    END AS country
    -- Normalize and Handle missing or blank country codes
FROM 
    erp_customer_locations