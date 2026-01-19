# Introduction #

## The Importance of Data ##

Data as prosthetic memory, analysis and interpretation of which can help us
understand everything from historical development to patient health to
the human genome.

## Structured Data ##

Unstructured data is data that contains information without any structure,
such as the content of a plain-text email or an image.

Storing data in an unstructured way can only work if there is a small
amount of it. Once there is a large amount of unstructured data it
becomes unwieldly.

At this point, you need to organize, or structure, your data. For example,
by storing it in a spreadsheet. This allows us to sort it alphabetically,
or to total a set of values. Storing data in a structured way allows us to
find it easily, and to manage it better.

A common way of storing data in a structured manner is to use a relational
database. A basic definition of a database is simply a 'structured set of
data held in a computer'.

## Spreadsheet as Database ##

We can think of a spreadsheet as a simple form of database. The
spreadsheet has multiple worksheets. Each worksheet has columns that might
track, say, a username and an id for that user, along with another column
that differs on each worksheet.

We can think of the spreadsheet as a whole as a database, and the
worksheets within the spreadsheet as describing tables within a database.

A table contains rows and columns. Each row contains data for one
individual. Each column contains data of one specific kind for all of the
individuals.

Each row represents a single set of related data, while the columns represent
a standardized way to store data for that particular attribute.

Spreadsheet         --- Database
Worksheet           --- Table
Worksheet column    --- Table column
Worksheet row       --- Table record

## Relational Database Management System ##

As a spreadsheet increases in size and the number of people adding data to it,
a spreadsheet also becomes unwieldly. You will begin to encounter issues with
dupclicate data, typos, formatting and so on. Finding and collecting
information requires a lot of scrolling and searching. At this point it would
be better to move to a **relational database management system**.

A **relational database** is a database orgaized according to the *relational
model* of data. In simple terms, the relational model defines a set of
relations (which we can think of as analogous to tables) and describes the
relationships, or connections, between them in order to determine how the data
stored in them can interact. Using the relational model elevates our database
from data that is represented in just a flat, two-dimensional table, to one
where we can describe the data in a more complex and detailed way. Using a
relational database helps us to cut down on duplicated data and provides a much
more useful data structure for us to interact with.

* We can think of an individual **relation** as analogous to a flat,
two-dimensional table.
* A relational database is comprised not only of a set of such relations, but
also the description of their connections with each other.
* For instance, the `id` column of one table might be described as being the
same as the `user_id` column of another table.
* Using a relational database rather than a spreadsheet helps us to cut down on
duplicated data and provides a much more useful data structure to work with. We
can describe the data in a more complex and detailed way.

A **relational database management system**, or **RDBMS**, is essentially a
software application, or system, for managing relational databases. An RDBMS
allows a user, or another application, to interact with a database by issuing
commands using syntax that conforms to a certain set of conventions or
standards.

There are many relational database management systems, including:
* SQLite
* MS SQL
* PostgreSQL
* MySQL

All of them use SQL as a language to interact with a database.

It is worth noting that the relational model is not the only structured data
model used by database software. A program like MongoDB, for example, uses a
document-oriented data storage model. This, and other systems using
non-relational data storage and retrieval models, are often loosely grouped
under the term 'NoSQL'.

## SQL ##

SQL, which stands for Structured Query Language, is the programming language
used to interact with a relational database.

SQL uses simple English allowing you to **Select** (find), **Insert** (add),
**Update** (change), and **Delete** (remove) data.

SQL is a **declarative** language; when you write an SQL statement you describe
*what* needs to be done, but not exactly *how* to do it. The exact details of
how the query is executed are handled internally by the RDBMS you are using.

The SQL language dates back to the 1970s, when it was conceived of in
E. F. Codd's paper 'A relational model for large data banks'. The paper laid
the foundations for what would become relational databases. You may hear the
term 'Relational Algebra' sometimes used when working with databases.
Essentially, this is the theory on which relational databases were built.

Summary:

* Data underpins web applications and web development
* Databases are a useful way to *structure* data that you want to work with
* RDBMSs are software applications for managing relational databases
* SQL is the language used by all RDBMSs

# Preparations #

## Vocabulary ##

* Relational database --- A structured collection of data that follows the
relational model.
* RDBMS --- Relational Database Management System. A software application for
managing relational databases, such as PostgreSQL.
* Relation --- A set of individual but related data entries; analogous to a
database table.
* SQL --- Structured Query Language. The language used by RDBMSs.
* SQL Statement --- An SQL command used to access/use the database or the data
within that database via the SQL language.
* SQL query --- A subset of an "SQL Statement". A query is a way to search, or
lookup, data within a database, as opposed to updating, or changing, data.

# Interacting With a Database #

There are many interfaces, or clients, through which you can interact with an
RDBMS such as PostgreSQL. You may access the database through a programming
language, through a GUI application that allows access and administration, or
through the command-line interface.

All these interfaces share an underlying architecture they use to interact with
the database: they issue a request, or declaration, and receive a response in
return. This is generally referred to as a "client-server" architecture.

