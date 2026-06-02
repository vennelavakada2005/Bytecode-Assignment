#Assignment Questions
-- PART 1 — Basic Window Functions
#1. Assign row numbers for each customer based on order date.
select order_date,customer_name,
row_number()over (partition by customer_name order by order_date)as row_num
from assignment_ecommerce_orders;

#2. Rank customers based on highest sales amount.
select customer_name,sales_amount,
dense_rank()over(partition by customer_name order by sales_amount desc) as rnk_num
from assignment_ecommerce_orders;

#3. Find dense rank of products within each category.
select product_name,category,
dense_rank()over(partition by category order by order_date desc) as dens_rnk
from assignment_ecommerce_orders;

#4. Find duplicate sales amounts using RANK() and DENSE_RANK().
select sales_amount,
dense_rank()over( order by sales_amount desc) as dens_rnk,
rank()over(order by sales_amount desc) as rnk_num
from assignment_ecommerce_orders;

#5. Display previous purchase amount for every customer using LAG().
select sales_amount,customer_name,
lag(sales_amount) over(partition by customer_name order by sales_amount) as lag_sales
from assignment_ecommerce_orders;

#6. Display next purchase amount using LEAD().
select sales_amount,
lead(sales_amount) over( order by sales_amount) as lead_sales
from assignment_ecommerce_orders;

#7. Find sales difference between current and previous purchase.
select order_date,
      sales_amount current_sale,
      lag(sales_amount) over(order by order_date) as previous_sales,
      lead(sales_amount) over( order by order_date) as nxt_sales,
	sales_amount - lag(sales_amount) over(order by order_date) as sales_difference
from assignment_ecommerce_orders;
      
#8. Find percentage increase/decrease from previous purchase.
SELECT CUSTOMER_NAME,ORDER_DATE,SALES_AMOUNT,
       ROUND(
       ((SALES_AMOUNT -
       LAG(SALES_AMOUNT) OVER(PARTITION BY CUSTOMER_NAME ORDER BY ORDER_DATE))
       /
       LAG(SALES_AMOUNT) OVER(PARTITION BY CUSTOMER_NAME ORDER BY ORDER_DATE)
       ) * 100,2) AS PERCENT_CHANGE
FROM assignment_ecommerce_orders;


 
-- PART 2 — Running & Rolling Calculations-p--
#9. Calculate running total sales for each customer
select customer_name,order_date,sales_amount,
      sum(sales_amount)over(order by order_date) as rolling_sales
from assignment_ecommerce_orders;

#10. Calculate cumulative sales month-wise.
select sales_amount,month(order_date),
sum(sales_amount)over(order by month(order_date)) as cumulative_sales
from assignment_ecommerce_orders;

#11. Calculate rolling 3-day sales.
select sales_amount,order_date,
sum(sales_amount) over(order by order_date rows between 2 preceding and current row) as sal_value
from assignment_ecommerce_orders;

#12. Calculate rolling 3-order average sales.
select sales_amount,order_date,
round(avg(sales_amount) over(order by order_date rows between 2 preceding and current row)) as sal_value
from assignment_ecommerce_orders;

#13. Find moving average sales for each customer.
select sales_amount,order_date,
round(avg(sales_amount) over( partition by customer_name order by order_date))as sal_value
from assignment_ecommerce_orders;

#14. Calculate cumulative category sales.
select sales_amount,category,
sum(sales_amount) over(order by category) as cummilative_sales
from assignment_ecommerce_orders;

-- PART 3 — FIRST_VALUE / LAST_VALUE ---
#15. Find first purchase amount of every customer.
select sales_amount ,customer_name,order_date,
first_value(sales_amount)over (partition by customer_name order by order_date) as fst_value
from assignment_ecommerce_orders;

#16. Find latest purchase amount of every customer.
select sales_amount ,customer_name,order_date,
last_value(sales_amount)over (partition by customer_name order by order_date) as lst_value
from assignment_ecommerce_orders;

#17. Find first product purchased in each category.
select product_name,order_date,category,
first_value(product_name) over (partition by category order by order_date) as fst_product
from assignment_ecommerce_orders;

