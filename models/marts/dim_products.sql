WITH crm_products AS (
    SELECT * 
    FROM 
        {{ ref('int_crm__products') }}
),
erp_products AS (
    SELECT * 
    FROM 
        {{ ref('int_erp__product_categories') }}
)
SELECT
    ROW_NUMBER() OVER (ORDER BY crm.start_date, crm.product_key) AS product_surr_key, 
    -- Surrogate key
    crm.product_id,
    crm.product_key,
    crm.product_name,
    crm.category_key,
    cat.category AS category,
    cat.subcategory,
    cat.maintenance,
    crm.cost,
    crm.product_line,
    crm.start_date,
FROM crm_products crm
LEFT JOIN erp_products cat 
    ON crm.category_key = cat.category_key
WHERE
    crm.end_date IS NULL
    -- Filter out all historical data