-- Run against the website catalog database after deploying the Maeil images.
START TRANSACTION;

SET @coffee_category_count = (
    SELECT COUNT(*)
    FROM categories c
    JOIN subcategories sc ON sc.category_id = c.id
    WHERE c.slug = 'beverage' AND sc.slug = 'coffee'
);

INSERT INTO brands (name, slug)
SELECT 'Maeil', 'maeil'
WHERE @coffee_category_count = 1
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'maeil' OR name = 'Maeil');

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT coffee.name, CONCAT('products/Beverage/Coffee/Maeil/', coffee.name, '.webp'),
       c.id, sc.id, brand.id, 1, coffee.sort_order
FROM categories c
JOIN subcategories sc ON sc.category_id = c.id
CROSS JOIN (
    SELECT MIN(id) AS id FROM brands
    WHERE slug = 'maeil' OR name = 'Maeil'
    HAVING COUNT(*) = 1
) brand
CROSS JOIN (
    SELECT 'Barista Rules Lower Sugar Espresso Latte' AS name, 1 AS sort_order
    UNION ALL SELECT 'Barista Rules Mocha Presso', 2
    UNION ALL SELECT 'Barista Rules Espresso Latte', 3
    UNION ALL SELECT 'Barista Rules Caramel Deep Presso', 4
    UNION ALL SELECT 'Barista Rules Smoky Roasting Latte', 5
) coffee
WHERE @coffee_category_count = 1
  AND c.slug = 'beverage' AND sc.slug = 'coffee'
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = brand.id AND p.name = coffee.name
  );

COMMIT;

-- Expect five active Barista Rules coffees.
SELECT p.name, p.image_url, p.is_active
FROM products p
JOIN brands b ON b.id = p.brand_id
JOIN categories c ON c.id = p.category_id
JOIN subcategories sc ON sc.id = p.subcategory_id AND sc.category_id = c.id
WHERE (b.slug = 'maeil' OR b.name = 'Maeil')
  AND c.slug = 'beverage' AND sc.slug = 'coffee'
  AND p.name LIKE 'Barista Rules %'
ORDER BY p.sort_order, p.name;
