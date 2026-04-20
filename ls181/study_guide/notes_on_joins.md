## Identify the different types of `JOIN`s and explain their differences. ##

* Inner joins
* Outer joins
  * left
  * right
  * full
* Cross joins

### Joins ###

At the most general, queries (requests to retrieve data from the db) are made up
of the table expression, the select list, and the sort specification.

Joins form part of the *table expression*, the expression that computes the table
(or result set) that our select list requests data from. The table expression
contains a `FROM` clause that is optionally followed by `WHERE`, `GROUP BY`, and
`HAVING` clauses, which can filter and group table rows in various ways.

The `FROM` clause constructs a transient table from which the select list
extracts the data we are interested in. A trivial `FROM` clause simply
references a single table, but we can also combine two or more tables together
in various ways via the various types of **join**.

In general, all types of join will attempt to combine rows from one table with
rows from another to form a transient table, which can be transformed in various
ways by `WHERE`, `GROUP BY`, and `HAVING`, before being read from by the select
list.

There are **inner joins**, **outer joins**, and **cross joins**;
outer joins can be further divided into **left outer joins**, **right outer
joins**, and **full outer joins**.

### Cross Joins ###

The simplest type of join to understand is the **cross join**, though this is
far less common than the other types. A cross join unconditionally joins every
row of one table with every row of another table to form the Cartesian product
of the two sets of rows. Thus, if table A has 10 rows and table B has 5 rows,
the transient table produced by the cross join of A and B will have 5 * 10 = 50
rows. The first row of table A will be copied and paired with the five rows of
table B to produce five rows. Each row will contain the same column values from
table A's first row along with the column values from table B for each row. This
process continues, with every row from A being concatenated with every different
row of B.

Since the result is always the Cartesian product of the two tables' rows, there
is no **join condition** for a cross join, unlike for every other type of join.

There are two syntaxes for a cross join, an older one:
```sql
SELECT *
  FROM table_a, table_b;
```
and a newer, more explicit one:
```sql
SELECT *
  FROM table_a
       CROSS JOIN table_b;
```

In real databases, the use cases for `CROSS JOIN` are very rare. They are more
likely to be used for generating test data than for production queries.

### Inner Joins ###

When we make an inner join, we must specify a **join condition** in an `ON`
clause. This looks like:
```sql
SELECT *
  FROM members
       INNER JOIN bookings
       ON members.id = bookings.member_id;
```
Unlike a Cross Join, an Inner Join requires a join condition, expressed by the
`ON` clause. If we have a table expression like
`FROM A INNER JOIN B ON A.id = B.a_id`, our RDBMS will create a row in the
transient table for each pairing of a row from table A and a row from table B
where the join condition is satisfied.

(SQL is declarative, and so the following description is a logical model rather
than a strict description of execution steps.) For each row in table A, the
RDBMS will look at each row in table B and produce a row in the resulting
transient table joining the row from A and the row from B for each pairing that
satisfies the join condition. Thus, as an upper bound, if the join condition is
always true, then the Inner Join is equivalent to a Cross Join, producing the
Cartesian product of the two tables. And as a lower bound, if the condition is
always false, then the resulting transient table contains 0 rows.

In SQL, `INNER JOIN` can be abreviated to simply `JOIN`.

### Left Outer Joins ###

The syntax for a `LEFT OUTER JOIN` looks like this:
```sql
SELECT *
  FROM members
       LEFT OUTER JOIN bookings
       ON members.id = bookings.member_id
```

Whereas an Inner Join rejects any pairing of rows from the two tables where the
join condition evaluates as false, a Left Outer Join promises to include all of
the rows from the left-hand table (that is, left of the `JOIN` keyword in the
table expression, here `members`), padding the columns derived from the
right-hand table with `NULL`s if necessary.

Essentially, the RDBMS first performs an Inner Join, and then for every row in
the left-hand table that has not been joined, a row will be added to the result
set containing the left-hand row and the remaining columns will have `NULL` for
each value.

Thus, the result set always has at least one row for every row in the left-hand
table.

`LEFT OUTER JOIN` can be abbreviated to simply `LEFT JOIN`.

### Right Outer Joins ###

A Right Outer Join works the same as a Left Outer Join, except the table whose
rows are always preserved in the result set is now the table whose name appears
to the right of the `JOIN` keyword.

`RIGHT OUTER JOIN` can be abbreviated to `RIGHT JOIN`.

### Full Outer Join ###

A Full Outer Join works similarly to the Left and Right Outer Joins, except that
both tables' rows are preserved.

Essentially, the database will perform an Inner Join, and then any rows from the
left-hand table that have not appeared in the result set will be added with
`NULL` values for the right-hand columns, and then any right-hand rows that have
not appeared will be added with `NULL` values for the left-hand columns.

`FULL OUTER JOIN` can be abbreviated to `FULL JOIN`.

* Select list
* Table expression
  * `FROM`
    * `JOIN`
  * `WHERE`
  * `GROUP BY`
  * `HAVING`
* Sorting
  * `ORDER BY`
    * `LIMIT`/`OFFSET`

## SQL Book: SQL Joins ##

* With properly normalized tables, it is often necessary to query data from more
than one table. To do so, we must **join** the tables together.
* SQL handles queries across more than one table through the use of `JOIN`s.
  * `JOIN`s are clauses in SQL statements that link two talbes together, usually
  based on the keys that define the relationship between those two tables.
* There are several types of `JOIN`: `INNER`, `LEFT OUTER`, `RIGHT OUTER`,
`FULL OUTER`, and `CROSS`.

The way the book explains joins is to begin with this syntax:
```sql
FROM table_name1
join_type JOIN table_name2
          ON join_condition
```
We need to know
* The name of the first table to join
* The type of join to use
* The name of the second table to join
* The join condition
These pieces of information are combined using the `JOIN` and `ON` keywords.

* The join condition defines the logic by which a row in one table is joined to a
row in another table.
  * In most cases, this join condition is created usingt the
  primary key of one table and the foreign key of the table we want to join it
  with.


Question: How does the number of rows returned by a `FULL JOIN` compare to the number of
rows returned by an `INNER JOIN` on the same tables and conditions? Under what
circumstances would the counts be the same?

A:

A `FULL JOIN` always returns at least as many rows as the corresponding
`INNER JOIN` (same tables, same conditions) because it includes:
* all the matching rows (same as `INNER`)
* extra rows for any unmatched rows on either side

The counts are exactly the same when there are no unmatched rows in either
table.

In other words, the number of rows from a `FULL JOIN` is greater than or equal
to the number from an `INNER JOIN` with the same tables and join condition.

They are equal if and only if every row in each table participates in at least
one match under that join condition, whereby there are no extra rows that need
to be added with `NULL`s.



The counts would be the same when there are no leftover rows from either table
that could not find a match on the join condition.
