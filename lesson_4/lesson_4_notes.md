# 4:1 What to Focus On #

* Optimization is something to be aware of.
    * A database-backed application can be slow for a variety of reasons.
    * You should understand what indexes are, how to implement them, and the
    trade-offs involved in using them.
    * You should be aware of the concept of comparing different SQL statements.
* Subqueries can be useful.
    * You should know what a subquery is and how to use it, but you aren't
    expected to know everything about them. Many queries can be accomplished
    using `JOIN`s *or* subqueries, and knowing which is the best requires
    understanding a lot about the specific scenario being considered. This isn't
    something you are expected to master at this point.

# 4:2 Indexes #

One way to optimize database-backed applications is to add indexes to the
database tables.

## What are Indexes? ##

In the context of a database, an index is a mechanism that SQL engines use to
speed up queries. They do this by storing indexed data in a table-like
structure, which can be quickly searched using particular search algorithms. The
results of the search provide a link back to the record(s) to which the indexed
data belongs. Using an index means that the database engine can locate column
values more efficiently since it doesn't have to search through every record in
a table in sequence.

## When to Use an Index? ##

Using indexes without any consideration of their trade-offs can actually make
database-backed applications slower. There are many reasons for this, one being
that when you build an index of a field, reads become faster but insertions and
updates become slower. Every time a row is inserted or updated, the index must
be updated as well, so performance takes a hit for these operations. As with
many database optimization decisions, there are a lot of choices involved in how
to decide whether or not a column should be designated an index.

There are some useful rules of thumb:
* Indexes are best used in cases where sequential reading is inadequate. For
example, columns that aid in mapping relationships (such as Foreign Key columns)
and columns that are frequently used as part of an `ORDER BY` clause are good
candidates for indexing.
* Indexes are best used in tables and/or columns where the data will be read
much more frequently than data is added or updated.

### Types of Index ###

Another decision when using indexes is the type of index to use. Different types
of index use different data structures and search algorithms. Some of the index
types available in PostgreSQL are B-tree, Hash, GiST, and GIN.

## Creating Indexes ##

Sometimes indexes are created implicitly when we take some other action. When we
define a `PRIMARY KEY` constraint or a `UNIQUE` constraint on a column, an
index is automatically created on that column. The index is the primary
mechanism by which these constraints enforce uniqueness.

Unlike `PRIMARY KEY` and `UNIQUE` constraints, a `FOREIGN KEY` constraint does
not automatically create an index. Foreign Key columns are, however, good
candidates for indexing, but we need to create such indexes explicitly.

The general form for adding an index to a table is:
```sql
CREATE INDEX index_name
          ON table_name (field_name);
```
If `index_name` is omitted, PostgreSQL automatically generates a unique name for
the index. If you want to specify your own name, it must be unique and unused.

PostgreSQL uses B-tree indexes by default, and B-tree indexes are the only type
available for *unique indexes*.

### Unique and Non-unique ###

When an index is created via `PRIMARY KEY` or `UNIQUE` constraints, the index
created is a *unique* index. When an index is unique, multiple table rows with
equal values for that index are not allowed. Generally, when we create an index
ourselves, explicitly, the index does *not* enforce uniqueness. This is
sometimes referred to as a non-unique index.

### Multicolumn Indexes ###

As well as indexing a single column, indexes can also be created on more than
one column. The form is alomst the same as a single-column index, except instead
of specifying a single column name, we specify more than one:
```sql
CREATE INDEX index_name ON table_name (field_name_1, field_name_2);
```
Only certain index types support multi-column indexes, and there is a limit to
the number of columns that can be combined in an index.

### Partial Indexes ###

Partial indexes are built from a subset of the data in a table. The subset of
data is defined by a conditional expression, and the index contains entries
only for the rows from the table where the value in the indexed column satisfies
the condition.

Partial indexes can be useful in certain situations, but they are far less
common than single-column or multi-column indexes.

## Deleting Indexes ##

The `DROP INDEX` command can be used to delete an index.

Drawbacks to indexing every column:
* Updates and Insertions become more expensive, since the index must be updated.
* Indexes require disk space.
* Every index must be read and considered by the query planner.
* Extra or poorly chosen indexes can actually make some queries slower if the
planner chooses a suboptimal index, or spends time evalutating many indexes that
are never useful.

We want to avoid indexing columns that
* are rarely used for searching, sorting, or joining
* have low selectivity (e.g a boolean column where most rows are the same value)

High selectivity columns are frequently indexed, since they have the power to
identify a small number of rows, and are consequently useful for searching and
joining. The maximal selectivity of well-thought out primary key columns is why
making a column `PRIMARY KEY` automatically builds an index for that column.

# 4:3 Comparing SQL Statements #

The choices we make when writing a query can affect how efficient the query is.
Whether we choose a `JOIN` or a subquery, what type of `JOIN` we use, and even
what condition we choose for a `WHERE` clause can all make a difference to how
fast a query is executed. For an individual bespoke query, these differences may
be unimportant, but in the context of an application where a particular query
structure may be used many times on a vast dataset, how efficient that structure
is can dramatically effect the responsiveness of the application. At that point,
query structure becomes a worthwhile target of optimization.

Although SQL is **declarative** and the precise details of how a query is
executed are abstracted away from the programmer, there are still ways to
influence how efficiently a query is executed in how we write our SQL
statements.

## Assessing a Query with `EXPLAIN` ##

