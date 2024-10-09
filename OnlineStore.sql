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

CREATE TABLE ORDER_ITEMS(
order_id INT REFERENCES orders(id),
customer_id INT REFERENCES customers(id),
quantity INT,
PRIMARY KEY(order_id, customer_id)
);