#18. Find last product purchased by each customer.
select product_name,order_date,customer_name,
last_value(product_name) over (partition by customer_name order by order_date) as last_product
from assignment_ecommerce_orders;

#19. Compare current purchase with first purchase.
 select sales_amount, customer_name,
 first_value(sales_amount) over(partition by customer_name order by order_date) as fst_purchase,
         sales_amount -
         first_value(sales_amount) over(partition by customer_name order by order_date) as current_purchase
         from assignment_ecommerce_orders;
         
#20. Compare current purchase with latest purchase
select sales_amount,customer_name,
last_value(sales_amount) over(partition by customer_name order by order_date) as latest_purchase,
         sales_amount -
         last_value(sales_amount) over(partition by customer_name order by order_date) as current_purchase
         from assignment_ecommerce_orders;
         
-- PART 4 — NTILE / Percentile Functions --
#21. Divide customers into 4 spending groups using NTILE(4).
select customer_name,sales_amount,
ntile(4) over (order  by sales_amount desc ) as customer_group 
from assignment_ecommerce_orders;

#22. Find top 25% customers based on sales. 
select *from (
select customer_name,sales_amount,
ntile(4) over (partition by sales_amount ) as customer_group 
from assignment_ecommerce_orders
) a
where customer_group = 1;

#23. Calculate PERCENT_RANK() for sales amount.
select sales_amount,customer_name,
percent_rank() over (partition  by customer_name order by order_date) as prcnt_rnk
from assignment_ecommerce_orders;

#24. Calculate CUME_DIST() for customer sales.
select sales_amount,customer_name,
cume_dist() over (partition  by customer_name order by order_date) as cum_dst
from assignment_ecommerce_orders;
#25. Identify customers whose sales fall above 80% distribution.
select * from (
select sales_amount,customer_name,
cume_dist() over (partition  by customer_name order by order_date) as cum_dst
from assignment_ecommerce_orders
) a 
where cum_dst >0.8;


--- PART 5 — Window Frames ---
#26. Calculate running total using:
select sales_amount,order_date,
sum(sales_amount) over(order by order_date rows between unbounded preceding  and current row) as sal_value 
from assignment_ecommerce_orders;

#27. Calculate next 2 orders sales using:
select sales_amount,order_date,
sum(sales_amount) over(order by order_date rows between current row and 2 following) as sal_value 
from assignment_ecommerce_orders;

#28. Calculate previous 2 orders sales using:
select sales_amount,order_date,
sum(sales_amount) over(order by order_date rows between 2 preceding and current row) as sal_value 
from assignment_ecommerce_orders;

#29. Find centered moving average using:
select sales_amount,order_date,
sum(sales_amount) over(order by order_date rows between 1 preceding and 1 following) as sal_value 
from assignment_ecommerce_orders;

#30. Compare all window frame outputs in one query.
 select customer_name,sales_amount,
 sum(sales_amount) over (order by order_date rows between unbounded preceding and current row) as running_total,
 sum(sales_amount) over (order by order_date rows between current row and 2 following ) as next2,
 sum(sales_amount) over (order by order_date rows between 2 preceding and current row) as prev2
 from assignment_ecommerce_orders;

 
-- PART 6 — Real-Time Business Scenarios--
#31. Find top 3 highest sales every month.
select * from 
(
select month(order_date) as month_num,customer_name,sales_amount,
   rank() over(partition by month(order_date) order by sales_amount desc) as rnk
from assignment_ecommerce_orders
) a
where rnk <= 3;

#32. Find customer who purchased continuously for 3 months.
select customer_name,
	count(distinct month(order_date)) as months
from assignment_ecommerce_orders
group by customer_name
having months >= 3;

#33. Find repeat customers.
select customer_name,
     count(*) as total_orders
from assignment_ecommerce_orders
group by customer_name
having count(*) > 1;

#34. Find customers whose current purchase is lower than previous purchase.
select customer_name,order_date,sales_amount,
	lag(sales_amount) over(partition by customer_name order by order_date) as prev_sales
from assignment_ecommerce_orders;

