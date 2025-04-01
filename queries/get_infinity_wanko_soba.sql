WITH RECURSIVE
    infinity_wanko_soba AS (
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
        WHERE
            ip.id = 3
        UNION ALL
        -- 再帰部分
        SELECT
            iws.purchase_id,
            itr.ingredient_id,
            itr.recipe_id,
            r.name
        FROM
            recipe_to_ingredient rti
            JOIN ingredient_to_recipe itr ON rti.ingredient_id = itr.ingredient_id
            JOIN recipes r ON r.id = itr.recipe_id
            JOIN infinity_wanko_soba iws ON iws.recipe_id = iws.recipe_id
    )
    -- 循環参照を検出
    CYCLE recipe_id
SET
    is_cycle USING path
SELECT
    *
FROM
    infinity_wanko_soba;
