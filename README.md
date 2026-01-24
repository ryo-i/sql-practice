# PostgreSQLで学ぶSQL

このリポジトリは、SQLを理解するために
PostgreSQL + psql を使って学習した記録を残すものです。

## 前提

- PostgreSQL がローカルにインストールされている
- psql コマンドが使用できる

## PostgreSQL の確認

インストール確認
```bash
psql --version
```

（PostgreSQLが入っていない場合）
```bash
brew install postgresql
```

起動確認
```bach
pg_isready
```
（起動してない場合）
```
brew services start postgresql
```

## 起動手順

DB作成
```bash
createdb sql_practice
```

psql起動
```bash
psql sql_practice
```

psql終了
```back
\q
```

## 構成

- setup/: DB・テーブル定義
- basic/: SQLの基礎