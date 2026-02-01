### HAVING（集計結果の絞り込み）

```
  ql_practice=# \i basic/09_having_basic.sql
 id |     name     | post_count 
----+--------------+------------
  1 | Alice Cooper |          2
  2 | Bob          |          1
(2 rows)

 id | name  | post_count 
----+-------+------------
  3 | Carol |          0
(1 row)

 id |     name     | post_count 
----+--------------+------------
  1 | Alice Cooper |          2
(1 row)

 id |     name     | post_count 
----+--------------+------------
  1 | Alice Cooper |          2
(1 row)
```
① 投稿が 1 件以上あるユーザー
- 一番よく使うパターン
- WHERE では書けない
- 「集計後にフィルタ」している

② 投稿が 0 件のユーザーだけ出す
- LEFT JOIN × HAVING の定番
- Carol だけが出るはず
- WHERE に書いたら消える（←重要）

③ 投稿が 2 件以上あるユーザー
- 「◯件以上」は実務で超よく使う
- ORDER BY に集計結果が使える
- HAVING と ORDER BY は役割が別

④ HAVING と WHERE の合わせ技
- 「特定条件の投稿が◯件以上あるユーザー」
- WHERE：集計前に行を減らす
- HAVING：集計後にグループを減らす
- 両方使うのが「普通」

| 句        | 役割        | 対象   |
| -------- | --------- | ---- |
| WHERE    | 行の絞り込み    | 生データ |
| GROUP BY | グループ化     | 集計単位 |
| HAVING   | グループの絞り込み | 集計結果 |
| ORDER BY | 並び替え      | 最終結果 |


### GROUP BY 基本（集計軸の違いを比較）

```
sql_practice=# \i basic/10_group_by_basic.sql
 id |     name     | post_count 
----+--------------+------------
  1 | Alice Cooper |          2
  2 | Bob          |          1
  3 | Carol        |          0
(3 rows)

 user_id | post_count 
---------+------------
       1 |          2
       2 |          1
(2 rows)
```
① users 軸での集計
- 集計軸：users（ユーザー）
- 数えているもの：posts
- LEFT JOIN を使っているので投稿がない Carol も 0 件として出てくる

「ユーザー一覧に、付随情報として投稿数を載せる」
 管理画面・一覧画面の王道パターン。

② posts 軸での集計
- 集計軸：posts（投稿）
- GROUP BY user_id
- 投稿が存在しないユーザー（Carol）は そもそも行が存在しない

「実際に投稿があったユーザーだけを対象にした集計」
ログ分析・実績集計・ランキング系でよく出る形

| FROM  | 何が主役か | 結果の性質     |
| ----- | ----- | --------- |
| users | ユーザー  | 0 件も含めたい  |
| posts | 投稿    | 実績があるものだけ |


### 条件付き集計（CASE WHEN）

```
sql_practice=# \i basic/11_group_by_case_when.sql
 id |     name     | titled_post_count 
----+--------------+-------------------
  1 | Alice Cooper |                 2
  2 | Bob          |                 1
  3 | Carol        |                 0
(3 rows)

 id |     name     | has_posts 
----+--------------+-----------
  1 | Alice Cooper | t
  2 | Bob          | t
  3 | Carol        | f
(3 rows)

 id |     name     | keyword_post_count 
----+--------------+--------------------
  1 | Alice Cooper |                  2
  2 | Bob          |                  0
  3 | Carol        |                  0
(3 rows)
```

① タイトルあり投稿数
has_posts（真偽値フラグ）
- CASE WHEN は 行単位で評価
- 条件を満たした行だけ 1
- 満たさない行は NULL
- COUNT は NULL を数えない
  - Alice: 投稿2件 → 2
  - Bob: 投稿1件 → 1
  - Carol: 投稿0件 → 0

「条件を満たす行数を数える」王道パターン
実務で一番よく使われる。

② ユーザーごとの投稿有無フラグ
has_posts（真偽値フラグ）

- COUNTの結果をさらに CASE で包んでいる
- 行ではなく グループ単位の判断
  - 投稿が1件以上あるか？
  - 管理画面の「有／無」「ON／OFF」判定に直結

これは HAVING の代替ではない ところが重要。
（HAVING は 行を落とす、これは 列として持つ）

③ 条件付き件数（特定ワードを含む投稿）
keyword_post_count（条件＋文字列）

- 「投稿」という文字列を含むタイトルだけをカウント
- Bob の Bobの日記 は条件不一致 → 0
- Carol はそもそも投稿なし → 0
- 検索条件つき集計
  - タグ別件数
  - ステータス別件数
  - キーワード別件数