-- Run against the website catalog database after deploying the Genki! photos.
DROP TEMPORARY TABLE IF EXISTS genki_catalog_items;
START TRANSACTION;

SET @genki_diapers_id = (
    SELECT MIN(sc.id)
    FROM subcategories sc
    JOIN categories c ON c.id = sc.category_id
    WHERE c.slug = 'consumables' AND sc.slug = 'diapers'
    HAVING COUNT(*) = 1
);

INSERT INTO brands (name, slug)
SELECT 'Genki!', 'genki'
WHERE @genki_diapers_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'genki' OR LOWER(name) IN ('genki', 'genki!'));

SET @genki_brand_id = (
    SELECT MIN(id) FROM brands
    WHERE slug = 'genki' OR LOWER(name) IN ('genki', 'genki!')
    HAVING COUNT(*) = 1
);

CREATE TEMPORARY TABLE genki_catalog_items (
    name VARCHAR(120) NOT NULL PRIMARY KEY,
    sort_order INT NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO genki_catalog_items (name, sort_order) VALUES
    ('Genki Tape Mega New Born', 1),
    ('Genki Tape Mega S78', 2),
    ('Genki Tape Mega M64', 3),
    ('Genki Tape Mega L54', 4),
    ('Genki Tape Mega XL42', 5),
    ('Genki! Pants Mega M56', 6),
    ('Genki! Pants Mega L46', 7),
    ('Genki! Pants Mega XL40', 8),
    ('Genki! Pants Mega XXL34', 9);

UPDATE products p
JOIN genki_catalog_items item
    ON CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
SET p.image_url = CONCAT('products/Consumables/Diapers/Genki!/Cutouts/', item.name, '.webp'),
    p.is_active = 1
WHERE p.brand_id = @genki_brand_id AND p.subcategory_id = @genki_diapers_id;

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Consumables/Diapers/Genki!/Cutouts/', item.name, '.webp'),
       sc.category_id, sc.id, @genki_brand_id, 1, item.sort_order
FROM genki_catalog_items item
JOIN subcategories sc ON sc.id = @genki_diapers_id
WHERE @genki_brand_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = @genki_brand_id AND p.subcategory_id = sc.id
        AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
  );

DROP TEMPORARY TABLE genki_catalog_items;
COMMIT;
