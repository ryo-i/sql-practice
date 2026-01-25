# PostgreSQLで学ぶSQL

このリポジトリは、SQLを理解するために
PostgreSQL + psql を使って学習した記録を残すものです。

## 学習ステップ

- [x] PostgreSQL / psql のセットアップ
- [x] データベース作成・接続
- [x] テーブル作成（DDL）
- [ ] INSERT（データ投入）
- [ ] CRUD（単一テーブル）
- [ ] テーブル定義の変更（ALTER TABLE）
- [ ] 既存レコードの補完・修正（UPDATE）
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
```bach
$ pg_isready
```
（起動してない場合）
```
$ brew services start postgresql
```

## 起動手順

DB作成
```bash
sql_practice=# createdb sql_practice
```

psql起動
```bash
sql_practice=# psql sql_practice
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

### 最新のDBスキーマをダンプする

migrationsに段階的にDBを定義していくため、DBの最新版のスキーマを取得する

（psqlを開いている場合は一度閉じてターミナルで実行）
```bash
$ pg_dump -s sql_practice > setup/snapshot/schema_latest_dump.sql
```