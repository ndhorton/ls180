# Name and define the three sublanguages of SQL and be able to classify different statements by sublanguage. #


## SQL Book: Interacting With PostgreSQL ##

SQL can be thought of as comprising of three separate sub-languages, each
concerned with a specific aspect of manipulating or interacting with a database.

The three sublanguages are:
* DDL: Data Definition Language. Used to define the structure of a database and
the tables and columns within it.
* DML: Data Manipulation Language. Used to retrieve or modify data stored in a
database. `SELECT` queries are part of DML.
* DCL: Data Control Language. Used to determine what various users are allowed
to do when interacting with a database.

## SQL Book: Create and View Tables ##

We use one of the SQL sub-languages, DDL, to create the schema for a database.
However, there are actually parts of a database's schema that are controlled and
managed by the DCL.

DCL is concerned with controlling who is allowed to perform certain actions
within a database, or in other words, with the 'security' of a database. The
'security settings' determined by the DCL are also part of the database's
schema. We can see a clue to this if we look at the information returned by the
`psql` meta command `\dt`. When we use `\dt`, we see a table of information that
includes `Schema`, `Name`, `Type`, and `Owner`.

All of these aspects of the database's schema could be used by DCL to allow or
restrict access to certain parts of the database or specific tables. The value
in the `Owner` column in particular is very much a DCL concern; for example you
could add a restriction to a table so that other users can add, read, update and
delete data from the table but only the owner can alter the structure of the
table or delete the table entirely.

## SQL Book: Interacting With a Database ##

SQL can be thought of as comprising three separate sub-languages, each concerned
with a specific aspect of manipulating or interacting with a database.

The three sublanguages of SQL are the Data Definition Language (DDL), the Data
Manipulation Language (DML), and the Data Control Language (DCL).

* DDL --- used to define the structure of a database and the tables and columns
within it.
* DML --- used to retrieve or modify data stored in a database.
* DCL --- used to determine what various users are allowed to do when
interacting with a database.

## 2:2 The SQL Language ##

SQL is a language used to manipulate the structure and values of datasets stored
in a relational database. It is described as a **special purpose language**
because it is typically used only for a very specific purpose: interacting with
relational databases. This can be contrasted with general purpose languages,
such as Ruby, Python, JavaScript, C etc, which can be used for a variety of uses
from application creation to scripting and embedding within other languages and
runtimes.

SQL is primarily a **declarative language**. This means that it describes *what*
needs to be done, but does not detail *how* to do it. In practice, this means
that the same query might be executed differently on an identical dataset based
on a variety of conditions. The SQL server for the most part abstracts these
details away from the user, although there are ways to see how a specific query
will be executed by the system. This is most commonly utilized when the
performance of a query does not meet an application's requirements. For the most
part, the SQL database engine selects the most efficient way to execute a query,
but in some circumstances a few hints from a human user can improve performance
dramatically.

* DDL controls relation structure and rules. Commands include `CREATE`, `DROP`,
`ALTER`.
* DML controls values stored within relations. Commands include `SELECT`,
`INSERT`, `UPDATE`, and `DELETE`.
* DCL controls who can do what. Commands include `GRANT` and `REVOKE`.

### Data Definition Language (DDL) ###

The **data definition** parts of SQL are what allow a user to create and modify
the schema stored within a database. It includes `CREATE TABLE`, `ALTER TABLE`,
`ADD COLUMN`, and several other statements for creating or modifying the
structure or rules that govern the data that is held within a database.

### Data Manipulation Language (DML) ###

This part of the SQL language is what allows a user to retrieve or modify the
data stored within a database. Some databases consider the retrieval and
manipulation as two separate languages themselves, but PostgreSQL's
documentation combines them. (The SQL standard theorizes the `SELECT` statement
as being its own DQL, or Data Query Language, but this distinction is elided by
most database systems and their communities of users and developers.)

### Data Control Language (DCL) ###

The DCL is tasked with controlling the rights and access roles of the users
interacting with a database or table.

## 2:3 Exercises DML/DDL/DCL ##

Common DCL statements include `GRANT` and `REVOKE`.

Common DML statements include `INSERT`, `SELECT`, `UPDATE`, and `DELETE`.

Common DDL statements include `CREATE`, `ALTER`, and `DROP`.

All `CREATE` statements, including `CREATE SEQUENCE`, are part of the DDL.

Although `DROP TABLE` and `DROP DATABASE` may have the side effect of deleting
data, but they are part of the DDL, since they alter the structure.

## Exercises: DDL (Data Definition Language) ##

### Altering constraints ###

If we are attempting to apply any constraint to a table that has existing rows
of data, we must first ensure that the existing rows conform to the constraint.
Otherwise the schema change operation will fail with an error. This includes
`NOT NULL`, `UNIQUE`, `CHECK`, `PRIMARY KEY`, `FOREIGN KEY`, and any others I
might have missed.

Similarly, if we add a column with a `NOT NULL` constraint to a table that
already contains data rows, the `ADD COLUMN` operation will fail with an error
**unless** we set a default value. Without a default value, the database system
will not know how to fill in the new column for each existing row, and since we
have specified the field must not be `NULL`, it cannot insert `NULL`.

### Altering types ###

PostgreSQL will not allow a narrowing type change for a character column.
It is ok to lose trailing space characters, but if the type change loses any
other character then the attempt will fail.

When a table has existing rows, sometimes a type change will fail with an error
because there is no defined default conversion from the type of the existing
values to the new type. In this situation we can say which conversion we want to
happen by specifying it in the `USING` clause. E.g.,
```sql
ALTER TABLE stars
            ALTER COLUMN spectral_type
            TYPE spectral_type_enum
            USING spectral_type::spectral_type_enum;
```
The general form seems to be:
```sql
ALTER TABLE table_name
            ALTER COLUMN column_name
            TYPE new_type
            USING column_name::new_type;
```
Remember that `::` in this context is peculiar to Postgres; SQL in general uses
`CAST()`.


