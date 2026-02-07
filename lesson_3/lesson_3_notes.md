# 3:1 Relational Data and `JOIN`s: What to Focus On #

Relational data is the key feature of relational databases.

* Focus on how to work with multiple tables using `JOIN`.

* SQL has a lot of optional keywords.

Use these keywords initially, since an explicit style is good for learning.

* Think about how schemas change over time.

# 3:2 What is Relational Data? #

Relational databases are called **relational** because they persist data in a
set of **relations**. What is a relation? A table, which is a set of columns and
rows of data, is a relation.

PostgreSQL also refers to some other objects as 'relations', not all of which
fit the relational model's notion of a relation.

The terminology can become confusing, though, when the concept of
**relationships** enter a discussion. The words *relation* and *relationship*
are visually similar, but they name two distinct things within a database. A
**relationship** is a connection between entity instances, or rows of data,
usually resulting fromm what those rows of data represent. For example, a row in
a **customers** table in a database would probably have a relationship with zero
or more rows in an **orders** table.

* A **relation** is *usually* another way to say "table".
* A **relationship** is an association between the data stored in those
relations.

For a developer, relational data can be translated into a more functional
definition: working with more than one table at a time.

# 3:3 Database Diagrams: Levels of Schema #

When looking at a database diagram, we need to ask what level of abstraction it
is modelling:
1. Conceptual --- thinking about the data in the most abstract way, thinking
about the relationships between business logic 'real-world' entities
2. Logical --- sits in between, avoids specific RDBMS details, but may think in
terms of general data types, etc
3. Physical --- thinking about the details of how data is stored, rules, keys,
RDBMS-specific details and so on.

* Conceptual schema: a high-level design focused on identifying entities and
their relationships.
    * **entity-relationship** model, Entity Relationship Diagram (ERD)

* Physical schema: low-level database-specific design focused on implementation.

# 3:4 Database Diagrams: Cardinality and Modality #

Cardinality and modality relate to the types of relationships between entities:
one-to-one, one-to-many, and many-to-many.

* Cardinality: the number of objects on each side of the relationship (1:1, 1:M,
M:M).

* Modality: if the relationship is required (1) or optional (0).

If the relationship is required, that means there has to be at least one
instance of that entity. If the relationship is optional, there don't need to be
any instances at all. We can think of the modality as the lower bound on how
many instances there can be in a relationship. Modality is often notated using a
single number: 1 if the relationship is required, 0 if it is not required.

The modality is not necessarily reflected in the physical schema; it is a more
conceptual category whose purpose is to help the developer understand the
relationships between high-level entities.

> In practice, one-to-one relationships are rare. Most often, a one-to-one
relationship that emerges between two entities during the developmenent of a
conceptual schema indicates that the two entities will be folded into a single
table in the physical schema.

In **crow's foot notation**, the crow's foot represents a modality of many, and
the horizontal line connector with a transverse '1' represents a cardinality of
one (on the side of that connection). Next to the crow's foot or transverse `1`
is either a '0' representing a modality of 'not required' or a '1' representing
a modality of 'required'.

## From Pete Hanson's Post on Cardinality and Modality in the Lesson Forum #

Assume two tables A and B.

* **Cardinality** answers the question "How many rows in table A are allowed to
be linked to how many rows in table B, and vice versa?"
    * A cardinality of **1:1** means that each row in table A can be connected
    to *at most one row* in table B, and vice versa. At least one of the two
    tables should have a foreign key that points to a key in the other table.
    * A cardinality of **1:M** means that each row in table A is allowed to be
    linked to *0, 1, or many rows* in table B. However, each row in table B can
    be linked to *at most one row* in table A. Here, we are assuming that table
    A is the '1' side of the relationship while B is the 'many' side. In this
    case, table B must have a foreign key that points to a key (often the
    primary key) in table A.
    * A cardinality of **M:M** means that each row in table A is allowed to be
    linked to *0, 1, or many rows* in table B. In addition, each row in table B
    is allowed to be linked to *0, 1, or many* rows in table A. An M:M
    cardinality requires a third table, sometimes called the 'join' table. This
    third table has two foreign keys, one that points to a key in table A, and
    one that points to a key in table B. (The keys in A and B are usually
    primary keys.)
    * Cardinality says nothing about whether a relationship between two tables
    is required.
