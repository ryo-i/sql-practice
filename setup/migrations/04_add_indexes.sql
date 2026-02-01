-- ============================================
-- 04_add_indexes.sql
-- インデックス追加用 migration
-- ============================================

-- インデックスは検索や集計などのパフォーマンスを向上させるために使用します。
-- 基本構文：
-- CREATE INDEX [index_name] ON [table_name]([column1], ...);
-- DROP INDEX [index_name];

-- ■ 実行タイミング
-- basic/13_index_basic.sql や EXPLAIN による検証で
-- 効果が確認できたインデックスのみ実行

-- ■ 役割
-- basic/*.sql           : 学習・実験用
-- setup/migrations/*.sql: 本番構造として確定した定義


-- posts.user_id で JOIN / 集計が多い
CREATE INDEX idx_posts_user_id
ON posts(user_id);

-- 日付順ソート・期間絞り込み用
CREATE INDEX idx_posts_created_at
ON posts(created_at);
