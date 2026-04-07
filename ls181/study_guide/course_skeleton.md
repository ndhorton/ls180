## Lesson 1: Introduction ##

Covers setting up Postgres, `psql`, and has the SQL book, along with some basic
exercises.

So the main thing is the SQL book.

## Lesson 2: Schema, Data, and SQL ##

### 2:2 The SQL Language ###

Covers DDL, DML, DCL.

### 2:5 PostgreSQL Data Types ###

Basic coverage of types and `NULL`.

### 2:9 `NOT NULL` and Default Values ###

More coverage of `NOT NULL` and default values, with some real-world scenarios
and edge cases.

### 2:11 Using Keys ###

Covers Natural and Surrogate Keys, as well as Primary Keys as a concept rather
than a schematic constraint.

### 2:12 How PostgreSQL Executes Queries ###

Explains the order of operations for a query.

### 2:15 Summary ###

* SQL is a special-purpose, declarative language used to manipulate the structure
and values of datasets stored in a relational database.
* SQL is comprised of three sublanguages: DDL, DML, and DCL.
* SQL code is made up of statements, which must be terminated by a semicolon.
* PostgreSQL provides many data types. We've looked at the following subset of
types it supports in this lesson: `varchar(length)`, `text`, `integer`, `real`,
`decimal(precision, scale)`, `timestamp`, `date`, and `boolean`.
* NULL is a special value that represents the absence of any other value.
* NULL values must be compared using IS NULL or IS NOT NULL.
* Database dumps can be loaded using
`psql -d database_name < file_to_import.sql`.
* Table columns can have default values, which are specified using SET DEFAULT.
* Table columns can be disallowed from storing NULL values using SET NOT NULL.
* CHECK constraints are rules that must be met by the data stored in a table.
* A natural key is an existing value in a dataset that can be used to uniquely
identify each row of data in that dataset.
* A surrogate key is a value that is created solely for the purpose of
identifying a row of data in a database table.
* A primary key is a value that is used to uniquely identify the rows in a table.
It cannot be NULL and must be unique within a table. They are created using
PRIMARY KEY.
* serial columns are typically used to create auto-incrementing columns in
PostgreSQL.
* AS is used to specify an alias for tables and columns within a SQL statement.

You may need to practice DDL and especially review the various ways schemas may
need to be updated once the table has rows of data and the logical pitfalls
involved.

## Lesson 3: Relational Data and JOINs ##

### 3:2: What is Relational Data? ###

Gives you simplified definitions of **relation**, **relationships** etc.

### 3:3 Database Diagrams: Levels of Schema ###

Video introducing conceptual, logical, and physical schema, mainly focusing on
the conceptual and the physical.

### 3:4 Database Diagrams: Cardinality and Modality ###

Video explaining cardinality and modality, as well as crow's foot notation.

### 3:5 A Review of JOINs ###

Video on joins.

### 3:7: Using Foreign Keys ###

Covers Foreign Keys as a concept and schematic constraint.

### 3:8 One to Many Relationships ###

Covers 1:M relationships.

### 3:9: Extracting a 1:M Relationship From Existing Data ###

Goes into detail on this. Might come up in the assessment.

### 3:12: Many-to-Many Relationships ###

Covers M:M relationships.

### 3:13: Converting a 1:M Relationship to a M:M Relationship ###

Goes into detail on this. Might come up in the assessment.

### 3:15 Summary ###

* Relational databases are called relational because they persist data in a set
of relations, or, as they are more commonly called, tables.

* A relationship is a connection between entity instances, or rows of data,
usually resulting from what those rows of data represent.

* The three levels of schema are conceptual, logical, and physical.

* The three types of relationships are one-to-one, one-to-many, and
many-to-many.

* A conceptual schema is a high-level design focused on identifying entities and
their relationships.

* A physical schema is a low-level database-specific design focused on
implementation.

* Cardinality is the number of objects on each side of the relationship.

* The modality of a relationship indicates if that relationship is required or
not.

* Data has referential integrity if it requires all references to be valid. That
is, if a value in a column references a value in another column (usually in
another table), then that value must exist in the referenced column.

## Lesson 4: Optimizing SQL Queries ##

### 4:2: Indexes ###

Covers indexes.

### 4:3: Comparing SQL Statements ###

Explains `EXPLAIN`.

### 4:4: Subqueries

Covers subquery expressions.

### 4:6: Summary ###

* Indexes can be used as part of database optimization.
* We can compare the performance of SQL statements.
* We can use subqueries as an alternative to joins.
