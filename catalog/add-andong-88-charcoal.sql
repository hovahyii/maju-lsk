-- Run against the website catalog database after deploying the 88 Charcoal photos.
DROP TEMPORARY TABLE IF EXISTS charcoal88_catalog_items;
START TRANSACTION;

SET @charcoal88_subcategory_id = (
    SELECT MIN(sc.id)
    FROM subcategories sc
    JOIN categories c ON c.id = sc.category_id
    WHERE c.slug = 'consumables' AND sc.slug = 'charcoal'
    HAVING COUNT(*) = 1
);

INSERT INTO brands (name, slug)
SELECT '88', '88'
WHERE @charcoal88_subcategory_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = '88' OR LOWER(name) IN ('88', '88 charcoal'));

SET @charcoal88_brand_id = (
    SELECT MIN(id) FROM brands
    WHERE slug = '88' OR LOWER(name) IN ('88', '88 charcoal')
    HAVING COUNT(*) = 1
);

CREATE TEMPORARY TABLE charcoal88_catalog_items (
    name VARCHAR(120) NOT NULL PRIMARY KEY,
    legacy_name VARCHAR(120),
    sort_order INT NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO charcoal88_catalog_items (name, legacy_name, sort_order) VALUES
    ('Compressed BBQ Charcoal (3 kg)', 'Compressed BBQ Charcoal', 1),
    ('Compressed BBQ Charcoal Standard (5 kg)', NULL, 2),
    ('Loose Charcoal Briquettes (20 kg)', NULL, 3),
    ('Loose Charcoal Briquettes (5 kg)', NULL, 4);

UPDATE products p
JOIN charcoal88_catalog_items item
    ON CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci IN (item.name, item.legacy_name)
SET p.name = item.name,
    p.image_url = CONCAT('products/Consumables/Charcoal/88/Cutouts/', item.name, '.webp'),
    p.is_active = 1
WHERE p.brand_id = @charcoal88_brand_id AND p.subcategory_id = @charcoal88_subcategory_id;

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Consumables/Charcoal/88/Cutouts/', item.name, '.webp'),
       sc.category_id, sc.id, @charcoal88_brand_id, 1, item.sort_order
FROM charcoal88_catalog_items item
JOIN subcategories sc ON sc.id = @charcoal88_subcategory_id
WHERE @charcoal88_brand_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = @charcoal88_brand_id AND p.subcategory_id = sc.id
        AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
  );

DROP TEMPORARY TABLE charcoal88_catalog_items;
COMMIT;
