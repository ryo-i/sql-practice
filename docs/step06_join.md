# JOIN

### JOIN（行を増やす）

目的
- 外部キーで「つながっている」テーブルを どうやって一緒に取得するか
- 1対多（users → posts） の実体をSQLで見る
- 実務で一番使う INNER JOIN / LEFT JOIN の違い

行を増やす
```bash
sql_practice=# \i basic/06_join_basic.sql
 id |     name     |       title        
----+--------------+--------------------
  1 | Alice Cooper | 初めての投稿
  2 | Bob          | Bobの日記
  1 | Alice Cooper | Aliceの2つ目の投稿
(3 rows)

 id |     name     |       title        
----+--------------+--------------------
  1 | Alice Cooper | 初めての投稿
  2 | Bob          | Bobの日記
  1 | Alice Cooper | Aliceの2つ目の投稿
  3 | Carol        | 
(4 rows)
```

INNER JOINの結果（3 rows）
posts が存在しない user は行ごと消える
- JOIN条件を満たす組み合わせだけが残る
- 「投稿があるユーザー一覧」を作りたいときに使う

実務での典型用途
- 投稿済みユーザー
- 注文履歴のある顧客
- 参加者のいるイベント

LEFT JOIN の結果（4 rows）
users を基準にして、posts がなければ NULL を詰める
- users は絶対に消えない
- 「未投稿ユーザー」も確認できる

実務での典型用途
- 投稿数0のユーザーを探す
- 注文していない顧客を抽出
- 設定未完了ユーザーの洗い出し

ポイント
JOIN は「行を増やす／減らす」操作
- Alice が 2行になる → 1対多
- Carol が消える or 残る → JOIN種別の違い
- JOIN = テーブル結合
- 結果セットの形をどうしたいかで選ぶ


### JOIN + WHERE（絞り込み）

```
sql_practice=# \i basic/07_join_where.sql
 id |     name     |       title        
----+--------------+--------------------
  1 | Alice Cooper | 初めての投稿
  2 | Bob          | Bobの日記
  1 | Alice Cooper | Aliceの2つ目の投稿
  3 | Carol        | 
(4 rows)

 id |     name     |       title        
----+--------------+--------------------
  1 | Alice Cooper | 初めての投稿
  2 | Bob          | Bobの日記
  1 | Alice Cooper | Aliceの2つ目の投稿
(3 rows)
```
- Carol の posts.title は NULL → WHERE 条件に合わず除外
- LEFT JOIN を使っていてもWHERE に右テーブルの条件を書くと LEFT じゃなくなる
- 実質 INNER JOIN と同じ振る舞い


### JOIN + COUNT（集計）

```
sql_practice=# \i basic/08_left_join_count.sql
 id |     name     | post_count 
----+--------------+------------
  1 | Alice Cooper |          2
  2 | Bob          |          1
  3 | Carol        |          0
(3 rows)

 id |     name     | post_count 
----+--------------+------------
  1 | Alice Cooper |          2
  2 | Bob          |          1
  3 | Carol        |          1
(3 rows)

 id |     name     | post_count 
----+--------------+------------
  1 | Alice Cooper |          2
  2 | Bob          |          1
(2 rows)

 id |     name     | post_count 
----+--------------+------------
  1 | Alice Cooper |          2
  2 | Bob          |          1
  3 | Carol        |          0
(3 rows)
```

- ① 正解パターン（基本）
  - ユーザーごとの投稿数を出す
  - 投稿がないユーザーも 0 件で表示される
- ② 罠①：COUNT(*) を使うとどうなるか
  - 投稿がないユーザーも 1 になってしまう
- ③ 罠②：WHERE に posts 条件を書く
  - LEFT JOIN なのに INNER JOIN の挙動になる
- ④ 正解：絞り込み条件は ON に書く
  - LEFT JOIN の性質を保ったまま集計できる