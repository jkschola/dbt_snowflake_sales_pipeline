WITH crm_customers AS (
    SELECT * 
    FROM 
        {{ ref('int_crm__customers') }}
),
erp_customers AS (
    SELECT * 
    FROM 
        {{ ref('int_erp__customers') }}
),
erp_customer_locations AS (
    SELECT * 
    FROM 
        {{ ref('Int_erp__customer_locations') }}
)
SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id) AS customer_surr_key, 
    -- Surrogate key
    crm.customer_id,
    crm.customer_key,
    crm.first_name,
    crm.last_name,
    loc.country,
    crm.marital_status,
    CASE 
        WHEN crm.gender != 'n/a' THEN crm.gender 
        -- CRM is the primary source for gender
        ELSE COALESCE(erp.gender, 'n/a')  			   
        -- Fallback to ERP data
    END AS gender,
    erp.birthdate,
    crm.create_date
FROM crm_customers crm
LEFT JOIN erp_customers erp 
    ON crm.customer_key = erp.customer_key
LEFT JOIN erp_customer_locations loc 
    ON crm.customer_key = loc.customer_key
