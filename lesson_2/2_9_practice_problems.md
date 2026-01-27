1.

Any operator with `NULL` as one of its operands will return `NULL`.

11.

`pg_dump` can be used to export a PostgreSQL database as an SQL script or to
other formats.

### LS answer ###

`pg_dump -d db_name -t table_name --inserts > dump.sql`

If you leave out `--inserts`, the resulting SQL statements will still restore
the table and its data. The format will just be slightly different, using a
`COPY FROM stdin` statement instead of multiple `INSERT` statements.

`COPY FROM` is the default because it is more efficient on large data sets, but
using `INSERTS` is also valid and creates SQL statements that are typically the
same as those that a user of the database might write themselves when adding
data to the table manually.

