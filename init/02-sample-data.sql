-- ── 材料の例 ────────────────────────────────────────────────────────
-- 材料
INSERT INTO
    ingredients (id, name)
VALUES
    (1, '味噌'),
    (101, 'カレールー'),
    (102, 'カレー'),
    (103, 'うどん');

-- レシピ
INSERT INTO
    recipes (id, name)
VALUES
    (1, '味噌汁'),
    (101, 'カレー'),
    (102, 'カレーうどん'),
    (103, 'お好み焼き');

-- 材料購入
INSERT INTO
    ingredient_purchases (id, ingredient_id, purchase_date)
VALUES
    (1, 1, '2020-01-01'),
    (2, 101, '2020-02-01');

-- 材料からレシピ
INSERT INTO
    ingredient_to_recipe (id, ingredient_id, recipe_id)
VALUES
    (1, 1, 1),
    (2, 101, 101),
    (3, 102, 102),
    (4, 103, 103);

-- レシピから材料
INSERT INTO
    recipe_to_ingredient (id, recipe_id, ingredient_id)
VALUES
    (1, 101, 102),
    (2, 102, 103);

-- ── 組織の例 ────────────────────────────────────────────────────────
-- 組織
INSERT INTO
    departments (id, name, parent_id)
VALUES
    (1, '人事部', NULL),
    (2, '開発本部', NULL),
    (3, 'バックエンド開発部', 2),
    (4, 'フロントエンド開発部', 2),
    (5, 'APIチーム', 3),
    (6, 'UIチーム', 4);
