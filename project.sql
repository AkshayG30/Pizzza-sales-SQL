-- Retrieve the total number of orders placed.
Select count(order_id) as Total_orders from orders;

-- Calculate the total revenue generated from pizaa sales.
SELECT ROUND(SUM(order_details.quantity * pizzas.price),2) 
AS Total_sales
FROM order_details
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id

-- Identify the highest-priced pizza
SELECT pizza_types.name, pizzas.price
  from pizza_types 
    join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id order by pizzas.price desc
      limit 1;

-- Identify the most common pizza size ordered.
Select pizzas.size, count(order_details.order_details_id) as order_count
 from pizzas join order_details 
   on pizzas.pizza_id = order_details.pizza_id 
     group by pizzas.size;

-- List the top 5 most ordered pizza types along with their quantities.
Select pizza_types.name,
 sum(order_details.quantity) as Quantity
  from pizza_types JOIN pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id 
   JOIN order_details on order_details.pizza_id = pizzas.pizza_id 
     group by pizza_types.name order by quantity desc limit 5

-- Join the necessary tables to find the total quantity of each pizza category ordered.
Select pizza_types.category, sum(order_details.quantity) as Quantity
 from pizza_types join pizzas
 on pizza_types.pizza_type_id = pizzas.pizza_type_id
  join order_details
    on order_details.pizza_id = pizzas.pizza_id
       group by pizza_types.category 
         order by quantity desc;
         
-- Determine the distribution of orders by hour of the day.
Select hour(order_time) as Hour, count(order_id) as order_count
  from orders
    group by hour(order_time);
   
-- Join relevant tables to find the category-wise distribution of pizzas
Select catogary, count(name) from pizza_types
      group by category;
   
-- Group the orders by date and calculate
-- the average number of pizzas ordered per day.
select round(avg(quantity),0) as avg_pizza_ordered_per_day from
(Select orders.order_date, sum(order_details.quantity) as quantity 
    from orders join order_details
	   on orders.order_id = order_details.order_id 
           group by orders.order_date) as order_quality;
           
-- Determine the top 3 most ordered pizza types based on revenue.
Select pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue 
   from pizza_types join pizzas
        on pizzas.pizza_type_id = pizza_types.pizza_type_id
          join order_details on order_details.pizza_id = pizzas.pizza_id
			 group by pizza_types.name order by revenue desc limit 3;
			
             
             

            






















