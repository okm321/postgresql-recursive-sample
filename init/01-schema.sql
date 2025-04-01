-- ── 材料の例 ────────────────────────────────────────────────────────
-- 材料テーブル
CREATE TABLE ingredients (id SERIAL PRIMARY KEY, name TEXT NOT NULL);

-- レシピテーブル
CREATE TABLE recipes (id SERIAL PRIMARY KEY, name TEXT NOT NULL);

-- 材料購入テーブル
CREATE TABLE ingredient_purchases (
    id SERIAL PRIMARY KEY,
    ingredient_id INT NOT NULL,
    purchase_date DATE NOT NULL,
    CONSTRAINT fk_ingredient FOREIGN KEY (ingredient_id) REFERENCES ingredients (id) ON DELETE CASCADE
);

-- 材料からレシピの履歴テーブル
CREATE TABLE ingredient_to_recipe_logs (
    id SERIAL PRIMARY KEY,
    ingredient_id INT NOT NULL,
    recipe_id INT NOT NULL,
    CONSTRAINT fk_ingredient FOREIGN KEY (ingredient_id) REFERENCES ingredients (id) ON DELETE CASCADE,
    CONSTRAINT fk_recipe FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE
);

-- レシピから材料の履歴テーブル
CREATE TABLE recipe_to_ingredient_logs (
    id SERIAL PRIMARY KEY,
    recipe_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    CONSTRAINT fk_recipe FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE,
    CONSTRAINT fk_ingredient FOREIGN KEY (ingredient_id) REFERENCES ingredients (id) ON DELETE CASCADE
);

-- ── 組織の例 ────────────────────────────────────────────────────────
-- 組織テーブル
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    parent_id INT,
    CONSTRAINT fk_parent_id FOREIGN KEY (parent_id) REFERENCES departments (id) ON DELETE CASCADE
);
