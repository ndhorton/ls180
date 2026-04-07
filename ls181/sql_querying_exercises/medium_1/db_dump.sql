-- PostgreSQL Schema & Data

-- Customers table
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT,
    created_at TEXT
);

-- Orders table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    total_amount REAL,
    status TEXT,
    order_date TEXT
);

-- Customers
INSERT INTO customers (id, name, email, created_at) VALUES
    (1, 'Alice Wong', 'alice@acme.com', '2025-01-10'),
    (2, 'Bob Smith', 'bob@acme.com', '2025-01-12'),
    (3, 'Alice Wong', 'alice.wong@acme.com', '2025-01-10'),
    (4, 'Charlie Kim', 'charlie@lumos.com', '2025-02-15'),
    (5, 'Dana Rodriguez', 'dana@lumos.com', '2025-02-17'),
    (6, 'Eve Johnson', 'unknown@domain.com', '2025-5-01'),
    (7, 'Frank Brown', 'unknown@domain.com', '2025-05-05'),
    (8, 'Grace Chen', NULL, '2025-02-18'),
    (9, 'Hannah Lee', 'hannah@zenith.com', 'Feb 30 2025'),
    (10, 'Ian Kim', 'ian@zenith.com', 'january'),
    (11, 'Malik Johnson', 'malik.johnson@example.com', '2025-06-01'),
    (12, 'Malcolm Johnson', 'malik.johnson@example.com', '2025-11-04');

-- Orders
INSERT INTO orders (id, customer_id, total_amount, status, order_date) VALUES
    (1, 1, 100.50, 'pending', '2025-09-01'),
    (2, 2, 200.00, 'PENDING', '2025-09-02'),
    (3, 3, 150.00, 'Pending ', '2025/09/03'),
    (4, 4, -50.00, 'closed', '2025-09-04'),
    (5, 5, 0, 'open', '09-05-2025'),
    (6, NULL, 75.00, 'pending', '2025-09-06'),
    (7, 6, 120.00, 'Pending ', '2025-09-07'),
    (8, 7, 90.00, 'completed', '2025-09-08'),
    (9, 8, 50.00, 'OPEN', '2025-09-09'),
    (10, 9, 110.00, 'closed', '2025-09-10'),
    (11, 10, NULL, 'pending', '2025-09-11'),
    (12, 10, NULL, 'pending', '2025-09-11'),
    (13, 999, 60.00, 'pending', '2025-09-12'),
    (14, 31, 603.00, 'PENDING', '2025-09-12');
