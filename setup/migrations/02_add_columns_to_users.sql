-- 既存カラムの型変更や制約変更
ALTER TABLE users ALTER COLUMN email TYPE VARCHAR(100);

-- 新しいカラムを追加
ALTER TABLE users ADD COLUMN age INT;

ALTER TABLE users ADD COLUMN city TEXT;

-- (初期値あり)
ALTER TABLE users ADD COLUMN is_active BOOLEAN DEFAULT FALSE;