PostgreSQL is a "client-server" database, which is an architecture design used
by most relational databases.

## PostgreSQL Client Applications ##

PostgreSQL comes packaged with what are called 'client applications'. These
client applications are used to interact with with PostgreSQL in various ways
by issuing a command via the command line. Some commonly used client
applications are:
* `createdb`
* `dropdb`
* `pg_dump`
* `pg_restore`
* `pg_bench`

Some of these are essentially wrappers around an SQL command. E.g., the command
`createdb`, which can be used to create a new PostgreSQL database, is a wrapper
around the SQL command `CREATE DATABASE`.

An important client application is `psql`. `psql` is an interactive console, a
terminal-based front-end to PostgreSQL.

There are two types of commands you can issue from the `psql` prompt:
* `psql` meta-commands
* SQL statements using standard SQL syntax

### Meta-commands ###

The syntax for a `psql` meta-command is a backslash followed by the command and
any optional arguments.
* `\conninfo` --- returns information about your current connection to the
database.
* `\q` --- quits the `psql` console and returns to the normal command line.

### SQL Statements ###

SQL statements are commands issued to the database using SQL syntax.

SQL statements always terminate in a semi-colon. This means that you can
actually write statments over multiple lines; PostgreSQL will not execute the
statement until it reaches the semi-colon.

## SQL Sub-languages ##

SQL can be thought of as comprising three separate sub-languages, each
concerned with a specific aspect of manipulating or interacting with a
database. The three sub-languages are:

* Data Definition Language (DDL) --- used to define the structure of a database
and the tables and columns within it.
* Data Manipulation Language (DML) --- used to retrieve or modify data stored
in a database. E.g., `SELECT` queries are part of the DML.
* Data Control Language (DCL) --- used to determine what various users are
allowed to do when interacting with a database.

# SQL Basics Tutorial #

The `-d` flag to `psql` is followed by the name of the db we wish to interact
with. I think it may only really be needed if the name of the db is not the
first argument.

We created a db with `createdb` followed by the name of the new database. We
then redirected the contents of an SQL file into `psql` to define a table and
its columns and insert some rows of actual data.

* `SELECT` --- an SQL keyword that identifies the type of statment being
issued. Since the statement starts with `SELECT`, we know it is a select
statement, and its purpose is to retrieve data.

* `*` --- this is a wild card character that acts as an identifier for *all* of
the columns in a given table.

* `FROM` --- another keyword. Used as a clause within a `SELECT` statement to
identify the table from which to retrieve the data.

Most of the time when interrogating a database, retrieving all of the data in
all of the columns is unlikely to be what you want to do. Generally, you will
want to retireve a *subset* of that data. You can achieve this by selecting
specific columns, or by using criteria to select specific rows.

* `WHERE` --- another keyword used as a clause to specify a constraint on the
rows being retrieved.

# SQL Basics Tutorial

## Data vs Schema ##

Schema is concerned with the *structure* of a database. This structure is
defined by things such as the names of tables and table columns, the data types
of those columns and any constraints that they may have.

Data is concerned with the *contents* of a database. These are the actual
values associated with specific rows and columns in a database table.

Schema and data work together in order to let us interact with a database in
useful ways. Schema without data would just be a bunch of empty tables. If we
had data without schema, we would be back in the realm of unstructured data.
Combining schema and data provides us with structured data that we can then
interact with in various ways.

## Summary ##

When we working with a database we can create, read, update, and delete schema
just as we can create, read, update, and delete data.


# Create and View Databases #

Data Definition Language (DDL) is focused on defining the characteristics of
the database and its tables and columns. This includes creating databases and
tables, or altering and changing finer details about your database, such as
table names and column data types. But it does not deal with the *data* within
a database.

## Using a SQL Command ##

`createdb [name]` is a wrapper around the SQL statement
    `CREATE DATABASE [name];`.

The `[name]` parameter is mandatory, but there are other, optional parameters
we can add to set things such as the database's encoding, collation, connection
limit, and so on. When omitted, PostgreSQL simply uses the default settings for
these parameters.

### Database Naming ###

Database names should be self-descriptive and should be in lower snake case.

The problem with attempting to use spaces rather than underscores in naming
databases, tables and columns is that SQL treats whitespace as a separator
between terms in a command. If we wished to name a column `customer name`, then
we need to quote it every time we use it: `"customer name"`. This is more
verbose and error-prone than using snake case: `customer_name`. If we did not
use quotes at all `customer name` would be interpreted as the separate
identifiers `customer` and `name`. Additionally, many tools, ORMs, and code
generators assume simple, unquoted, snake_case names.

## Connecting to a Database ##

We can connect to a database from the command line using `psql -d [name]`.
Within the `psql` console, we can connect to a different database with the
meta-command `\connect [name]`, or its abbreviated form, `\c [name]`.

When we connect to a database within the `psql` console like this, the previous
connection is closed.

Notice that meta-commands, unlike SQL statements, do not need to be closed with
a semi-colon.

