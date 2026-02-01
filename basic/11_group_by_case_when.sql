-- 条件付き集計（CASE WHEN）

-- ① タイトルあり投稿数
-- has_posts（真偽値フラグ）
SELECT
  u.id,
  u.name,
  COUNT(
    CASE
      WHEN p.title IS NOT NULL THEN 1
    END
  ) AS titled_post_count
FROM users u
LEFT JOIN posts p
  ON u.id = p.user_id
GROUP BY u.id, u.name
ORDER BY u.id;


-- ② ユーザーごとの投稿有無フラグ
-- has_posts（真偽値フラグ）
SELECT
  u.id,
  u.name,
  CASE
    WHEN COUNT(p.id) > 0 THEN TRUE
    ELSE FALSE
  END AS has_posts
FROM users u
LEFT JOIN posts p
  ON u.id = p.user_id
GROUP BY u.id, u.name
ORDER BY u.id;


-- ③ 条件付き件数（特定ワードを含む投稿）
-- keyword_post_count（条件＋文字列）
SELECT
  u.id,
  u.name,
  COUNT(
    CASE
      WHEN p.title LIKE '%投稿%' THEN 1
    END
  ) AS keyword_post_count
FROM users u
LEFT JOIN posts p
  ON u.id = p.user_id
GROUP BY u.id, u.name
ORDER BY u.id;