PostgreSQL provides a useful `EXPLAIN` command, which gives a step by step
analysis of how the query will be run internally by PostgreSQL.

In order to execute each query that it receives, PostgreSQL devises an
appropriate **query plan**.

The `EXPLAIN` command allows us to access and read the query plan for a query.

* The structure of the query plan is a node-tree. The more 'elements' there are to
a query, the more nodes there will be in the tree.
* Each node consists of the node type along with an estimated cost for that node
(start-up cost followed by total cost), the estimated number of rows to be
output by the node, and the estimated average width of the rows in bytes.

The cost4 values are calculated using arbitrary units determined by the
planner's cost parameters, and represent the estimated amount of effort or
resources required to execute the query as planned.

However many nodes the query plan has, one of the key pieces of information to
look out for inorder to compare queries is the estimated 'total cost' value of
the top-most node.

## `EXPLAIN ANALYZE` ##

When you use `EXPLAIN`, the query is not actually run. The values that `EXPLAIN`
outputs are estimates, based on the planner's knowledge of the schema and
assumptions based on PostgreSQL **system statistics**.

In order to assess a query using actual data, you can add the `ANALYZE` option
to the `EXPLAIN` command: `EXPLAIN ANALYZE [query]`.

Using the `ANALYZE` option actually runs the query. It will then output, in
addition to the output normally returned by `EXPLAIN`, the actual time in
milliseconds required to run the query and its constituent parts, as well as the
actual rows returned by each plan node rather than just an estimated number of
rows based on defaults statistics.

Since `EXPLAIN ANALYZE` actually executes the statement, we must be careful when
using it with a destructive operation - like insertion, deletion, or updating -
that we actually want the operation to be performed. The consequences will be
permanent, like with any insertion, deletion or update.

# 4:4 Subqueries #

When comparing different queries as part of an optimization process, it can
sometimes be useful to test out some subqueries.

The key thing to understand conceptually is that we are using the nested query
to generate a set of one or more values, which we then use as part of an outer
query (usually as part of a condition).

## Subquery Expressions ##

When our nested query returns a single value, we can use it in a condition with
a comparison operator like `=`. Often, however, a subquery will return multiple
values; this is where subquery expressions become useful.

Subquery expressions are a special set of operators for use specifically with
subqueries, most commonly within a conditional subquery.

### `EXISTS` ###

`EXISTS` effectively checks whether *any* rows at all are returned by the nested
query. If at least one row is returned by the subquery, then the result of
`EXISTS` is `true`, otherwise `false`.

`EXISTS` can be useful is certain situations, such as in *correlated
subqueries*.

### `IN` ###

`IN` compares an evaluated expression to every row in the subquery result. If a
row equal to the evaluated expression is found, then the result of `IN` is
`true`, otherwise `false`.

### `NOT IN` ###

`NOT IN` is similar to `IN` except that the result of `NOT IN` is `true` if an
equal row is **not** found, otherwise `false`.

### `ANY` / `SOME` ###

`ANY` and `SOME` are synonyms, and can be used interchangeably. These
expressions are used along with an operator (e.g. `=`, `<`, `>`, etc). The
result of `ANY` / `SOME` is `true` if *any* true result is obtained when the
expression to the left of the operator is evaluated using that operator against
the results of the nested query.

When the `=` operator is used with `ANY` / `SOME`, the meaning is equivalent to
`IN`.

### `ALL` ###

As with `ANY` / `SOME`, `ALL` is used along with an operator. The result of
`ALL` is `true` only if *all* of the results are `true` when the expression to
the left of the operator is evaluated using that operator against the results of
the nested query.

When the `<>` (or `!=`) operator is used with `ALL`, this is equivalent to
`NOT IN`.

## When to Use Subqueries ##

When comparing subqueries and joins that produce the same results, one can be
faster than the other. When initially formulating queries, however, we tend not
to worry about speed; optimization is separate stage in development, and comes
later in a project.

Before optimization, when performance isn't a factor, the decision whether to
use a subquery or a join will often come down to personal preference. There are,
nevertheless, valid arguments that subqueries are more readable or make more
logical sense in certain situations.

For example, if we wish to return data from one table conditional on data from
another table, but we don't need to actually return any data from the second
table, then a subquery may make more logical sense and be more readable. If you
need to return data from both tables, then you would need to use a join.

# 4:5 SQL Fundamentals --- Subqueries and More #

As well as using subqueries to generate sets of data for comparison in a `WHERE`
clause, we can also use subqueries to construct a transient table in the `FROM`
clause, whose columns can be accessed by use of a table alias.

The general form is:
```sql
SELECT transient_alias.column_name FROM (
    SELECT column_name FROM table_name
) AS transient_alias;
```

As well as using subqueries with subquery expressions in the `WHERE` clause, and
using subqueries to construct transient tables in the `FROM` clause, we can also
use subqueries directly in the list of expressions right after the `SELECT`
keyword.

E.g.
```sql
SELECT items.name,
       (SELECT COUNT(bids.item_id)
          FROM bids
        WHERE bids.item_id = items.id)
  FROM items;
```
Here, `items.id` acts as a variable passed in from the outer query, such that,
for each row scanned by the outer query, `items.id` in the inner query is
replaced by the value of the `id` column in the current row of the outer query.
A new result from the inner query is thus produced for each row of the outer
query's result table.

* Note: `EXPLAIN` is not a statement in the SQL standard, but it is implemented
in other RDBMSs.

