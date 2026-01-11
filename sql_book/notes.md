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
