-- Run against the website catalog database.
START TRANSACTION;

UPDATE products
SET name = LEFT(name, CHAR_LENGTH(name) - CHAR_LENGTH(SUBSTRING_INDEX(name, ' (', -1)) - 2)
WHERE name IN (
    'Capati (8 pcs, 400 g)',
    'Capati with Chicken Curry (8 pcs, 600 g)',
    'Paratha (Onion) (5 pcs, 400 g)',
    'Paratha (Onion) with Chicken Curry (5 pcs, 600 g)',
    'Paratha (Original) (5 pcs, 400 g)',
    'Paratha (Original) with Chicken Curry (5 pcs, 600 g)',
    'Roti Canai (5 pcs, 400 g)',
    'Roti Canai with Chicken Curry (5 pcs, 600 g)'
)
AND brand_id IN (SELECT id FROM brands WHERE slug = 'adabi' OR LOWER(name) = 'adabi')
AND EXISTS (
    SELECT 1
    FROM subcategories sc
    JOIN categories c ON c.id = sc.category_id
    WHERE sc.id = products.subcategory_id AND c.id = products.category_id
      AND sc.slug = 'flatbread' AND c.slug = 'frozen-food'
);

COMMIT;
