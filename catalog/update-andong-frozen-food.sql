USE `majul764_product`;

START TRANSACTION;

INSERT INTO brands (name, slug)
SELECT 'Mum Mum', 'mum-mum'
WHERE EXISTS (
    SELECT 1 FROM products p
    JOIN brands b ON b.id = p.brand_id
    JOIN categories c ON c.id = p.category_id
    WHERE c.slug = 'frozen-food'
      AND (b.slug = 'easy-meal-everyday' OR b.name = 'Easy Meal Everyday')
      AND p.name IN (
          'Beancurd Prawn Roll 240g x 16pkts', 'Prawn Siew Mai 198g x 24pkts',
          'Beancurd Prawn Roll', 'Prawn Siew Mai'
      )
)
AND NOT EXISTS (
    SELECT 1 FROM brands WHERE slug = 'mum-mum' OR name = 'Mum Mum'
);

INSERT INTO subcategories (category_id, name, slug)
SELECT c.id, 'Snack', 'snack'
FROM categories c
WHERE c.slug = 'frozen-food'
  AND NOT EXISTS (
      SELECT 1 FROM subcategories sc
      WHERE sc.category_id = c.id AND (sc.slug = 'snack' OR sc.name = 'Snack')
  );

UPDATE products
SET name = CASE
        WHEN name = 'Beancurd Prawn Roll 240g x 16pkts' THEN 'Beancurd Prawn Roll'
        WHEN name = 'Prawn Siew Mai 198g x 24pkts' THEN 'Prawn Siew Mai'
        ELSE name
    END,
    brand_id = (SELECT MIN(id) FROM brands WHERE slug = 'mum-mum' OR name = 'Mum Mum')
WHERE category_id IN (SELECT id FROM categories WHERE slug = 'frozen-food')
  AND brand_id IN (
      SELECT id FROM brands
      WHERE slug IN ('easy-meal-everyday', 'mum-mum') OR name IN ('Easy Meal Everyday', 'Mum Mum')
  )
  AND name IN (
      'Beancurd Prawn Roll 240g x 16pkts', 'Prawn Siew Mai 198g x 24pkts',
      'Beancurd Prawn Roll', 'Prawn Siew Mai'
  )
  AND (SELECT COUNT(*) FROM brands WHERE slug = 'mum-mum' OR name = 'Mum Mum') = 1;

UPDATE products
SET name = 'Keropok Lekor Mega Soft Frozen',
    subcategory_id = (
        SELECT MIN(sc.id) FROM subcategories sc
        WHERE sc.category_id = products.category_id AND (sc.slug = 'snack' OR sc.name = 'Snack')
    )
WHERE category_id IN (SELECT id FROM categories WHERE slug = 'frozen-food')
  AND brand_id IN (SELECT id FROM brands WHERE slug = 'kitasama' OR name = 'Kitasama')
  AND name IN (
      'Keropok Lekor Mega Soft Frozen 1kg x 10pkts',
      'Keropok Lekor Mega Soft Frozen 500g x 20pkts',
      'Keropok Lekor Mega Soft Frozen'
  )
  AND (
      SELECT COUNT(*) FROM subcategories sc
      WHERE sc.category_id = products.category_id AND (sc.slug = 'snack' OR sc.name = 'Snack')
  ) = 1;

COMMIT;

SELECT p.id, b.name AS brand, p.name AS product, c.name AS category, sc.name AS subcategory
FROM products p
JOIN brands b ON b.id = p.brand_id
JOIN categories c ON c.id = p.category_id
LEFT JOIN subcategories sc ON sc.id = p.subcategory_id
WHERE c.slug = 'frozen-food'
  AND ((b.name = 'Mum Mum' AND p.name IN ('Beancurd Prawn Roll', 'Prawn Siew Mai'))
       OR (b.name = 'Kitasama' AND p.name = 'Keropok Lekor Mega Soft Frozen'))
ORDER BY b.name, p.name, p.id;
