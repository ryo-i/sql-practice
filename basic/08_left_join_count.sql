-- LEFT JOIN + COUNT の基本と罠
-- users : posts = 1 : 多


-- ① 正解パターン（基本）
-- ユーザーごとの投稿数を出す
-- 投稿がないユーザーも 0 件で表示される
SELECT
  u.id,
  u.name,
  COUNT(p.id) AS post_count
FROM users u
LEFT JOIN posts p
  ON u.id = p.user_id
GROUP BY u.id, u.name
ORDER BY u.id;


-- ② 罠①：COUNT(*) を使うとどうなるか
-- 投稿がないユーザーも 1 になってしまう
SELECT
  u.id,
  u.name,
  COUNT(*) AS post_count
FROM users u
LEFT JOIN posts p
  ON u.id = p.user_id
GROUP BY u.id, u.name
ORDER BY u.id;


-- ③ 罠②：WHERE に posts 条件を書く
-- LEFT JOIN なのに INNER JOIN の挙動になる
SELECT
  u.id,
  u.name,
  COUNT(p.id) AS post_count
FROM users u
LEFT JOIN posts p
  ON u.id = p.user_id
WHERE p.title IS NOT NULL
GROUP BY u.id, u.name
ORDER BY u.id;


-- ④ 正解：絞り込み条件は ON に書く
-- LEFT JOIN の性質を保ったまま集計できる
SELECT
  u.id,
  u.name,
  COUNT(p.id) AS post_count
FROM users u
LEFT JOIN posts p
  ON u.id = p.user_id
 AND p.title IS NOT NULL
GROUP BY u.id, u.name
ORDER BY u.id;