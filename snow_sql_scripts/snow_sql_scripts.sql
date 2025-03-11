-- 1️⃣ Create a File Format for CSV Files

CREATE OR REPLACE FILE FORMAT SALES_DB.RAW.FF_CSV_FORMAT
    TYPE = 'CSV'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
    NULL_IF = ('NULL', '');


-- 2️⃣ Create a Snowflake Stage for File Upload

CREATE OR REPLACE STAGE SALES_DB.RAW.CSV_STAGE;


-- 3️⃣ Explore the data before loading
-- cust_info.csv
-- prd_info.csv
-- sales_details.csv


select $1, $2, $3, $4, $5, $6, $7, $8
from @SALES_DB.RAW.CSV_STAGE/cust_info.csv
(file_format => SALES_DB.RAW.FF_CSV_FORMAT);


select $1, $2, $3, $4, $5, $6, $7, $8
from @SALES_DB.RAW.CSV_STAGE/prd_info.csv
(file_format => SALES_DB.RAW.FF_CSV_FORMAT);

select $1, $2, $3, $4, $5, $6, $7, $8
from @SALES_DB.RAW.CSV_STAGE/sales_details.csv
(file_format => SALES_DB.RAW.FF_CSV_FORMAT);

-- each file has 7 columns


-- 4️⃣ Create Tables in the RAW Schema



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


-- 5️⃣ Load Data into Tables

-- Load Customers Data
COPY INTO SALES_DB.RAW.crm_cust_info
FROM @SALES_DB.RAW.CSV_STAGE
FILES = ('cust_info.csv')
FILE_FORMAT = (FORMAT_NAME = SALES_DB.RAW.FF_CSV_FORMAT);


SELECT * FROM SALES_DB.RAW.crm_cust_info;



-- Load Products Data
COPY INTO SALES_DB.RAW.crm_prd_info
FROM @SALES_DB.RAW.CSV_STAGE
FILES = ('prd_info.csv')
FILE_FORMAT = (FORMAT_NAME = SALES_DB.RAW.FF_CSV_FORMAT);


SELECT * FROM SALES_DB.RAW.crm_prd_info;


-- Load Sales Details Data
COPY INTO SALES_DB.RAW.crm_sales_details
FROM @SALES_DB.RAW.CSV_STAGE
FILES = ('sales_details.csv')
FILE_FORMAT = (FORMAT_NAME = SALES_DB.RAW.FF_CSV_FORMAT);


SELECT * FROM SALES_DB.RAW.crm_sales_details;

