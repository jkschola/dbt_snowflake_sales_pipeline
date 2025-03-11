WITH crm_products_cleansed AS (
    SELECT * 
    FROM 
        {{ ref('stg_crm__products') }}
)
SELECT * 
FROM (
    SELECT
        product_id,
        REPLACE(SUBSTRING(product_key, 1, 5), '-', '_') AS category_key,
        -- Extract Category key (e.g CL-TI-TG-W091-S -> CL_TI (First 5 char & Replace hyphens with underscore))
        SUBSTRING(product_key, 7, LEN(product_key)) AS product_key,
        -- Extract product key from 7th character to the end
        product_name,
        IFNULL(cost, 0) AS cost,
        -- Replace NULL values with 0
        CASE
            WHEN UPPER(TRIM(product_line)) = 'M' THEN 'Mountain'
            WHEN UPPER(TRIM(product_line)) = 'R' THEN 'Road'
            WHEN UPPER(TRIM(product_line)) = 'S' THEN 'Other Sales'
            WHEN UPPER(TRIM(product_line)) = 'T' THEN 'Touring'
            ELSE 'n/a'
        END AS product_line,
        -- Map product line codes to descriptive values
        start_date,
        LEAD(start_date) OVER (PARTITION BY product_key ORDER BY start_date) - 1 AS end_date
        -- Calculate end date as the day before the next product start date
    FROM
        crm_products_cleansed
)
WHERE
    end_date IS NULL -- Filter out all historical data