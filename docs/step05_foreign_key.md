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

### 外部キー制約の挙動確認

目的
- 外部キー（FK）が 何を防いでくれるのか
- JOIN 前提の安全性を体感する
- ON DELETE / ON UPDATE の意味を実感する

前提状態（今の構成）
- users
- posts.user_id → users.id（FKあり）

存在しない親を参照しようとするとどうなる？
```bash
sql_practice=# INSERT INTO posts (user_id, title, content)
VALUES (999, '存在しないユーザーの投稿', 'これは失敗するはず');
ERROR:  insert or update on table "posts" violates foreign key constraint "posts_user_id_fkey"
DETAIL:  Key (user_id)=(999) is not present in table "users".
```
- posts 側だけでは完結しない
- 「親が存在すること」を DB が保証してくれる
- アプリ側のバグを DB が防いでくれる

### 親（users）を削除しようとすると？
```bash
sql_practice=# DELETE FROM users WHERE id = 1;
ERROR:  update or delete on table "users" violates foreign key constraint "posts_user_id_fkey" on table "posts"
DETAIL:  Key (id)=(1) is still referenced from table "posts".
```
- posts が存在する限り、users は消せない
- 参照整合性が壊れるのを防止
- デフォルトは RESTRICT（削除禁止）