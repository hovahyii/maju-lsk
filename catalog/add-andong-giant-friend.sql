-- Run against the website catalog database after deploying the Giant Friend photos.
START TRANSACTION;

SET @giant_friend_cooking_id = (
    SELECT MIN(id) FROM categories WHERE slug = 'cooking-ingredients'
    HAVING COUNT(*) = 1
);

INSERT INTO subcategories (category_id, name, slug)
SELECT @giant_friend_cooking_id, 'Ice Cream Powder', 'ice-cream-powder'
WHERE @giant_friend_cooking_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM subcategories
      WHERE category_id = @giant_friend_cooking_id AND slug = 'ice-cream-powder'
  );

INSERT INTO brands (name, slug)
SELECT 'Giant Friend', 'giant-friend'
WHERE @giant_friend_cooking_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'giant-friend' OR LOWER(name) = 'giant friend');

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Cooking Ingredients/Ice Cream Powder/Giant Friend/', item.name, '.webp'),
       sc.category_id, sc.id, brand.id, 1, item.sort_order
FROM subcategories sc
CROSS JOIN (
    SELECT MIN(id) AS id FROM brands
    WHERE slug = 'giant-friend' OR LOWER(name) = 'giant friend'
    HAVING COUNT(*) = 1
) brand
CROSS JOIN (
    SELECT 'Soft Serve Ice Cream Powder - Sea Salt' AS name, 1 AS sort_order
    UNION ALL SELECT 'Soft Serve Ice Cream Powder - Taro', 2
    UNION ALL SELECT 'Soft Serve Ice Cream Powder - Chocolate', 3
    UNION ALL SELECT 'Soft Serve Ice Cream Powder - Yogurt', 4
    UNION ALL SELECT 'Soft Serve Ice Cream Powder - Vanilla', 5
) item
WHERE sc.category_id = @giant_friend_cooking_id AND sc.slug = 'ice-cream-powder'
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = brand.id AND p.subcategory_id = sc.id
        AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
  );

COMMIT;
