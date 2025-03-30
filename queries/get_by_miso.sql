WITH RECURSIVE
    recipe_finder AS (
        -- 初期クエリ
        SELECT
            ip.ingredient_id ingredient_id,
            itr.recipe_id recipe_id,
            r.name,
            1 AS depth
        FROM
            ingredient_purchases ip
            JOIN ingredient_to_recipe itr ON ip.ingredient_id = itr.ingredient_id
            JOIN recipes r ON itr.recipe_id = r.id
        WHERE
            ip.id = 1
        UNION ALL
        -- 再帰部分
        SELECT
            itr.ingredient_id,
            itr.recipe_id,
            r.name,
            rf.depth + 1
        FROM
            recipe_to_ingredient rti
            JOIN ingredient_to_recipe itr ON rti.ingredient_id = itr.ingredient_id
            JOIN recipes r ON r.id = itr.recipe_id
            JOIN recipe_finder rf ON rf.recipe_id = rti.recipe_id
    )
SELECT
    *
FROM
    recipe_finder
