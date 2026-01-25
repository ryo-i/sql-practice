-- ========================================
-- INSERT 別テーブルへの挿入（学習用）
-- ========================================

-- postsにデータを追加
INSERT INTO posts (user_id, title, content) VALUES
(1, '初めての投稿', 'Alice の最初の投稿です'),
(2, 'Bobの日記', 'Bob が書いた投稿です'),
(1, 'Aliceの2つ目の投稿', 'Alice の追加の投稿');

-- 挿入後確認
SELECT * FROM posts;