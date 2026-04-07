# Be able to describe what primary, foreign, natural, and surrogate keys are. #

## SQL Book: Create and View Tables ##

One of the important functions of a database is to maintain the integrity and
quality of the data that it is storing. Keys and Constraints are rules that
define what data values are allowed in certain columns. They are an important
database concept and are part of a database's chema definition. Defining keys
and constraints is part of the database design process and ensures that the data
within a database is reliable and maintains its integrity. Constraints can apply
to a specific column, an entire table, more than one table, or an entire schema.

Keys come into play when we have to set up relationships between different
database tables. They're also useful for keeping track of unique rows within a
database.

## SQL Book: Create Multiple Tables ##

Once we know the tables we need and have defined the relationships that should
exist between those tables in an ERD, we can implement these relationships in
the schema using **keys**.

Keys are a special type of constraint used to establish relationships and
uniqueness. They can be used to *identify a specific row in the current table*,
or to *refer to a specific row in another table*. The two types of key that
fulfil these roles are **Primary Keys** and **Foreign Keys** respectively.

### Primary Keys ###

A necessary part of establishing relationships between two entities or two
pieces of data is being able to identify the data correctly. In SQL, uniquely
identifying data is critical. **A Primary Key is a unique identifier for a row
of data**.

In order to act as a unique identifier, a column must contain some data, and
that data should be unique to each row. Thus, at the column data constraint
level, a `PRIMARY KEY` constraint is essentially equivalent to adding `NOT NULL`
and `UNIQUE` constraints to that column.

However, although any column in a table can have `UNIQUE` and `NOT NULL`
constraints applied to them, each table can have only one Primary Key. It is
common practice for that Primary Key to be named `id`.

The Primary Key, through enforcing the presence of a unique value, means at the
level of a single table that we can always grasp a particular row, regardless of
the similarity of values between rows for the other columns. But importantly,
the Primary Key is one half of the mechanism for implementing relationships
between tables.

### Foreign Keys ###

A Foreign Key allows us to associate a row in one table to a row in another
table. This is done by setting a column in one table as a Foreign Key and having
that column reference another table's Primary Key column. Creating this
relationship is done using the `REFERENCES` keyword. Row values in the Foreign
Key column act as references to rows in the Primary Key column of another table.

By setting up the reference between the Foreign Key constrained column of one
table and the Primary Key constrained column of another table, we are helping
ensure the **referential integrity** of a relationship. Referential integrity
guarantees that a given foreign key value references an existing record in the
target table; if it doesn't, an error occurs. In other words, a SQL database
system won't let you add a value to the Foreign Key column of a table if the
Primary Key column of the target table doesn't already have that value.

A Foreign Key constraint prevents
* Operations on the referencing table that attempt to add a value for the Foreign
Key column that is not already present in the referenced
table's Primary Key column.
* Operations on the referenced table that would remove a value in the Primary
Key column that is referenced by the referencing table, unless a policy such as
`ON DELETE CASCADE` is in place (in which case, the affected rows in the
referencing table are also deleted).

It is important to remember that a Foreign Key constraint on the referencing
table also constrains operations on the referenced table. This is how
referential integrity is preserved.

### Referential Integrity ###

Referential integrity is a concept used when discussing relational data to
indicate that table relationships must be consistent.

This means not only making use of Foreign and Primary Keys, but also setting up
these constraints such that they enforce the type of relationship we want:
one-to-one, one-to-many, or many-to-many.

The specific way in which a Foreign Key is used as part of a table's schema
depends on the type of relationship we want to define between our tables. In
order to implement that schema correctly it is useful to formally describe the
relationships we need to model between our entities:
* one-to-one
* one-to-many
* many-to-many

A **one-to-one** relationship between two entities exists when a particular entity
instance exists in one table, and it can have only one associated entity
instance in another table.

Example: a user can have only one address, and an address belongs to only one
user. (This example is contrived, and unlikely in practice.)

A one-to-one relationship is implemented as follows. The `id` that is the
`PRIMARY KEY` of the `users` table is used as both the `FOREIGN KEY` and
`PRIMARY KEY` of the `addresses` table. In other words, the `FOREIGN KEY` that
references the `PRIMARY KEY` of the referenced table is also the `PRIMARY KEY`
of the referencing table.

A **one-to-many** relationship exists between two entities if an entity instance
in one of the tables can be associated with multiple records (entity instances)
in the other table. The opposite relationship does not exist; that is, each
entity instance in the second table can only be associated with one entity
instance in the first table.

Example: a review belongs to only one book. A book has many reviews.

Here, the foreign key in the referencing table is **not** the primary key of the
referencing table. This means that the Foreign Key is not bound by uniqueness,
and so multiple rows of the referencing table can reference the same row of the
referenced table.

It is important to note that when we specify a column `FOREIGN KEY`, this does
not automatically make the column `NOT NULL`. Nevertheless, we almost always
want a Foreign Key column to disallow `NULL` values, so we should specify this
additional constraint ourselves.

A **many-to-many** relationship exists between two entities if for one entity
instance there may be multiple records in the other table, and vice-versa.

