create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key (order_id));

select * from pizzahut.orders;

create table orders_details(
orders_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key (orders_details_id));

-- 1 Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

-- 2 Calculate the total revenue generated from pizza sales.-- 
SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    orders_details
        JOIN
    pizzas ON pizzas.pizza_id = orders_details.pizza_id;
    
-- 3 Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size,
    COUNT(orders_details.orders_details_id) AS order_count
FROM
    pizzas
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, SUM(orders_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered. 
select pizza_types.category,
sum(orders_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details 
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by quantity desc;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);

-- Join relevant tables to find the category-wise distribution of pizzas.
select category , count(name) from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity), 0) as avg_pizza_ordered_per_day
FROM
    (SELECT 
        orders.order_date, SUM(orders_details.quantity) AS quantity
    FROM
        orders
    JOIN orders_details ON orders.order_id = orders_details.order_id
    GROUP BY orders.order_date) AS order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name,
sum(orders_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;
