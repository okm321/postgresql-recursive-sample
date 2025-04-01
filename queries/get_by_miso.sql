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
            JOIN ingredient_to_recipe_logs itr ON ip.ingredient_id = itr.ingredient_id
            JOIN recipes r ON itr.recipe_id = r.id
        WHERE
            ip.id = 1
        UNION ALL
        -- 再帰部分
        SELECT
            rf.purchase_id,
            itr.ingredient_id,
            itr.recipe_id,
            r.name
        FROM
            recipe_to_ingredient_logs rti
            JOIN ingredient_to_recipe_logs itr ON rti.ingredient_id = itr.ingredient_id
            JOIN recipes r ON r.id = itr.recipe_id
            JOIN recipe_finder rf ON rf.recipe_id = rti.recipe_id
    )
    -- 探索順序を記録
    SEARCH DEPTH FIRST BY purchase_id
SET
    ordercol
    -- 循環参照を検出
    CYCLE recipe_id
SET
    is_cycle USING path
SELECT
    *
FROM
    recipe_finder
