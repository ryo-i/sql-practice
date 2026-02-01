-- 複合集計（2軸以上・分布）

-- ① ユーザーごとの複合集計
SELECT
  u.id,
  u.name,
  COUNT(p.id)        AS post_count,
  MAX(p.created_at)  AS latest_post_at
FROM users u
LEFT JOIN posts p
  ON u.id = p.user_id
GROUP BY u.id, u.name
ORDER BY u.id;


-- ② 投稿数ごとのユーザー分布
SELECT
  post_count,
  COUNT(*) AS user_count
FROM (
  SELECT
    u.id,
    COUNT(p.id) AS post_count
  FROM users u
  LEFT JOIN posts p
    ON u.id = p.user_id
  GROUP BY u.id
) t
GROUP BY post_count
ORDER BY post_count;


-- ③ 投稿数カテゴリ別ユーザー数
SELECT
  CASE
    WHEN post_count = 0 THEN '0件'
    WHEN post_count = 1 THEN '1件'
    ELSE '2件以上'
  END AS post_category,
  COUNT(*) AS user_count
FROM (
  SELECT
    u.id,
    COUNT(p.id) AS post_count
  FROM users u
  LEFT JOIN posts p
    ON u.id = p.user_id
  GROUP BY u.id
) t
GROUP BY post_category
ORDER BY post_category;
