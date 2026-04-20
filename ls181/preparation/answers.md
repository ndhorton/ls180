## SQL Sublanguages ##

SQL is divided up into sub-languages which govern different aspects of working with relational databases. The three sub-languages common to all major RDBMSs are the Data Definition Language (DDL), the Data Manipulation Language (DML), and the Data Control Language (DCL).

The DDL governs the schema of a database, meaning the structure of our data. We use DDL commands like `CREATE` and `ALTER` to create databases and tables, or to alter columns of tables, as well as other operations that are concerned with the structure of our database and the rules that govern what data is allowed in our tables and what relationships the tables have with each other.

The DML allows us to create, read, update and delete data rows in our database tables. We use the `INSERT` command to create data rows; the `SELECT` command to read, or retrieve, data; the `UPDATE` command to update, or modify, existing data rows; and the `DELETE` command to delete data rows.

The DCL governs who has access to which parts of our database, or the 'security' of our data. Commands include `GRANT` and `REVOKE`. The parts of the schema related to ownership are also controlled by DCL statements.

---

## Implementing types of relationship: 1:1, 1:M, M:M ##

### 1:1 ###

A one-to-one relationship in a relational database exists when an entity
instance in one table should be associated with at most one entity instance in
another table. For instance, we might have a `users` table and a `usernames`
table, and the rule that each user should have only one username.

In an actual database, we can implement and enforce this using constraints. Let
us say that the auto-incrementing integer `id` column of `users` has had a
`PRIMARY KEY` constraint imposed on it so that each value in this column uniquely
identifies each row. We would then add a `user_id` column to the usernames
table, placing a `FOREIGN KEY` constraint on `usernames.user_id`  which
references `users.id`. 

Crucially, to achieve a one-to-one relationship, we must ensure that a `UNIQUE`
constraint is placed on the `FOREIGN KEY` column; this is often done by making
the `FOREIGN KEY` column also the `PRIMARY KEY`, since this implies `UNIQUE`.
This means that each row of the `FOREIGN KEY` column must have a value different
to every other, and thus each row of `users` can only be referenced by a single
row of `usernames`. By placing these constraints on the `usernames.user_id`
column, we enforce that each username can belong to only one user, and each user
can only have one username. This is a one-to-one relationship.

In real databases, however, one-to-one relationships are not common. For
instance, in our example, the data in each row of `usernames` is wholly
dependent on the row of `users` to which it is associated. This suggests that we
should instead simply create a `username` column in the `users` table.

### 1:M ###

In a one-to-many relationship, a single row of one table can be associated with
many rows of another table, but each row of the second table can only be
associated with a single row of the first. An example might be that a `user` can
have multiple `credit_cards`, but each `credit_card` can only be associated with
one `user`.

Let us assume that we have a `users` table with an auto-incrementing integer
column `id` that has been constrained as `PRIMARY KEY`, so that this column
uniquely identifies each row in the table.

We would then create an integer column called `user_id` in our `credit_cards`
table. We would then constrain this as a `FOREIGN KEY` referencing `users.id`.
It is important that this column is not `UNIQUE`, and thus it cannot serve as
`PRIMARY KEY` either. This allows us to have the same `users.id` value in
multiple rows of `credit_cards.user_id`, establishing the 'many' part of the
relationship; and since each row of `credit_cards.user_id` can only hold one
atomic integer value, it can only reference one row of users. This way, each
credit card belongs to a single user, but a user can have many credit cards.
This is a one-to-many relationship.

### M:M ###

A many-to-many relationship is where each entity instance in one table can be
associated with many entity instances in another table, and vice versa.
Implementing a many-to-many relationship in a database is quite different to
implementing the other two types of relationship, since it requires the creation
of a third 'join' table.

The purpose of the join table is to record the associations between the two
entity tables. If we attempted to create a many-to-many relationship without a
join table, we would run into difficulties.

