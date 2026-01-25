-- ========================================
-- UPDATE 基本
-- ========================================

-- UPDATE文の基本構文
-- UPDATE [table_name]
-- SET [column1] = [value1], [column2] = [value2], ...
-- WHERE [条件];

-- id指定で名前を変更
UPDATE users
SET name = 'Alice Cooper'
WHERE id = 1;

-- emailで条件指定
UPDATE users
SET email = 'alice.cooper@example.com'
WHERE email = 'alice@example.com';

-- 更新後確認
SELECT * FROM users;