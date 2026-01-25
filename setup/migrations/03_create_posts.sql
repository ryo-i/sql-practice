-- ========================================
-- FOREIGN KEY（外部キー）基本構文
-- ========================================
--
-- 外部キー制約は、あるテーブルのカラムが他のテーブルの主キー（またはユニークキー）を参照することを保証します。
-- データの整合性を保つために使用されます。
--
-- 基本構文：
-- CREATE TABLE [child_table] (
--   ...
--   [column_name] [type],
--   FOREIGN KEY ([column_name]) REFERENCES [parent_table]([parent_column])
-- );


-- postsテーブルを作成（users.id を参照する外部キーあり）
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    title TEXT NOT NULL,
    content TEXT,
    created_at TIMESTAMP DEFAULT now(),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 外部キー制約により以下が保証される
-- ・存在しない user_id を posts に入れられない
-- ・投稿が存在する user は削除できない（RESTRICT）
-- JOIN の前提となる参照整合性をDBが担保している