* **Modality** answers the question, "Can a row in table A exist without a
corresponding row in table B?"
    * If it can, then the modality for table B is **optional** (or '0' as
    depicted in ERD).
    * If it cannot, then the modality for table B is **required** (or '1' as
    depicted in ERD).
    * In a 1:M relationship:
        * If the foreign key in table B can be `NULL`, the modality of table B
        is **optional**.
        * If the foreign key in table B has a `NOT NULL` constraint, the
        modality of table B is **required**.
    * In an **M:M** relationship, there is **usually no easy way** to tell from
    looking at the schema whether one side or the other is optional or required.
    By default, all M:M relationships have a modality of optional on both sides.
    SQL servers cannot enforce a required modality. However, developers can
    write code that can effectively provide a required modality; this is usually
    depicted in the ERD.

# 3:5 A Review of `JOIN`s #

* Use the most explicit name for each type of join.
* It is possible to get the results produced by joins without using the `JOIN`
syntax. However, since we should always use the most explicit syntax, we should
use the `JOIN` syntax (which is actually newer than the other syntax).
* The older syntax for a cross join is simply to list multiple tables in the
`FROM` clause. If we then add a `WHERE table_a.id = table_b.b_id` clause, we get
the same result as an inner join.

# 3:7 Using Foreign Keys #

In database parlance, a *foreign key* can refer to two different, but related,
things:
* A column that represents a relationship between two rows by pointing to a
specific row in another table using its *primary key*. A complete name for these
columns is *foreign key column*.
* A constraint that enforces certain rules about what values are permitted in
these foreign key relationships. A complete name for this type of constraint is
*foreign key constraint*.

### Creating Foreign Key Columns ###

To create a foreign key *column*, just create a column of the same type as the
primary key column it will point to.

### Creating Foreign Key Constraints ###

To create a foreign key *constraint*, there are two syntaxes that can be used.
The first is to add a `REFERENCES` clause to the description of a column in a
`CREATE TABLE` statement:
```sql
CREATE TABLE orders (
    id serial PRIMARY KEY,
    product_id integer REFERENCES products (id),
    quantity integer NOT NULL
);
```

The second way is to add the foreign key constraint separately, just as you
would any other constraint (note the use of `FOREIGN KEY`):
```sql
ALTER TABLE orders
  ADD CONSTRAINT orders_product_id_fkey
  FOREIGN KEY (product_id)
    REFERENCES products(id);
```

### Referential Integrity ###

One of the main benefits of using the foreign key constraints provided by a
relational database is to preserve the *referential integrity* of the data in
the database. The database does this by ensuring that every value in a foreign
key column exists in the primary key column of the table being referenced.
Attempts to insert rows that violate the table's constraints will be rejected.

## The upshot of this assignment ##

We can have a 'foreign key column' without a `FOREIGN KEY` constraint on that
column. We could manually ensure that every value in that column references a
value in the primary key column of another table, and we are free to make
`JOIN`s between the table without any constraints.

What the `FOREIGN KEY` constraint offers is the ability to tell the database at
the schema level that it should *only* accept values from the referenced primary
key column as valid values for rows in the foreign key column.

This ensures referential transparency: a guarantee that every value in the
foreign key column points to an existing row of the of the other table.
Without this, we could create 'orphaned' rows of the table with the foreign key
since we are free to insert values that do not match any of the values in the
primary key column of the referenced table.

If we have such orphaned rows, then our `JOIN`s will start to lose meaning. An
`INNER JOIN` will drop rows where there is no meaningful referential connection.
A `LEFT JOIN` will show a row from one table with `NULL` values for the other.
And so we stop being able to trust basic operations. This is why `FOREIGN KEY`
constraints are so useful, in that they ensure that our data structure remains
meaningful and enforced.

* It is worth noting that a `FOREIGN KEY` constraint, by itself, will still
permit `NULL` values. In order to ensure that *every* row in the foreign key
column references a row in the other table's primary key column, we need to add
a `NOT NULL` constraint on the foreign key column.

* Therefore it is often necessary to use `FOREIGN KEY` and `NOT NULL` together.

# 3:8 One-to-Many Relationships #

When a badly-designed schema forces us to duplicate data values between rows,
this causes problems, including:
* If we need to update one of those values, we need to update it in every row
where it occurs. This creates a situation in which it would be easy to make the
database inconsistent, which means that it contains more than one answer for a
given question. If this occurred, it would be known as an **update anomaly**.

In general, a schema combining tables that should be separate can create many
problems, including:
* **Insertion anomaly** --- for instance, being unable to store contact details
without a call having been placed to that contact.
* **Deletion anomaly** --- for instance, being unable to delete calls made to a
contact without deleting the contact information.

