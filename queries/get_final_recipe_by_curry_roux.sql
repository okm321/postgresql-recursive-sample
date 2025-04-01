WITH RECURSIVE
    recipe_finder AS (
        -- 初期クエリ
        SELECT
            ip.id purchase_id,
            ip.ingredient_id ingredient_id,
            itr.recipe_id recipe_id,
            r.name
        FROM
            ingredient_purchases ip
            JOIN ingredient_to_recipe itr ON ip.ingredient_id = itr.ingredient_id
            JOIN recipes r ON itr.recipe_id = r.id
        UNION ALL
        -- 再帰部分
        SELECT
            rf.purchase_id,
            itr.ingredient_id,
            itr.recipe_id,
            r.name
        FROM
            recipe_to_ingredient rti
            JOIN ingredient_to_recipe itr ON rti.ingredient_id = itr.ingredient_id
            JOIN recipes r ON r.id = itr.recipe_id
            JOIN recipe_finder rf ON rf.recipe_id = rti.recipe_id
    )
    -- 探索順序を記録
    SEARCH DEPTH FIRST BY recipe_id
SET
    ordercol
    -- 循環参照を検出
    CYCLE recipe_id
SET
    is_cycle USING path,
    -- 各purchase_idごとに最も深い階層のレコードを取得するサブクエリ
    latest_recipes AS (
        SELECT DISTINCT
            ON (purchase_id) purchase_id,
            ingredient_id,
            recipe_id,
            name,
            ordercol,
            is_cycle,
            path
        FROM
            recipe_finder
        ORDER BY
            purchase_id,
            ordercol DESC -- 同じ深さなら探索順の降順
    )
SELECT
    *
FROM
    latest_recipes
ORDER BY
    purchase_id;