First, each table can only have a finite number of columns. We cannot simply
create a new column each time we wish to associate a given entity instance with
another entity instance. Second, a single column of a relational database should
hold a single value. In relation to database normalization, this principle is
called 'atomicity', since we should have a single atomic value for each field of
a record. Without being able to make this assumption, we lose much of the
functionality that makes a relational database so powerful. Thus, attempting to
store multiple references in some sort of collection or array structure would
not be a good idea.

Rather, in relational databases, we need a finite, largely static number of
columns, and then a dynamically growing number of data rows. Using a third join
table gives us this unbounded space in which to dynamically record associations
between entity instances, making possible a many-to-many relationship, where the
number of associations between entity instances is unbounded.

As an example of implementing a many-to-many relationship, we might suppose we
have a table of `authors` and a table of `books`. An author can publish many
books, and a book can be co-authored by multiple authors. We can assume that
each table has its own `id` column containing an auto-incrementing integer value
that serves as `PRIMARY KEY`, uniquely identifying each row.

We first need to create the join table. This table might be called
`books_authors`. Within this table we would create two integer columns, one
called `book_id` and one called `author_id`. We would impose `FOREIGN KEY`
constraints such that `book_id` references `books.id` and `author_id` references
`authors.id`. It is important that we additionally constrain these columns as
`NOT NULL`, since an association requires a reference to each entity instance.
Now, each time we wish to associate a book with an author, we simply insert a
new row into `books_authors` containing the appropriate references.

If we want the behavior that each association between two entity instances
should only appear once in the join table, it is common to make the
`PRIMARY KEY` of the join table a composite key, here `(book_id, author_id)`.

---

## Difference between `WHERE` and `HAVING` ##


The `WHERE` clause and the `HAVING` clause are both used as filters in SQL
`SELECT` queries. Both filter rows from the result set according to a boolean
condition. However, they come at different points in the logical execution
order of a query and are not interchangeable.

The `WHERE` clause is the more straightforward of the two. Any `SELECT` query
can have a `WHERE` clause attached. The purpose of a `WHERE` clause is to ensure
that our result set contains only those rows that satisfy the boolean condition
immediately following `WHERE`. In the logical order of execution of a query, the
`WHERE` clause is applied after the `FROM` clause (and its `JOIN`s, if any) has
constructed a transient, working table, but before any grouping or aggregation
operations have taken place.

For instance,
```sql
SELECT firstname,
       lastname
  FROM customers
 WHERE lastname = 'Barnes';
```
Here, our simple `FROM` clause constructs a transient table that is simply the
`customers` table without any `JOIN` operations. Next, our `WHERE` clause
filters the table rows such that the only remaining rows are those where the
`lastname` field is exactly equal to the string `'Barnes'`. Finally, our select
list selects the `firstname` and `lastname` columns for the result set.
Essentially, our query asks for the `firstname` and `lastname` of any customer
whose `lastname` is Barnes.

The `HAVING` clause can only be applied to a query in which we have a `GROUP BY`
clause. Logically, the `HAVING` filter is applied after the grouping and
aggregation operations, but before the select list selects columns for the
result set. For instance,
```sql
SELECT lastname,
       COUNT(id) AS lastname_count
  FROM customers
 GROUP BY lastname
HAVING COUNT(id) > 1;
```
Here, our `FROM` clause again uses only the `customers` table. We have no
`WHERE` clause, and so the logical order of execution moves to the grouping
operation, where we `GROUP BY` the value of the `lastname` column. Next comes
our `HAVING` clause.

The filtering condition here is more complex than for our `WHERE`
clause, since it makes use of an aggregate function. This does not have to be the
case, but the ability to filter data based on aggregate results is a key
difference between the `HAVING` and `WHERE` clauses. Since `WHERE` comes before
grouping and aggregation, it cannot filter based on aggregate functions. Our
condition preserves only those groups where the `COUNT` of `id` values (meaning
the number of rows represented by the group) is greater than 1.

