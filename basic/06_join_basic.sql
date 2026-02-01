-- =========================
-- INNER JOIN
-- 紐づくレコードだけ取得
-- =========================
SELECT
  users.id,
  users.name,
  posts.title
FROM users
INNER JOIN posts
  ON users.id = posts.user_id;


-- =========================
-- LEFT JOIN
-- users を基準に全件取得
-- =========================
SELECT
  users.id,
  users.name,
  posts.title
FROM users
LEFT JOIN posts
  ON users.id = posts.user_id;
