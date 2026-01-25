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

-- 既存レコードの補完例
-- id=1 Alice, id=2 Bob, id=3 Carol に対して補完

-- 年齢を仮に設定
UPDATE users
SET age = 25
WHERE id = 1;

UPDATE users
SET age = 30
WHERE id = 2;

UPDATE users
SET age = 28
WHERE id = 3;

-- city を補完（今回は Tokyo 以外も仮に設定）
UPDATE users
SET city = 'Tokyo'
WHERE id = 1;

UPDATE users
SET city = 'Osaka'
WHERE id = 2;

UPDATE users
SET city = 'Nagoya'
WHERE id = 3;

-- is_active はデフォルト FALSE が入っているので更新不要だが、
-- 学習用に全員 TRUE に変更してみる例
UPDATE users
SET is_active = TRUE;

-- 更新後確認
SELECT * FROM users;