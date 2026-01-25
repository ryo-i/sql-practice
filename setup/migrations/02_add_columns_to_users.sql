-- ALTER TABLE文の基本構文

-- 【カラム追加】
-- ALTER TABLE [table_name]
--   ADD COLUMN [column_name] [type] [constraint];

-- 【カラム削除】
-- ALTER TABLE [table_name]
--   DROP COLUMN [column_name];

-- 【カラム型変更】
-- ALTER TABLE [table_name]
--   ALTER COLUMN [column_name] TYPE [new_type];

-- 既存カラムの型変更や制約変更
ALTER TABLE users ALTER COLUMN email TYPE VARCHAR(100);

-- 新しいカラムを追加
ALTER TABLE users ADD COLUMN age INT;

ALTER TABLE users ADD COLUMN city TEXT;

-- (初期値あり)
ALTER TABLE users ADD COLUMN is_active BOOLEAN DEFAULT FALSE;