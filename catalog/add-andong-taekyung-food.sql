-- Run against the website catalog database after deploying the Taekyung Food photos.
DROP TEMPORARY TABLE IF EXISTS taekyung_catalog_items;
START TRANSACTION;

SET @taekyung_snacks_id = (
    SELECT MIN(sc.id)
    FROM subcategories sc
    JOIN categories c ON c.id = sc.category_id
    WHERE c.slug = 'instant-food' AND sc.slug = 'snacks'
    HAVING COUNT(*) = 1
);

INSERT INTO brands (name, slug)
SELECT 'Taekyung Food', 'taekyung-food'
WHERE @taekyung_snacks_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'taekyung-food' OR LOWER(name) = 'taekyung food');

SET @taekyung_brand_id = (
    SELECT MIN(id) FROM brands
    WHERE slug = 'taekyung-food' OR LOWER(name) = 'taekyung food'
    HAVING COUNT(*) = 1
);

CREATE TEMPORARY TABLE taekyung_catalog_items (
    name VARCHAR(120) NOT NULL PRIMARY KEY,
    sort_order INT NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO taekyung_catalog_items (name, sort_order) VALUES
    ('Seasoned Laver Original', 1),
    ('Roasted Seasoned Laver With Green Algae', 2),
    ('Seasoned Laver With Olive Oil', 3),
    ('Seasoned Laver With Green Tea', 4);

UPDATE products p
JOIN taekyung_catalog_items item
    ON CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
SET p.image_url = CONCAT('products/Instant Food/Snacks/Taekyung Food/Cutouts/', item.name, '.webp'),
    p.is_active = 1
WHERE p.brand_id = @taekyung_brand_id AND p.subcategory_id = @taekyung_snacks_id;

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Instant Food/Snacks/Taekyung Food/Cutouts/', item.name, '.webp'),
       sc.category_id, sc.id, @taekyung_brand_id, 1, item.sort_order
FROM taekyung_catalog_items item
JOIN subcategories sc ON sc.id = @taekyung_snacks_id
WHERE @taekyung_brand_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = @taekyung_brand_id AND p.subcategory_id = sc.id
        AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
  );

DROP TEMPORARY TABLE taekyung_catalog_items;
COMMIT;