`\c` and `\connect` can take arguments for options like username, port, host,
and so on. If they are not provided, the same values used for the previous
connection are re-used for the new one. If connecting to a local database, you
can usually omit these additional arguments.

## Delete the Database ##

* `DROP DATABASE` --- SQL command that deletes a database. The syntax is mostly
the same as for `CREATE DATABASE`.

We can also use `dropdb` as a PostgreSQL client application that acts as a
wrapper around the SQL command.

Warning: the `DROP` commands permanantly delete the schema and data to which
they apply. Be careful you really want to delete these forever.

## Summary ##

Some meta-commands:
* `\l` or `\list` --- displays all databases
* `\c` or `\connect` --- connect to the named database
* `\q` --- exits the PostgreSQL session and returns to the command line
* `\e` --- calls up a text editor and lets you edit and re-run the previous
command. By default, PostgreSQL uses Vim. This can be changed with by adding
the following lines to `.bashrc` (or `.zshrc`):

```
export EDITOR="[cli_editor_command] -w"
export VISUAL="[cli_editor_command] -w"
```

We also have some commands that are programs installed by PostgreSQL on our
system:
* `psql -d [name]` --- open the `psql` console and connect to the named db.
* `createdb [name]` --- create the named database.
* `dropdb [name]` --- permanently delete the named db.

The last two are wrappers around SQL commands:
* `CREATE DATABASE [name]` --- create the named database.
* `DROP DATABASE [name]` --- permanently delete the named database.

# Create and View Tables #

Database tables, sometimes referred to as relations, and the relationships
between those tables are what provide the structure we need to house our data.
Tables can represent real-world entities involved in the business logic of an
application, like a customer or an order. The tables and the relationships
between them are used to store data to reflect our business logic. For example,
consider representing a customer who has orders associated with them.

## Table Creation Syntax ##

* `CREATE TABLE [name]([list_of_columns])` --- create the named table in the
connected db.

Unlike `CREATE TABLE`, we must place parentheses after the name. This will
contain a list of columns within the new table; without columns, we could not
insert any data. Columns are what we use to give tables their structure. (Even
if we wished to create a table and then insert columns later, we still need to
provide empty parentheses for it to be a syntactically valid statement).

The syntax for adding the columns is like so:
```sql
CREATE TABLE [table_name] (
    [column_1_name] [column_1_data_type] [constraints, ...],
    [column_2_name] [column_2_data_type] [constraints, ...],
    ...
    [table_level_constraints, ...]
);
```

Column names and data types are a required part of each column definition;
constraints are optional. Constraints can be defined either at the column level
or at the table level.

## Data Types ##

A data type classifies particular values that are allowed for that column. This
can help protect our database from data of an invalid type being entered.

Common data types include:
* `serial` --- used to create identifier columns for a PostgreSQL database.
These identifiers arre integers, auto-incrementing, and cannot contain a null
value.
* `char(N)` --- specifies that information stored in a column can contain
strings of up to N characters in length. If a string less than length N is
stored, then the remaining string length is filled up with space characters.
* `varchar(N)` --- similar to `char(N)` except that, in the case of less than N
characters being provided, the rest of the string is not used.
* `boolean` --- can only contain two values, `"true"` and `"false"`. In
PostgreSQL, boolean values are often displayed in a shorthand format, `t` or
`f`.
* `integer` or `INT` --- a whole number.
* `decimal([precision], [scale])` --- takes two arguments. The precision is the
number of digits on both sides of the decimal point. The scale is the number of
digits in the fractional part of the number to the right of the decimal point.
* `timestamp` --- contains both a simple data and time in YYYY-MM-DD HH:MM:SS
format.
* `date` --- the date type contains a date but no time.
* `IDENTITY` --- standard ANSI/ISO SQL:2003 syntax for auto-incrementing
values. Effectively replaces `serial`, which is now deprecated for new,
production applications.

## Keys and Constraints ##

One of the key functions of a database is to maintain the integrity and quality
of the data that it is storing. Keys and Constraints are rules that define what
data values are allowed in certain columns.

Defining keys and constraints is part of the database design process and
ensures that the data within a database is reliable and maintains its
integrity.

Constraints can apply to a specific column, an entire table, more than one
table, or an entire schema.

Some constraints for columns:
* `UNIQUE` --- prevents any duplicate values from being entered into that
column.
* `NOT NULL` --- when adding data to the table a value MUST be entered for that
column; it cannot be left empty.
* `DEFAULT [value]` --- if no value is set in this field when a record is created then
the value given here will be set for it.

Keys come into play once we have to set up relationships between different
tables. They're also useful for keeping track of unique rows within a table.

## View the Table ##

* `\dt` --- show a list of all the tables, or relations, in the database.
* `\d [table_name]`  --- show detailed information about the named table.

## Schema and DCL ##

Although we have used only one of SQL's sub-languages, DDL, to describe the
schema thus far, parts of the schema are also controlled by the DCL (Data
Control Language).

DCL is concerned with controlling who is allowed to perform certain actions
within a database, or in other words, with the security of a database. The
security settings determined by DCL are also part of the database's schema.

