-- CREATE TABLE文の基本構文
-- CREATE TABLE [table_name] (
--   [column1] [type1] [constraint],
--   [column2] [type2] [constraint],
--   ...
-- );

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT now()
);
