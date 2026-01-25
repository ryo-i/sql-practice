-- ========================================
-- SELECT 基本
-- ========================================

-- SELECT文の基本構文
-- SELECT [column1], [column2], ...
-- FROM [table_name]
-- WHERE [条件];

-- 全件取得
SELECT * FROM users;

-- 特定カラムのみ
SELECT id, name, email FROM users;

-- 条件付き検索
SELECT *
FROM users
WHERE email = 'alice@example.com';

-- 並び替え
SELECT *
FROM users
ORDER BY created_at DESC;

-- 件数制限
SELECT *
FROM users
ORDER BY id
LIMIT 2;