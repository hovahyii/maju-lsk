-- Run against the website catalog database after deploying the product images.
USE `majul764_product`;

START TRANSACTION;

UPDATE products
SET name = REPLACE(REPLACE(REPLACE(name, 'Starmax Gold ', ''), ' (425g)', ''), ' (340g)', '')
WHERE name IN (
    'Starmax Gold Whole Kernel Golden Sweet Corn, Brine Packed (425g)',
    'Starmax Gold Cream Style Cream Corn, Picked & Pureed (425g)',
    'Starmax Gold Whole Kernel Golden Sweet Corn, Vacuum Packed (340g)'
)
AND EXISTS (
    SELECT 1 FROM brands b
    WHERE b.id = products.brand_id AND (b.slug = 'starmax' OR b.name = 'Starmax')
)
AND EXISTS (
    SELECT 1 FROM categories c
    JOIN subcategories sc ON sc.category_id = c.id
    WHERE c.id = products.category_id AND sc.id = products.subcategory_id
      AND c.slug = 'instant-food' AND sc.slug = 'canned-food'
);

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT corn.name,
       CONCAT('products/Instant Food/Canned Food/Starmax/', corn.filename, '.webp'),
       catalog.category_id, catalog.subcategory_id, brand.id, 1, corn.sort_order
FROM (
    SELECT MIN(c.id) AS category_id, MIN(sc.id) AS subcategory_id
    FROM categories c
    JOIN subcategories sc ON sc.category_id = c.id
    WHERE c.slug = 'instant-food' AND sc.slug = 'canned-food'
    HAVING COUNT(*) = 1
) catalog
CROSS JOIN (
    SELECT MIN(id) AS id FROM brands WHERE slug = 'starmax' OR name = 'Starmax'
    HAVING COUNT(*) = 1
) brand
CROSS JOIN (
    SELECT 'Whole Kernel Golden Sweet Corn, Brine Packed' AS name,
           'Whole Kernel Golden Sweet Corn - Brine Packed (425g)' AS filename,
           1 AS sort_order
    UNION ALL
    SELECT 'Cream Style Cream Corn, Picked & Pureed',
           'Cream Style Cream Corn (425g)', 2
    UNION ALL
    SELECT 'Whole Kernel Golden Sweet Corn, Vacuum Packed',
           'Whole Kernel Golden Sweet Corn - Vacuum Packed (340g)', 3
) corn
WHERE NOT EXISTS (
    SELECT 1 FROM products p WHERE p.brand_id = brand.id AND p.name = corn.name
);

COMMIT;

-- Expect three active rows under the existing Starmax brand.
SELECT b.name AS brand, p.name AS product, p.image_url, p.is_active
FROM products p
JOIN brands b ON b.id = p.brand_id
JOIN categories c ON c.id = p.category_id
JOIN subcategories sc ON sc.id = p.subcategory_id AND sc.category_id = c.id
WHERE (b.slug = 'starmax' OR b.name = 'Starmax')
  AND c.slug = 'instant-food' AND sc.slug = 'canned-food'
  AND p.name IN (
      'Whole Kernel Golden Sweet Corn, Brine Packed',
      'Cream Style Cream Corn, Picked & Pureed',
      'Whole Kernel Golden Sweet Corn, Vacuum Packed'
  )
ORDER BY p.sort_order, p.name;