## Summary ##

* Tables are created using the `CREATE TABLE` SQL command.
* Table column definitions go between the parentheses of the table creation
statement.
* Table column definitions consist of a column name, data type, and optional
constraints.
* There are many different data types, and these can be used to restrict the
data that can be input to a column.
* Constraints can also be used on the data that is input to a particular
column.
* We can view a list of tables or the structures of a particular table in the
`psql` console using meta-commands.
* Although database schema is largely a DDL (Data Definition Language) concern,
parts of it, such as access and permissions, are determined by DCL (Data
Control Language).

* `CREATE TABLE [name]()`
* `\dt` --- shows the tables in the current database.
* `\d [name]` --- shows the schema of the named table.

It is common to use `char` instead of `varchar` when a text field is known to
always have the same number of characters. In some RDBMSs, this confers
performance advantages, but this is not the case in PostgreSQL.

# Alter a Table #

## Alter Table Syntax ##

Existing tables can be altered with an `ALTER TABLE` statement. An
`ALTER TABLE` statement is part of DDL, and is for altering a table **schema**
only.

The basic syntax is:
```sql
ALTER TABLE [name]
    [stuff_to_change_goes_here]
    [additional_arguments]
```

## Renaming a Table ##

A table can be renamed using the `RENAME` clause and the `TO` clause:
```sql
ALTER TABLE [old_name]
    RENAME TO [new_name]
```

## Renaming a Column ##

```sql
ALTER TABLE [table_name]
    RENAME COLUMN [old_column_name] TO [new_column_name];
```

## Changing a Column's Datatype ##

```sql
ALTER TABLE [table_name]
    ALTER COLUMN [column_name] TYPE [new_type];
```

## Adding a Constraint ##

Constraints are different from the name and data type of a column in that
constraints are optional and we can have none or many of them. Therefore, if we
want to change the constraints on a column, it is not a matter of replacing but
of adding or removing constraints.

(Note: there is actually an `ALTER CONSTRAINT` clause that can be used to alter
certain aspects of Foreign Key constraints, but most of the time we will want
to add or remove constraints.)

The syntax for adding a constraint can vary depending on the type of constraint
we wish to add. Some types of constraint are considered 'table constraints'
even when they are applied to a column rather than a table. Other types of
constraint are considered 'column constraints'.

The differences between table and column constraints are mainly syntactic. Some
forms of the various commands let you specify table constraints while others
require column constraints. While this can be important when writing a command,
the two types of constraints have no appreciable differences.

