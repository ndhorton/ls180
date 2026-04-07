-- PostgreSQL Schema & Data

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    joined_at DATE NOT NULL
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    price NUMERIC(8,2) NOT NULL
);

CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE products_tags (
    product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    tag_id INTEGER NOT NULL REFERENCES tags(id),
    PRIMARY KEY (product_id, tag_id)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    created_at DATE NOT NULL
);

CREATE TABLE orders_products (
    order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL,
    PRIMARY KEY(order_id, product_id)
);

INSERT INTO customers (name, joined_at) VALUES
    ('Alice', '2025-01-10'),
    ('Bob',   '2025-02-02'),
    ('Cathy', '2025-02-10'),
    ('Dan',   '2025-02-14'),
    ('Eve',   '2025-03-01'),
    ('Frank', '2025-03-05'),
    ('Grace', '2025-03-07'),
    ('Hank',  '2025-03-09'),
    ('Ivy',   '2025-03-10'),
    ('John',  '2025-03-12'),
    ('Karen', '2025-03-18'),
    ('Ayu',   '2025-03-19'),
    ('Leo',   '2025-03-20');

INSERT INTO products (name, price) VALUES
    ('Laptop Sleeve', 29.99),
    ('Wireless Mouse', 19.99),
    ('Mechanical Keyboard', 89.99),
    ('USB-C Cable', 9.99),
    ('Noise-Canceling Headphones', 129.99),
    ('Standing Desk', 299.99),
    ('LED Monitor', 179.99),
    ('Ergonomic Chair', 249.99),
    ('Webcam', 49.99),
    ('Desk Lamp', 39.99),
    ('Portable SSD', 99.99),
    ('Tablet Stand', 24.99),
    ('Bluetooth Speaker', 59.99),
    ('Microphone', 79.99),
    ('Charging Station', 69.99),
    ('Whiteboard', 59.99),
    ('Laptop Stand', 34.99),
    ('HDMI Switch', 29.99),
    ('Desk Organizer', 19.99),
    ('Graphic Tablet', 149.99);

INSERT INTO tags (name) VALUES
    ('tech'),
    ('accessories'),
    ('audio'),
    ('office'),
    ('furniture'),
    ('storage'),
    ('video'),
    ('lighting'),
    ('productivity');

INSERT INTO products_tags VALUES
    (1,1),(1,2),
    (2,1),(2,2),
    (3,1),
    (4,1),(4,2),
    (5,1),(5,3),
    (6,4),(6,5),
    (7,1),(7,4),(7,7),
    (8,4),(8,5),
    (9,1),(9,2),(9,7),
    (10,8),(10,4),
    (11,1),(11,6),
    (12,2),(12,4),
    (13,3),(13,2),
    (14,3),(14,1),
    (15,1),(15,2),
    (16,4),(16,9),
    (17,2),(17,9),
    (18,1),(18,2),
    (19,4),(19,9),
    (20,1),(20,2);

INSERT INTO orders (customer_id, created_at) VALUES
    (1,'2025-03-01'),
    (1,'2025-03-12'),
    (2,'2025-03-05'),
    (3,'2025-03-09'),
    (5,'2025-03-11'),
    (6,'2025-03-13'),
    (7,'2025-03-14'),
    (7,'2025-03-20'),
    (8,'2025-03-15'),
    (9,'2025-03-15'),
    (10,'2025-03-16'),
    (11,'2025-03-17'),
    (12,'2025-03-18'),
    (3,'2025-03-21'),
    (2,'2025-03-22'),
    (4,'2025-03-23'),
    (4,'2025-03-25'),
    (8,'2025-03-26'),
    (9,'2025-03-27'),
    (5,'2025-03-29'),
    (6,'2025-03-30'),
    (7,'2025-03-30'),
    (1,'2025-03-31'),
    (10,'2025-04-01'),
    (12,'2025-04-02');

INSERT INTO orders_products VALUES
    (1,1,1),(1,4,2),(1,9,1),
    (2,3,1),
    (3,5,1),(3,4,1),
    (4,7,2),(4,2,1),
    (5,6,1),
    (6,10,1),(6,11,1),(6,4,3),
    (7,1,1),(7,2,2),(7,20,1),
    (8,6,1),(8,8,1),
    (9,13,2),
    (10,12,1),(10,18,1),
    (11,14,1),(11,5,1),
    (12,19,2),
    (13,15,1),(13,1,1),
    (14,7,1),(14,9,1),(14,10,1),
    (15,11,1),(15,17,1),
    (16,6,1),(16,3,1),(16,4,2),
    (17,8,1),(17,1,2),
    (18,2,1),(18,3,1),(18,13,1),
    (19,5,2),
    (20,16,1),(20,9,2),
    (21,6,1),(21,7,1),(21,3,1),
    (22,1,1),(22,12,1),(22,13,1),
    (23,2,1),(23,4,1),(23,5,1),
    (24,9,1),(24,10,1),(24,11,1),
    (25,20,1),(25,19,1),(25,3,1);
