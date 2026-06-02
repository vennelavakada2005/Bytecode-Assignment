use nineam_class;
CREATE TABLE sub_queries_assignment_beauty_orders (
    order_id INT,
    order_date DATE,
    customer_id INT,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    gender VARCHAR(10),
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    brand VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    sales DECIMAL(10,2),
    payment_mode VARCHAR(20),
    order_status VARCHAR(20)
);

INSERT INTO sub_queries_assignment_beauty_orders  VALUES
(1001,'2024-01-05',101,'Aisha','Hyderabad','Female',201,'Vitamin C Serum','Serum','Minimalist',1,699,699,'UPI','Delivered'),

(1002,'2024-01-10',102,'Rahul','Bangalore','Male',202,'Hydrating Face Wash','Cleanser','Cetaphil',2,450,900,'Card','Delivered'),

(1003,'2024-01-15',103,'Sneha','Chennai','Female',203,'Niacinamide Serum','Serum','Derma Co',1,599,599,'COD','Cancelled'),

(1004,'2024-02-01',101,'Aisha','Hyderabad','Female',205,'Sunscreen SPF 50','Sunscreen','Aqualogica',2,499,998,'UPI','Delivered'),

(1005,'2024-02-05',104,'Arjun','Mumbai','Male',206,'Retinol Cream','Cream','Skinkraft',1,899,899,'Card','Delivered'),

(1006,'2024-02-12',105,'Meera','Delhi','Female',204,'Aloe Vera Gel','Moisturizer','Plum',3,299,897,'UPI','Delivered'),

(1007,'2024-02-20',106,'Karan','Pune','Male',208,'Hyaluronic Acid Serum','Serum','Minimalist',1,799,799,'COD','Delivered'),

(1008,'2024-03-01',107,'Diya','Hyderabad','Female',205,'Sunscreen SPF 50','Sunscreen','Aqualogica',1,499,499,'UPI','Returned'),

(1009,'2024-03-05',108,'Varun','Kolkata','Male',210,'Under Eye Cream','Cream','Skinkraft',1,999,999,'Card','Delivered'),

(1010,'2024-03-11',109,'Pooja','Jaipur','Female',209,'Rice Water Toner','Toner','Plum',2,399,798,'UPI','Delivered'),

(1011,'2024-03-15',110,'Nikhil','Delhi','Male',207,'Tea Tree Face Wash','Cleanser','Mamaearth',2,349,698,'COD','Pending'),

(1012,'2024-04-01',102,'Rahul','Bangalore','Male',201,'Vitamin C Serum','Serum','Minimalist',1,699,699,'UPI','Delivered'),

(1013,'2024-04-05',103,'Sneha','Chennai','Female',206,'Retinol Cream','Cream','Skinkraft',2,899,1798,'Card','Delivered'),

(1014,'2024-04-18',104,'Arjun','Mumbai','Male',205,'Sunscreen SPF 50','Sunscreen','Aqualogica',1,499,499,'UPI','Delivered'),

(1015,'2024-04-22',101,'Aisha','Hyderabad','Female',208,'Hyaluronic Acid Serum','Serum','Minimalist',1,799,799,'Card','Delivered'),

(1016,'2024-05-02',105,'Meera','Delhi','Female',203,'Niacinamide Serum','Serum','Derma Co',2,599,1198,'UPI','Delivered'),

(1017,'2024-05-10',106,'Karan','Pune','Male',204,'Aloe Vera Gel','Moisturizer','Plum',1,299,299,'COD','Delivered'),

(1018,'2024-05-12',107,'Diya','Hyderabad','Female',210,'Under Eye Cream','Cream','Skinkraft',1,999,999,'Card','Delivered'),

(1019,'2024-05-18',108,'Varun','Kolkata','Male',205,'Sunscreen SPF 50','Sunscreen','Aqualogica',3,499,1497,'UPI','Delivered'),

(1020,'2024-05-25',109,'Pooja','Jaipur','Female',201,'Vitamin C Serum','Serum','Minimalist',2,699,1398,'Card','Delivered'),

(1021,'2024-06-01',110,'Nikhil','Delhi','Male',206,'Retinol Cream','Cream','Skinkraft',1,899,899,'UPI','Delivered'),

(1022,'2024-06-08',101,'Aisha','Hyderabad','Female',209,'Rice Water Toner','Toner','Plum',1,399,399,'UPI','Delivered'),

(1023,'2024-06-15',102,'Rahul','Bangalore','Male',210,'Under Eye Cream','Cream','Skinkraft',1,999,999,'Card','Delivered'),

