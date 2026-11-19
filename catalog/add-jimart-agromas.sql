-- Run against the website catalog database after deploying the AgroMas photos.
START TRANSACTION;

INSERT INTO subcategories (category_id, name, slug)
SELECT c.id, 'Spreads', 'spreads'
FROM categories c
WHERE c.slug = 'cooking-ingredients'
  AND NOT EXISTS (
      SELECT 1 FROM subcategories sc WHERE sc.category_id = c.id AND sc.slug = 'spreads'
  );

INSERT INTO brands (name, slug)
SELECT 'AgroMas', 'agromas'
WHERE NOT EXISTS (SELECT 1 FROM brands WHERE slug IN ('agromas', 'agro-mas') OR LOWER(name) = 'agromas');

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, item.image_url, c.id, sc.id, brand.id, 1, item.sort_order
FROM (
    SELECT 'cooking-ingredients' AS category_slug, 'spreads' AS subcategory_slug, 'Seri Kaya Dengan Madu' AS name, 'products/Cooking Ingredients/Spreads/AgroMas/Seri Kaya Dengan Madu.webp' AS image_url, 1 AS sort_order
    UNION ALL SELECT 'cooking-ingredients', 'spreads', 'Seri Kaya Pandan Coconut', 'products/Cooking Ingredients/Spreads/AgroMas/Seri Kaya Pandan Coconut.webp', 2
    UNION ALL SELECT 'cooking-ingredients', 'spreads', 'Seri Kaya Gula Melaka', 'products/Cooking Ingredients/Spreads/AgroMas/Seri Kaya Gula Melaka.webp', 3
    UNION ALL SELECT 'cooking-ingredients', 'sauce', 'Kuah Rojak Dengan Madu', 'products/Cooking Ingredients/Sauce/AgroMas/Kuah Rojak Dengan Madu.webp', 4
    UNION ALL SELECT 'beverage', 'coffee', 'Premix Coffee Habbatus Sauda (4 in 1)', 'products/Beverage/Coffee/AgroMas/Premix Coffee Habbatus Sauda (4 in 1).webp', 5
    UNION ALL SELECT 'beverage', 'coffee', 'Premix White Coffee', 'products/Beverage/Coffee/AgroMas/Premix White Coffee.webp', 6
    UNION ALL SELECT 'beverage', 'coffee', 'Premix Tongkat Ali Coffee (4 in 1)', 'products/Beverage/Coffee/AgroMas/Premix Tongkat Ali Coffee (4 in 1).webp', 7
    UNION ALL SELECT 'cooking-ingredients', 'protein', 'Chicken Floss', 'products/Cooking Ingredients/Protein/AgroMas/Chicken Floss.webp', 8
    UNION ALL SELECT 'cooking-ingredients', 'protein', 'Beef Floss', 'products/Cooking Ingredients/Protein/AgroMas/Beef Floss.webp', 9
) item
JOIN categories c ON CONVERT(c.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.category_slug
JOIN subcategories sc ON sc.category_id = c.id
    AND CONVERT(sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.subcategory_slug
CROSS JOIN (
    SELECT MIN(id) AS id FROM brands
    WHERE slug IN ('agromas', 'agro-mas') OR LOWER(name) = 'agromas'
    HAVING COUNT(*) = 1
) brand
WHERE NOT EXISTS (
    SELECT 1 FROM products p
    WHERE p.brand_id = brand.id AND p.subcategory_id = sc.id
      AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
);

COMMIT;
