USE `majul764_product`;

START TRANSACTION;

UPDATE products
SET is_active = 0
WHERE is_active = 1
  AND name IN ('Aloe Vera Original', 'Aloe Vera Pineapple')
  AND brand_id IN (
      SELECT id FROM brands WHERE LOWER(slug) = 'visvita' OR LOWER(name) = 'visvita'
  );

COMMIT;

SELECT p.name, p.is_active
FROM products p
JOIN brands b ON b.id = p.brand_id
WHERE (LOWER(b.slug) = 'visvita' OR LOWER(b.name) = 'visvita')
  AND p.name IN ('Aloe Vera Original', 'Aloe Vera Pineapple')
ORDER BY p.name;
