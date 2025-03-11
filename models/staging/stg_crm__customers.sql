WITH crm_customers AS (
    SELECT * 
    FROM 
        SALES_DB.RAW.CRM_CUST_INFO
)
SELECT
    cst_id AS customer_id,   
    cst_key AS customer_key,             
    cst_firstname AS first_name, 
    cst_lastname AS last_name,
    cst_marital_status AS marital_status,
    cst_gndr AS gender,       
    cst_create_date AS create_date
FROM 
    crm_customers