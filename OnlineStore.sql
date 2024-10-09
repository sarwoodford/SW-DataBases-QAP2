-- CREATE TABLES

CREATE TABLE products(
id SERIAL PRIMARY KEY,
product_name VARCHAR(100),
product_price DECIMAL(10, 2),
stock_quantity INT
);

CREATE TABLE customers(
id SERIAL PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100)
);

CREATE TABLE orders(
id SERIAL PRIMARY KEY,
customer_id INT REFERENCES customers(id),
order_date DATE
);

CREATE TABLE order_items(
order_id INT REFERENCES orders(id),
product_id INT REFERENCES products(id),
quantity INT,
PRIMARY KEY(order_id, product_id)
);

-- INSERT DATA INTO TABLES 

INSERT INTO products (product_name, product_price, stock_quantity) VALUES
('Kettle', 120.00, 9),
('Teapot', 75.00, 13),
('Tea Cup Set', 109.99, 12),
('Tea Bag Variety Pack', 50.00, 16),
('Thermal Mug', 25.50, 40);

INSERT INTO customers (first_name, last_name, email) VALUES
('Jim', 'Bob', 'jimb@example.com'),
('John', 'Brown', 'johnb@example.com'),
('Linda', 'Ryan', 'lindar@example.com'),
('Carley', 'Grant', 'carleyg@example.com');

INSERT INTO orders (customer_id, order_date) VALUES
(1, '2024-04-20'),
(2, '2024-05-19'),
(3, '2024-06-18'),
(4, '2024-07-17'),
(4, '2024-08-16');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 2, 1),
(2, 4, 2),
(3, 1, 1),
(4, 5, 4),
(5, 3, 5),
(1, 4, 2),
(2, 5, 6),
(3, 3, 1),
(4, 1, 3),
(5, 2, 2);

-- SQL QUERIES
-- RETRIEVE ALL NAMES AND STOCK QUANTITIES FROM PRODUCTS

SELECT product_name, stock_quantity FROM products;

-- RETRIEVE PRODUCT NAMES AND QUANTITIES FOR ONE OF THE ORDERS PLACED

SELECT products.product_name, order_items.quantity
FROM order_items
JOIN products ON order_items.product_id = products.id
WHERE order_items.order_id = 1;

-- RETRIEVE ALL ORDERS PLACED BY CUSTOMER ID = 2

SELECT orders.id AS order_id, order_items.product_id, order_items.quantity
FROM orders
JOIN order_items ON orders.id = order_items.order_id
WHERE orders.customer_id = 2;

-- UPDATE DATA
-- REDUCE STOCK FOR A SPECIFIC ORDER ID, RESPECTIVE TO HOW MANY WERE ORDERED OF THE ITEM

-- view stock quantity before change 
-- SELECT * FROM products; 

UPDATE products
SET stock_quantity = stock_quantity - order_items.quantity
FROM order_items
WHERE products.id = order_items.product_id AND order_items.order_id = 3;

-- stocks were reduced for both orders where order id = 3, they appear as '(3, 1, 1)' and '(3, 3, 1)' where data
-- was inserted into order_items table.

-- verify that update worked
-- SELECT * FROM products; 

-- REMOVE ONE OF THE ORDERS AND ALL ASSOCIATED ORDER_IEMS FROM THE SYSTEM
-- removed order_items where order_id = 4

-- view order_items before updating
-- SELECT * FROM orders

DELETE FROM order_items WHERE order_id = 4;

DELETE FROM orders WHERE id = 4;

-- verify that the update worked
-- SELECT * FROM orders