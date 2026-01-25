### 複数テーブル設計（外部キー）

migration（DDL）
```bash
sql_practice=# \i setup/migrations/03_create_posts.sql
CREATE TABLE
```

basic（DML）
```bash
sql_practice-# \i basic/05_insert_posts.sql
INSERT 0 3
 id | user_id |       title        |        content         |         created_at         
----+---------+--------------------+------------------------+----------------------------
  1 |       1 | 初めての投稿       | Alice の最初の投稿です | 2026-01-25 22:59:07.128589
  2 |       2 | Bobの日記          | Bob が書いた投稿です   | 2026-01-25 22:59:07.128589
  3 |       1 | Aliceの2つ目の投稿 | Alice の追加の投稿     | 2026-01-25 22:59:07.128589
(3 rows)
```