1.

The Data Definition Language (DDL) is the aspect of SQL that deals with defining
the structure of the database and the rules that govern what data values can be
inserted into the database, and how different parts of the database relate to
each other. If a database is a warehouse for data, the DDL would be like the
architects and builders of the warehouse, responsible for the floor plan, and
designing with a view to which types of cargo can be stored where within the
warehouse.

The Data Manipulation Language (DML) is the aspect of SQL that deals with
putting data into the database, retrieving it, and changing or deleting data.
If a database is like a warehouse, the DML would be like the foreman, forklift
drivers, and inventory administrators, who take cargo into the warehouse and
place it where it needs to go, and who can find out what is stored where, and
bring cargo out, or replace existing stock with new stock.

### LS solution ###

The Data Definition Language (DDL) component of SQL is used to create, modify,
and delete databases and tables; that is, the DDL is responsible for describing
how data is structured. Common SQL DDL statements include:
* `CREATE`
* `ALTER`
* `DROP`

The Data Manipulation Language (DML) component of SQL is used to create, read,
update, and delete the actual data in a database. Common SQL DML statements
include:
* `SELECT`
* `INSERT`
* `UPDATE`
* `DELETE`

2.

The statement is a `SELECT` statement, corresponding to the 'Read' part of CRUD.
This means that it uses the DML component of SQL.

3.

The statement creates a table using `CREATE TABLE`. Since this deals with the
creation of the structure for our structured data, it is part of the DDL.

4.

The `ALTER TABLE` statement deals with changing the structure of data, or
redefining the attributes that the data is permitted to have, and is therefore
part of the DDL.

LS: "`ALTER TABLE` modifies the characteristics and attributes of a table. It
does not actually manipulate any data, but instead modifies the data
definitions."

5.

An `INSERT` statement adds a row, or rows, of data to a database table. Since
this means manipulating data itself, `INSERT` is part of the DML.

6.

The `UPDATE` statement makes changes to existing data. Since we are manipulating
data, rather than changing the defintion or structure of data, it is part of the
DML.

7.

The given command is not part of SQL, and is therefore not part of DDL, DML or
DCL. Rather than an SQL statement, the command is a `psql` meta-command, used
to examine the structure of an existing relation.

8.

A `DELETE` statement removes existing data rows from a database table. Since we
are manipulating the data and not the structure or security rules of a database,
a `DELETE` statement forms part of the DML.

9.

`DROP DATABASE` deals with the most basic structure of a database --- whether
the database exists or not. As such, it forms part of the DDL.

### LS answer ###

This one is a bit ambiguous... you might think it is part of the DML, part of
the DDL, or both.

`DROP DATABASE` removes all data from the database, including any and all tables
in the database. In this respect, it manipulates data, so some people think of
it as part of DML. However, `DROP DATABASE` also deletes everything about the
structure of the database and its tables. Furthermore, all variabnts of the
`DROP` statement are generally treated as DDL. In these respects,
`DROP DATABASE` manipulates how the data is structured, so it is considered part
of the DDL sublanguage.

For our purposes, `DROP DATABASE` is DDL, since its main purpose is to operate
on data definitions; the deletion of data is merely a side effect.

10.

Although this statment could be considered ambiguous, since in defining a
sequence, mathematically we define all of its values in advance,
`CREATE SEQUENCE` deals with defining the possible data of a relation rather
than adding to or manipulating the rows of data in the database tables. As such,
it could perhaps best be considered part of the DDL.

### LS Answer ###

`CREATE SEQUENCE` statements modify the characteristics and attributes of a
database by adding a sequence object to the database structure. It does not
actually manipulate any data, but instead manipulates the data definitions. As
such, `CREATE SEQUENCE` statements are part of the DDL sublanguage.

It could also be argued that `CREATE SEQUENCE` is DML; the sequence object it
creates is a bit of data that is used to keep track of a sequence of
automatically generated values, so it can be thought of as being part of the
data instead of a characteristic of the data. However, all `CREATE` statements
(not just `CREATE SEQUENCE`) are generally thought of as DDL.