> It is best not to think about the space required to store duplicate data when
thinking about **normalization**, but instead to think of the
**three anomalies**. Sometimes, it is actually desirable to have data duplicated
(or **denormalized**), as it can make some retrieval operations much more
efficient.

**Normalization** is the process of designing schema that minimize or eliminate
the possibile occurence of these anomalies.

The basic procedure of normalization involves extracting data into additional
tables and using foreign keys to tie it back to its associated data.

> Recall that a **foreign key column** is a column that stores references to a
primary key column elsewhere in a database. Foreign keys usually point to other
tables, but there are cases where they will point to rows in the same table.

* Note that there are keywords that are reserved, meaning we need to
double-quote an identifier named the same thing, and there are keywords that are
non-reserved, meaning they can be used as identifiers with no issue.

# 3:9 Extracting a 1:M Relationship From Existing Data #

It's usually a good idea to try to keep a table's schema restrictive in order to
help preserve the integrity of the data within it. But keep in mind that the
same constraints that can help ensure this integrity also limit what data is
stored, and, often more importantly, how data can be added and modified.
Sometimes it is necessary to have the database in an 'invalid' state temporarily
while performing certain operations, but this should only be done if there is no
other way to proceed.

# 3:10 DDL Exercises #

An enumerated type is a data type that must have one of a finite set of values.
For instance, a traffic light can be red, green, or yellow; these are enumerate
values for the color of the currently lit signal light.

> to **enumerate**: to name things separately, one by one; to specify each
member of a sequence individually in incrementing order.

# 3:12: Many-to-Many Relationships #

**Many-to-many** relationships are those where there can be multiple entity
instances on both sides of the relationship. You can think of them as
one-to-many relationships that go from the first table to the second **and**
from the second table to the third.

This intermediating table that establishes a many-to-many relationship via
having a one-to-many relationship to two different tables is called a *join
table*.

>The reason we need a join table is that foreign keys can only express either a
one-to-many relationship, or, if the foreign key column is also the primary key
of the same table, a one-to-one relationship. If we had two tables, `books` and
`genres` and we wanted to express the many-to-many relationship where a book
might fit several genres and a genre includes many books, we cannot do this with
only the two tables in relation. For instance, if `books` contains the foreign
key `genre_id`, this means that each book can only belong to one genre unless we
have many rows in `books` devoted to the same book. This kind of duplication
breaks normalization and leads to the problems associated with data duplication.
Another option might be to try stuffing multiple genres into a single row of the
column, but this would create all sorts of problems for querying the data
effectively. And the same problems would arise if we tried adding a `book_id` to
the `genres` table.
>
>So instead, we need a join table. In a many-to-many relationship, many books
might relate to many genres and vice versa, but we need to keep track of which
book relates to which genres and vice versa. The purpose of the join table is
essentially to store the information about all such connections. So each
*connection* becomes a row in the join table, telling us that *this specific
book* is related to *this specific genre*, but also that the same book is also
related to another genre. Since the join table consists primarily of two foreign
key columns, we can store as many rows relating to the same book, or the same
genre, since the only information about a book or genre in the table are
references to those entity instances in their respective tables.

### Should join tables include a primary key column? ###

**It depends**. On one hand, we can uniquely identify a row in a join table that
relates tables A and B, because a row in the join table will have a unique
combination of references to a specific row in A and a specific row in B. On the
other hand, many tools for building applications make the assumption that all
tables will have a primary key `id` column. Rails, for instance, now suggests
developers of Rails apps follow this convention. So whether a join table needs a
primary key of its own depends largely on the broader design of and tooling used
by an application.

### Should Foreign Keys in a Join Table Allow `NULL`s? ###

In almost all cases, you should **not** allow `NULL` foreign keys in a join
table.

One problem caused by allowing `NULL` fields is that it becomes difficult to
identify entity instances from table A that are *not* currently related to any
instances in table B.

Similar problems can occur unless we also specify `ON DELETE CASCADE` for the
foreign key columns in the join table.

Unless there is some specific requirement to omit them, you should **always**
use the `NOT NULL` constraint and `ON DELETE CASCADE` for foreign key columns in
a join table. This prevents `NULL` values and mitigates against references to
non-existent table rows. To further mitigate error, our join tables should also
have a `UNIQUE (a_id, b_id)` table constraint to guarentee that each pair of
foreign key references is unique.

# 3:13: Converting a 1:M Relationship to a M:M Relationship #

When creating a join table, the table name should consist of the joined tables'
names in alphabetical order, separated by an underscore.

