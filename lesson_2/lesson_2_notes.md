# 2:1 What to Focus On #

* Learn the SQL and relational database features mentioned in this lesson. Do
not go down rabbit holes at this stage.
* Spend some time with parts of the documentation. Don't try to read all of the
docs.
* Learn the difference between data and schema.

# 2:2 The SQL Language #

SQL is a language used to manipulate the structure and values of datasets
stored in a relational database. It is described as a **special purpose
language** because it is typically used only for a very specific purpose:
interacting with relational databases. This can be contrasted with a general
purpose language, such as Ruby, JavaScript, C, or many others, that can be used
for a variety of uses from application creation to scripting and embedding
within other languages and runtimes.

SQL is predominantly a **declarative language**. This means that it describes
*what* needs to be done, but does not detail *how* to accomplish it. In
practice, this means that the same query might be executed differently on an
identical dataset based on a variety of conditions. The SQL server, for the
most part, abstracts these details away from the user, although there are ways
to see how a specific query will be executed by the system. This is most
commonly utilized when the performance of a query does not meet an application's
requirements. For the most part, the SQL database engine selects the most
efficient way to execute a query, but in some circumstances a few hints from a
human user can improve performance drastically.

SQL is really three languages in one, containing smaller sub-languages for data
definition, data manipulation, and data control.
* DDL (Data Definition Language) --- relation structure and rules
* DML (Data Manipulation Language) --- values stored within relations
* DCL (Data Control Language) --- who can do what

### Data Definition Language (DDL) ###

The *data definition* pars of SQL are what allow a user to create and modify the
schema stored within a database. It includes `CREATE TABLE`, `ALTER TABLE`,
`ADD COLUMN`, and other statements for creating or modifying the structure of or
rules that govern the data that is held within a database.

### Data Manipulation Language (DML) ###

This part of the SQL language is what allows a user to retrieve or modify the
data stored within a database. Some RDBMSs consider the retrieval and
manipulation as two separate languages themselves, but PostgreSQL's
documentation combines them.

DML includes `SELECT`, `INSERT`, `UPDATE`, and `DELETE`.

### Data Control Language (DCL) ###

**DCL** is tasked with controlling the rights and access roles of the users
interacting with a database or table.

DCL includes `GRANT` and `REVOKE`.

## Syntax ##

SQL code is made up of **statements**. A SQL statement is terminated by a
semi-colon.

You can evaluate arbitrary SQL expressions by typing them after `SELECT`.

**Expressions** in SQL can make use of operators and functions.

# 2:5 PostgreSQL Data Types #

The `text` data type allows us to enter strings of any length we wish. However,
it is specific to PostgreSQL, and is therefore not portable across different
RDBMSs.

It is important to keep in mind that most data types have a limit to the amount
of data they can store. For example, an `integer` column can only store integer
values between -2,147,483,648 and +2,147,483,647. Other data types, such as
`varchar`, have a limit that is defined by the column. PostgreSQL will return an
error if you attempt to store too large a value in a column.

## `NULL` ##

There is a special value in relation databases called `NULL`. This value
represents nothing, that is, the absence of value. The crucial thing to remember
about `NULL` is that it behaves somewhat differently than the nothing value in
other languages. Most languages have somthing similar to `NULL`, and you can
compare that value to itself to get a truthy result.
For example,
```javascript
null == null // => true
```

```ruby
nil == nil # => true
```

```python
None == None # => True
```

In SQL, however, `NULL` behaves differently. When a `NULL` value appears to
either side of any ordinary comparison operator (such as `=`, `<`, `>=`, etc),
the operator will return `NULL` instead of `true` or `false`.

When dealing with `NULL` values, **always** use the `IS NULL` or `IS NOT NULL`
constructs.

# 2:7 Loading Database Dumps #

There are two ways to load SQL files into a PostgreSQL database.

## `psql` ##

The first option is to pipe the SQL file into the `psql` program, using
redirection on the command line to stream the SQL file into `psql`'s standard
input:
```bash
psql -d my_database < file_to_import.sql
```
This will execute the SQL statements within `file_to_import.sql` within the
`my_database` database.

If you already have a running `psql` session, you can import a SQL file using
the `\i` meta-command:
```psql
\i /path/to/file/file_to_import.sql
```

# 2:9 `NOT NULL` and Default Values #

