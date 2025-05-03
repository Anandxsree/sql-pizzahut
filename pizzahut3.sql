-- Identify the highest-priced pizza

select pizza_types.name , pizzas.price from pizza_types join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc limit 1; 

-- Identify the most common pizza size ordered

select pizzas.size ,count(order_details.order_details_id) from pizzas
join order_details on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size
order by count(order_details.quantity) desc limit 1;