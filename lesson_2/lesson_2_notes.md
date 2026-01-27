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

