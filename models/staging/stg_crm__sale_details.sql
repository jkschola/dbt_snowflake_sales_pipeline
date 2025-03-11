WITH crm_sale_details AS (
    SELECT * 
    FROM 
        {{ source('sales_db', 'crm_sale_details') }}
)
SELECT
    sls_ord_num  AS order_number,
    sls_prd_key  AS product_key,
    sls_cust_id  AS customer_id,
    sls_order_dt AS order_date,
    sls_ship_dt  AS shipping_date,
    sls_due_dt   AS due_date,
    sls_sales    AS sales_amount,
    sls_quantity AS quantity,
    sls_price    AS price
FROM 
    crm_sale_details