Example: a user can check out many books. A book can be checked out by many
users (over time).

There is no way to implement a many-to-many relationship between two tables
directly. Instead, we break apart this many-to-many relationship into two
one-to-many relationships using a third, cross-reference table (also known as a
join table). This table holds the relationship between the two entities, by
having two `FOREIGN KEY` columns, each of which references the `PRIMARY KEY` of
one of the tables for which we want to create this relationship.

The join table may well have additional data fields which do not pertain to
either of the associated entities in the many-to-many relationship but rather
to the association itself. This additional context can be useful within the
business logic of our application.


### The `ON DELETE` Clause ###

In PostgreSQL, the default behavior when attempting to delete a row in a table
that is referenced by a row in another table is for the operation to fail with
an error. This is the `ON DELETE RESTRICT` or `ON DELETE NO ACTION` policy.

Adding the `ON DELETE` clause and setting it to `CASCADE` means that when we
delete a row that is referenced by another table, the referencing row is also
deleted.

There are alternatives to `CASCADE`, such as `SET NULL` and `SET DEFAULT`. It is
important to choose the right behavior deliberately, since otherwise the
behaviour is left up to the default of the database system we happen to be
using.

The problem with using `RESTRICT` is that in order to delete a row from the
referenced table, we must first delete any rows that reference it. This requires
our application to know, or find, every reference to the row throughout the rest
of the database, which introduces unnecessarily brittle logic. Essentially, we
are duplicating logic that could be performed by the database itself with
`CASCADE`, and we may need to use this logic in many places in our application
where it could instead be centralized within the database policy. This makes it
harder for dangling references to accumulate over time.

## SQL Book: Summary and Additional Resources ##

Primary Keys and Foreign Keys are used to create references between rows in
different tables, creating different kinds of relationship between tables:
one-to-one, one-to-many, and many-to-many.

## 2:11 Using Keys ##

If we do not use keys at all, we are dependent on ad hoc means of identifying
rows of data. For example, if we wish to retrieve a unique row, we might need
to filter on more than one data field, the number of which depends on how many
fields are identical to those of another row, and this presents problems for
designing applications. Sometimes, we might need to store multiple rows, all of
whose column values are exactly the same. In this common scenario, we cannot
identify an individual row at all without a key.

The solution to these problems is to stop using values with the data to identify
rows. Or at least, stop using values that have not been carefully selected to be
unique across the entire dataset.

A key uniquely identifies a single row in a database table. There are two types
of key: **natural keys** and **surrogate keys**.

### Natural Keys ###

A **natural key** is an existing field --- or combination of fields --- in a
dataset that can be used to uniquely identify each row of data in that dataset.
On the surface, there appear to be a lot of values that *might* be satisfactory
for this use: a person's phone number, email address, social security number, or
a product number.

However, in reality most values that *seem* like they are good candidates for
natural keys turn out not to be. A phone number or email address can change
hands. A social security number shouldn't change, but only some people have
them. And products often go through multiple revisions while retaining the same
product number.

There are a variety of solutions to these problems, including using more than
one existing value together as a **composite key**. But instead of solving the
problems associated with natural keys, this will often just defer the problem
until later without actually addressing it.

### Surrogate Keys ###

A **surrogate key** is a value that is created solely for the purpose of
identifying a row of data in a database table. Because it is created
specifically for that purpose, it can avoid many of the problems associated with
natural keys.

Perhaps the most common surrogate key in use today is an auto-incrementing
integer. This is a value that is added to each row in a table as it is created.
With each row, this value increases in order to remain unique in each row.

In PostgreSQL, we implement auto-incrementing integers through the `serial`
pseudo-type, which under the hood creates a sequence object. A sequence is a
special kind of object, which PostgreSQL treats as a relation. A sequence
remembers the last number it generated, so it will generate a sequence of
numbers in a predetermined order automatically. These numbers are retrieved
using the `nextval` function, and once a number has been returned by such a call
it will not be returned again, guaranteeing that this mechanism can provide a
unique value for each row in the surrogate key column.

Since we wish our surrogate key to uniquely identify each row, it is important
we constrain the column used for this purpose to be `UNIQUE` and `NOT NULL`.
Both of these constraints are automatically applied if we place the
`PRIMARY KEY` constraint on a column.

### Primary Keys ###

By specifying `PRIMARY KEY` as a constraint, PostgreSQL will create an index on
that column that enforces it holding unique values in addition to preventing the
column from holding `NULL` values.

As well as enforcing uniqueness and preventing `NULL` values, making a column
`PRIMARY KEY` makes explicit our intention: the values in this column are to be
treated as the canonical means of identifying individual rows of data. It acts
as documentation of our intention as database designers.

For primary key columns, there are certain widely-used conventions:
1. All tables should have a primary key column called `id`.
2. The `id` column should automatically be set to a unique value as new rows are
inserted into the table.
3. The `id` column will often be an integer, but there are other data types
(such as UUIDs) that can provide specific benefits.

While we do not have to have a `PRIMARY KEY` column in every table, doing so is
generally a good idea.


