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
