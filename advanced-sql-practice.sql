-- LESSON 2 PRACTICE

drop table if exists customers;
drop table if exists orders;

create table customers (
 id int primary key auto_increment,
 first_name varchar(50),
 last_name varchar(50)
);

create table orders (
 id int primary key,
 customer_id int null,
 order_date date,
 total_amount decimal(10, 2),
 foreign key (customer_id) references customers(id)
);

insert into customers (id, first_name, last_name) values
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Smith'),
(4, 'Bob', 'Brown');

insert into orders (id, customer_id, order_date, total_amount) values
(1, 1, '2023-01-01', 100.00),
(2, 1, '2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00),
(6, NULL, '2023-04-01', 100.00);

-- Use JOIN statements to combine data from multiple tables
SELECT DISTINCT orders.id, orders.order_date, customers.first_name, customers.last_name, orders.total_amount
FROM customers
INNER JOIN orders ON orders.customer_id = customers.id;

-- Write GROUP BY queries with aggregate functions like SUM and COUNT
SELECT orders.customer_id, COUNT(orders.id), customers.first_name, customers.last_name
FROM orders INNER JOIN customers ON orders.customer_id = customers.id
GROUP BY orders.customer_id;

-- Apply WHERE and HAVING clauses to filter data
SELECT orders.order_date, SUM(total_amount) AS total_spent
FROM orders
GROUP BY orders.order_date
HAVING SUM(total_amount) > 200;

SELECT orders.order_date, customers.first_name, customers.last_name, customers.id
FROM orders INNER JOIN customers ON orders.customer_id = customers.id
WHERE customers.last_name = "Doe";

-- Practice using SubQueries to create dynamic filters
SELECT id, order_date, total_amount
FROM orders
WHERE total_amount <= (SELECT AVG(total_amount) FROM orders);

SELECT id, order_date, total_amount, customer_id
FROM orders
WHERE customer_id IN (SELECT id FROM customers WHERE last_name = 'Smith');
