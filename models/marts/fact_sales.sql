WITH sale_details AS (
    SELECT * 
    FROM 
        {{ ref('int_crm__sale_details') }}
),
products AS (
    SELECT * 
    FROM 
        {{ ref('dim_products') }}
),
customers AS (
    SELECT * 
    FROM 
        {{ ref('dim_customers') }}
)
SELECT
    sd.order_number,
    p.product_key,
    c.customer_key,
    sd.order_date,
    sd.shipping_date,
    sd.due_date,
    sd.sales_amount,
    sd.quantity,
    sd.price
FROM sale_details sd 
JOIN products p 
    ON sd.product_key = p.product_key
JOIN customers c
    ON sd.customer_id = c.customer_id