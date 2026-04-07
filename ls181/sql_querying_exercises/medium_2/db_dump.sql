-- PostgreSQL Schema & Data

-- Tables
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at DATE NOT NULL
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at DATE NOT NULL
);

CREATE TABLE follows (
    follower_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    followee_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    PRIMARY KEY (follower_id, followee_id)
);

CREATE TABLE likes (
    post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    PRIMARY KEY (post_id, user_id)
);


-- Users
INSERT INTO users (name, created_at) VALUES
    ('Alice Wong', '2025-07-01'),
    ('Bob Smith', '2025-07-02'),
    ('Charlie Kim', '2025-07-03'),
    ('Dana Rodriguez', '2025-07-04'),
    ('Eve Johnson', '2025-07-05'),
    ('Fatima Ali', '2025-07-06'),
    ('George O''Connor', '2025-07-07'),
    ('Hiro Tanaka', '2025-07-08'),
    ('Isabella Rossi', '2025-07-09'),
    ('Jamal Brown', '2025-07-10'),
    ('Liam Patel', '2025-07-11'),
    ('Maya Singh', '2025-07-12');

-- Follows (who follows whom)
INSERT INTO follows (follower_id, followee_id) VALUES
    (1,2),(1,3),(1,6),(1,7),
    (2,1),(2,3),(2,5),(2,8),
    (3,1),(3,2),(3,4),(3,6),
    (4,3),(4,5),
    (5,2),(5,4),(5,10),
    (6,1),(6,3),(6,7),
    (7,6),(7,8),(7,1),
    (8,7),(8,9),(8,2),
    (9,8),(9,10),
    (10,5),(10,9);

-- Posts
INSERT INTO posts (user_id, content, created_at) VALUES
    (1, 'Just started a new painting, excited to share!', '2025-10-21'),
    (1, 'Morning yoga session complete, feeling great!', '2025-10-25'),
    (1, 'Last month I tried a new recipe for pasta.', '2025-09-15'),
    (2, 'Excited to share my new blog post on sustainable living!', '2025-10-20'),
    (2, 'Morning run in the park was amazing!', '2025-10-28'),
    (2, 'Attended a virtual conference on climate change.', '2025-10-30'),
    (2, 'Started learning guitar last month.', '2025-08-15'),
    (3, 'Just finished a great book on machine learning.', '2025-10-22'),
    (3, 'Cooking some Italian recipes tonight!', '2025-10-27'),
    (3, 'Trying out a new Python project!', '2025-10-24'),
    (3, 'Weekend trip was amazing!', '2025-09-10'),
    (4, 'Started learning the guitar, loving it!', '2025-10-24'),
    (4, 'Attended a local music workshop today.', '2025-10-29'),
    (4, 'Finished reading a book on mindfulness.', '2025-09-18'),
    (5, 'Looking for recommendations for sci-fi novels.', '2025-10-23'),
    (5, 'Joined a book club this weekend.', '2025-10-26'),
    (5, 'Trying out a new cafe in town ☕', '2025-06-10'),
    (6, 'Hiking trip this weekend was breathtaking.', '2025-10-25'),
    (6, 'New sketch added to my portfolio.', '2025-10-27'),
    (6, 'Experimenting with watercolor techniques.', '2025-10-30'),
    (6, 'Visited the art museum last month.', '2025-09-12'),
    (7, 'Attended a fantastic jazz concert yesterday.', '2025-10-22'),
    (7, 'Learning to play the piano.', '2025-10-28'),
    (7, 'Watched a documentary on space exploration.', '2025-08-05'),
    (8, 'Experimenting with plant-based recipes!', '2025-10-21'),
    (8, 'Trying a new cycling route today.', '2025-10-29'),
    (8, 'Weekend hike was amazing.', '2025-09-25'),
    (9, 'Photography session by the lake, amazing sunset.', '2025-10-28'),
    (9, 'Editing my travel photos from Italy.', '2025-10-30'),
    (9, 'Planning next month''s trip.', '2025-09-05'),
    (10, 'Participated in local charity event today!', '2025-10-23'),
    (10, 'Organizing community cleanup for Saturday.', '2025-10-27');

-- Likes
INSERT INTO likes (post_id, user_id) VALUES
    (1,2),(1,3),(1,4),(1,5),(1,6),
    (2,2),(2,3),
    (3,1),(3,4),(3,5),(3,6),
    (4,1),(4,2),(4,3),
    (5,3),(5,6),
    (6,1),(6,2),(6,4),
    (7,1),(7,3),(7,5),(7,6),
    (8,2),(8,5),(8,7),
    (9,1),(9,6),(9,7),(9,8),
    (10,3),(10,5),(10,8),
    (11,1),(11,4),
    (12,2),(12,6),(12,7),
    (13,1),(13,3),(13,5),(13,7),(13,8),
    (14,2),(14,5),
    (15,3),(15,7),
    (16,1),(16,5),(16,6),
    (17,2),(17,6),(17,8),
    (18,1),(18,4),(18,5),
    (19,2),(19,6),(19,9),
    (20,1),(20,3);
