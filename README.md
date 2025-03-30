# PostgreSQL RECURSIVE句サンプル

## 概要

PostgreSQLの`WITH RECURSIVE`句を使った再帰クエリのサンプルです。購入した材料が最終的にどのレシピに使われいるかを再帰的に取得するクエリを実行します。

## 構成

```bash
├── docker-compose.yml
├── init
│   ├── 01-schema.sql
│   └── 02-sample-data.sql
└── queries
    ├── get_by_curry_roux.sql （カレールーが使われたレシピを再起的に取得するクエリ）
    ├── get_by_miso.sql （味噌が使われたレシピを再起的に取得するクエリ）
    └── get_final_recipe_by_curry_roux.sql（カレールーが使われた最終的なレシピを再起的に取得するクエリ）
```

## 実行方法

### 1. Dockerコンテナの起動

```bash
docker compose up -d
```

### 2. DB接続

```bash
pgcli -U postgres -h 127.0.0.1 -p 5400 -d recursive-query-db

password: postgres
```

### 3. クエリの実行

```bash
\i queries/get_by_curry_roux.sql
\i queries/get_by_miso.sql
\i queries/get_final_recipe_by_curry_roux.sql
```

## テーブル構造

### ingredients(材料)

- id
- name

### recipes(レシピ)

- id
- name

### ingredient_purchases(材料購入)

- id
- ingredient_id
- purchase_date

### ingredient_to_recipe(材料からレシピの記録)

- id
- ingredient_id
- recipe_id

### recipe_to_ingredinet(レシピから材料の記録)

- id
- recipe_id
- ingredient_id
