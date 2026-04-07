* order of operations
    1. Joins necessary tables
    2. `WHERE` clause filter
    3. Grouping and aggregation operations
    4. `HAVING` clause filter
    5. Evaluation of `SELECT` expression list
    6. Sorting
    7. Limiting

* Table vs column constraints
* `NULL` sort order
* Types of relationships
One thing to be aware of, and which is not covered in explicit detail in the
main material, is how 1:1 relationships are enforced.

In the book, mention is made of using the Primary Key constraint on the same
column as the foreign key, and this enforces a 1:1 relationship. However, the
reason it does so is because a Primary Key constraint implies a Unique
constraint. Which means we can simply use a Unique constraint in addition to a
Foreign Key constraint on a column to ensure that we can only have one row from
the referencing table referencing any given row of the referenced table. This
establishes a 1:1 relationship. Any row in table A can only be referenced by at
most one row of table B.

* Normalization
* Cardinality and modality of relationships
* Types of join
  * self join (using table aliases)
* `ON DELETE CASCADE`
* join tables (many-to-many relationships)
* the three anomalies
* types of subquery: scalar, correlative, transient table aliases, etc
* Window functions

One thing to note is that if we use `ORDER BY` in the `OVER` clause of a window
function call, it can appear as though the ordering is being applied to the
result set. However, this is an arbitrary effect of the order of execution of
the query, not somethin we can rely on, especially with complex queries.
Therefore, if we actually want the output rows in that order, we must repeat the
ordering in the query's main `ORDER BY` clause.

* Window functions vs aggregate functions

When we `GROUP BY`, we partition the rows into groups based on the distinct
values of the column(s) listed in the `GROUP BY` clause. If we have multiple
columns listed, let's say column A and column B, then we can think of this
similarly to a `UNIQUE` table constraint like `UNIQUE(A, B)`: we are grouping
rows by distinct *combinations* of values from columns A and B.

Once we have grouped the rows, either by the distinct values of one column or
the distinct combinations of values from multiple columns, aggregate functions
used in the `SELECT` expression list will be performed *over* each group of rows
and *for* each group of rows, reducing the multiple values in the targeted
column over each group of rows to a single value for each group.

Window functions perform aggregate operations over groups of rows, but they
produce a result *for each row* without reducing the number of rows in the
result set.

For example, the following query uses a simple aggregate function in conjunction
with the `GROUP BY` clause:
```sql
SELECT department
       COUNT(id)
  FROM employees
 GROUP BY department;
```
This query groups the rows from the `FROM` clause by distinct values for
`department`; then, *over each group and for each group*, we produce a single
value. This means that this query will return only as many rows as there are
distinct values in the `department` column.

The following query, however, uses `COUNT` as a window function by the addition
of an `OVER` clause. Here, we are producing a new value *for each row* in the
`employees` table:
```sql
SELECT name,
       department,
       COUNT(id) OVER (PARTITION BY department) AS employees_in_department
  FROM employees;
```
For this specific example, we are producing a single result over each group of
rows defined by the `PARTITION BY` expression, but we are producing a new value
*for every row* in the `employees` table. We are creating a new column in the
result set, `employees_in_department` such that each row in the result set now
tells us the employee's `name` and `department` but also how many employees are
in that employee's department (`employees_in_department`). This means that our
result set includes as many rows as there are in the table from the `FROM`
clause.

