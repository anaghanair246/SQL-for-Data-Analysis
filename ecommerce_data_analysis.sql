
-- 1. Create Tables
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    country TEXT
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    total_amount REAL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price REAL
);

CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    price REAL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    payment_date DATE,
    payment_method TEXT,
    amount REAL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 2. Insert Sample Data
INSERT INTO customers VALUES
(1, 'Alice', 'alice@example.com', 'India'),
(2, 'Bob', 'bob@example.com', 'USA'),
(3, 'Charlie', 'charlie@example.com', 'UK');

INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 1000),
(2, 'Smartphone', 'Electronics', 600),
(3, 'Book', 'Education', 20);

INSERT INTO orders VALUES
(1, 1, '2024-01-15', 1620),
(2, 2, '2024-02-10', 620),
(3, 3, '2024-03-05', 20);

INSERT INTO order_items VALUES
(1, 1, 1, 1, 1000),
(2, 1, 2, 1, 600),
(3, 1, 3, 1, 20),
(4, 2, 2, 1, 600),
(5, 2, 3, 1, 20),
(6, 3, 3, 1, 20);

INSERT INTO payments VALUES
(1, 1, '2024-01-16', 'Credit Card', 1620),
(2, 2, '2024-02-11', 'PayPal', 620),
(3, 3, '2024-03-06', 'Debit Card', 20);

-- 3. Basic SELECT
SELECT name, email, country
FROM customers
WHERE country = 'India'
ORDER BY name ASC;

-- 4. JOIN Example
SELECT o.order_id, c.name, o.order_date, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE o.total_amount > 1000;

-- 5. GROUP BY with Aggregate
SELECT country, COUNT(*) AS num_customers
FROM customers
GROUP BY country
ORDER BY num_customers DESC;

-- 6. Subquery Example
SELECT name, customer_id
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- 7. Create View
CREATE VIEW customer_sales_summary AS
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- 8. Create Index
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
