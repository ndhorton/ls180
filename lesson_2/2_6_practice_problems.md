1.

```sql
CREATE TABLE people(
    id serial PRIMARY KEY,
    name character varying(40),
    age integer,
    occupation character varying(80)
);
```

LS solution:
```sql
CREATE TABLE people(
    name character varying(255),
    age integer,
    occupation character varying(255)
);
```

2.

```sql
INSERT INTO people (name, age, occupation)
VALUES ('Abby', 34, 'biologist'),
        ('Mu''nisah', 26, NULL),
        ('Mirabelle', 40, 'contractor');
```

3.

```sql
SELECT *
FROM people
WHERE name = 'Mu''nisah' AND age = 26;

SELECT *
FROM people
ORDER BY age
LIMIT 1;

SELECT *
FROM people
WHERE occupation IS NULL;
```

4.
```sql
CREATE TABLE birds(
    name varchar(255),
    length decimal(4, 1),
    wingspan decimal(4, 1),
    family varchar(255),
    extinct boolean
);
```

5.
```sql
INSERT INTO birds (name, length, wingspan, family, extinct)
VALUES ('Spotted Towhee', 21.6, 26.7, 'Emberzidae', false),
       ('American Robin', 25.5, 36.0, 'Turdidae', false),
       ('Greater Koa Finch', 19.0, 24.0, 'Fringilidae', true),
       ('Carolina Parakeet', 33.0, 55.8, 'Psittacidae', true),
       ('Common Kestrel', 35.5, 73.5, 'Falconidae', false);
```

6.
```sql
SELECT name, family
FROM birds
WHERE extinct = false
ORDER BY length DESC;
```

7.

```sql
SELECT round(avg(wingspan), 1), min(wingspan), max(wingspan)
FROM birds;
```

8.

```sql
CREATE TABLE menu_items(
    item text,
    prep_time integer,
    ingredient_cost decimal(4, 2),
    sales integer,
    menu_price decimal(4, 2)
);
```

9.

```sql
INSERT INTO menu_items VALUES ('omelette', 10, 1.50, 182, 7.99);
INSERT INTO menu_items VALUES ('tacos', 5, 2.00, 254, 8.99);
INSERT INTO menu_items VALUES ('oatmeal', 1, 0.50, 79, 5.99);
```

10.
```sql
SELECT item, (menu_price - ingredient_cost) AS profit
FROM menu_items
ORDER BY profit DESC
LIMIT 1;
```

11.
```sql
SELECT  item,
        menu_price,
        ingredient_cost,
        round(prep_time * 13.0 / 60.0, 2) AS labor,
        menu_price - round(prep_time * 13.0 / 60.0, 2) - ingredient_cost AS profit
FROM menu_items
ORDER BY profit DESC;
```