(1024,'2024-06-20',103,'Sneha','Chennai','Female',202,'Hydrating Face Wash','Cleanser','Cetaphil',2,450,900,'COD','Delivered'),

(1025,'2024-06-28',104,'Arjun','Mumbai','Male',208,'Hyaluronic Acid Serum','Serum','Minimalist',2,799,1598,'UPI','Delivered');


-- ****************************************************************************** ---
-- SCALAR SUB QUERY
-- 1. Show every order along with overall average sales.          
SELECT ORDER_DATE,SALES,
		  (SELECT ROUND(AVG(SALES)) AS AVG_SALARY FROM sub_queries_assignment_beauty_orders)AS AVG_SALARY 
FROM sub_queries_assignment_beauty_orders;

-- 2. Show each product with maximum sales value.
SELECT PRODUCT_NAME,SALES,
          (SELECT (MAX(SALES)) AS MAX_SALES FROM sub_queries_assignment_beauty_orders) AS MAX_SALES
FROM sub_queries_assignment_beauty_orders
GROUP BY PRODUCT_NAME,SALES;

-- 3. Show each customer order with total company revenue.
SELECT ORDER_ID,CUSTOMER_ID,SALES,
     (SELECT (SUM(SALES)) AS TOTAL_REVENUE FROM sub_queries_assignment_beauty_orders) AS TOTAL_REVENUE
FROM sub_queries_assignment_beauty_orders;

-- 4. Show each order with total number of customers.
SELECT ORDER_ID,
      (SELECT (COUNT(ORDER_ID)) AS TOTAL_NUMBER FROM sub_queries_assignment_beauty_orders) AS TOTAL_NUMBER
FROM sub_queries_assignment_beauty_orders;

-- 5. Show each order with latest order date in dataset.
SELECT ORDER_ID,ORDER_DATE,
    (SELECT(MAX(ORDER_DATE)) AS LATEST_ORDER_DATE FROM sub_queries_assignment_beauty_orders) AS LATEST_ORDER_DATE
FROM sub_queries_assignment_beauty_orders;


-- SINGLE ROW SUB-QUERY
-- 1. Find orders having sales greater than average sales.
SELECT ORDER_ID,SALES,(SELECT ROUND(AVG(SALES)) AS AVG_SALES FROM sub_queries_assignment_beauty_orders)AS AVG_SALES
FROM sub_queries_assignment_beauty_orders
WHERE SALES > (SELECT ROUND(AVG(SALES)) AS AVG_SALES FROM sub_queries_assignment_beauty_orders);

-- 2. Find products priced higher than Vitamin C Serum.
SELECT *
FROM sub_queries_assignment_beauty_orders
WHERE PRICE >
(  
SELECT MAX(PRICE) AS MAX_SALES  
FROM sub_queries_assignment_beauty_orders
WHERE PRODUCT_NAME = "Vitamin C Serum"
);

-- 3. Find orders placed after the first order date.
SELECT *
FROM  sub_queries_assignment_beauty_orders
WHERE ORDER_DATE >
(
SELECT MIN(ORDER_DATE) AS FIRST_ORDER_DATE
FROM sub_queries_assignment_beauty_orders
);

-- 4. Find customers whose sales is greater than Rahul’s sales.
SELECT *
FROM sub_queries_assignment_beauty_orders
WHERE SALES > 
(
SELECT MAX(SALES) AS MAXX
FROM sub_queries_assignment_beauty_orders
WHERE CUSTOMER_NAME = "RAHUL"
);

-- 5. Find products having price less than highest product price.
SELECT * 
FROM sub_queries_assignment_beauty_orders
WHERE PRICE < 
(
SELECT MAX(PRICE) AS MAXX
FROM sub_queries_assignment_beauty_orders
);

-- MULTIPLE ROW SUB-QUERY
-- 1. Find customers who purchased Serum products.
SELECT CUSTOMER_NAME,PRODUCT_NAME
FROM sub_queries_assignment_beauty_orders
WHERE PRODUCT_ID in
(
SELECT PRODUCT_ID
FROM sub_queries_assignment_beauty_orders
WHERE PRODUCT_NAME LIKE "%SERUM%"
);

-- 2. Find customers who never purchased Cream category.
SELECT CUSTOMER_NAME,PRODUCT_NAME
FROM sub_queries_assignment_beauty_orders
WHERE PRODUCT_ID NOT in
(
SELECT PRODUCT_ID
FROM sub_queries_assignment_beauty_orders
WHERE PRODUCT_NAME LIKE "%CREAM%"
);

