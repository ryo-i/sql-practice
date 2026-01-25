# CRUD

## Create: INSERT 基本

```sql
-- 学習用リセット（本来はリセットしない）
TRUNCATE TABLE users RESTART IDENTITY;

-- INSERT文の基本構文
-- INSERT INTO [table_name] ([column1], [column2], ...)
-- VALUES ([value1], [value2], ...);

INSERT INTO users (name, email)
VALUES
  ('Alice', 'alice@example.com'),
  ('Bob',   'bob@example.com'),
  ('Carol', 'carol@example.com');

-- 挿入後確認
SELECT * FROM users;
```

```bash
sql_practice-# \i basic/01_insert_users.sql
TRUNCATE TABLE
INSERT 0 3
 id | name  |       email       |         created_at         
----+-------+-------------------+----------------------------
  1 | Alice | alice@example.com | 2026-01-25 18:21:47.136245
  2 | Bob   | bob@example.com   | 2026-01-25 18:21:47.136245
  3 | Carol | carol@example.com | 2026-01-25 18:21:47.136245
(3 rows)
```

##  Read: SELECT 基本

```sql
-- SELECT文の基本構文
-- SELECT [column1], [column2], ...
-- FROM [table_name]
-- WHERE [条件];

-- 全件取得
SELECT * FROM users;

-- 特定カラムのみ
SELECT id, name, email FROM users;

-- 条件付き検索
SELECT *
FROM users
WHERE email = 'alice@example.com';

-- 並び替え
SELECT *
FROM users
ORDER BY created_at DESC;

-- 件数制限
SELECT *
FROM users
ORDER BY id
LIMIT 2;
```

```bash
sql_practice-# \i basic/02_select_users.sql
 id | name  |       email       |         created_at         
----+-------+-------------------+----------------------------
  1 | Alice | alice@example.com | 2026-01-25 18:21:47.136245
  2 | Bob   | bob@example.com   | 2026-01-25 18:21:47.136245
  3 | Carol | carol@example.com | 2026-01-25 18:21:47.136245
(3 rows)

 id | name  |       email       
----+-------+-------------------
  1 | Alice | alice@example.com
  2 | Bob   | bob@example.com
  3 | Carol | carol@example.com
(3 rows)

 id | name  |       email       |         created_at         
----+-------+-------------------+----------------------------
  1 | Alice | alice@example.com | 2026-01-25 18:21:47.136245
(1 row)

 id | name  |       email       |         created_at         
----+-------+-------------------+----------------------------
  1 | Alice | alice@example.com | 2026-01-25 18:21:47.136245
  2 | Bob   | bob@example.com   | 2026-01-25 18:21:47.136245
  3 | Carol | carol@example.com | 2026-01-25 18:21:47.136245
(3 rows)

 id | name  |       email       |         created_at         
----+-------+-------------------+----------------------------
  1 | Alice | alice@example.com | 2026-01-25 18:21:47.136245
  2 | Bob   | bob@example.com   | 2026-01-25 18:21:47.136245
(2 rows)
```

## Update: UPDATE 基本

```sql
-- UPDATE文の基本構文
-- UPDATE [table_name]
-- SET [column1] = [value1], [column2] = [value2], ...
-- WHERE [条件];

-- id指定で名前を変更
UPDATE users
SET name = 'Alice Cooper'
WHERE id = 1;

-- emailで条件指定
UPDATE users
SET email = 'alice.cooper@example.com'
WHERE email = 'alice@example.com';

-- 更新後確認
SELECT * FROM users;
```

```bash
sql_practice-# \i basic/03_update_users.sql
UPDATE 1
UPDATE 1
 id |     name     |          email           |         created_at         
----+--------------+--------------------------+----------------------------
  2 | Bob          | bob@example.com          | 2026-01-25 18:21:47.136245
  3 | Carol        | carol@example.com        | 2026-01-25 18:21:47.136245
  1 | Alice Cooper | alice.cooper@example.com | 2026-01-25 18:21:47.136245
(3 rows)

```

## Delte: DELETE 基本

```sql
-- DELETE文の基本構文
-- DELETE FROM [table_name]
-- WHERE [条件];

-- 特定レコード削除
DELETE FROM users
WHERE id = 2;

-- 削除後確認
SELECT * FROM users;
```

```bash
sql_practice-# \i basic/04_delete.sql
DELETE 1
 id |     name     |          email           |         created_at         
----+--------------+--------------------------+----------------------------
  3 | Carol        | carol@example.com        | 2026-01-25 18:21:47.136245
  1 | Alice Cooper | alice.cooper@example.com | 2026-01-25 18:21:47.136245
(2 rows)
```