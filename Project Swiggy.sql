use swiggy;  
show tables; 
desc items; 
select * from items; 
select * from orders; 

# Query NO.1
# How many distinct items were ordered?
select count(distinct name) from items; 
# 164 unique items were ordered 

# Query no.2
# How many veg and non veg items are ordered? 
select is_veg, count(name)as items from items group by is_veg; 
# 180 veg items were ordered and 12 non-veg and one item probably dessert 


# Query no.3
# How many distinct orders were placed?
select count(distinct order_id) as order_count from orders; 
# There were 95 distinct orders

# Query no.4
# How many items contain the word "Chicken"? 
select count(*)  from items where name like '%chicken%'; 
# 10 items contains the word chicken

# Query no.5 
# How many items contain the word "Paratha"? 
select count(*) from items where name like '%paratha%';  
# 4 items contains the word paratha

# Query no.6 
# What is the average number of items per order?
select count(name)/count(distinct order_id) as avg_items_per_order from items; 
# On an avg per every order 2 items were ordered 

# Query no.7
# How many times each item was ordered? 
select name,count(*) as num_of_order from items group by name order by count(*) desc; 
# We can see here Classic mac & Cheese has the more number of orders followed by Gobi Manchurian, Paneer Butter Masala and so on, so that company knows which of the items the customers are fond of. 

# Query no.8 
# What are the distinct rain modes?
select distinct(rain_mode) from orders; 
# There are three types of rain modes 

# Query no.8 
# How many times "on_time" was delivered?
select distinct(on_time)from orders; 
# Sometimes its delivered on time sometimes its late due to various reasons 

# Query no.9 
# How many distinct restaurants were the orders from? 
select count(distinct restaurant_name) from orders; 
# We have ordered from 49 different restaurants 

# Query no.10 
# Favourite restaurant?
select restaurant_name,count(*) as num_of_order from orders group by restaurant_name order by count(*) desc; 
# The bowl company has got maximum number of orders 

# Query no.11 
# The most recent order that has been made?
select max(order_time) from orders; 
# Recent order was at 5th of february 2022

# Query no.12 
# Average Order Value (On an avg per order how much do the customers spend?)
SELECT sum(order_total)/count(distinct order_id) as avg_order_value
FROM orders; 
# So on an avg customers spend 293.22 ~ Rs 300 per order, 
# previuosly we understood that we order 2 items per order so that means per item per order customers spend ~ Rs 150

# Query no.13 
# YOY Change in revenue using lag function and ranking the highest year 
with final as (
select year(order_time) as year_order, sum(order_total) as revenue from orders group by  year(order_time)) 
select year_order, revenue,lag(revenue) over(order by year_order) as previous_revenue from final; 
# Now we can subtract revenue- previous revenue to find out the percentage growth

# Query no.14  
# Restaurant with highest revenue ranking
with final as (
select restaurant_name,year(order_time) as year_order, sum(order_total) as revenue from orders group by restaurant_name, year_order)
select restaurant_name, revenue,rank() over(order by revenue desc) as ranking from final order by revenue desc; 

 # Query no.15 
 # How much money was made at the time of rain mode? 
 select rain_mode, sum(order_total)from orders group by rain_mode; 
 # Most of the revenue was made when it was not raining and rest are minimal,
 # so better avoid ordering at the time of raining 
 
  # Query no.16 
  # We want to see what all items were ordered in each order? 
  select a.name,a.is_veg,b.restaurant_name,b.order_id,b.order_time from items a join orders b on a.order_id=b.order_id; 
  
   # Query no.17 
   # Product combinations which are ordered together?
   select a.order_id, a.name,b.name as name2,concat(a.name,b.name) as combo from items a 
   join items b on a.order_id=b.order_id where a.name!=b.name and a.name<b.name; 
   # We can find out the combos customers like to order and take decisions accordingly
  
 

