-- GROUP BY 基本（集計軸の違いを比較）

-- ① users 軸での集計
SELECT
  u.id,
  u.name,
  COUNT(p.id) AS post_count
FROM users u
LEFT JOIN posts p
  ON u.id = p.user_id
GROUP BY u.id, u.name
ORDER BY u.id;


-- ② posts 軸での集計
SELECT
  user_id,
  COUNT(*) AS post_count
FROM posts
GROUP BY user_id
ORDER BY user_id;

