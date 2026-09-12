drop table customers_medium;
create database exercise;
--to show our tables
select table_name
from INFORMATION_SCHEMA.TABLES;
select * from customers_medium;
select * from menu_items;
select * from orders_medium;
select * from restaurants;
select * from [order_items (2)];
--How many total orders were placed?
select count(*) as total_orders from orders_medium;
--total_orders=5000
--Which cities have the most customers?
select 
	city,
	count(*) as city_mostcustomers
from customers_medium
group by city
order by city_mostcustomers desc;
--Bristol 270 then leeds 252 then liverpool 247 city_mostcustomers
--Which cuisine types are most common?
select 
	cuisine,-- cuisine يعنى اي مطبخ او اسلوب طبخ زى المطبخ الايطالى
	count(*) as most_commoncuisine
from restaurants
group by cuisine
order by most_commoncuisine desc; 
-- thai 26 , indian22 , italian 20 most_commoncuisine
--What are the top restaurants by rating?
/*select top 3
rating,
round(count(*),1)as top_rating
from restaurants
group by rating
order by top_rating  desc;*/
select top 3 
	restaurant_id,
	city
from restaurants
order by rating desc;
--restaurabt_id 20.00,then 30.00 then, 115.00
--What is the average delivery time?
select 
avg(DATEDIFF(minute,order_time,delivery_time)) as avg_deliverytime
from orders_medium
-- the average of delivery time is 54
--Which restaurants generate the most revenue?
select * from [order_items (2)];
select * from orders_medium;
/*select oi.order_id,
sum(quantity*price) as mostrevenue
from [order_items (2)] as oi
inner join orders_medium as om
on oi.order_id = om.order_id
where status != 'cancelled'
group by oi.order_id
order by mostrevenue desc;*/
select 
mi.restaurant_id,
round(sum(quantity* ori.price),2) as mostrevnue
from menu_items as mi
inner join [order_items (2)] as ori
on mi.item_id = ori.item_id
inner join orders_medium as om
on ori.order_id = om.order_id
where om.status != 'Cancelled'
group by mi.restaurant_id
order by mostrevnue desc;
-- we find that restaurant _id 46.00 is most revue then 99.00 then 23.00
--What are the most ordered menu items?
select item_id,
sum(quantity) as most
from [order_items (2)]
group by item_id
order by most desc;
-- item_id M0245 IS MOST THEN M0200 THEN M0108
--Which cities generate the highest revenue?
select * from customers_medium;
select * from menu_items;
select * from orders_medium;
select * from restaurants;
select * from [order_items (2)];
SELECT 
c.city,
round(sum(oi.quantity*oi.price),2) as city_highstrevnue
from customers_medium as c
inner join orders_medium as om
on c.customer_id = om.customer_id
inner join [order_items (2)] as oi
on oi.order_id = om.order_id
group by city
order by city_highstrevnue desc
-- Bistrol then leed then london
--Which customers order most frequently?
select orm.customer_id,
count(orm.order_id) as customersordermostfrequently
from orders_medium as orm
group by orm.customer_id
order by customersordermostfrequently desc;
--C1065 IS MOST FREQUENTLY THEN C0801 THEN C0860
--Which cuisine type generates the most revenue?
select * from restaurants;
select * from [order_items (2)];
select * from orders_medium;
SELECT cuisine,
sum(ori.quantity*ori.price) as mostrevenuecuisine
from [order_items (2)] as ori
inner join orders_medium as orm
on ori.order_id = orm.order_id
inner join restaurants as res
on orm.restaurant_id = res.restaurant_id
where status != 'Cancelled'
group by cuisine
order by mostrevenuecuisine desc;
-- cuisine thai then indian then mexican most revnue
--Which restaurant receives the most orders?
select * from restaurants;
select * from orders_medium;
select res.restaurant_id,
count(order_id) as mostrestaurantorder
from restaurants as res
inner join orders_medium
on res.restaurant_id = orders_medium.restaurant_id
group by res.restaurant_id
order by mostrestaurantorder desc;
--restaurant_id 21.00 then 60.00 then 22.00

