-- ========================================
-- INSERT 基本（学習用）
-- 毎回同じ結果になるよう、事前にリセットする
-- ========================================

-- 学習用リセット（本来はリセットしない）
TRUNCATE TABLE users RESTART IDENTITY;

-- INSERT文の基本構文
-- INSERT INTO [table_name] ([column1], [column2], ...)
-- VALUES ([value1], [value2], ...);

INSERT INTO users (name, email)
VALUES
  ('Alice', 'alice@example.com'),
  ('Bob',   'bob@example.com'),
  ('Carol', 'carol@example.com');

-- 挿入後確認
SELECT * FROM users;