The design of relational database, and their power, comes from the work involved
in defining a common set of attributes (the values of which are stored in
columns). It follows that the more specific and exact the design of the schema
is, the "neater" and more consistent the data will be. Relational databases
allow a schema designer to build a variety of rules about the data into the
system. These rules allow users of the system to make certain assumptions about
the data that lead to simpler solutions.

Being able to insert `NULL` values can lead to problems. `NULL` represents an
absent or missing value. Where does a missing or unknown value fit in within a
sorting sequence? How do you compare a value that is missing with another value
that is unknown? This can lead to unexpected behavior if you aren't careful.

`NULL` values sort as though `NULL` were the maximum value. This means that a
query that orders results in descending order by a check on a column that
contains `NULL` values will return the rows containing `NULL` at the top of the
list.

Having `NULL` be the 'maximum' rather than 'minimum' value for sorting purposes
is arbitrary. Remember that the result of using any operator with `NULL` as an
operand is `NULL`. This makes it impossible to compare a `NULL` value with any
other value, which is normally how a set of values would be sorted.

Because of this arbitrary ordering, `NULL` values will appear first or last. In
PostgreSQL, they appear first when you specify a descending order, and last if
you specify an ascending order.

Problems with `NULL` values not only affect queries run directly on the
database but also cause problems on any software systems that depend on the data
in the database. As well as any application that uses the database as a
datastore, it can also affect systems that are connected to that application via
the internet. For instance, a problem with a company's database could cause
problems with its automated payroll application that in turn makes problematic
payments or charges via internet banking. Problems like this can have dire
real-world consequences. An empty value can affect not only queries done to that
system, but also other systems that have to operate on the same data.

Thus, having undefined values, or `NULL`s, in a database can lead to problems.
These issues can manifest themselves in the form of slightly more complicated
queries or as additional complexity in other systems that have to be designed to
test for every possible value that could be missing.

A better way is to only allow `NULL` values in the database when they are
absolutely needed. Most of the time, there is another value that can be used
instead that can prevent the kinds of complications we've been looking at.

* Note: for type casting, the following syntaxes are equivalent:
```sql
type_name 'string'
'string'::type_name
CAST ( 'string' AS type_name )
```
where `type_name` is the name of the type we wish to cast *to*.

The `::` operator casts the value on the left to the type on the right.

The `column BETWEEN value1 AND value2` comparison predicate is equivalent to
`column >= value1 AND column <= value2`.

# Using Keys #

It is entirely possible to have identical rows of data that represent different
real-world entities appear in the same table.

## Solving the Problem: Keys ##

Keys allow us to stop using values within the data itself to identify rows. Or
at least, stop using values that have not been carefully selected to be unique
across the entire dataset.

A **key** uniquely identifies a single row in a database table. There are two
types of key to focus on here:
* Natural keys
* Surrogate keys

## Natural Keys ##

A **natural key** is an existing value in a dataset that can be used to uniquely
identify each row of data in that dataset.

In reality, most values that *seem* like they are good candidates for natural
keys turn out not to be.

There are a variety of solutions to this problem, including using more than one
existing value as a **composite key**. But instead of solving the problems
associated with natural keys, this will often just defer the problem until later
without actually addressing it.

## Surrogate Keys ##

A **surrogate key** is a value that is created solely for the purpose of
identifying solely for the purpose of identifying a row of data in a database
table.

Perhaps the most common surrogate key in use today is an auto-incrementing
integer. This is a value that is added to each row in a table as it is created.
With each row, this value increases in order to remain unique in each row.

The **serial** type in PostgreSQL is actually a short-hand for a definition that
is much longer:
```sql
-- This statement:
CREATE TABLE colors(id serial, name text);

-- is actually interpreted as if it were this one:
CREATE SEQUENCE colors_id_seq;
CREATE TABLE colors (
    id integer NOT NULL DEFAULT nextval('colors_id_seq'),
    name text
);
```

A **sequence** is a special kind of relation that generates a series of numbers.
A sequence will remember the last number it generated, so it will generate
numbers in a predetermined sequence automatically.

The next value of a sequence is accessed using `nextval()`, and can be done in
any SQL statement.

Once a number is returned by `nextval` for a standard sequence, it will not be
returned again, regardless of whether the value was stored in a row or not.

### Enforcing Uniqueness ###

It is a requirement of a surrogate key, or any sort of key, that the value in
each row be unique. If there are duplicate values, then that column stops being
a unique identifier for each row.

## Primary Keys ##

