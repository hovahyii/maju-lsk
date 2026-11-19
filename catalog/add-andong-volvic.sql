-- Run against the website catalog database after deploying the Volvic photos.
DROP TEMPORARY TABLE IF EXISTS volvic_catalog_items;
START TRANSACTION;

SET @volvic_water_id = (
    SELECT MIN(sc.id)
    FROM subcategories sc
    JOIN categories c ON c.id = sc.category_id
    WHERE c.slug = 'beverage' AND sc.slug = 'mineral-water'
    HAVING COUNT(*) = 1
);

INSERT INTO brands (name, slug)
SELECT 'Volvic', 'volvic'
WHERE @volvic_water_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'volvic' OR LOWER(name) = 'volvic');

SET @volvic_brand_id = (
    SELECT MIN(id) FROM brands
    WHERE slug = 'volvic' OR LOWER(name) = 'volvic'
    HAVING COUNT(*) = 1
);

CREATE TEMPORARY TABLE volvic_catalog_items (
    name VARCHAR(120) NOT NULL PRIMARY KEY,
    legacy_name VARCHAR(120),
    sort_order INT NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO volvic_catalog_items (name, legacy_name, sort_order) VALUES
    ('Volvic Mineral Water (500 mL)', NULL, 1),
    ('Volvic Mineral Water (1.5 L)', NULL, 2),
    ('Volvic Mineral Water Multipack (6 × 1.5 L)', 'Plain', 3);

UPDATE products p
JOIN volvic_catalog_items item
    ON CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci IN (item.name, item.legacy_name)
SET p.name = item.name,
    p.image_url = CONCAT('products/Beverage/Mineral Water/Volvic/Cutouts/', REPLACE(item.name, '×', 'x'), '.webp'),
    p.is_active = 1
WHERE p.brand_id = @volvic_brand_id AND p.subcategory_id = @volvic_water_id;

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Beverage/Mineral Water/Volvic/Cutouts/', REPLACE(item.name, '×', 'x'), '.webp'),
       sc.category_id, sc.id, @volvic_brand_id, 1, item.sort_order
FROM volvic_catalog_items item
JOIN subcategories sc ON sc.id = @volvic_water_id
WHERE @volvic_brand_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = @volvic_brand_id AND p.subcategory_id = sc.id
        AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
  );

DROP TEMPORARY TABLE volvic_catalog_items;
COMMIT;
