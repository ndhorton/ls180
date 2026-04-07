# Talk about the different levels of schema. #

## SQL Book: SQL Basics Tutorial ##

### Data vs Schema ###

Schema is concerned with the *structure* of a database. This structure is
defined by things such as the names of tables and table columns, the data
types of those columns and any constraints that they may have.

Data is concerned with the *contents* of a database. These are the actual
values associated with specific rows and columns in a database table.

Schema and data work together in order to let us interact with a database in
useful ways. Schema without data would just be a bunch of empty tables. If we
had data without schema, we'd be back to unstructured data.

DDL permits us to create, read, update and delete schema just as DML allows us
to create, read, update and delete data.

## SQL Book: Create and View Databases ##

A schema is also part of the database. We can perhaps think of a building as a
database. The floor plan would then be the schema, while the physical rooms
correspond to the tables in the database. The rooms are perhaps different sizes,
have different things in them, and some of them might be connected to each
other, but they all exist within the schema (the floor plan) of the building
(database).

## SQL Book: Create and View Tables ##

Once we have created a database, we have the 'outer shell' of our building. Our
building doesn't currently have any rooms however, so if we were to fill that
building with stuff, that stuff wouldn't be any more organised inside the
building than outside of it. We need to add some rooms so that we can organize
our stuff properly. In SQL terms, we need to add tables.

Database tables, or relations, and the relationships between those tables are
what provide the structure we need to house our data. Tables can represent
real-world entities that constitute the business logic of an application, like a
customer or an order. The tables and the relationships between them are used to
store data to represent our business logic. For example, consider representing a
customer who has orders associated with them.

### Schema and DCL ###

When we've previously spoken about creating the schema for a database, we've
explained that we use one of the SQL sub-languages, DDL, to do this. There are
actually parts of a database's schema that are controlled and managed by another
of SQL's sub-languages, DCL (Data Control Language).

DCL is concerned with controlling who is allowed to perform certain actions
within a database, or in other words with the 'security' of a database. It is
worth understanding that the 'security settings' determined by DCL are also part
of the database's schema.

All aspects of the database's schema could be used by DCL to allow or restrict
access to certain parts of the database or specific tables.

## SQL Book: Create Multiple Tables ##

### Normalization ###

Duplication of data (often referred to as 'redundancy') resulting from too many
fields being present on a single table can lead to issues with data integrity.
Ideally, we want information about an entity to be stored in only one place,
and we can then use references to that entity instance if we need to associate
the data with another entity instance.

The process of splitting up data from one big table into smaller tables that
represent discrete entities is called **normalization**.

Normalization is a deep topic, and there are complex sets of rules which dictate
the extent to which a database is judged to be *normalized*. These rule-sets are
known as 'normal forms'.

* The *reason* for normalization is to reduce data redundancy and improve data
integrity.
* The mechanism for carrying out normalization is arranging data in multiple
tables and defining relationships between them.

### Database Design ###

At a high level, the process of database design involves defining **entities**
to represent different sorts of data and designing **relationships** between
those entities.

An **entity** represents a real world object, or a set of data that we want to
model within our database; we can often identify these as the major nouns of the
system we're modelling.

For the sake of simplicity we might draw a direct correlation between an entity
and a single table of data; in a real production database, however, the data for
a single entity might be stored in more than one table.

### ERDs introduced ###

An Entity Relationship Diagram, or ERD, is a graphical representation of
entities and their relationships to each other, and is a commonly used tool
within database design.

There are different types of ERD varying from conceptual to detailed, and often
using specific conventions such as crow's foot notation to model relationships.

## 3:3 Database Diagrams: Levels of Schema ##

An Entity Relationship Diagram, or Entity-Relationship model, is a visual
layout depicting entities and the relationships between them.

The three levels of schema, or, essentially, levels of abstraction, involved in
Entity Relationship Diagrams are, from the most abstract to the least:
conceptual, logical, physical.

An ERD at the *conceptual* level of abstraction is concerned with the highest
level objects or entities, and perhaps with some sense of the relationships
between them. It is not concerned with how these entities will be stored or
implemented in a database.

An ERD at the *physical* level of abstraction will model each entity with all of
its attributes and their data types, as well as more detailed rules concerning
these attributes, most especially those concerning relationships between
entities. The physical level of ERD is drawn up for a specific database system.

An ERD at the *logical* level is somewhere between the two above. A logical
schema diagram will generally include the attributes of entities and the general
type of data that each attribute is concerned with, but will not be concerned
with the particulars of any specific RDBMS. For instance, a logical ERD might
use only the data types described in the SQL standard.

* Conceptual Schema --- a high-level design focused on identifying entities and
their relationships.
* Physical Schema --- a low-level database-specific design that is focused on
the implementation.

A conceptual ERD would omit attributes and hence data types, keys, constraints,
etc. Moreover, diagrams at the conceptual level of schema are modelling business
entities and their relationships, not tables as such. This means that a
conceptual diagram might express a many-to-many relationship between two
entities that would need to be broken out into two 'entity tables' and a third
intermediate join table that would actually implement the conceptual many-to-many
relationship in a relational database.

Or again, a conceptual schema might show the modalities of a relationship as
required (1) on both sides, but in practice (and in the physical schema) this
might not be implemented since attempting to impose such constraints at the SQL
level would create difficulties in inserting new rows into tables.

## 3:4 Database Diagrams: Cardinality and Modality ##

* Cardinality --- the number of objects on each side of the relationship (1:1,
1:M, M:M).

* Modality --- if the relationship is required (1) or optional (0).

Each side of a relationship between entities has a cardinality and a modality.
Cardinality represents the upper bound of how many entity instances there can be
on one side of the relationship. There can be *at most* one, or there can be *at
most* multiple entity instances. The lower bound is determined by the modality.
If the modality is required (1), then there must be *at least one* entity
instance on this side of the relationship. If the modality is optional (0), then
there can be zero entity instances on this side of the relationship.

One-to-one relationships are fairly rare in real databases. A one-to-one
relationship at the conceptual level most often implies that when the physical
schema is drawn up, or the database design is actually implemented, the two
entities will actually be stored in the same table.

When designing a database, cardinality is usually discussed before modality.
This is because the cardinality defines the overall shape of the relationship
between entities (1:1, 1:M, M:M). Once that context has been defined, it becomes
meaningful to discuss whether each side of the relationship is required or not.
