-- Run against the website catalog database after deploying the Samyang photos.
START TRANSACTION;

INSERT INTO brands (name, slug)
SELECT 'Samyang', 'samyang'
WHERE NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'samyang' OR LOWER(name) = 'samyang');

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, item.image_url, c.id, sc.id, brand.id, 1, item.sort_order
FROM (
    SELECT 'instant-food' AS category_slug, 'instant-noodles' AS subcategory_slug, 'Chacharoni' AS name, 'products/Instant Food/Instant Noodles/Samyang/Chacharoni.webp' AS image_url, 1 AS sort_order
    UNION ALL SELECT 'instant-food', 'instant-noodles', 'Kimchi Ramen', 'products/Instant Food/Instant Noodles/Samyang/Kimchi Ramen.webp', 2
    UNION ALL SELECT 'cooking-ingredients', 'pasta', 'Tangle Creamy Mushroom Pasta (Multipack)', 'products/Cooking Ingredients/Pasta/Samyang/Tangle Creamy Mushroom Pasta (Multipack).webp', 3
    UNION ALL SELECT 'cooking-ingredients', 'pasta', 'Tangle Creamy Mushroom Pasta (Bowl)', 'products/Cooking Ingredients/Pasta/Samyang/Tangle Creamy Mushroom Pasta (Bowl).webp', 4
    UNION ALL SELECT 'cooking-ingredients', 'pasta', 'Tangle Garlic Oil Pasta (Multipack)', 'products/Cooking Ingredients/Pasta/Samyang/Tangle Garlic Oil Pasta (Multipack).webp', 5
    UNION ALL SELECT 'cooking-ingredients', 'pasta', 'Tangle Garlic Oil Pasta (Bowl)', 'products/Cooking Ingredients/Pasta/Samyang/Tangle Garlic Oil Pasta (Bowl).webp', 6
    UNION ALL SELECT 'cooking-ingredients', 'sauce', 'Hot Chicken Carbo Buldak Sauce', 'products/Cooking Ingredients/Sauce/Samyang/Hot Chicken Carbo Buldak Sauce.webp', 7
    UNION ALL SELECT 'cooking-ingredients', 'sauce', 'Hot Chicken Buldak Sauce (2 kg Pouch)', 'products/Cooking Ingredients/Sauce/Samyang/Hot Chicken Buldak Sauce (2 kg Pouch).webp', 8
) item
JOIN categories c ON CONVERT(c.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.category_slug
JOIN subcategories sc ON sc.category_id = c.id
    AND CONVERT(sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.subcategory_slug
CROSS JOIN (
    SELECT MIN(id) AS id FROM brands
    WHERE slug = 'samyang' OR LOWER(name) = 'samyang'
    HAVING COUNT(*) = 1
) brand
WHERE NOT EXISTS (
    SELECT 1 FROM products p
    WHERE p.brand_id = brand.id AND p.subcategory_id = sc.id
      AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
);

COMMIT;