Using the Primary Key constraint implicitly imposes the `UNIQUE` and `NOT NULL`
constraints. However, using `PRIMARY KEY` instead expresses the intent that we
wish the column to be not merely `UNIQUE` and `NOT NULL` but also the main
unique identifier for a given table. Part of this is that we can have only one
Primary Key per table. But it also acts as documentation and expression of
intent, for other developers and ourselves at a later date. Specifying a column
as Primary Key means that the guarantee that it can be used as unique identifier
for each row is baked into the database's schema.

Many ORMs (including ActiveRecord) make the assumption that the unique
identifier for each row will be a column with a Primary Key constraint. Admin
tools, codegen, and migration tools often make the same assumption.

Contemporary database development within the Ruby, JavaScript, and other
language communities has settled on the following conventions for working with
tables and primary keys:
1. All tables should have a primary key column called `id`.
2. The `id` column should automatically be set to a unique value as new rows are
inserted into the table.
3. The `id` column will often be an integer, but there are other data types
(such as UUIDs) that can provide specific benefits.

> What is a UUID?
> UUIDs (or *universally unique identifiers*) are vary large numbers that are
used to identify individual objects or, when working with a database, rows in a
database. There are a few formats and different ways to generate these numbers
(they don't increment by `1` as we've been doing). UUIDs are often represented
using hexadecimal strings with dashes. Although they are represented this way,
each UUID is simply a 128-bit number.

UUIDs are large enough that any randomly-generated UUID will be, in practice,
unique from all other UUIDs.

# 2:13 How PostgreSQL Executes Queries #

## A Declarative Language ##

SQL is a declarative language. A SQL statement describes *what* to do, but not
*how* to do it. It is up to the PostgreSQL server to take each query, determine
how best to execute it, and return the desired results.

The benefit of this approach is that it vastly simplifies database interactions
for the user. Databases can perform involved data manipulations with the use of
just a few SQL terms, freeing the user to think at a higher level about what
data they want returned and in what format.

The downside to this automated approach is that some of the time, the database
will choose to do something in an inefficient way. This happens because the only
way to know for sure how long a particular query plan will take to execute is to
execute it. The estimates that are generated as a part of the query plan are
generally pretty accurate, but when they are off, the result can make processing
a query take much more time and resources than it might otherwise.

* A **query plan** is sometimes called a **query execution plan**. It is a
sequence of steps used to access data in a SQL relational database management
system.

Fortunately, there are ways to give the database hints (or requirements) about
how it should execute a query.

## How PostgreSQL Executes a Query ##

While the exact way that a PostgreSQL database server will execute a query will
depend on many variables, there is a high-level process that each query goes
through.

The process described here relates to `SELECT` queries. Other types of SQL
statement use many of the same steps, but are almost always less complex than
`SELECT` queries.

1. Rows are collected into a **virtual derived table**

We can think of this step as the database creating a new temporary table using
the data from all the tables listed in the query's `FROM` clause, including
tables that are used in `JOIN` clauses.

NB: this virtual derived table is different from the 'transient tables' used as
a model in the SQL book.

2. Rows are filtered using `WHERE` conditions

All the conditions in the `WHERE` clause are evaluated for each row, ande those
that don't meet these requirements are removed.

3. Rows are divided into groups

If the query includes a `GROUP BY` clause, the remaining rows are divided into
the appropriate groups.

4. Groups are filtered using `HAVING` conditions

`HAVING` conditions are very similar to `WHERE` conditions, only they are
applied to the values that are used to create groups and not individual rows.
This means that a column that is mentioned in a `HAVING` clause should almost
always appear in a `GROUP BY` clause and/or an aggregate function in the same
query. Both `GROUP BY` and aggregate functions perform grouping, and the
`HAVING` clause is used to filter that aggregated/grouped data.

5. Compute values to return using select list

Each element in the select list is evaluated, including any functions, and the
resulting values are associated with the name of the column they are from or the
name of the last function evaulated, unless a different name is specified in the
query with `AS`.

6. Sort results

The result set is sorted as specified in the `ORDER BY` clause. Without this
clause, the results are returned in an order that is the result of how the
database executed the query and the rows' order in the original tables. It's
best to always specify an explicit order if your application relies on rows
being returned in a specific order.

7. Limit results

If `LIMIT` or `OFFSET` clauses are included in the query, these are used to
adjust which rows in the result set are returned.

# 2:14 Table and Column Aliases #
