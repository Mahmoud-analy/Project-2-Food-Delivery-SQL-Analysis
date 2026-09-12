# Project 2: Food Delivery SQL Analysis

مشروع تحليل بيانات نظام توصيل طلبات (عملاء - مطاعم - قوائم طعام - طلبات) باستخدام Microsoft SQL Server، بالتركيز على Filtering وMultiple Joins.

## Q1: How many total orders were placed?
```sql
SELECT COUNT(*) AS total_orders
FROM orders_medium;
```
**النتيجة:** 5000 طلب

## Q2: Which cities have the most customers?
```sql
SELECT city, COUNT(*) AS city_mostcustomers
FROM customers_medium
GROUP BY city
ORDER BY city_mostcustomers DESC;
```
**النتيجة:** Bristol (270) → Leeds (252) → Liverpool (247)

## Q3: Which cuisine types are most common?
```sql
SELECT cuisine, COUNT(*) AS most_commoncuisine
FROM restaurants
GROUP BY cuisine
ORDER BY most_commoncuisine DESC;
```
**النتيجة:** Thai (26) → Indian (22) → Italian (20)

## Q4: What are the top restaurants by rating?
```sql
SELECT TOP 3
    restaurant_id,
    city,
    rating
FROM restaurants
ORDER BY rating DESC;
```

## Q5: What is the average delivery time?
```sql
SELECT AVG(DATEDIFF(MINUTE, order_time, delivery_time)) AS avg_deliverytime
FROM orders_medium;
```
**النتيجة:** 54 دقيقة

## Q6: Which restaurants generate the most revenue?
```sql
SELECT
    mi.restaurant_id,
    ROUND(SUM(ori.quantity * ori.price), 2) AS mostrevenue
FROM menu_items AS mi
INNER JOIN order_items AS ori
    ON mi.item_id = ori.item_id
INNER JOIN orders_medium AS om
    ON ori.order_id = om.order_id
WHERE om.status != 'Cancelled'
GROUP BY mi.restaurant_id
ORDER BY mostrevenue DESC;
```
**النتيجة:** المطعم R046 هو الأعلى إيرادًا، ثم R099، ثم R023

## Q7: What are the most ordered menu items?
```sql
SELECT
    item_id,
    SUM(quantity) AS most_ordered
FROM order_items
GROUP BY item_id
ORDER BY most_ordered DESC;
```
**النتيجة:** M0245 هو الأكثر طلبًا، ثم M0200، ثم M0108

## Q8: Which cities generate the highest revenue?
```sql
SELECT
    c.city,
    ROUND(SUM(oi.quantity * oi.price), 2) AS city_highestrevenue
FROM customers_medium AS c
INNER JOIN orders_medium AS om
    ON c.customer_id = om.customer_id
INNER JOIN order_items AS oi
    ON oi.order_id = om.order_id
GROUP BY c.city
ORDER BY city_highestrevenue DESC;
```
**النتيجة:** Bristol → Leeds → London

## Q9: Which customers order most frequently?
```sql
SELECT
    orm.customer_id,
    COUNT(orm.order_id) AS orders_count
FROM orders_medium AS orm
GROUP BY orm.customer_id
ORDER BY orders_count DESC;
```
**النتيجة:** C1065 هو الأكثر تكرارًا، ثم C0801، ثم C0860

## Q10: Which cuisine type generates the most revenue?
```sql
SELECT
    res.cuisine,
    SUM(ori.quantity * ori.price) AS mostrevenue_cuisine
FROM order_items AS ori
INNER JOIN orders_medium AS orm
    ON ori.order_id = orm.order_id
INNER JOIN restaurants AS res
    ON orm.restaurant_id = res.restaurant_id
WHERE orm.status != 'Cancelled'
GROUP BY res.cuisine
ORDER BY mostrevenue_cuisine DESC;
```
**النتيجة:** Thai → Indian → Mexican

## Q11: Which restaurant receives the most orders?
```sql
SELECT
    res.restaurant_id,
    COUNT(orders_medium.order_id) AS most_restaurant_orders
FROM restaurants AS res
INNER JOIN orders_medium
    ON res.restaurant_id = orders_medium.restaurant_id
GROUP BY res.restaurant_id
ORDER BY most_restaurant_orders DESC;
```
**النتيجة:** R021 → R060 → R022

---

## المفاهيم المستخدمة
`INNER JOIN (Multiple Tables)` · `GROUP BY` · `WHERE (Filtering)` · `Aggregate Functions (SUM, COUNT, AVG)` · `DATEDIFF` · `ROUND` · `ORDER BY` · `TOP N`

## البيانات
داتاسيت من Kaggle: [SQL Practice Dataset 2 (Medium Queries)](https://www.kaggle.com/datasets/nudratabbas/sql-practice-dataset-2-medium-queries)
