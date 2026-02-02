### インデックス（何に・なぜ貼るか）

```
sql_practice=# \i basic/13_index_basic.sql
 id |       title        |     name     
----+--------------------+--------------
  1 | 初めての投稿       | Alice Cooper
  2 | Bobの日記          | Bob
  3 | Aliceの2つ目の投稿 | Alice Cooper
(3 rows)

 id |       title        
----+--------------------
  1 | 初めての投稿
  3 | Aliceの2つ目の投稿
(2 rows)

CREATE INDEX
 id |       title        
----+--------------------
  1 | 初めての投稿
  3 | Aliceの2つ目の投稿
(2 rows)

CREATE INDEX
 id |       title        |         created_at         
----+--------------------+----------------------------
  1 | 初めての投稿       | 2026-01-25 22:59:07.128589
  2 | Bobの日記          | 2026-01-25 22:59:07.128589
  3 | Aliceの2つ目の投稿 | 2026-01-25 22:59:07.128589
(3 rows)
```

① インデックスなしで JOIN を使う SELECT

ここで起きていること
- posts と users を user_id = id で結合
- まだ posts.user_id にインデックスはない

DB内部の動き（イメージ）
- posts を1行ずつ読む
- 各行ごとに users を探す
- データが増えると JOIN が重くなる

学習ポイント
- JOIN は「結合キー」にインデックスがないと遅くなりやすい

② WHERE で user_id を絞る（よくあるクエリ）

ここで起きていること
- user_id = 1 の投稿を探す
- インデックスなしなので 全件走査（Seq Scan）

DB内部の動き
- posts を先頭から最後まで全部読む
  - → 条件に合う行だけ返す

学習ポイント
- WHERE 句はインデックスの最重要対象

③ posts.user_id にインデックスを貼る

ここで起きていること
- posts.user_id 用の 索引（検索用の別構造） が作られる
- データ行は一切変わらない

このインデックスが効く場面
- WHERE p.user_id = ?
- JOIN posts.user_id = users.id

学習ポイント
- 「JOINキー + WHERE条件」は最優先でインデックス候補

④ 同じ SELECT をもう一度（結果は変わらない）

見た目の結果
- ②と 完全に同じ

でも内部では？
- Index Scan が使われる可能性が出る
- DBは「インデックス経由で該当行だけ取れるな」と判断できる
- ただし：データが少ないと Seq Scan のまま になることもある

学習ポイント
- インデックスは「結果」ではなく「処理経路」を変える

⑤ created_at にもインデックスを貼ってみる（ORDER BY 用）

ここで起きていること
- created_at の 並び順用インデックス

これは何のため？
- ORDER BY created_at
- 最新順 / 古い順の一覧表示

学習ポイント
- ORDER BY / LIMIT はインデックスがないと激重になりやすい

⑥ 並び替えクエリ
インデックスなしの場合
- 全件取得
- メモリ or ディスクでソート
- 件数が多いとかなり重い

インデックスありの場合
- インデックス順に読むだけ
- ソート不要 or 最小限

学習ポイント
- ORDER BY 用インデックスは「一覧画面の生命線」

まとめ

インデックス名は DB内部で参照されるだけ
- この idx_posts_user_id は 人間が識別する名前
- SELECT 文で明示的に書く必要はありません
- DB が自動で WHERE / JOIN / ORDER BY に使えそうな場合に参照 します

SELECT 文の書き方は変わらない
- ②と④の違いは見た目の結果は同じ
- インデックスがあるかどうかで DB の処理方法が変わる

インデックスの効果

| 効果   | 内容                                     |
| ---- | -------------------------------------- |
| 結果   | **変わらない**                              |
| 実行速度 | **変わる**                                |
| 実行計画 | `EXPLAIN` で Seq Scan → Index Scan に変わる |

- 例えば posts.user_id にインデックスがあれば、WHERE user_id = 1 は Index Scan になり、全件スキャン（Seq Scan）より速くなる
- ORDER BY created_at もインデックスがあれば ソート処理が減る
- ただし結果は常に同じ


### 実行計画（EXPLAIN / EXPLAIN ANALYZE）

```
sql_practice=# \i basic/14_explain_basic.sql
                                            QUERY PLAN                                            
--------------------------------------------------------------------------------------------------
 Seq Scan on posts p  (cost=0.00..1.04 rows=1 width=36) (actual time=0.201..0.205 rows=2 loops=1)
   Filter: (user_id = 1)
   Rows Removed by Filter: 1
 Planning Time: 3.565 ms
 Execution Time: 1.905 ms
(5 rows)

INSERT 0 10000
                                                          QUERY PLAN                                                           
-------------------------------------------------------------------------------------------------------------------------------
 Index Scan using idx_posts_user_id on posts p  (cost=0.27..8.29 rows=1 width=36) (actual time=0.135..0.356 rows=2488 loops=1)
   Index Cond: (user_id = 1)
 Planning Time: 0.022 ms
 Execution Time: 0.416 ms
(4 rows)

                                                 QUERY PLAN                                                  
-------------------------------------------------------------------------------------------------------------
 Sort  (cost=96.57..97.20 rows=252 width=44) (actual time=6.496..7.154 rows=10003 loops=1)
   Sort Key: created_at DESC
   Sort Method: quicksort  Memory: 1166kB
   ->  Seq Scan on posts  (cost=0.00..86.52 rows=252 width=44) (actual time=0.032..3.022 rows=10003 loops=1)
 Planning Time: 0.200 ms
 Execution Time: 7.616 ms
(6 rows)

TRUNCATE TABLE
```

① ダミーデータなし（件数が少ない）
```
Seq Scan on posts p
Filter: (user_id = 1)
Rows Removed by Filter: 1
```
何が起きている？
- posts は 3件程度
- PostgreSQL は判断しています：
- 全件なめたほうが早い

ポイント
- インデックスは存在している
- それでも Seq Scan が選ばれている
- インデックス = 常に使われる、ではない
- 件数が少ないとインデックスはむしろコストが高い

② ダミーデータ投入後（1万件）
```
INSERT 0 10000
```
- posts が 10003件 に増加
- 統計情報的に状況が変わった

③ ダミーデータあり（user_id 絞り込み）
```
Index Scan using idx_posts_user_id on posts p
Index Cond: (user_id = 1)
```
- Index Scan に切り替わった
- idx_posts_user_id が明示的に使われている

行数の読み方
```
rows=2488
```
- user_id = 1 の投稿が約 1/4
- インデックス → 対象行だけ拾う → テーブル参照
- インデックスの価値が初めて発揮された瞬間

④ ORDER BY created_at（インデックスがあるのに？）
```
Seq Scan on posts
Sort Method: quicksort
```
- idx_posts_created_at は 存在している
- なのに Seq Scan + Sort

PostgreSQL の判断：
- 全部読むなら、インデックス順に読むよりまとめて読んでソートしたほうが安い

特に今回は：
- 全件取得
- LIMIT なし
- created_at インデックスは「全件 ORDER BY」では使われにくい

もしこう書いたらどうなる？
```
SELECT id, title, created_at
FROM posts
ORDER BY created_at DESC
LIMIT 10;
```
- Index Scan が選ばれる可能性が高い

⑤ TRUNCATE の意味
```
TRUNCATE TABLE
```
- ダミーデータを 完全削除
- ID もリセット
- 次回実行に影響を残さない