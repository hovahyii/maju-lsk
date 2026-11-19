-- Run against the website catalog database after deploying the Mamaku photos.
START TRANSACTION;

SET @mamaku_frozen_food_id = (
    SELECT MIN(id) FROM categories WHERE slug = 'frozen-food'
    HAVING COUNT(*) = 1
);

INSERT INTO subcategories (category_id, name, slug)
SELECT @mamaku_frozen_food_id, 'Snack', 'snack'
WHERE @mamaku_frozen_food_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM subcategories
      WHERE category_id = @mamaku_frozen_food_id AND slug = 'snack'
  );

INSERT INTO brands (name, slug)
SELECT 'Mamaku', 'mamaku'
WHERE @mamaku_frozen_food_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'mamaku' OR LOWER(name) = 'mamaku');

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Frozen Food/Snack/Mamaku/', item.name, '.webp'),
       sc.category_id, sc.id, brand.id, 1, item.sort_order
FROM subcategories sc
CROSS JOIN (
    SELECT MIN(id) AS id FROM brands
    WHERE slug = 'mamaku' OR LOWER(name) = 'mamaku'
    HAVING COUNT(*) = 1
) brand
CROSS JOIN (
    SELECT 'Korean Corn Sausage' AS name, 1 AS sort_order
    UNION ALL SELECT 'Korean Corn Sausage Cheese', 2
    UNION ALL SELECT 'Korean Corn Cheese', 3
    UNION ALL SELECT 'Korean Corn Sausage Cheese Potato', 4
    UNION ALL SELECT 'Korean Corn Sausage Cheese Noodles', 5
) item
WHERE sc.category_id = @mamaku_frozen_food_id AND sc.slug = 'snack'
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = brand.id AND p.subcategory_id = sc.id
        AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
  );

COMMIT;
