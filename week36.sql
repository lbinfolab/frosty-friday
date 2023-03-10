use lukas.public;

CREATE OR REPLACE TABLE table_1 (id INT);
CREATE OR REPLACE VIEW view_1 AS (SELECT * FROM table_1);
CREATE OR REPLACE TABLE table_2 (id INT);
CREATE OR REPLACE VIEW view_2 AS (SELECT * FROM table_2);
CREATE OR REPLACE TABLE table_6 (id INT);
CREATE OR REPLACE VIEW view_6 AS (SELECT * FROM table_6);
CREATE OR REPLACE TABLE table_5 (id INT);
CREATE OR REPLACE VIEW view_5 AS (SELECT * FROM table_5);
CREATE OR REPLACE TABLE table_4 (id INT);
CREATE OR REPLACE VIEW view_4 AS (SELECT * FROM table_4);
CREATE OR REPLACE TABLE table_3 (id INT);
CREATE OR REPLACE VIEW view_3 AS (SELECT * FROM table_3);
CREATE OR REPLACE VIEW my_union_view AS
SELECT * FROM table_1
UNION ALL
SELECT * FROM table_2
UNION ALL
SELECT * FROM table_3
UNION ALL
SELECT * FROM table_4
UNION ALL
SELECT * FROM table_5
UNION ALL
SELECT * FROM table_6;


-- Due to the process of extracting the data from Snowflake’s internal metadata store, the account usage views have some natural latency:
-- For most of the views, the latency is 2 hours (120 minutes).
-- For the remaining views, the latency varies between 45 minutes and 3 hours

use snowflake;

select distinct 
referencing_object_name as dependant_views,
referenced_object_name as table_name
from snowflake.account_usage.object_dependencies
where 
UPPER(REFERENCED_OBJECT_NAME) = UPPER('table_6') or
UPPER(REFERENCED_OBJECT_NAME) = upper('table_5') or
UPPER(REFERENCED_OBJECT_NAME) = upper('table_4') or
UPPER(REFERENCED_OBJECT_NAME) = upper('table_3') or
UPPER(REFERENCED_OBJECT_NAME) = upper('table_2') or
UPPER(REFERENCED_OBJECT_NAME) = upper('table_1');
