# PostgreSQLで学ぶSQL

このリポジトリは、SQLを理解するために
PostgreSQL + psql を使って学習した記録を残すものです。

## 学習ステップ

- [x] PostgreSQL / psql のセットアップ
- [x] データベース作成・接続
- [x] テーブル作成（DDL）
- [x] INSERT（データ投入）
- [x] CRUD（単一テーブル）
- [x] テーブル定義の変更（ALTER TABLE）
- [x] 既存レコードの補完・修正（UPDATE）
- [ ] 複数テーブル設計（外部キー）
- [ ] JOIN
- [ ] 集計・GROUP BY
- [ ] インデックス & 実行計画

## 前提

- PostgreSQL がローカルにインストールされている
- psql コマンドが使用できる

## PostgreSQL の確認

インストール確認
```bash
$ psql --version
```

（PostgreSQLが入っていない場合）
```bash
$ brew install postgresql
```

起動確認
```bash
$ pg_isready
```
（起動してない場合）
```bash
$ brew services start postgresql
```

## 起動手順

DB作成
```bash
$ createdb sql_practice
```

psql起動
```bash
$ psql sql_practice
```

（psql終了）
```bash
sql_practice=# \q
```

## 構成

- setup/: DB・テーブル定義
- basic/: SQLの基礎

## テーブル作成

テーブル作成
```bash
sql_practice=# \i setup/migrations/01_create_tables.sql
```

テーブル一覧
```bash
sql_practice=# \dt
```

テーブル定義
```bash
sql_practice=# \d users
```

### INSERT（データ投入）

psql の中で INSERT ファイルを実行
```bash
sql_practice=# \i basic/01_insert.sql
```

データの確認
```bash
sql_practice=# SELECT * FROM users;
```

（データがおかしくなった場合はリセット）
```bash
TRUNCATE TABLE users RESTART IDENTITY;
```

### 最新のseedデータをダンプする

学習用に段階的に進めているため、最新版の DB 状態（テーブル構造＋データ）を seed として書き出すには下記を実行します：
```bash
$ pg_dump sql_practice > setup/snapshot/seed.sql
```
- seed.sql を実行すれば、一発でテーブル作成とデータ投入が再現できます
- 学習用に追加した CRUD データも含まれます

### CRUD（単一テーブル）

Create: INSERT 基本
```bash
sql_practice=# \i basic/01_insert.sql
```

Read: SELECT 基本
```bash
sql_practice=# \i basic/02_select.sql
```

Update: UPDATE 基本
```bash
sql_practice=# \i basic/03_update.sql
```

Delte: DELETE 基本
```bash
sql_practice=# \i basic/04_delete.sql
```

### テーブル定義の変更（ALTER TABLE）

テーブルの定義変更を反映
```bash
sql_practice=# \i setup/migrations/02_add_columns_to_users.sql
```

Insert実行
```bash
sql_practice=# \i basic/01_insert.sql
```

Update実行
```bash
sql_practice=# \i basic/03_update.sql
```