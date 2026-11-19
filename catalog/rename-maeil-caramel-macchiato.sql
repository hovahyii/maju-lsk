-- Run against the website catalog database using a UTF-8 connection.
START TRANSACTION;

UPDATE products
SET name = 'My Café Latte Caramel Macchiato'
WHERE name IN (
    'My Café Latte Caramel Macchiato 220ml x 10cups',
    'My Cafe Latte Caramel Macchiato 220ml x 10cups'
)
AND brand_id IN (SELECT id FROM brands WHERE slug = 'maeil' OR name = 'Maeil')
AND EXISTS (
    SELECT 1
    FROM categories c
    JOIN subcategories sc ON sc.category_id = c.id
    WHERE c.id = products.category_id AND sc.id = products.subcategory_id
      AND c.slug = 'beverage' AND sc.slug = 'coffee'
);

COMMIT;
