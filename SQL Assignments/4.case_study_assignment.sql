use nineam_class;  -- DOUBT QUESTIONS ASK (16,17,27,37,38(2),
select * from retail_orders_data;
-- 1. Management wants the top 5 highest sales orders.
select customer_name,sales  
from retail_orders_data
group by customer_name,sales
order by sales desc
limit 5;

-- 2. Find categories where average profit is negative.
select category,avg(profit) as avg_profit
from retail_orders_data
group by category
having avg_profit < 0;

-- 3. Find states generating more than ₹1,00,000 sales.
select city,sales
from retail_orders_data
where sales > 100000
group by city,sales;

-- 4. Management wants delayed deliveries above 5 days.
SELECT order_id, customer_name,
DATEDIFF(ship_date, order_date) AS delivery_days
FROM retail_orders_data
WHERE DATEDIFF(ship_date, order_date) > 5;

/*
5. Identify risky orders:
Conditions:
Returned orders
Negative profit
Discount above ₹1000
*/

select order_id,order_status,profit,discount
from retail_orders_data
where order_status = "Returned" and profit < 0 and discount > 1000;

-- 6. Classify customers based on sales amount, sales >= 50000(VIP), sales between 10000 and 49999 (premium) rest regular customers 
SELECT customer_name,sales as sales_amount,
CASE
    WHEN sales >= 50000 THEN 'VIP'
    WHEN sales BETWEEN 10000 AND 49999 THEN 'Premium'
    ELSE 'Regular'
END AS customer_type
FROM retail_orders_data
GROUP BY customer_name,sales;

-- 7. Find cities with more than 2 orders.
select city,count(order_id) as total_orders
from retail_orders_data
group by city
having total_orders > 2;

-- 8. Find categories having average rating above 4.
select category, avg(rating) as avg_rating
from retail_orders_data
group by category
having avg_rating > 4;

-- 9. Show monthly sales trend
select monthname(order_date) as month,sum(sales) as total_sales
from retail_orders_data
group by monthname(order_date)
order by month;

-- 10. Find total cancelled and pending orders.
select order_status,count(order_id) as total_orders
from retail_orders_data
where order_status in ("cancelled","pending")
group by order_status;

-- 11. Find products where customer names contain “Kumar”
select product_name,customer_name
from retail_orders_data
where customer_name like "%kumar%";

-- 12. Extract first name from customer names.
SELECT customer_name,
SUBSTRING_INDEX(customer_name,' ',1) AS first_name
FROM retail_orders_data;

-- 13. Replace spaces in product names with underscores.
SELECT product_name,
REPLACE(product_name,' ','_') AS updated_name
FROM retail_orders_data;

-- 14. Find all weekend orders.
SELECT ORDER_DATE , SALES,
DAYNAME(ORDER_DATE),
DAYOFWEEK(ORDER_DATE)
FROM DATE_DATA_ORDERS
WHERE DAYOFWEEK(ORDER_DATE) IN (1,7)
ORDER BY DAYOFWEEK(ORDER_DATE) ;

-- 15. Management wants expected delivery date by adding 5 days to order date.
SELECT order_id,order_date,
       DATE_ADD(ORDER_DATE, INTERVAL 5 DAY ) AS ADD_5_DAYS
from retail_orders_data;

-- 16. Find orders placed in the last 30 days from current date.
select *
from retail_orders_data
where order_date >  curdate() - interval 30 day;

-- 17. Generate monthly sales reporting date.Report should be generated 2 days after month end.
SELECT order_id,
LAST_DAY(order_date) + INTERVAL 2 DAY AS report_date
FROM retail_orders_data;

-- 18. Find orders where expected delivery crossed month end.
SELECT order_id, order_date
FROM retail_orders_data
WHERE DATE_ADD(order_date, INTERVAL 5 DAY) > LAST_DAY(order_date);

-- 19. Find orders placed exactly 1 month ago from today.
select *
from retail_orders_data
where curdate() - interval 1 month;

-- 20. Find number of days remaining for month end from order date.
select order_id,order_date,
datediff(last_day(order_date),order_date) as remaining_days
from retail_orders_data;

-- 21. Find all orders placed in quarter 2.
SELECT *
FROM retail_orders_data
WHERE QUARTER(order_date) = 2;

-- 22. Find orders shipped within 3 days.
select *
from retail_orders_data
where datediff(ship_date,order_date) <=3;

-- 23. Find month-end sales rush orders. Orders placed in last 5 days of month.
select *
from retail_orders_data
WHERE DAY(LAST_DAY(order_date)) - DAY(order_date) <= 5;

-- 24. Management wants reminder date 3 days before shipping.
SELECT order_id, ship_date,
DATE_SUB(ship_date, INTERVAL 3 DAY) AS reminder_date
FROM retail_orders_data;

-- 25. Find first day of next month.
SELECT DATE_ADD(LAST_DAY(CURDATE()), INTERVAL 1 DAY) AS first_day_next_month;

-- 26. Find orders delivered after expected delivery date. Assume expected delivery is within 5 days.
SELECT order_id, ship_date,order_date
FROM retail_orders_data
where ship_date > DATE_ADD(order_date, INTERVAL 5 DAY);

/*
27. Management wants customer initials for ID card generation.
sample output:
customer_name	initials
Ravi Kumar	RK
*/

-- 28. Find regions with more than 2 Electronics orders.
select region ,count(order_date) as total_orders
from retail_orders_data
where category = "electronics"
group by region
having total_orders > 2;

-- 29. Find products contributing 50K+ revenue.
SELECT product_name, SUM(sales) AS revenue
FROM retail_orders_data
GROUP BY product_name
HAVING SUM(sales) >= 50000;

/*
30. Identify fake discount strategy.
Conditions
High discount
Negative profit. 
*/
select *
from retail_orders_data
where discount > 1000 and profit < 0;

-- 31. Find repeat cities with both Delivered and Returned orders.
select city 
from retail_orders_data
where order_status in ("returned","delivered")
GROUP BY city
HAVING COUNT(DISTINCT order_status) = 2;

/*
32. Find orders where profit is NULL and classify reason
	order_id	order_status	reason
	104	Cancelled	Order Cancelled.
*/
SELECT order_id,order_status,
CASE
    WHEN profit IS NULL AND order_status='Cancelled'
    THEN 'Order Cancelled'
    ELSE 'Check Order'
END AS reason
FROM retail_orders_data;

-- 33. Generate category-wise pivot sales report.
select category,sum(sales) as total_sales
from retail_orders_data
group by category
having total_sales;
           --    ************OR**************
SELECT
SUM(CASE WHEN category='Furniture' THEN sales ELSE 0 END) AS Furniture,
SUM(CASE WHEN category='Electronics' THEN sales ELSE 0 END) AS Electronics,
SUM(CASE WHEN category='fashion' THEN sales ELSE 0 END) AS fashion,
SUM(CASE WHEN category='beuty' THEN sales ELSE 0 END) AS beuty,
SUM(CASE WHEN category='home appliances' THEN sales ELSE 0 END) AS home_appliances
FROM retail_orders_data;

/*
34. Management wants delivery performance classification.
    if delivery days <=3, fast delivery
    delivery days between 4 and 5, normal delivery
    else delivery delayed
    Sample Output
order_id	customer_name	delivery_days	delivery_status
101	Ravi Kumar	3	Fast Delivery
109	Vikram Patel	6	Delayed Delivery
*/

select order_id,customer_name, 
datediff(ship_date,order_date) as delivery_days,
CASE
    WHEN datediff(ship_date,order_date) <=3 THEN 'Fast Delivery'
    WHEN datediff(ship_date,order_date) BETWEEN 4 AND 5 THEN 'Normal Delivery'
    ELSE 'Delayed Delivery'
END AS delivery_status
from retail_orders_data;

/*
35. Identify products with high discount but low customer satisfaction.
Conditions
Discount > 3000
Rating <= 2
Sample Output
product_name	discount	rating
Air Conditioner	4500	2
*/
select product_name,discount,rating
from retail_orders_data
where discount > 3000 and rating <=2;

/*
36. tate-wise KPI Dashboard Query
Business Requirement

Management wants a state-wise KPI dashboard showing:

Total Orders
Total Sales
Total Profit
Average Discount
Delivered Orders
Returned Orders
Cancelled Orders
Average Rating
Profit Margin %
Total Customers
Sample Output
state_name	total_orders	total_sales	total_profit	avg_discount	delivered_orders	returned_orders	cancelled_orders	avg_rating	profit_margin_percent	total_customers
Hyderabad	28	1452000	382500	2850	24	3	0	4.3	26.34	6
Delhi	16	1185000	324200	3200	14	0	1	4.8	27.35	3
Chennai	18	865000	228500	2100	17	0	0	4.5	26.42	3
*/

SELECT city,
COUNT(order_id) AS total_orders,
SUM(sales) AS total_sales,
SUM(profit) AS total_profit,
AVG(discount) AS avg_discount,
SUM(case WHEN order_status='Delivered' THEN 1 ELSE 0 end) AS delivered_orders,
SUM(case WHEN order_status='Returned' THEN 1 ELSE 0 end) AS returned_orders,
SUM(case WHEN order_status='Cancelled' THEN 1 ELSE 0 end) AS cancelled_orders,
AVG(rating) AS avg_rating,
ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin_percent,
COUNT(DISTINCT customer_name) AS total_customers
FROM retail_orders_data
GROUP BY city;

-- 37. Find sales contribution percentage by city.
SELECT city,SUM(sales) AS total_sales,
ROUND((SUM(sales) / (SELECT SUM(sales) FROM retail_orders_dataset))*100,2)
FROM retail_orders_data
GROUP BY city; 

/*
38. Business Requirement
Management wants performance classification.
Excellent → Profit Margin > 25%
Good → Profit Margin 15-25%
Poor → Profit Margin < 15%
Sample Output
city	total_sales	total_profit	profit_margin	performance_status
Hyderabad	1452000	382500	26.34	Excellent
Delhi	1185000	324200	27.35	Excellent
Mumbai	156000	18200	11.67	Poor
*/
select city,sum(sales) as total_sales,sum(profit) as total_profit ,
ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin_percent,
case
when ROUND((SUM(profit)/SUM(sales))*100,2) > 25  then "Excellent" 
when ROUND((SUM(profit)/SUM(sales))*100,2) between 15 and 25  then "Good" 
else "Poor" 
end as performance_status
from  retail_orders_data
group by city;

/*
38. Extract domain-style short names. ex: 
sample output
customer_nme order_id name
ravi kumar  1001      ravi1001
*/
select customer_name,order_id,
CONCAT(LOWER(SUBSTRING_INDEX(customer_name,' ',1)),order_id) AS short_name
from retail_orders_data;

-- 39. Find names longer than 12 characters.
select customer_name,length(customer_name) as length
from retail_orders_data
where length(customer_name) > 12;

/*
40. Generate customer codes.
Format: HYD_RAVI_101
*/
SELECT customer_name,city,order_id,
CONCAT(UPPER(LEFT(city,3)),'_',
UPPER(SUBSTRING_INDEX(customer_name,' ',1)),'_',order_id) AS customer_code
FROM retail_orders_data;

/*
41. Generate email-style usernames.
Example:Ravi Kumar → ravi.kumar
*/
select customer_name,
concat(replace(customer_name,' ','.')) as email
from retail_orders_data;

/*
42. Create masked customer names.
Example:Ravi Kumar → Ravi ****
*/
select customer_name,
CONCAT(SUBSTRING_INDEX(customer_name,' ',1),' ****')
AS masked_name
from retail_orders_data;

-- 43. Extract last name, first_name from customer names.
select customer_name,
SUBSTRING_INDEX(customer_name,' ',1) AS first_name,
SUBSTRING_INDEX(customer_name,' ',-1) AS last_name
FROM retail_orders_data;

-- 44. Find customers whose names start with 'R'.
select customer_name
from retail_orders_data
where customer_name like 'R%';

-- 45. Top loss-making products.
SELECT product_name, SUM(profit) AS total_loss
FROM retail_orders_data
GROUP BY product_name
ORDER BY total_loss ASC
LIMIT 5;

-- 46. Generate Customer Feedback Labels.rating =5, excellent, ratin >=3 (good), rating<3, (poor) else no rating
select customer_name,rating,
CASE
    WHEN rating =5 THEN 'Excellent'
    WHEN rating >=3 THEN 'good'
    WHEN rating <5 THEN 'poor'
    ELSE 'No rating'
END AS feedback
from retail_orders_data;

-- 47. Find repeat states with both Delivered and Returned orders.
select city 
from retail_orders_data
where order_status in ("returned","delivered")
GROUP BY city
HAVING COUNT(DISTINCT order_status) = 2;

-- 48. CASE WITH PIVOT REPORT Monthly Category Sales Dashboard
SELECT
MONTH(order_date) AS month,
SUM(CASE WHEN category='Furniture' THEN sales ELSE 0 END) AS Furniture,
SUM(CASE WHEN category='Electronics' THEN sales ELSE 0 END) AS Electronics,
SUM(CASE WHEN category='fashion' THEN sales ELSE 0 END) AS fashion,
SUM(CASE WHEN category='beuty' THEN sales ELSE 0 END) AS beuty,
SUM(CASE WHEN category='home appliances' THEN sales ELSE 0 END) AS home_appliances
FROM retail_orders_data
GROUP BY MONTH(order_date)
ORDER BY month;

-- 49. Find the highest and lowest sales by category. 
SELECT category,
MAX(sales) AS highest_sales,
MIN(sales) AS lowest_sales
FROM retail_orders_data
GROUP BY category;

-- 50. Replace NULL profits with 0.
select order_id,profit,
ifnull(profit,0) as updated_profit
from retail_orders_data;