It is important to note that our select list uses the same `COUNT(id)` function
and gives it the column alias of `lastname_count`. However, our `HAVING` clause
cannot use the alias, since the `HAVING` clause comes logically before the
select list.

So the difference between `WHERE` and `HAVING` can be summarised as being the
difference between an initial filter applied to the table constructed by the
`FROM` clause (`WHERE`), and a filter applied to this transient table after
grouping and aggregation have transformed it (`HAVING`).

---

## Difference between `INNER JOIN` and `LEFT OUTER JOIN` ##

An `INNER JOIN` can be mentally modelled by imagining that we first construct a
transient table in which each row from the table to the left of the `JOIN`
keyword is concatenated with every row in turn from the table on the right such
that the transient table is the Cartesian product of the left and right tables; the
join condition given in the `ON` clause then filters out any rows that do not
satisfy the join condition. Importantly, any rows from the left or right tables
that cannot be concatenated with a row from the other table while satisfying the
join condition will simply be left out of the resulting transient table.

A `LEFT OUTER JOIN` works the same as an `INNER JOIN` up to this point, but any rows
from the left hand table that did not find any matching rows from the right hand
table that could satisfy the join condition will now be added to the result set
with `NULL` values for each of the right hand table's columns. This means that
regardless of the join condition, we can be sure that every row from the left
hand table will be preserved in the transient table resulting from the join
operation.

A common scenario where we would choose a `LEFT JOIN` over an `INNER JOIN` would
be where we want to generate a count of some sort and we want to be sure that
our result set includes the count for each entity instance even where it is
zero.

To clarify this, let us assume that we have a database for a social media app in
which we have a `users` table and a `posts` table. If we wanted to count how
many posts each user had made, we need to decide whether we are only interested
in users that have made at least one post, or whether we want to include users
that have made zero posts.

If we are only interested in users that have made at least one post, we would
use an `INNER JOIN`:

```sql
SELECT users.name,
       COUNT(posts.id) AS post_count
  FROM users
       INNER JOIN posts
       ON users.id = posts.user_id
 GROUP BY users.id, users.name;
```

Any `users` entity instance whose `id` does not appear in at least one row of
the `posts.user_id` column will simply be discarded, and the `posts_count`
column in our result set will always be greater than zero.

On the other hand, if we want to include `users` whose `post_count` is zero,
we would use a `LEFT JOIN`:

```sql
SELECT users.name,
       COUNT(posts.id) AS post_count
  FROM users
       LEFT OUTER JOIN posts
       ON users.id = posts.user_id
 GROUP BY users.id, users.name;
```

This time, any `users` entity that is not referenced by at least one row of the
`posts.user_id` column will be added to the transient table resulting from the
`FROM... JOIN` clause with `NULL` values in the `posts` columns. The `COUNT`
function will return `0` for those groups, and so we now have a count for every
user in `users`, even if that count is zero.

---

## Subqueries vs Joins ##


Subqueries in SQL allow us to use the result set of one query (the subquery) in
the context of another query (the outer query).

Subqueries can appear in various different clauses of a query and they have many
uses. A subquery might return a single row/column value (a scalar subquery), an
entire column of row values, or even an entire table (generally in the context
of a `FROM` clause).

Sometimes, a subquery can be used to achieve the same result as a `JOIN`,
and which to use will come down to code clarity and readability, or often
performance for large-scale databases. While `JOIN`s are generally more
efficient, this is not always the case, and if we are optimizing for performance
we generally need to test the different approaches using `EXPLAIN` and
`EXPLAIN ANALYZE` to see which is faster in the specific context.

The following is an example of two queries that achieve the same result. For
these examples, let us assume that we have a library database containing a
`users` table and a `checkouts` table, with the latter recording when a user
has checkout out a book.

The first uses a subquery.

```sql
SELECT u.full_name
  FROM users AS u
 WHERE u.id NOT IN (SELECT c.user_id FROM checkouts AS c);
```

This query will return the `full_name` from the `users` table for only those
users who have not checked out a book.

