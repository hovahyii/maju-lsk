-- Run against the website catalog database after deploying the product images.
-- The existing Fats > Cooking Oil category must resolve to exactly one row.
START TRANSACTION;

SET @cooking_oil_category_count = (
    SELECT COUNT(*)
    FROM categories c
    JOIN subcategories sc ON sc.category_id = c.id
    WHERE c.slug = 'fats' AND sc.slug = 'cooking-oil'
);

INSERT INTO brands (name, slug)
SELECT incoming.name, incoming.slug
FROM (
    SELECT 'Reiser' AS name, 'reiser' AS slug
    UNION ALL SELECT 'Twin Leaves', 'twin-leaves'
) incoming
WHERE @cooking_oil_category_count = 1
  AND NOT EXISTS (
      SELECT 1 FROM brands b
      WHERE b.slug = incoming.slug OR b.name = incoming.name
  );

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT CONCAT(oil.brand_name, ' Cooking Oil (', pack.size_label, ')'),
       CONCAT('products/Fats/Cooking Oil/', oil.brand_name, '/Cooking Oil (', pack.size_label, ').webp'),
       c.id, sc.id, oil.brand_id, 1, pack.sort_order
FROM categories c
JOIN subcategories sc ON sc.category_id = c.id
CROSS JOIN (
    SELECT 'Reiser' AS brand_name, MIN(id) AS brand_id
    FROM brands WHERE slug = 'reiser' OR name = 'Reiser'
    HAVING COUNT(*) = 1
    UNION ALL
    SELECT 'Twin Leaves', MIN(id)
    FROM brands WHERE slug = 'twin-leaves' OR name = 'Twin Leaves'
    HAVING COUNT(*) = 1
) oil
CROSS JOIN (
    SELECT '1.7L' AS size_label, 1 AS sort_order
    UNION ALL SELECT '5L', 2
    UNION ALL SELECT '17L', 3
) pack
WHERE @cooking_oil_category_count = 1
  AND c.slug = 'fats'
  AND sc.slug = 'cooking-oil'
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = oil.brand_id
        AND p.name = CONCAT(oil.brand_name, ' Cooking Oil (', pack.size_label, ')')
  );

COMMIT;

-- Expect six active rows, three for each brand.
SELECT b.name AS brand, p.name AS product, p.image_url, p.is_active
FROM products p
JOIN brands b ON b.id = p.brand_id
JOIN categories c ON c.id = p.category_id
JOIN subcategories sc ON sc.id = p.subcategory_id AND sc.category_id = c.id
WHERE c.slug = 'fats'
  AND sc.slug = 'cooking-oil'
  AND p.name IN (
      'Reiser Cooking Oil (1.7L)', 'Reiser Cooking Oil (5L)', 'Reiser Cooking Oil (17L)',
      'Twin Leaves Cooking Oil (1.7L)', 'Twin Leaves Cooking Oil (5L)', 'Twin Leaves Cooking Oil (17L)'
  )
ORDER BY b.name, p.sort_order, p.name;
