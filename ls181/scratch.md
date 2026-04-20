When a SQL query involves more than one `JOIN`, the process can be mentally
modelled as a sequence of binary `JOIN`s. The `FROM` clause, including the
`JOIN`s, comes logically at the start of the execution of the query, and its
function is to build up a 'transient' table, which can then be filtered,
grouped, aggregated, have columns selected from it, and so on, by the other
parts of the query.

For an example, let us assume a library database with a `users` table, a `books`
table, and a `checkouts` table that records when a user checks out a book.

```sql
SELECT u.full_name,
       b.title
  FROM users AS u
       INNER JOIN checkouts AS c
       ON u.id = c.user_id
       INNER JOIN books AS b
       ON c.book_id = b.id
 WHERE c.status = 'Checked out';
```

We can begin with the first `INNER JOIN` with `users` on the left and
`checkouts` on the right of the `JOIN` keyword. The transient table that results
from this join operation contains rows representing only those concatenations of
a row from `users` and a row from `checkouts` where the `users.id` value matches
the `checkouts.user_id` value. This join 'returns' a new transient table which
becomes the left-hand operand of the next `INNER JOIN`, with `books` as the
right-hand operand. This second join operations returns a new transient table
containing concatenated rows where the `checkouts.book_id` column value matches
the `id` column of a row from `books`.

So we gradually build the transient table that is returned by the `FROM` clause
via a left-to-right sequence of 'binary' joins, where the left hand operand is
the transient table resulting from the previous join.

The fact that we have two different columns named `id`, in addition to `book_id`
and `user_id`, emphasizes how important it can be for readability to use table
aliases in multi-part joins.


