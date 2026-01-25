docs/step02_insert.md
```
-- INSERT文の基本構文
-- INSERT INTO [table_name] ([column1], [column2], ...)
-- VALUES ([value1], [value2], ...);
```

```
sql_practice=# TRUNCATE TABLE users RESTART IDENTITY;
TRUNCATE TABLE
sql_practice=# SELECT * FROM users;
 id | name | email | created_at 
----+------+-------+------------
(0 rows)

sql_practice=# \i basic/01_insert.sql
INSERT 0 1
sql_practice=# SELECT * FROM users;
 id | name  |       email       |         created_at         
----+-------+-------------------+----------------------------
  1 | Alice | alice@example.com | 2026-01-25 16:58:04.022849
(1 row)

```

