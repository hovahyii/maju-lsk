-- Run against the website catalog database after deploying the Miga photos.
START TRANSACTION;

SET @miga_snacks_id = (
    SELECT MIN(sc.id)
    FROM subcategories sc
    JOIN categories c ON c.id = sc.category_id
    WHERE c.slug = 'instant-food' AND sc.slug = 'snacks'
    HAVING COUNT(*) = 1
);

INSERT INTO brands (name, slug)
SELECT 'Miga', 'miga'
WHERE @miga_snacks_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'miga' OR LOWER(name) = 'miga');

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Instant Food/Snacks/Miga/', item.name, '.webp'),
       sc.category_id, sc.id, brand.id, 1, item.sort_order
FROM subcategories sc
CROSS JOIN (
    SELECT MIN(id) AS id FROM brands
    WHERE slug = 'miga' OR LOWER(name) = 'miga'
    HAVING COUNT(*) = 1
) brand
CROSS JOIN (
    SELECT 'Chu Luv Toppoki (Original Flavor)' AS name, 1 AS sort_order
    UNION ALL SELECT 'Chu Luv Toppoki (Pink Rose Spicy Carbonara)', 2
    UNION ALL SELECT 'Chu Luv Toppoki (Fiery Hot)', 3
    UNION ALL SELECT 'Chu Luv Toppoki (Cheese)', 4
    UNION ALL SELECT 'Chu Luv Toppoki (Jjajang)', 5
) item
WHERE sc.id = @miga_snacks_id
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = brand.id
        AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
  );

COMMIT;
