SELECT * FROM food_delivery
LIMIT 10;

--Top Spending Customers--
SELECT customer_id,
       COUNT(order_id) AS total_orders,
	   ROUND(SUM(final_amount),2) AS total_spent,
	   ROUND(AVG(final_amount),2) AS avg_order_value
FROM food_delivery
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

--Weekend vs Weekday Orders--
SELECT
		order_day_type,
		COUNT(*) AS total_orders,
		ROUND(SUM(final_amount),2) AS revenue,
		ROUND(AVG(final_amount),2) AS avg_order_value
FROM food_delivery
GROUP BY order_day_type;

--Monthly Revenue Trend--
SELECT
    EXTRACT(MONTH FROM order_date) AS month_no,
    TO_CHAR(order_date, 'Mon') AS month,
    ROUND(SUM(final_amount), 2) AS revenue
FROM food_delivery
GROUP BY
    EXTRACT(MONTH FROM order_date),
    TO_CHAR(order_date, 'Mon')
ORDER BY month_no;

--Discount Impact on Profit--
SELECT
	discount_applied,
	ROUND(AVG(profit_margin),2) AS avg_profit,
	ROUND(AVG(final_amount),2) AS avg_sales,
	COUNT(*) AS orders
FROM food_delivery
GROUP BY discount_applied;

--High Revenue cities--
SELECT
	city,
	ROUND(SUM(final_amount),2) AS revenue
FROM food_delivery
GROUP BY city
ORDER BY revenue DESC;

--High Revenue Cuisine--
SELECT
	cuisine_type,
	ROUND(SUM(final_amount),2) AS revenue
FROM food_delivery
GROUP BY cuisine_type
ORDER BY revenue DESC;

--Average delivery time by city--
SELECT
	city,
	ROUND(AVG(delivery_time_min),2) AS avg_delivery_time
FROM food_delivery
GROUP BY city
ORDER BY avg_delivery_time;

--Delivery Rating vs Delivery Time--
SELECT
	delivery_rating,
	ROUND(AVG(delivery_time_min),2) AS avg_delivery_time
FROM food_delivery
GROUP BY delivery_rating
ORDER BY delivery_rating;

--Top rated restaurant--
SELECT
restaurant_name,
ROUND(AVG(restaurant_rating),2) AS rating,
COUNT(*) AS total_orders
FROM food_delivery
GROUP BY restaurant_name
ORDER BY rating DESC,total_orders DESC
LIMIT 10;

--Cuisine Performance--
SELECT
cuisine_type,
COUNT(*) AS orders,
ROUND(SUM(final_amount),2) AS revenue,
ROUND(AVG(profit_margin),2) AS avg_profit,
ROUND(AVG(delivery_rating),2) AS delivery_rating
FROM food_delivery
GROUP BY cuisine_type
ORDER BY revenue DESC;

--Weekday vs Weekend Demand--
SELECT
order_day_type,
COUNT(*) AS orders
FROM food_delivery
GROUP BY order_day_type
ORDER BY orders DESC;

--Payment Mode Preferences--
SELECT
payment_mode,
COUNT(*) AS orders,
ROUND(100*COUNT(*)/(SELECT COUNT(*) FROM food_delivery),2) AS percentage
FROM food_delivery
GROUP BY payment_mode
ORDER BY orders DESC;
