CREATE DATABASE RETAIL_DB;
USE RETAIL_DB;
CREATE TABLE sales_data ( 
order_id INT PRIMARY KEY,
order_date DATE,
customer_id INT,
customer_name VARCHAR(100),
region VARCHAR(50),
product_category VARCHAR(50),
product_name VARCHAR(100),
sales_amount DECIMAL(10,2),
quantity INT,
discount DECIMAL(5,2)
);

ALTER TABLE sales_data
ADD payment_mode VARCHAR(50);

ALTER TABLE sales_data
DROP COLUMN payment_mode;

ALTER TABLE sales_data
RENAME COLUMN customer_name TO customer_full_name;

INSERT INTO sales_data VALUES
(1, '2024-01-01', 101, 'vennela', 'South', 'Furniture', 'Chair', 5000, 2, 10),
(2, '2024-01-02', 102, 'Anita', 'North', 'Electronics', 'Mobile', 15000, 1, 5),
(3, '2024-01-03', 103, 'vasantha', 'West', 'Clothing', 'Shirt', 2000, 3, 15),
(4, '2024-01-04', 104, 'Priya', 'East', 'Furniture', 'Table', 8000, 1, 12),
(5, '2024-01-05', 105, 'Rahithya', 'South', 'Electronics', 'Laptop', 50000, 1, 8),
(6, '2024-01-06', 106, 'Sneha', 'North', 'Clothing', 'Jeans', 2500, 2, 10),
(7, '2024-01-07', 107, 'Aruna', 'West', 'Furniture', 'Sofa', 20000, 1, 20),
(8, '2024-01-08', 108, 'pavitra', 'East', 'Electronics', 'TV', 30000, 1, 10),
(9, '2024-01-09', 109, 'Meena', 'South', 'Clothing', 'Saree', 4000, 2, 5),
(10, '2024-01-10', 110, 'indu', 'North', 'Furniture', 'Bed', 25000, 1, 15);

UPDATE sales_data
SET discount = 20
WHERE product_category = 'Furniture';

DELETE FROM sales_data
WHERE sales_amount=1000;

TRUNCATE TABLE sales_data;




