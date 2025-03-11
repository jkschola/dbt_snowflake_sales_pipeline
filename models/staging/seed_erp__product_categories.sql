WITH erp_product_categories AS (
    SELECT * 
    FROM 
        {{ ref('seed_erp_product_categories') }}
)
SELECT
    id AS category_key,
    cat AS category,
    subcat AS subcategory,
    maintenance AS maintenance

FROM
    erp_product_categories