
setup/migrations/02_add_columns_to_users.sql
```sql
-- 既存カラムの型変更や制約変更
ALTER TABLE users ALTER COLUMN email TYPE VARCHAR(100);

-- 新しいカラムを追加
ALTER TABLE users ADD COLUMN age INT;

ALTER TABLE users ADD COLUMN city TEXT;

-- (初期値あり)
ALTER TABLE users ADD COLUMN is_active BOOLEAN DEFAULT FALSE;
```

basic/03_update.sql
```sql
-- 既存レコードの補完例
-- id=1 Alice, id=2 Bob, id=3 Carol に対して補完

-- 年齢を仮に設定
UPDATE users
SET age = 25
WHERE name = 'Alice';

UPDATE users
SET age = 30
WHERE name = 'Bob';

UPDATE users
SET age = 28
WHERE name = 'Carol';

-- city を補完（今回は Tokyo 以外も仮に設定）
UPDATE users
SET city = 'Tokyo'
WHERE name = 'Alice';

UPDATE users
SET city = 'Osaka'
WHERE name = 'Bob';

UPDATE users
SET city = 'Nagoya'
WHERE name = 'Carol';

-- is_active はデフォルト FALSE が入っているので更新不要だが、
-- 学習用に全員 TRUE に変更してみる例
UPDATE users
SET is_active = TRUE;
```

テーブルの定義変更を反映
```bash
sql_practice=# \i setup/migrations/02_add_columns_to_users.sql
ALTER TABLE
ALTER TABLE
ALTER TABLE
ALTER TABLE
```

Insert実行
```bash
sql_practice=# \i basic/01_insert.sql
TRUNCATE TABLE
INSERT 0 3
 id | name  |       email       |         created_at         | age | city | is_active 
----+-------+-------------------+----------------------------+-----+------+-----------
  1 | Alice | alice@example.com | 2026-01-25 20:41:15.637587 |     |      | f
  2 | Bob   | bob@example.com   | 2026-01-25 20:41:15.637587 |     |      | f
  3 | Carol | carol@example.com | 2026-01-25 20:41:15.637587 |     |      | f
(3 rows)
```

Update実行
```bash
sql_practice=# \i basic/03_update.sql
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 3
 id |     name     |          email           |         created_at         | age |  city  | is_active 
----+--------------+--------------------------+----------------------------+-----+--------+-----------
  1 | Alice Cooper | alice.cooper@example.com | 2026-01-25 20:43:24.913606 |  25 | Tokyo  | t
  2 | Bob          | bob@example.com          | 2026-01-25 20:43:24.913606 |  30 | Osaka  | t
  3 | Carol        | carol@example.com        | 2026-01-25 20:43:24.913606 |  28 | Nagoya | t
(3 rows)
```

