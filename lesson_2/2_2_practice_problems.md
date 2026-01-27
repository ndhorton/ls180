1.

SQL is a declarative, special purpose language. Its special purpose is to
interact with relational databases.

2.

The three sublanguages of SQL are:
* Data Definition Language (DDL), used to give structure to a database and
provide rules about what data can enter the database.
* Data Manipulation Language (DML), used to retrieve or modify data within a
database.
* Data Control Language (DCL), used to set access rights and roles for users of
a database.

3.
    1. 'canoe'
    2. 'a long road'
    3. 'weren''t'
    4. '"No way!"'

4.

The `||` operator can be used for string concatenation.

5.

The `lower()` function returns the all lower case version of the given string.

E.g.:
```sql
SELECT lower('SHOUTING');
```

6.

The `psql` console often displays `true` and `false` values as `t` and `f`
respectively.

7.

```sql
SELECT trunc(4 * pi() * power(26.3, 2)) AS "Approx Surface Area";
```

LS solution:
```sql
SELECT trunc(4 * pi() * 26.3 ^ 2);
```
