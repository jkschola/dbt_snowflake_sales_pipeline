WITH crm_sale_details_cleansed AS (
    SELECT * 
    FROM 
        {{ ref('stg_crm__sale_details') }}
)
SELECT
    order_number,
    product_key,
    customer_id,
    order_date,
    shipping_date,
    due_date,
    CASE 
        WHEN sales_amount IS NULL OR sales_amount <= 0 
             OR ABS(sales_amount - (quantity * ABS(price))) > 0.01 * (quantity * ABS(price))
            THEN quantity * ABS(price)
        ELSE sales_amount
    END AS sales_amount,
    -- Recalculate sales if original value is missing or incorrect

    quantity,

    CASE 
        WHEN price IS NULL OR price <= 0 
            THEN COALESCE(sales_amount / NULLIF(quantity, 0), 0)
        ELSE price 
    END AS price
    -- Derive price if original value is invalid
FROM 
    crm_sale_details_cleansed
