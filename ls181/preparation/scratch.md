A many-to-many relationship exists between two entities if for one entity
instance there may be multiple records on the other table, and vice versa.

For example, a book may belong to many genres, and a genre may contain many
books.

To implement a many-to-many relationship between two tables in a database, we
need to create a third table, called a join table, in order to store connections
between entity instances in the two entity tables.

The reason for this third table is that we need a dynamically flexible place to
store connections as they arise, and therefore we cannot simply add them to the
rows in the existing tables. Each entity instance in one table needs a place for
multiple references to entity instances in the other table, and vice versa. We
cannot do this in a single column without using some kind of collection data
structure, and this would violate the principle of atomicity, an aspect of
database normalization necessary for ensuring the functionality and reliabiltiy
of a relational database. We cannot simply add extra columns either, since we
have no way of knowing in advance the maximum number of references between
instances in the two tables, and different instances would need different
numbers of columns.

So to return to our example, assume we have a `books` table and a `genres` table
created with these statements:

```sql
CREATE TABLE books(
    id serial PRIMARY KEY,
    title text
);

CREATE TABLE genre(
    id serial PRIMARY KEY,
    name text
);
```

We need to create a join table between them to express their many-to-many
relationship. The way we do this is to create a table, which we might call
`books_genres`, containing two Foreign Key columns, one referencing `books` and
the other referencing `genres`. It is important in a join table to constrain
these Foreign Key columns as `NOT NULL`, and to ensure an `ON DELETE CASCADE`
policy, since it makes no since to have one-sided 'connections', nor do we want
connections between deleted entity instances, since this degrades referential
integrity.

```sql
CREATE TABLE books_genres(
    book_id integer NOT NULL REFERENCES books(id) ON DELETE CASCADE,
    genre_id integer NOT NULL REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY(book_id, genre_id)
);
```

It is common to use a composite `PRIMARY KEY` like the above if we know that
each connection or pairing in the join table should only appear once (since a
`PRIMARY KEY` constraint imposes `UNIQUE`). However, regardless of how often a
connection should be able to appear, some software development frameworks insist
on a surrogate Primary Key column even in a join table, and in those cases this
kind of composite key should be avoided.



