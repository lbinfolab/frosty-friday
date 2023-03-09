create or replace table week23 (
id string,
first_name string,
last_name string,
email string,  
gender string,
ip_address string );

CREATE OR REPLACE FILE FORMAT  csv_file_format
TYPE =CSV
SKIP_HEADER = 1;
                                                    
PUT file:///Users/lukasbogacz/snowflake/ff/week23/*1.csv  @%week23;

COPY INTO WEEK23 FROM @%week23
ON_ERROR=CONTINUE
FILE_FORMAT = csv_file_format ;

-- LOL  cat data_batch_1-101.csv :)

select * from week23 limit 10;