We can replace the `VALUES (column_1_value, ...)` part of an `INSERT` statement
with a subquery, and it will insert the columns of datareturned by the subquery
into the table columns specified by the `INSERT` statement.

For example,
```sql
INSERT INTO films_directors (film_id, director_id) (
    SELECT id, director_id
    FROM films
);
```

`VALUES` is just a special type of `SELECT` and `INSERT` writes the result of
arbitrary `SELECT` statements into the table.

The reason `VALUES` is often used with `INSERT` is that many RDBMSs don't
support `SELECT` without a `FROM` clause, so using `VALUES` is more convenient
and portable.

# 3:14: SQL Fundamentals --- Many to Many

## `CASE` Expressions ##

The SQL `CASE` expression is a generic conditional expression, similar to
if/else statements in other programming languages.

```sql
SELECT a,
       CASE WHEN a=1 THEN 'one'
            WHEN a=2 THEN 'two'
            ELSE 'other'
       END
    FROM test;
```

There is a 'simple' more switch-like case statement syntax:
```sql
CASE expression
    WHEN value THEN result
    [WHEN ...]
    [ELSE result]
END
```

## Window Functions ##

A **windown function** performs a calculation across a set of table rows that
are somehow related to the current row.

This is comparable to the type of calculation that can be done with an aggregate
function. But unlike regular aggregate functions, use of a window function does
not cause rows to become grouped into a single output row --- the rows retain
their separate identities. Behind the scenes, the window function is able to
access more than just the current row of the query result.

Some aggregate functions can also be used as window functions. Some window
functions are always window functions. What distinguishes a window function call
syntactically is that a window function call always contains an `OVER` clause
that directly follows the function's name and arguments.

The `OVER` clause determines exactly how the rows of the query are split up for
processing by the window function. The `PARTITION BY` list within `OVER`
specifies dividing the rows into groups, or partitions, that share the same
values of the `PARTITION BY` expression(s). For each row, the window function is
computed across the rows that fall into the same partition as the current row.

You can also control the order in which rows are processed by window functions
using `ORDER BY` within `OVER`. (The window `ORDER BY` does not even have to
match the order in which the rows are output.)

The rows considered by a window function are those of the 'virtual table'
produced by the query's `FROM` clause as filtered by its `WHERE`, `GROUP BY` and
`HAVING` clauses, if any. For example, a row removed because it does not meet
the `WHERE` condition is not seen by any window function. A query can have
multiple window functions that slice up the data in different ways by means of
different `OVER` clauses, but they all act on the same collection of rows
defined by this virtual table.

It is possible to omit `PARTITION BY`, in which case there is just one partition
containing all the rows. `ORDER BY` can be omitted if order of processing is not
important.

For each row, there is a set of rows within its partition called its *window
frame*. Many (though not all) window functions act only on the rows of the
window frame, rather than of the whole partition.

By default, if `ORDER BY` is supplied then the frame consists of all rows from
the start of the partition through the current row, plus any following rows that
are equal to the current row according to the `ORDER BY` clause. When `ORDER BY`
is omitted the default frame consists of all rows in the partition.

Window functions are permitted only in the `SELECT` list and the `ORDER BY`
clause of the query. They are forbidden elsewhere, such as in `GROUP BY`,
`HAVING`, and `WHERE` clauses. This is because they logically execute after the
processing of those clauses. Also, window functions execute *after* regular
aggregate functions. This means it is valid to include an aggregate function
call in the arguments of a window function call, but not vice versa.

* Note: you should *always* think about sort order, even when you *happen* to
get the results in the order you want without an `ORDER BY` clause. You should
generally include an `ORDER BY` when solving an exercise or problem, even if it
is not strictly necessary because the rows happen to be returned in the looked
for order.

# 3:15 Summary #

* *Relational database* are called *relational* because they persist data in a set
of *relations*, or, as they are more commonly called, *tables*.
* A *relationship* is a connection between entity instances, or rows of data,
usually resulting from what those rows of data represent.
* The three levels of schema are *conceptual*, *logical*, and *physical*.
* The three types of relationship are *one-to-one*, *one-to-many*, and
*many-to-many*.
* A *conceptual schema* is a high-level design focused on identifying entities
and their relationships.
* A *physical schema* is a low-level database-specific design focused on
implementation.
* *Cardinality* is the number of objects on each side of the relationship.
* The *modality* of a relationship indicates if that relationship is required or
not.
* Data has *referential integrity* if it requireds all references to be valid.

