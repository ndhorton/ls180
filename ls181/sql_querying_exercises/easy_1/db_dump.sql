-- Postgres Schema & Data

-- Tables
CREATE TABLE authors (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  country TEXT
);

CREATE TABLE publishers (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  founded_year INTEGER
);

CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  published_year INTEGER,
  price NUMERIC(6,2),
  author_id INTEGER NOT NULL REFERENCES authors(id) ON DELETE CASCADE,
  publisher_id INTEGER NOT NULL REFERENCES publishers(id) ON DELETE CASCADE
);

-- Data
-- Authors
INSERT INTO authors (name, country) VALUES
  ('Haruki Murakami',          'Japan'),
  ('Toni Morrison',            'USA'),
  ('Chimamanda Ngozi Adichie', 'Nigeria'),
  ('George Orwell',            'UK'),
  ('Jane Austen',              'UK'),
  ('Kazuo Ishiguro',           'UK'),
  ('Margaret Atwood',          'Canada'),
  ('Gabriel García Márquez',   'Colombia'),
  ('Jhumpa Lahiri',            'USA'),
  ('Colson Whitehead',         'USA');

-- Publishers
INSERT INTO publishers (name, founded_year) VALUES
  ('Vintage Books',    1954),
  ('Penguin Classics', 1946),
  ('Knopf',            1915),
  ('HarperCollins',    1989),
  ('Random House',     1927);

-- Books
INSERT INTO books (title, published_year, price, author_id, publisher_id) VALUES
  ('Norwegian Wood',                1987, 14.99, 1, 1),
  ('Kafka on the Shore',            2002, 17.50, 1, 1),
  ('The Wind-Up Bird Chronicle',    1994, 18.50, 1, 3),
  ('Beloved',                       1987, 13.95, 2, 3),
  ('Song of Solomon',               1977, 12.99, 2, 3),
  ('Half of a Yellow Sun',          2006, 15.99, 3, 3),
  ('Americanah',                    2013, 16.50, 3, 1),
  ('1984',                          1949, 12.50, 4,  2),
  ('Animal Farm',                   1945, 10.99, 4,  2),
  ('Pride and Prejudice',           1813, 9.99,  5,  2),
  ('Emma',                          1815, 10.50, 5,  2),
  ('Never Let Me Go',               2005, 14.25, 6,  1),
  ('The Remains of the Day',        1989, 13.75, 6,  3),
  ('The Handmaid''s Tale',          1985, 13.95, 7,  4),
  ('Oryx and Crake',                2003, 14.95, 7,  4),
  ('One Hundred Years of Solitude', 1967, 15.50, 8,  5),
  ('Love in the Time of Cholera',   1985, 14.75, 8,  5),
  ('The Namesake',                  2003, 13.50, 9,  1),
  ('Interpreter of Maladies',       1999, 11.99, 9,  1),
  ('The Underground Railroad',      2016, 16.99, 10, 5),
  ('The Nickel Boys',               2019, 15.25, 10, 5);
