-- PostgreSQL Schema & Data

-- Plans table
CREATE TABLE plans (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    monthly_price INTEGER NOT NULL CHECK (monthly_price >= 0),
    max_seats INTEGER NOT NULL CHECK (max_seats >= 1)
);

-- Organizations table
CREATE TABLE organizations (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TEXT
);

-- Subscriptions table
CREATE TABLE subscriptions (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    plan_id INTEGER NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
    status TEXT NOT NULL CHECK (status IN ('active', 'canceled')),
    start_date TEXT NOT NULL,
    end_date TEXT
);

-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    organization_id INTEGER NOT NULL REFERENCES organizations(id),
    created_at TEXT
);

-- Plans
INSERT INTO plans (name, monthly_price, max_seats) VALUES
    ('Free', 0, 5),
    ('Team', 50, 15),
    ('Pro', 75, 30);

-- Organizations
INSERT INTO organizations (name, created_at) VALUES
    ('Acme Corp', '2024-09-10'),
    ('Lumos Labs', '2025-02-12'),
    ('Brightside Inc', '2025-05-01'),
    ('Zenith Studios', '2025-06-18'),
    ('Aurora Tech', '2025-09-02'),
    ('Nimbus Co', '2025-10-10'),
    ('Corelytics', '2024-12-20'),
    ('Stellar Solutions', '2025-01-15'),
    ('QuantumWorks', '2025-07-01'),
    ('Vertex Dynamics', '2025-08-12'),
    ('Horizon Labs', '2025-09-15'),
    ('PixelWorks', '2025-09-20');

-- Subscriptions
INSERT INTO subscriptions (organization_id, plan_id, status, start_date, end_date) VALUES
    (1, 3, 'active', '2024-09-10', NULL),            -- Acme: Pro
    (2, 2, 'active', '2025-02-12', NULL),            -- Lumos: Team
    (3, 2, 'canceled', '2025-05-01', '2025-08-01'),  -- Brightside: canceled Team
    (4, 3, 'active', '2025-06-18', NULL),            -- Zenith: Pro
    (5, 1, 'active', '2025-09-02', NULL),            -- Aurora: Free
    (6, 2, 'active', '2025-10-10', NULL),            -- Nimbus: Team
    (7, 2, 'active', '2024-12-20', NULL),            -- Corelytics: Team
    (8, 1, 'active', '2025-01-15', NULL),            -- Stellar: Free
    (9, 2, 'active', '2025-07-01', NULL),            -- QuantumWorks: Team
    (10, 3, 'active', '2025-08-12', NULL),           -- Vertex: Pro
    (11, 1, 'active', '2025-09-15', NULL),           -- Horizon Labs: Free
    (12, 1, 'active', '2025-09-20', NULL);           -- PixelWorks: Free

-- Users
-- Acme (Pro, 2 users)
INSERT INTO users (name, email, organization_id, created_at) VALUES
    ('Alice Wong', 'alice@acme.com', 1, '2024-09-10'),
    ('Bob Smith', 'bob@acme.com', 1, '2024-09-12');

-- Lumos (Team, 12 users)
INSERT INTO users (name, email, organization_id, created_at) VALUES
    ('Charlie Kim', 'charlie@lumos.com', 2, '2025-02-12'),
    ('Dana Rodriguez', 'dana@lumos.com', 2, '2025-02-15'),
    ('Ethan Hall', 'ethan@lumos.com', 2, '2025-02-16'),
    ('Fiona Li', 'fiona@lumos.com', 2, '2025-02-17'),
    ('Grace Chen', 'grace@lumos.com', 2, '2025-02-18'),
    ('Henry Park', 'henry@lumos.com', 2, '2025-02-19'),
    ('Isla Wong', 'isla@lumos.com', 2, '2025-02-20'),
    ('Jackie Brown', 'jackie@lumos.com', 2, '2025-02-21'),
    ('Kevin Patel', 'kevin@lumos.com', 2, '2025-02-22'),
    ('Laura Singh', 'laura@lumos.com', 2, '2025-02-23'),
    ('Mason Lee', 'mason@lumos.com', 2, '2025-02-24'),
    ('Nina Lopez', 'nina@lumos.com', 2, '2025-02-25');

-- Brightside (canceled Team, 1 user)
INSERT INTO users (name, email, organization_id, created_at) VALUES
    ('Eve Johnson', 'eve@brightside.com', 3, '2025-05-01');

-- Zenith (Pro, 5 users)
INSERT INTO users (name, email, organization_id, created_at) VALUES
    ('Fatima Ali', 'fatima@zenith.com', 4, '2025-06-18'),
    ('George O''Connor', 'george@zenith.com', 4, '2025-06-19'),
    ('Hannah Lee', 'hannah@zenith.com', 4, '2025-06-20'),
    ('Ian Kim', 'ian@zenith.com', 4, '2025-06-21'),
    ('Julia Chen', 'julia@zenith.com', 4, '2025-06-22');

-- Aurora Tech (Free, 2 users)
INSERT INTO users (name, email, organization_id, created_at) VALUES
    ('Hiro Tanaka', 'hiro@aurora.com', 5, '2025-09-02'),
    ('Isabella Rossi', 'isabella@aurora.com', 5, '2025-09-03');

