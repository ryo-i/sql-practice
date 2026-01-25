-- ========================================
-- DELETE 基本
-- ========================================

-- DELETE文の基本構文
-- DELETE FROM [table_name]
-- WHERE [条件];

-- 特定レコード削除
DELETE FROM users
WHERE id = 2;

-- 削除後確認
SELECT * FROM users;