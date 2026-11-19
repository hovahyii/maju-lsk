USE `majul764_product`;

-- Deploy the four product photos before running this import.
START TRANSACTION;

UPDATE products
SET image_url = CONCAT('products/Frozen Food/French Fries/Starmax/', name, '.webp')
WHERE name IN ('Shoestring Fries', 'Straight Cut Fries', 'Crinkle Fries', 'Seasoned Wedges')
  AND EXISTS (
      SELECT 1 FROM brands b
      WHERE b.id = products.brand_id AND (b.slug = 'starmax' OR b.name = 'Starmax')
  )
  AND EXISTS (
      SELECT 1 FROM categories c
      JOIN subcategories sc ON sc.category_id = c.id
      WHERE c.id = products.category_id AND sc.id = products.subcategory_id
        AND c.slug = 'frozen-food' AND sc.slug = 'french-fries'
  );

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT fries.name,
       CONCAT('products/Frozen Food/French Fries/Starmax/', fries.name, '.webp'),
       catalog.category_id, catalog.subcategory_id, brand.id, 1, fries.sort_order
FROM (
    SELECT MIN(c.id) AS category_id, MIN(sc.id) AS subcategory_id
    FROM categories c
    JOIN subcategories sc ON sc.category_id = c.id
    WHERE c.slug = 'frozen-food' AND sc.slug = 'french-fries'
    HAVING COUNT(*) = 1
) catalog
CROSS JOIN (
    SELECT MIN(id) AS id FROM brands WHERE slug = 'starmax' OR name = 'Starmax'
    HAVING COUNT(*) = 1
) brand
CROSS JOIN (
    SELECT 'Shoestring Fries' AS name, 1 AS sort_order
    UNION ALL SELECT 'Straight Cut Fries', 2
    UNION ALL SELECT 'Crinkle Fries', 3
    UNION ALL SELECT 'Seasoned Wedges', 4
) fries
WHERE NOT EXISTS (
    SELECT 1 FROM products p
    WHERE p.brand_id = brand.id
      AND p.category_id = catalog.category_id
      AND (p.name = fries.name
           OR p.image_url = CONCAT('products/Frozen Food/French Fries/Starmax/', fries.name, '.webp'))
);

COMMIT;

SELECT p.name, p.image_url, p.is_active
FROM products p
JOIN brands b ON b.id = p.brand_id
JOIN categories c ON c.id = p.category_id
JOIN subcategories sc ON sc.id = p.subcategory_id AND sc.category_id = c.id
WHERE (b.slug = 'starmax' OR b.name = 'Starmax')
  AND c.slug = 'frozen-food' AND sc.slug = 'french-fries'
  AND p.name IN ('Shoestring Fries', 'Straight Cut Fries', 'Crinkle Fries', 'Seasoned Wedges')
ORDER BY p.sort_order, p.name;
