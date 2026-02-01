-- ① LEFT JOIN（素の状態）
SELECT
  users.id,
  users.name,
  posts.title
FROM users
LEFT JOIN posts
  ON users.id = posts.user_id;

-- ② LEFT JOIN + WHERE（罠パターン）
SELECT
  users.id,
  users.name,
  posts.title
FROM users
LEFT JOIN posts
  ON users.id = posts.user_id
WHERE posts.title IS NOT NULL;