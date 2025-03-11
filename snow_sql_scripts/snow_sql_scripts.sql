-- The RAW data from CRM system is stored in CSV files. 
-- The data is stored in three files: cust_info.csv, prd_info.csv, and sales_details.csv. 
-- The data in these files needs to be loaded into Snowflake tables. The data in the files is as follows:


-- 1️⃣ Create a File Format for CSV Files

CREATE OR REPLACE FILE FORMAT SALES_DB.RAW.FF_CSV_FORMAT
    TYPE = 'CSV'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
    NULL_IF = ('NULL', '');


-- 2️⃣ Create a Snowflake Stage for File Upload

CREATE OR REPLACE STAGE SALES_DB.RAW.CSV_STAGE;


-- 3️⃣ Explore the data before loading

-- CRM files (each CRM file has 7 columns)
    -- cust_info.csv
    -- prd_info.csv
    -- sales_details.csv


select $1, $2, $3, $4, $5, $6, $7
from @SALES_DB.RAW.CSV_STAGE/cust_info.csv
(file_format => SALES_DB.RAW.FF_CSV_FORMAT);

select $1, $2, $3, $4, $5, $6, $7
from @SALES_DB.RAW.CSV_STAGE/prd_info.csv
(file_format => SALES_DB.RAW.FF_CSV_FORMAT);

select $1, $2, $3, $4, $5, $6, $7
from @SALES_DB.RAW.CSV_STAGE/sales_details.csv
(file_format => SALES_DB.RAW.FF_CSV_FORMAT);


-- ERP Files
    -- CUST_AZ12.csv
    -- LOC_A101.csv

select $1, $2, $3
from @SALES_DB.RAW.CSV_STAGE/CUST_AZ12.csv
(file_format => SALES_DB.RAW.FF_CSV_FORMAT);


select $1, $2
from @SALES_DB.RAW.CSV_STAGE/LOC_A101.csv
(file_format => SALES_DB.RAW.FF_CSV_FORMAT);



-- 4️⃣ Create Tables in the RAW Schema

-- CRM Tables

-- Customers Table
CREATE OR REPLACE TABLE SALES_DB.RAW.crm_cust_info (
    cst_id INT,
    cst_key STRING,
    cst_firstname STRING,
    cst_lastname STRING,
    cst_marital_status STRING,
    cst_gndr STRING,
    cst_create_date DATE
);

-- Products Table
CREATE OR REPLACE TABLE SALES_DB.RAW.crm_prd_info (
    prd_id INT,
    prd_key STRING,
    prd_nm STRING,
    prd_cost FLOAT,
    prd_line STRING,
    prd_start_dt DATE,
    prd_end_dt DATE
);

-- Sales Details Table
CREATE OR REPLACE TABLE SALES_DB.RAW.crm_sales_details (
    sls_ord_num STRING,
    sls_prd_key STRING,
    sls_cust_id INT,
    sls_order_dt DATE,
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales FLOAT,
    sls_quantity INT,
    sls_price FLOAT
);


-- ERP Tables

-- Customer Data from ERP

CREATE OR REPLACE TABLE SALES_DB.RAW.erp_cust_az12 (
    CID STRING,
    BDATE DATE,
    GEN STRING
);

-- Customer Location Table

CREATE OR REPLACE TABLE SALES_DB.RAW.erp_loc_a101 (
    CID STRING,
    CNTRY STRING
);


-- Product Category Table (left in seeds in dbt)



-- 5️⃣ Load Data into Tables

-- Load CRM Customers Data
COPY INTO SALES_DB.RAW.crm_cust_info
FROM @SALES_DB.RAW.CSV_STAGE
FILES = ('cust_info.csv')
FILE_FORMAT = (FORMAT_NAME = SALES_DB.RAW.FF_CSV_FORMAT);


SELECT * FROM SALES_DB.RAW.crm_cust_info;



-- Load CRM Products Data
COPY INTO SALES_DB.RAW.crm_prd_info
FROM @SALES_DB.RAW.CSV_STAGE
FILES = ('prd_info.csv')
FILE_FORMAT = (FORMAT_NAME = SALES_DB.RAW.FF_CSV_FORMAT);


SELECT * FROM SALES_DB.RAW.crm_prd_info;


-- Load CRM Sales Details Data
COPY INTO SALES_DB.RAW.crm_sales_details
FROM @SALES_DB.RAW.CSV_STAGE
FILES = ('sales_details.csv')
FILE_FORMAT = (FORMAT_NAME = SALES_DB.RAW.FF_CSV_FORMAT);


SELECT * FROM SALES_DB.RAW.crm_sales_details;


-- Load ERP Customer Data
COPY INTO SALES_DB.RAW.erp_cust_az12
FROM @SALES_DB.RAW.CSV_STAGE
FILES = ('CUST_AZ12.csv')
FILE_FORMAT = (FORMAT_NAME = SALES_DB.RAW.FF_CSV_FORMAT);

SELECT * FROM SALES_DB.RAW.erp_cust_az12;


-- Load ERP Customer Location Data
COPY INTO SALES_DB.RAW.erp_loc_a101
FROM @SALES_DB.RAW.CSV_STAGE
FILES = ('LOC_A101.csv')
FILE_FORMAT = (FORMAT_NAME = SALES_DB.RAW.FF_CSV_FORMAT);


SELECT * FROM SALES_DB.RAW.erp_loc_a101;

