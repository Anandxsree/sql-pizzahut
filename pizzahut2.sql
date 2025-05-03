-- RETRIEVE THE TOATL NUMBER OF ORDERS PLACED.

SELECT count(order_id) as total_orders FROM orders;

-- CALCULATED THE TOTAL REVENUE GENERATED FROM PIZZA SALE

SELECT round(SUM(order_details.quantity * pizzas.price),2) AS TOTAL_REVENUE from order_details JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id