-- 3. Find products ordered by Hyderabad customers.
SELECT PRODUCT_NAME,CITY
FROM sub_queries_assignment_beauty_orders
WHERE CUSTOMER_ID in
(
SELECT CUSTOMER_ID
FROM sub_queries_assignment_beauty_orders
WHERE CITY ="HYDERABAD"
);

-- 4. Find brands purchased by female customers.
SELECT BRAND,GENDER
FROM sub_queries_assignment_beauty_orders
WHERE CUSTOMER_ID in
(
SELECT CUSTOMER_ID
FROM sub_queries_assignment_beauty_orders
WHERE GENDER ="FEMALE"
);

-- 5. Find orders containing products priced above 800.
SELECT ORDER_ID,PRODUCT_NAME,PRICE
FROM sub_queries_assignment_beauty_orders
WHERE PRODUCT_ID in
(
SELECT PRODUCT_ID
FROM sub_queries_assignment_beauty_orders
WHERE PRICE > 800
);

-- CORRELATED SUB QUERYS
-- 1. Find highest sales order for each customer. 
 SELECT CUSTOMER_NAME,SALES
 FROM sub_queries_assignment_beauty_orders S1
 WHERE SALES =
 (
 SELECT MAX(SALES) AS MAXX 
 FROM sub_queries_assignment_beauty_orders S2
 WHERE S1.CUSTOMER_ID = S2.CUSTOMER_ID
 );

-- 2. Find products priced above their category average price.
SELECT PRODUCT_NAME,PRICE,CATEGORY
FROM sub_queries_assignment_beauty_orders S1
WHERE PRICE > 
(
SELECT AVG(PRICE) AS AVG_PRICE
FROM sub_queries_assignment_beauty_orders S2
WHERE S1.CATEGORY = S2.CATEGORY
);

-- 3. Find customers whose sales are above their own average sales.
SELECT CUSTOMER_NAME,SALES
FROM sub_queries_assignment_beauty_orders S1
WHERE SALES > 
(
SELECT AVG(SALES) AS AVG_SALES
FROM sub_queries_assignment_beauty_orders S2
WHERE S1.CUSTOMER_ID = S2.CUSTOMER_ID
);

-- 4. Find latest order for each customer.
SELECT CUSTOMER_NAME,ORDER_DATE
FROM sub_queries_assignment_beauty_orders S1
WHERE ORDER_DATE = 
(
SELECT MAX(ORDER_DATE) AS MAXX
FROM sub_queries_assignment_beauty_orders S2
WHERE S1.CUSTOMER_ID = S2.CUSTOMER_ID
);

-- 5. Find products having sales greater than average sales of their brand.
SELECT PRODUCT_NAME,SALES,BRAND
FROM sub_queries_assignment_beauty_orders S1
WHERE SALES > 
(
SELECT AVG(SALES) AS AVG_SALES
FROM sub_queries_assignment_beauty_orders S2
WHERE S1.BRAND = S2.BRAND
);


-- 1. Find customers who placed at least one delivered order.
SELECT CUSTOMER_NAME,ORDER_STATUS
FROM sub_queries_assignment_beauty_orders S1
WHERE CUSTOMER_ID IN
(
SELECT CUSTOMER_ID
FROM sub_queries_assignment_beauty_orders S2
WHERE ORDER_STATUS = 'Delivered'
);


-- 2. Find customers who never placed cancelled orders.
SELECT CUSTOMER_NAME,ORDER_STATUS
FROM sub_queries_assignment_beauty_orders S1
WHERE CUSTOMER_ID NOT IN
(
SELECT CUSTOMER_ID
FROM sub_queries_assignment_beauty_orders S2
WHERE ORDER_STATUS = 'CANCELLED'
);

-- 3. Find products never returned.
SELECT CUSTOMER_NAME,ORDER_STATUS
FROM sub_queries_assignment_beauty_orders S1
WHERE CUSTOMER_ID NOT IN
(
SELECT CUSTOMER_ID
FROM sub_queries_assignment_beauty_orders S2
WHERE ORDER_STATUS = 'RETURNED'
);

-- 4. Find brands having at least one order above 1500 sales.
SELECT BRAND,SALES
FROM sub_queries_assignment_beauty_orders S1
WHERE PRODUCT_ID IN
(
SELECT PRODUCT_ID
FROM sub_queries_assignment_beauty_orders S2
WHERE SALES > 1500
);


-- 5. Find customers who never purchased Sunscreen products.
SELECT CUSTOMER_NAME,CATEGORY
FROM sub_queries_assignment_beauty_orders S1
WHERE CUSTOMER_ID NOT IN
(
SELECT CUSTOMER_ID
FROM sub_queries_assignment_beauty_orders S2
WHERE CATEGORY = 'SUNSCREEN'
);







