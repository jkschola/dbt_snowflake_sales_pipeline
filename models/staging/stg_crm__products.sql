WITH crm_products AS (
    SELECT * 
    FROM 
        {{ source('sales_db', 'crm_products') }}
)
SELECT
    prd_id AS product_id, 
    prd_key AS product_key,
    prd_nm AS product_name,
    prd_cost AS cost,
    prd_line AS product_line,
    prd_start_dt AS start_date,
    prd_end_dt AS product_end_date
FROM 
    crm_products