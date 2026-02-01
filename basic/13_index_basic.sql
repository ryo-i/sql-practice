-- インデックスの基本（何に・なぜ貼るか）

-- ① インデックスなしで JOIN を使う SELECT
-- 投稿一覧 + ユーザー名
SELECT
  p.id,
  p.title,
  u.name
FROM posts p
INNER JOIN users u
  ON p.user_id = u.id
ORDER BY p.id;


-- ② WHERE で user_id を絞る（よくあるクエリ）
SELECT
  p.id,
  p.title
FROM posts p
WHERE p.user_id = 1;


-- ③ posts.user_id にインデックスを貼る
-- JOIN / WHERE 両方で使われる
CREATE INDEX idx_posts_user_id
ON posts(user_id);


-- ④ 同じ SELECT をもう一度（結果は変わらない）
SELECT
  p.id,
  p.title
FROM posts p
WHERE p.user_id = 1;


-- ⑤ created_at にもインデックスを貼ってみる
-- ORDER BY 用
CREATE INDEX idx_posts_created_at
ON posts(created_at);


-- ⑥ 並び替えクエリ
SELECT
  id,
  title,
  created_at
FROM posts
ORDER BY created_at DESC;