In general, `NOT NULL` is always a column constraint. The remaining
constraints (`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, and `CHECK`) can be either
table or column constraints.

Since `NOT NULL` is always a column constraint, there is a special syntax for
adding the constraint to an existing table:
```sql
ALTER TABLE [table_name]
    ALTER COLUMN [column_name]
    SET NOT NULL;
```

To add any other constraint to an existing table, you must use this syntax to
add a table constraint:
```sql
ALTER TABLE [table_name]
    ADD [[CONSTRAINT [constraint_name]]]
    [constraint_clause];
```
The double brackets indicate that naming the constraint is optional.

This second constraint syntax can apply to a single column, or to relationships
between columns, depending on the constraint clause. It is complex and
flexible. The first syntax is specific to setting `NOT NULL` on a single
column.

## Removing a Constraint ##

For most types of constraint, the same syntax can be used to remove both column
and table constraints:
```sql
ALTER TABLE [table_name]
    DROP CONSTRAINT [constraint_name];
```

If we wish to remove a `DEFAULT` clause, which is technically not a constraint,
the syntax is different:
```sql
ALTER TABLE [table_name]
    ALTER COLUMN [column_name]
    DROP DEFAULT;
```

## Adding a Column ##

The syntax to add a new column to a table is:
```sql
ALTER TABLE [table_name]
    ADD COLUMN [new_column_name] [data_type] [constraints, ...];
```

* `NOW()` is an SQL function. It provides the current data and time when it is
called.

There can be problems adding new columns with constraints. For instance, if we
add a column to a table that contains existing rows of data with the constraint
`NOT NULL`, we must provide a `DEFAULT` clause so that PostgreSQL is able to
fill in the existing rows of the new column with a default value. Otherwise,
the RDBMS would be unable to leave them blank (`NULL`) but would have no value
to put there, and so the command would fail.

## Removing a Column ##

The syntax for removing a column is:
```sql
ALTER TABLE [table_name]
    DROP COLUMN [column_name];
```

## Dropping Tables ##

The syntax to delete a table is:
```sql
DROP TABLE [table_name];
```

Actions such as `DROP COLUMN` and `DROP TABLE` are not reversible. All data is
permanently lost.

## Summary ##

This chapter covered:
* Renaming a table
* Renaming a column
* Changing a column's data type
* Adding a constraint
* Removing a constraint
* Adding a column
* Removing a column
* Dropping a table

The book here gives a helpful table of actions and syntax. All except `DROP
TABLE` use the starting clause `ALTER TABLE [table_name]`.

## Exercises discursive material ##

Most actions to alter a table can be combined into a single statement, but this
is not possible with certain actions, including `RENAME`.

* When converting data types, if there is no implicit conversion from the old
type to the new type you need to add a `USING` clause to the statement, with an
expression that specifies how to compute the new column value from the old.

Some such expressions can be quite complex, but a simple form would be
something like:
```sql
ALTER TABLE table_name
    ALTER COLUMN column_name
    TYPE new_data_type
    USING column_name::new_data_type
```

* We can combine multiple actions into a single statement in various ways. One
such is when we wish to perform more than one action involving `ALTER COLUMN`,
e.g:
```sql
ALTER TABLE celebrities
    ALTER COLUMN date_of_birth TYPE date
        USING date_of_birth::date,
    ALTER COLUMN date_of_birth SET NOT NULL;
```
Here we piggy-back off the same `ALTER TABLE` starting clause and separate our
`ALTER COLUMN` clauses using a comma. Thus we can combine multiple,
comma-separated `ALTER COLUMN` actions into one overall `ALTER TABLE`
statement.

# Inserting Data into a Table #

## Data and DML ##

DML (Data Manipulation Language) is a sub-language of SQL which incorporates
the various keywords, clauses and syntax used to write Data Manipulation
Statements.

Data Manipulation Statements are used for accessing and manipulating data in
the database. Data Manipulation Statements can be categorized into four
different types:

* `INSERT` statements --- these add new data into the database.
* `SELECT` statements --- also referred to as queries, these retrieve existing
data from database tables
* `UPDATE` statements --- these update existing data in a database table.
* `DELETE` statements --- these delete existing data from a database table.

The actions performed by thesew four types of statement are sometimes also
referrred to as CRUD operations.

## A Bit About CRUD ##

The four words for which the acronym CRUD stands are Create, Read, Update, and
Delete. These four words are analogous to `INSERT`, `SELECT`, `UPDATE`, and
`DELETE` statements, and we can think of these statements as performing their
equivalent CRUD operations.

Web applications whose main purpose is to provide an interface to perform these
operations are often referred to as 'CRUD apps'.

## Insertion Statement Syntax ##

The general form of an `INSERT` statement is:
```sql
INSERT INTO table_name
        (column1_name, column2_name, ...)
    VALUES (data_for_column1, data_for_column2, ...);
```

When inserting data into a table, you may specify all the columns from the
table, some of them, or none. Not specifying columns can sometimes lead to
unexpected results, so it is generally better to specify which columns you want
to insert data into.

When specifying columns, for each column specified you must supply a value for
it in the `VALUES` clause, or the command will fail with an error.

If you don't specify a column for data insertion, then `NULL` or a default
value will be added to the record you wish to store instead.

## Adding Rows of Data ##

### Rows ###

If we think of columns as giving structure to our table, then we can think of
rows (sometimes referred to as 'tuples') as actually containing the data. Each
row in a table is an individual entity, which can perhaps be seen as the
logical equivalent of a record, and has a corresponding value for each column
in the table. The rows and columns work together. It is the intersection of the
structure provided by our columns and the data in our rows that create the
structured data that we need.

### Adding a Single Row ###

When inserting a row without specifying columns, we must match each value in
the `VALUES` clause list to the corresponding column and its data type. If we
wish to use default values, we must use the keyword `DEFAULT` **if** there are
actual values in the list following. If we end the list prematurely, then all
trailing columns in the row will be set to their default value, or `NULL` if
there is no default.

If we specify values, we need only provide the values for the specified columns
and any others will be assigned to the default, or `NULL`.

* **Command Tag** --- the keyword returned by PostgreSQL after successfully
executing an SQL command other than `SELECT`. (`SELECT` returns the
selected data.)

* Object Identifiers (oid) --- used internally by PostgreSQL aas primary keys
for various system tables.

When we make an insertion into a table, the first number after the command tag
is the `oid`. The second is the number of rows that have been inserted.

### Adding Multiple Rows ###

The syntax for inserting multiple rows is something like:
```sql
INSERT INTO table_name (column1, column2, ...)
    VALUES (row1_value1, row1_value2, ...),
           (row2_value1, row2_value2, ...),
           ...
           ... ;
```

When we add multiple rows, PostgreSQL inserts them in the order given.

If we insert multiple rows in a single `INSERT` statement and any of those rows
violate a constraint or data type, then as we might expect the entire statement
fails with an error and no data rows are inserted. In this sense, inserting
multiple rows in one statement is different to inserting one row per statement,
since with separate statements, the well-formed statements will succeed and the
invalid ones will not.

## Constraints and Adding Data ##

Although setting constraints is part of DDL, constraints are primarily concerned
with controlling what data can be inserted into a table.

### Default Values ###

Setting a `DEFAULT` value for a column ensures that if a value is not specified
for that column in an `INSERT` statement, then the default value will be used
instead.

### `NOT NULL` Constraints ###

It doesn't always make sense for a column to have a default value. For example,
when a column should always contain a name specific to a user; here, there is
no such thing as a 'generic user name' that can be applied to multiple users.

`NOT NULL` constraints can be used to ensure that when a new row is added, a
value must be provided for that column.

If our `INSERT` statement specifies both columns and values but we don't
specify a particular column, SQL will try to insert `null` into that column by
default. If we have a `NOT NULL` constraint on that column, then the command
fails with an error.

### Unique Constraints ###

Sometimes, rather than simply ensuring that a column has a value in it, we want
to ensure that the value added for that column is unique; to do this we can use
a `UNIQUE` constraint.

### `CHECK` Constraints ###

Check constraints limit the type of data that can be included in a column based
on some condition we set in the constraint. Each time a new record is in the
process of being added to a table, that constraint is first *checked* to ensure
that data being added conforms to it.

* In SQL, `<>` is the 'not equal to' operator. In PostgreSQL specifically, `!=`
is a valid alias for `<>`, but `<>` is the standard, portable SQL inequality
operator. It is better to stick with `<>` for consistency across RDBMSs.

* If we don't need a specific name for our check constraint, it is fine to
leave the naming up to PostgreSQL.

* In PostgreSQL, a string is denoted using single-quotes. If a string needs to
actually contain single-quote characters, we escape them using a second
single-quote, like `'Brian O''Leary'`.

## Summary ##

Important themes from this chapter:
* `INSERT` statement syntax
* Table rows
* Adding a single row of data
* Adding multiple rows of data
* Various types of constraint we can use to control what data is needed
    * `DEFAULT` values
    * `NOT NULL` constraints
    * `UNIQUE` constraints
    * `CHECK` constraints

* Generally, you want to avoid boolean columns being able to hold `NULL`
values, since booleans, by their nature, should only have two states, `true`
and `false`. Throwing `NULL` into the mix creates three possible states. This
is sometimes called the Three State Boolean problem, or the Three Valued-logic
problem.

# Select Queries #

Querying data forms the **Read** part of CRUD operations, and is arguably the
most common operation in database-backed applications.

## Select Query Syntax ##

```sql
SELECT column_name, ...
    FROM table_name
    WHERE condition;
```

We can list a number of column names separated by commas; we can also use a `*`
widlcard. The table_name can be a real table, or a 'virtual' table generated in
some way. The `WHERE` clause allows us to filter our data based on a condition.
The condition will typically include one of the columns in the table you are
querying.

* The order of the columns int the response is the order that the column names
are specified in our query, rather than the 'natural' order of the table
columns.

* SQL is not a case-sensitive language. Keywords are conventionally written in
uppercase while identifiers are written in lowercase. It is generally a good
idea to avoid naming an identifier something that is a reserved word in
PostgreSQL. For instance, the word 'year' is actually a reserved word, and if
we name a column `year`, this could cause problems in certain contexts. What
you can do is to use double-quotes for the column `"year"`. PostgreSQL then
knows to treat it as an identifier. But it is perhaps best to avoid naming
clashes altogether.

## Order By ##

Another clause that we might use in a `SELECT` query is the `ORDER BY` clause.
Rather than returning only certain rows, as `WHERE` does, `ORDER BY` displays
the results of a query in a particular sort order.

SQL allows returning sorted data by adding the `ORDER BY [column_name]` clause
to a query. Adding this to our general syntax, we get:
```sql
SELECT column_name, ...
    FROM table_name
    WHERE condition
    ORDER BY column_name, ...;
```
The `ORDER BY` clause comes after we have specified the table name. If our
statement includes a `WHERE` clause, the `ORDER BY` clause comes after this
also.

* When ordering by boolean values, `false` comes before `true` in ascending
order.
* The sort of rows with an identical value is arbitrary.
* We can specify ascending or descending order via the keywords `ASC` or `DESC`
respectively. These keywords come after `ORDER BY [column_name]`. If omitted,
the default is `ASC`.
* As with a `WHERE` clause, we can `ORDER BY` a column even if we do not
include it in our column list
* We can set a sort direction for each column we are using to order our
results.

## Operators ##

Operators are generally used as part of an expression in a `WHERE` clause (or a
`CHECK` constraint).

We can group operators into three different types:
1. Comparison
2. Logical
3. String Matching

We will only cover the most commonly used operators, since there are very many.

### Comparison Operators ###

These operators are used to compare one value to another. Often these values
are numerical, but other data types can also be compared.

Within the expression of a `WHERE` clause, the comparison operator is place in
between the two things being compared; i.e. the column name and the specific
value to be compared against the values in that column.

The comparison operators are for the most part the same as for most programming
languages except:
* The equality operator is `=`, instead of `==` or `===`.
* The inequality operator is `<>` instead of `!=` (though PostgreSQL allows
`!=` as an alias particular to this specific RDBMS rather than SQL generally).

There are also what are termed *comparison predicates*, which behave much like
operators but have special syntax. Examples of comparison predicates include:
* `BETWEEN`
* `NOT BETWEEN`
* `IS DISTINCT FROM`
* `IS NOT DISTINCT FROM`
* `IS NULL`
* `IS NOT NULL`

`NULL` is a special value in SQL which represents the absence of a value or an
unknown value. On a practical level, this means that we cannot treat `NULL` as
we would any other value.

We cannot, for instance, have a `WHERE` clause in the form
`WHERE some_column = NULL`. Instead we would use `IS NULL`, e.g.
```sql
SELECT * FROM my_table
    WHERE my_column IS NULL;
```

### Logical Operators ###

There are three logical operators:
* `AND`
* `OR`
* `NOT`

You can use parentheses to group sub-clauses together.

### String Matching Operators ###

String, or pattern, matching allows you to add flexibility by searching for a
sub-set of the data within a column. As the name suggests, string matching only
works with string data types.

The most common string matching operators are:
* `LIKE` --- works in combination with `%` and `_` characters to pattern match.
* `ILIKE` --- case-insensitive `LIKE`.
* `SIMILAR TO` --- compares string column to Regex pattern.

The `%` character combined with `LIKE`/`ILIKE` serves as a wildcard. It means
'zero or more occurences of any characters'.

The `_` character combined with `LIKE`/`ILIKE` matches any single character.

## Summary ##

The `SELECT` statement is probably the most commonly used statement in SQL.

* `ORDER BY column_name [ASC, DESC]`
* `WHERE column_name [>,<,>=,<=,=,<>] value`
* `WHERE expression1 [AND,OR] expresson2`
* `WHERE string_column LIKE '%substring'`

The expression in a `CHECK` constraint evaluates to `true` or `false` for each
row, just like a `WHERE` condition does, so any operator that can be used in a
`WHERE` clause can be also be used in a `CHECK` constraint, even operators like
`LIKE`, `ILIKE`, and `SIMILAR TO`.

* You should essentially always add the `NOT NULL` constraint to boolean
columns.

# More on Select #

## `LIMIT` and `OFFSET` ##

When working with large datasets, it is common to only want to display one
portion of the result data at a time. Displaying portions of data as separate
'pages' is a user interface pattern used in many web applications, generally
referred to as 'pagination'.

The `LIMIT` and `OFFSET` clauses of `SELECT` are the base on which pagination
is built.

```sql
SELECT [column_list]
    FROM [table_name]
    LIMIT [N1]
    OFFSET [N2]
```

N1 represents the number of rows to return. N2 represents how many rows to skip
before returning N1 rows.

As well as pagination, `LIMIT` is useful during development when we wish to get
a sense of the data in the table without returning the entire, potentially very
big, dataset.

When doing pagination, it is important to use `ORDER BY` so that rows are
returned in some kind of deterministic order. The 'natural' order of table rows
is **not guaranteed**, and is an implementation detail. The 'natural' order may
change between queries for a multitude of reasons, and so when we are
paginating, we want to return page 1, 2, etc, of a stable, ordered collection.

* If you are using `LIMIT` and `OFFSET`, your query should include `ORDER BY`.
With respect to pagination, a stable and deterministic order of rows is what
makes the concept of 'pages' meaningful in that it makes pages actually
sequential.

## `DISTINCT` ##

Sometimes duplicate data is unavoidable. For example, we might get duplication
when joining more than one table together. One way to formulate queries to deal
with duplication is to use the `DISTINCT` clause.

```sql
SELECT DISTINCT column_name FROM table_name;
```
but also with functions, like:
```sql
SELECT count(DISTINCT column_name) FROM table_name;
```

## Functions ##

Functions are a way of working with data in SQL. The set of available functions
are provided by the RDBMS, and perform operations on fields or data. Some
functions provide data transformations that can be applied before returning
results. Others simply return information on the operations carried out.

These functions can generally be grouped into different types. Some of the most
commonly used types of functions are:
1. String
2. Date/Time
3. Aggregate

### String Functions ###

String Functions perform some sort of operation on values whose data type is
String. Some examples:
* `length()` --- returns the length of the string
* `trim()` --- trims strings in a user-specified way

### Date/Time Functions ###

Date/time functions, for the most part, perform operations on date and time
data. Many of the date/time functions take time or timestamp inputs:
* `date_part()` --- extracts only the part of a given timestamp that we want,
such as `'year'`
* `age()` --- when passed a single `timestamp` as an argument, calculates the
time elapsed between that timestamp and the current time.

### Aggregate Functions ###

Aggregate functions perform aggregation; they compute a single ressult from a
set of input values. For instance:
* `count()` --- returns the number of values in the column passed as argument
* `sum()` --- sums numeric type values for all of the selected rows and returns
the total.
* `min()` --- returns the lowest value in a column for all of the selected
rows. Can be used with various data types such as numeric, date/time, and
string.
* `max()` --- the opposite of `min()`.
* `avg()` --- returns the average (arithmetic mean) of numeric type values for
all of the selected rows.

Aggregate functions really start to be useful when grouping table rows
together. The way we do that is by using the `GROUP BY` clause.

## `GROUP BY` ##

`GROUP BY` can partition rows based on a column.

One thing to be aware of when using aggregate functions and `GROUP BY`, is that
if you include columns in the column list alongside the function, then those
columns **must** also be included in a `GROUP BY` clause.

The PostgreSQL docs say:
> When `GROUP BY` is present, or any aggregate functions are present, it is not
valid for the `SELECT` list expressions to refer to ungrouped columns except
within aggregate functions or when the ungrouped column is functionally
dependent on the grouped columns, since there would otherwise be more than one
possible value to return for an ungrouped column. A functional dependency
exists if the grouped columns (or a subset thereof) are the primary key of the
table containing the ungrouped columns.

All of the columns in the select list must either be included in the `GROUP BY`
clause, be the result of an aggregate function, or the `GROUP BY` clause must
be based on the primary key. This requirement ensures that there is a single
value for every column in the result set.

Essentially, `GROUP BY` is needed to give a meaningful grouping key, and only
such keys can be present alongside aggregate functions in a select list.

## Medium article on `GROUP BY` ##

### What does `GROUP BY` do? ###

The `GROUP BY` clause makes groups of rows where values in the specified
columns are the same. Those groups are then used in the final output of the
query.

In the results, a row can contain values from grouped columns and ungrouped
columns which belong to the same group. It is important to note that the output
can only contain one value for each column in the group. The value for a
grouped column will be the shared value of each row in the group. The value for
an ungrouped column will be the single value that is the result of
*aggregating* all of the values in the column within the group.

An aggregate function is simply a function which takes multiple values,
performs some operation on them, and then produces a single value as a
result. This is exactly what is needed if we want to include some information
from an ungrouped column in the output of a data set that has been grouped with
`GROUP BY`. That way, wherever there is a group of rows, and some rows have
multiple different values in a column, those different values can be combined
in some way to form a single value for that group.

* `string_agg(column_name, delimiter)` --- concatenates all of the string
values separated by the delimiter of all of the rows in the specified column in
the group.

In a sense, the grouped column has its values aggregated to a single
representative value (representative because equal under the standard rules for
equality for that data type).

### The `HAVING` Clause ###

Aggregate functions are not valid in `WHERE` clauses. The `HAVING` clause
filters groups by comparing them to a conditional statement. If the comparison
returns `true`, the group is included in the results, otherwise the group is
not included.

### Functional Dependency ###

If we `GROUP BY` the Primary Key of the table, we can include any column in the
select list, since by definition, each value of the Primary Key column is
unique and not null, and so the groups formed by this will have one row only.

This doesn't work for a column whose row values merely *happen to be* unique.
There is no *functional dependency*, and so we do not have a general rule to
guarantee that for each result row, there will be a unique value that can be
found for each column. In fact, even if there is a unique constraint on the
column, this is not enough to satify the concept of functional dependency: the
grouped column must be the Primary Key.

## Summary ##

* Returning portions of a dataset using `LIMIT` and `OFFSET`
* Returning unique values using `DISTINCT`
* Using SQL functions to work with data in various ways
* Aggregating data using `GROUP BY`

# Update Data in a Table #

## Updating Data ##

An `UPDATE` statement can be written with the following syntax:
```sql
UPDATE table_name
    SET column_name = value, ...
    WHERE expression;
```
The ellipsis indicates that you can specify multiple `column_name = value`
entries.

If we omit the `WHERE` clause, PostgreSQL will update that column to that value
for *every* row in the table, which is rarely what we want. Even if we have a
`WHERE` clause, we must be certain that it is specific enough to target only
those rows we wish to update. Therefore, it is a good idea to first test the
condition in a `SELECT` statement for a read-only trial run.

## Deleting Data ##

The `DELETE` statement is used to remove entire rows from a database table.

The syntax of a `DELETE` statement is somewhat similar to `UPDATE`:
```sql
DELETE FROM table_name
    WHERE expression;
```

As with `UPDATE`, the `WHERE` clause in a `DELETE` statement is used to target
specific rows.

In the rare circumstance that we want to delete all data rows from a table, we
would simply leave out the `WHERE` clause:
```sql
DELETE FROM table_name;
```

## Update vs Delete ##

One key difference to keep in mind between how `UPDATE` works and how `DELETE`
works is that `UPDATE` can target one or more columns in one or more rows by
using the `SET` clause, whereas `DELETE` targets one or more *entire* rows. 

If we wish to 'delete' specific values from within a row, we would approximate
this by updating values to `NULL`:

```sql
UPDATE table_name
    SET column_name = NULL
    WHERE expression;
```
* Unlike with a `WHERE` clause, with a `SET` clause we can use `=` with `NULL`
since it is not being used as a comparison operator in this situation.
* If a column has a `NOT NULL` constraint, then it's not possible to set its
value to `NULL`. An error will be thrown.

## Use Caution ##

Remember that most of the time you do not want to delete or update *all* the
rows in a table. So you should always be alert to the necessity of a `WHERE`
clause for the vast majority of `UPDATE` or `DELETE` statements.

Even if you are using a `WHERE` clause, be sure to test the clause first with a
query.



