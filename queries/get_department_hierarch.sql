WITH RECURSIVE
    department_hierarchy AS (
        -- 初期クエリ：親を持たないトップレベルの部門
        SELECT
            id,
            name,
            1 AS level,
            name AS path
        FROM
            departments
        WHERE
            parent_id IS NULL
        UNION ALL
        -- 再帰クエリ：子部門を取得
        SELECT
            d.id,
            d.name,
            dh.level + 1,
            dh.path || ' > ' || d.name
        FROM
            departments d
            JOIN department_hierarchy dh ON d.parent_id = dh.id
    ) CYCLE id
SET
    is_cycle USING id_path -- 循環参照を検出
    -- 結果出力
SELECT
    *
FROM
    department_hierarchy
ORDER BY
    id_path;
