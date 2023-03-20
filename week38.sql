create database frosty;
use frosty;


CREATE or replace TABLE employees (
id INT,
name VARCHAR(50),
department VARCHAR(50)
);


INSERT INTO employees (id, name, department)
VALUES
(1, 'Alice', 'Sales'),
(2, 'Bob', 'Marketing');


CREATE TABLE sales (
id INT,
employee_id INT,
sale_amount DECIMAL(10, 2)
);

-- -— Insert example data into second table
INSERT INTO sales (id, employee_id, sale_amount)
VALUES
(1, 1, 100.00),
(2, 1, 200.00),
(3, 2, 150.00);

-- — Create view that combines both tables
CREATE VIEW employee_sales AS
SELECT e.id, e.name, e.department, s.sale_amount
FROM employees e
JOIN sales s ON e.id = s.employee_id;

-- — Query the view to verify the data
SELECT * FROM employee_sales;

create or replace stream employee_sales_stream on view employee_sales;

select * from employee_sales_stream;

delete  from sales where sale_amount = 150;

create table deleted_sales as (select * from employee_sales_stream where METADATA$ACTION = 'DELETE');

select * from deleted_sales;