The condition in the `WHERE` clause uses a subquery expression, `NOT IN`;
subquery expressions are a special set of set operators that return a boolean
value in relation to the result of a subquery. The `NOT IN` operator (like the
opposite `IN` operator) takes a single scalar value to the left and then a flat
set of values on the right. It is important here that our subquery returns only
a single column of row values, acting as a flat set or list of values. `NOT IN`
returns `true` only if the value to the left, here `users.id`, does not appear
in the set on the right, generated by our subquery.

Since our subquery selects every value in the `user_id` column from the
`checkouts` table, the outer query's `WHERE` clause filters out any `users`
whose `id` is referenced by any row of `checkouts`.

The second approach uses a `JOIN`.

```sql
SELECT u.full_name
  FROM users AS u
       LEFT OUTER JOIN checkouts AS c
       ON users.id = checkouts.user_id
 WHERE c.user_id IS NULL;
```

Here, we use a `LEFT OUTER JOIN` to join `users` and `checkouts`. This means
that any row of `users` where the `id` is not referenced by any row of
`checkouts.user_id` will appear in the resulting transient table with `NULL`
values for each column from `checkouts`. Our `WHERE` clause then selects only
those rows of the transient table whose `checkouts.user_id` column contains
`NULL`.

Both these approaches yield the same result set via different means.

---

## How do muli-part `JOIN`s work ##


When a SQL query involves more than one `JOIN`, the process can be mentally
modelled as a sequence of binary `JOIN`s. The `FROM` clause, including the
`JOIN`s, comes logically at the start of the execution of the query, and its
function is to build up a 'transient' table, which can then be filtered,
grouped, aggregated, have columns selected from it, and so on, by the other
parts of the query.

For an example, let us assume a library database with a `users` table, a `books`
table, and a `checkouts` table that records when a user checks out a book.

```sql
SELECT u.full_name,
       b.title
  FROM users AS u
       INNER JOIN checkouts AS c
       ON u.id = c.user_id
       INNER JOIN books AS b
       ON c.book_id = b.id
 WHERE c.status = 'Checked out';
```

We can begin with the first `INNER JOIN` with `users` on the left and
`checkouts` on the right of the `JOIN` keyword. The transient table that results
from this join operation contains rows representing only those concatenations of
a row from `users` and a row from `checkouts` where the `users.id` value matches
the `checkouts.user_id` value. This join 'returns' a new transient table which
becomes the left-hand operand of the next `INNER JOIN`, with `books` as the
right-hand operand. This second join operations returns a new transient table
containing concatenated rows where the `checkouts.book_id` column value matches
the `id` column of a row from `books`.

So we gradually build the transient table that is returned by the `FROM` clause
via a left-to-right sequence of 'binary' joins, where the left hand operand is
the transient table resulting from the previous join.

The fact that we have two different columns named `id`, in addition to `book_id`
and `user_id`, emphasizes how important it can be for readability to use table
aliases in multi-part joins.

---

## Explain self-joins with an example of use case ##

A self-join happens when we join a table to itself. This is useful when we need
to create relationships between instances of the same entity.

For instance, if an app offered membership discounts to users who recruit new
users by recommendation, the database might contain a table of `users` with an
`id` column as Primary Key, and a Foreign Key column `recommended_by` which
references the `id` column of the same table. If we wanted to see the name
of members who had made a recommendation and the name of the member they had
recommended, we might write a query like:
```sql
SELECT recommenders.full_name AS recommender,
       recommendees.full_name AS recomendee
  FROM members AS recommenders
       INNER JOIN members AS recommendees
       ON recommenders.id = recommendees.recommended_by;
```

Unlike when joining separate tables, we must always use table aliases in
order to express a self-join. In our example, it is vitally important to use
the table aliases `recommenders` and `recommendees`, since we are essentially
using two copies of the same table to construct the transient table for our
query and we need to be able to distinguish between them in order for our join
condition to be syntactically expressable.


