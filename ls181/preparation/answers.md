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




