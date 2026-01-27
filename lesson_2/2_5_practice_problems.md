1.

The `varchar` type is a string type, which can hold variable-length strings
where the maximum size is known beforehand.

The `varchar(n)` data type is the same as the `character varying(n)` type, where
`n` is the maximum size of string data that the column can hold. A `varchar`
string can be any size up to `n`; if shorter than `n` characters, then the
string itself will be shorter, rather than being padded to the given size.
`varchar` is a standard SQL type.

The `text` data type is a string type, which can hold variable-length strings of
an arbitrary size. Unlike `varchar`, `text` is a type particular to PostgreSQL.
Each RDBMS solves the problem of variable-length of arbitrary size differently.
Therefore, although `text` is fine in PostgreSQL, columns defined with `text`
would need to be changed if we were to migrate a PostgreSQL database over to a
different RDBMS.

2.

The `integer` data type can hold whole numbers (integers) within a predetermined
range of magnitude (from `-(2^31)` up to `2^31 - 1`). The range of values that
can be contained is directly related to the size of the type (4 bytes, or 32
bits, 32 - 1 because a signed number.

The `real` data type is an inexact floating-point number, implemented according
to IEEE Standard 754 for Binary Floating-Point Arithmetic. The `real` type has a
range of `1E-37` to `1E+37` with a precision of at least 6 decimal digits.

The `decimal` data type represents exact arbitrary-precision decimal numbers. It
is useful for decimal quantities that need to be exact, such as for monetary
amounts. `decimal` is an alias for `numeric`.

We specify the desired precision of accuracy for our `decimal` type with the
syntax `decimal(scale, precision)`, where `scale` represents the total number of
digits the type can hold, while `precision` represents the number of digits
after the decimal point.

3.

The largest value that can be stored in an `integer` column is `2^31 - 1`, or
2,147,483,647.

4.

The `timestamp` data type holds both a date and a time of day. The `date` type
holds a date only.

5.

The SQL standard requires that writing just `timestamp` be equivalent to
`timestamp without time zone`, and PostgreSQL honors that behaviour.

### LS answer ###

There is also a `timestamp with time zone` type, aliased as `timestamptz`, which
is a PostgreSQL extension. `timestamptz` will store the timezone in addtion to
the date and time.


