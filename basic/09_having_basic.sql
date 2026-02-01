-- HAVING（集計結果の絞り込み）

-- ① 投稿が 1 件以上あるユーザー
SELECT
  u.id,
  u.name,
  COUNT(p.id) AS post_count
FROM users u
LEFT JOIN posts p
  ON u.id = p.user_id
GROUP BY u.id, u.name
HAVING COUNT(p.id) >= 1
ORDER BY u.id;

-- ② 投稿が 0 件のユーザーだけ出す
SELECT
  u.id,
  u.name,
  COUNT(p.id) AS post_count
FROM users u
LEFT JOIN posts p
  ON u.id = p.user_id
GROUP BY u.id, u.name
HAVING COUNT(p.id) = 0
ORDER BY u.id;

-- ③ 投稿が 2 件以上あるユーザー
SELECT
  u.id,
  u.name,
  COUNT(p.id) AS post_count
FROM users u
LEFT JOIN posts p
  ON u.id = p.user_id
GROUP BY u.id, u.name
HAVING COUNT(p.id) >= 2
ORDER BY post_count DESC;

-- ④ HAVING と WHERE の合わせ技
SELECT
  u.id,
  u.name,
  COUNT(p.id) AS post_count
FROM users u
LEFT JOIN posts p
  ON u.id = p.user_id
WHERE p.title LIKE '%投稿%'
GROUP BY u.id, u.name
HAVING COUNT(p.id) >= 1
ORDER BY u.id;
