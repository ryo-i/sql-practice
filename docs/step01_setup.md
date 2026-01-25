# Step 1: PostgreSQLセットアップとテーブル作成

## PostgreSQLのインストール・起動

```bash
$ brew install postgresql
$ brew services start postgresql
$ pg_isready
/tmp:5432 - accepting connections
```

## データベース作成・接続

```bash
$ createdb sql_practice
$ psql sql_practice
psql (14.20 (Homebrew))
Type "help" for help.

sql_practice=#
```

## テーブル作成

```sql
sql_practice=# \i setup/migrations/01_create_tables.sql
CREATE TABLE
sql_practice=# \dt
         List of relations
 Schema | Name  | Type  |  Owner   
--------+-------+-------+----------
 public | users | table | iidaryou
(1 row)

sql_practice=# \d users
                                        Table "public.users"
   Column   |            Type             | Collation | Nullable |              Default              
------------+-----------------------------+-----------+----------+-----------------------------------
 id         | integer                     |           | not null | nextval('users_id_seq'::regclass)
 name       | text                        |           | not null | 
 email      | text                        |           | not null | 
 created_at | timestamp without time zone |           |          | now()
Indexes:
    "users_pkey" PRIMARY KEY, btree (id)
    "users_email_key" UNIQUE CONSTRAINT, btree (email)
```

## スキーマダンプ

```bash
$ pg_dump -s sql_practice > setup/snapshot/schema_latest_dump.sql
```
