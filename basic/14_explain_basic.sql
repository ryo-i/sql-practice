-- ============================================
-- 実行計画の比較
-- ① データ少（インデックスありでも効かない）
-- ② データ多（インデックスが効く）
-- ============================================


-- ============================================
-- ① ダミーデータなし（件数が少ない状態）
-- ============================================

-- posts は数件しかない状態

EXPLAIN ANALYZE
SELECT
  p.id,
  p.title
FROM posts p
WHERE p.user_id = 1;

-- 👉 ここでは Seq Scan になる可能性が高い
-- 👉 「インデックスがあっても使われない」例


-- ============================================
-- ② ダミーデータを追加
-- ============================================

-- 行数を増やして実行計画が変わる状況を作る
INSERT INTO posts (user_id, title, content, created_at)
SELECT
  (random() * 2 + 1)::int,
  'Dummy Post ' || g,
  'dummy',
  now() - (g || ' minutes')::interval
FROM generate_series(1, 10000) g;


-- ============================================
-- ③ ダミーデータあり（件数が多い状態）
-- ============================================

EXPLAIN ANALYZE
SELECT
  p.id,
  p.title
FROM posts p
WHERE p.user_id = 1;

-- 👉 Index Scan / Bitmap Index Scan に変わる
-- 👉 インデックスの効果が「見える」


-- ============================================
-- ④ ORDER BY + インデックス確認
-- ============================================

EXPLAIN ANALYZE
SELECT
  id,
  title,
  created_at
FROM posts
ORDER BY created_at DESC;

-- 👉 created_at のインデックスが効くか確認


-- ============================================
-- ⑤ 後片付け（ダミーデータ削除）
-- ============================================

TRUNCATE TABLE posts RESTART IDENTITY CASCADE;

-- 初期データに戻したい場合は以下を実行
-- （psql上で）
-- \i basic/05_insert_posts.sql