-- Nimbus Co (Team, 10 users)
INSERT INTO users (name, email, organization_id, created_at) VALUES
    ('Jamal Brown', 'jamal@nimbus.com', 6, '2025-10-10'),
    ('Karla Singh', 'karla@nimbus.com', 6, '2025-10-11'),
    ('Liam Patel', 'liam@nimbus.com', 6, '2025-10-12'),
    ('Maya Singh', 'maya@nimbus.com', 6, '2025-10-13'),
    ('Oscar Chen', 'oscar@nimbus.com', 6, '2025-10-14'),
    ('Paula Green', 'paula@nimbus.com', 6, '2025-10-15'),
    ('Quinn Black', 'quinn@nimbus.com', 6, '2025-10-16'),
    ('Ravi Kumar', 'ravi@nimbus.com', 6, '2025-10-17'),
    ('Sophia Li', 'sophia@nimbus.com', 6, '2025-10-18'),
    ('Thomas Hardy', 'tom@nimbus.com', 6, '2025-10-19');

-- Corelytics (Team, 8 users)
INSERT INTO users (name, email, organization_id, created_at) VALUES
    ('Uma Patel', 'uma@corelytics.com', 7, '2024-12-21'),
    ('Victor Chen', 'victor@corelytics.com', 7, '2024-12-22'),
    ('Wendy Zhang', 'wendy@corelytics.com', 7, '2024-12-23'),
    ('Xander Li', 'xander@corelytics.com', 7, '2024-12-24'),
    ('Yara Singh', 'yara@corelytics.com', 7, '2024-12-25'),
    ('Zane Kim', 'zane@corelytics.com', 7, '2024-12-26'),
    ('Avery Brown', 'avery@corelytics.com', 7, '2024-12-27'),
    ('Benjamin Li', 'ben@corelytics.com', 7, '2024-12-28');

-- Stellar Solutions (Free, 2 users)
INSERT INTO users (name, email, organization_id, created_at) VALUES
    ('Clara Zhang', 'clara@stellar.com', 8, '2025-01-16'),
    ('Daniel Kim', 'daniel@stellar.com', 8, '2025-01-17');

-- QuantumWorks (Team, 3 users)
INSERT INTO users (name, email, organization_id, created_at) VALUES
    ('Ella Wong', 'ella@quantumworks.com', 9, '2025-07-02'),
    ('Frank Brown', 'frank@quantumworks.com', 9, '2025-07-03'),
    ('Grace Hall', 'grace@quantumworks.com', 9, '2025-07-04');

-- Vertex Dynamics (Pro, 16 users)
INSERT INTO users (name, email, organization_id, created_at) VALUES
    ('Gina Lee', 'gina@vertex.com', 10, '2025-08-13'),
    ('Harry Chen', 'harry@vertex.com', 10, '2025-08-14'),
    ('Ivy Patel', 'ivy@vertex.com', 10, '2025-08-15'),
    ('Jack Li', 'jack@vertex.com', 10, '2025-08-16'),
    ('Kelly Zhang', 'kelly@vertex.com', 10, '2025-08-17'),
    ('Leo Singh', 'leo@vertex.com', 10, '2025-08-18'),
    ('Mia Brown', 'mia@vertex.com', 10, '2025-08-19'),
    ('Noah Kim', 'noah@vertex.com', 10, '2025-08-20'),
    ('Olivia Wong', 'olivia@vertex.com', 10, '2025-08-21'),
    ('Peter Lee', 'peter@vertex.com', 10, '2025-08-22'),
    ('Quincy Chen', 'quincy@vertex.com', 10, '2025-08-23'),
    ('Rachel Patel', 'rachel@vertex.com', 10, '2025-08-24'),
    ('Sam Brown', 'sam@vertex.com', 10, '2025-08-25'),
    ('Tina Kim', 'tina@vertex.com', 10, '2025-08-26'),
    ('Uma Li', 'uma@vertex.com', 10, '2025-08-27'),
    ('Victor Zhang', 'victor@vertex.com', 10, '2025-08-28');

-- Horizon Labs (Free, 5 users)
INSERT INTO users (name, email, organization_id, created_at) VALUES
    ('Alex Grant', 'alex@horizon.com', 11, '2025-09-15'),
    ('Brianna Lee', 'brianna@horizon.com', 11, '2025-09-15'),
    ('Caleb Kim', 'caleb@horizon.com', 11, '2025-09-15'),
    ('Diana Wong', 'diana@horizon.com', 11, '2025-09-15'),
    ('Ethan Fox', 'ethan@horizon.com', 11, '2025-09-15');

-- PixelWorks (Free, 5 users)
INSERT INTO users (name, email, organization_id, created_at) VALUES
    ('Fiona Hart', 'fiona@pixelworks.com', 12, '2025-09-20'),
    ('George Mills', 'george@pixelworks.com', 12, '2025-09-20'),
    ('Hannah Cho', 'hannah@pixelworks.com', 12, '2025-09-20'),
    ('Isaac Yang', 'isaac@pixelworks.com', 12, '2025-09-20'),
    ('Jade Patel', 'jade@pixelworks.com', 12, '2025-09-20');
