-- Run against the website catalog database.
START TRANSACTION;

INSERT INTO brands (name, slug)
SELECT 'Eggtech', 'eggtech'
WHERE NOT EXISTS (
    SELECT 1 FROM brands WHERE slug = 'eggtech' OR LOWER(name) = 'eggtech'
);

UPDATE products p
JOIN brands source_brand ON source_brand.id = p.brand_id
JOIN subcategories sc ON sc.id = p.subcategory_id AND sc.category_id = p.category_id
CROSS JOIN (
    SELECT MIN(id) AS id
    FROM brands
    WHERE slug = 'eggtech' OR LOWER(name) = 'eggtech'
    HAVING COUNT(*) = 1
) eggtech
SET p.brand_id = eggtech.id
WHERE (source_brand.slug = 'bakels' OR LOWER(source_brand.name) = 'bakels')
  AND (sc.slug = 'frozen-egg' OR LOWER(sc.name) = 'frozen egg')
  AND p.name IN (
    'Frozen Pasteurized Liquid Egg White - Stranding Order',
    'Frozen Pasteurized Liquid Egg Yolk - Stranding Order',
    'Frozen Pasteurized Liquid Whole Egg'
  );

COMMIT;