#35. Find highest selling category every month.
select *from
(
select month(order_date) as month_num,category,
       sum(sales_amount) as total_sales,
       rank() over(partition by month(order_date) order by sum(sales_amount) desc) as rnk
from assignment_ecommerce_orders
group by month(order_date),category
)a 
where rnk = 1;

#36. Find contribution % of each order to total monthly sales.
select order_date,sales_amount,
    round(sales_amount * 100 / sum(sales_amount) over(partition by month(order_date)),2) as contribution_percent
from assignment_ecommerce_orders;

#37. Find customers contributing highest revenue.
select customer_name,sum(sales_amount) as total_revenue,
    rank() over(order by sum(sales_amount) desc) as rnk
from assignment_ecommerce_orders
group by customer_name;

#38. Identify low-performing months.
select month(order_date) as month_num,sum(sales_amount) as total_sales
from assignment_ecommerce_orders
group by month(order_date)
having total_sales <=
(
select avg(sales_amount)
from assignment_ecommerce_orders
);

#39. Find purchase gap between consecutive orders.
select customer_name,order_date,
datediff(order_date,lag(order_date)over(partition by customer_name order by order_date)) as gap_days
from assignment_ecommerce_orders;

#40. Find customers whose sales are continuously increasing.
select customer_name,order_date,sales_amount,
lag(sales_amount)over(partition by customer_name order by order_date) as increasing_sales
from assignment_ecommerce_orders;


#------------ Advanced Questions --------------
#41. Find second highest purchase of every customer.
select * 
from 
(
select customer_name,sales_amount,
     dense_rank() over(partition by customer_name order by sales_amount desc) as rnk 
from assignment_ecommerce_orders
) a
where rnk = 2 ;

#42. Find nth highest sales using window functions.
select *
from 
(
select customer_name,sales_amount,
	dense_rank() over(partition by customer_name order by sales_amount desc) as rnk
from assignment_ecommerce_orders
) a 
where rnk = 5;

#43. Remove duplicates using ROW_NUMBER().
select *
from (
select *,
      row_number() over(partition by customer_name,order_date,sales_amount order by order_date) as rnk
from assignment_ecommerce_orders
) a 
where rnk = 1;
      
#44. Find first and last purchase date of each customer.
select customer_name,order_date,sales_amount,
      first_value(order_date) over(partition by customer_name order by  order_date) as first_purchase,
      last_value(order_date) over(partition by customer_name order by order_date rows between unbounded preceding and unbounded following) as lst_purchase
from assignment_ecommerce_orders; 
           
#45. Find highest purchase growth month-over-month.
select customer_name,date_format(order_date,"%m")as month_wise,sales_amount,
     max(sales_amount) over(partition by customer_name,date_format(order_date,"%m") order by date_format(order_date,"%m"))as highest_purchase
     from assignment_ecommerce_orders;

#46. Find customers whose purchase amount is above customer average.
select customer_name,sales_amount
from(
select customer_name,sales_amount,
	round(avg(sales_amount) over (partition by customer_name)) as avg_sales
from assignment_ecommerce_orders
) a
where sales_amount > avg_sales;

#47. Find monthly sales trend using LAG().
select month(order_date) as month_num,sum(sales_amount) as monthly_sales,
    lag(sum(sales_amount)) over(order by month(order_date)) as prev_month_sales
from assignment_ecommerce_orders
group by month(order_date);

#48. Compare each month's sales with previous month.
select month(order_date) as month_num,sum(sales_amount) as monthly_sales,
     sum(sales_amount)-
     lag(sum(sales_amount)) over(order by month(order_date))as comparision
from assignment_ecommerce_orders
group by month(order_date);

#49. Find highest order of every category.
select *
from 
(
select customer_name,sales_amount,category,
	dense_rank() over(partition by category order by sales_amount desc) as rnk
from assignment_ecommerce_orders
) a
where rnk =1;  
  
#50. Find customer retention month-wise.
select month(order_date)as month_num,
       count(distinct customer_name) as retained_customers
from assignment_ecommerce_orders
group by month(order_date);       