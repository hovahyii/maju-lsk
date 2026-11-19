-- Run against the website catalog database after deploying the Lutosa photos.
DROP TEMPORARY TABLE IF EXISTS lutosa_catalog_items;
START TRANSACTION;

SET @lutosa_fries_id = (
    SELECT MIN(sc.id)
    FROM subcategories sc
    JOIN categories c ON c.id = sc.category_id
    WHERE c.slug = 'frozen-food' AND sc.slug = 'french-fries'
    HAVING COUNT(*) = 1
);

INSERT INTO brands (name, slug)
SELECT 'Lutosa', 'lutosa'
WHERE @lutosa_fries_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'lutosa' OR LOWER(name) = 'lutosa');

SET @lutosa_brand_id = (
    SELECT MIN(id) FROM brands
    WHERE slug = 'lutosa' OR LOWER(name) = 'lutosa'
    HAVING COUNT(*) = 1
);

CREATE TEMPORARY TABLE lutosa_catalog_items (
    name VARCHAR(120) NOT NULL PRIMARY KEY,
    legacy_name VARCHAR(120),
    sort_order INT NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO lutosa_catalog_items (name, legacy_name, sort_order) VALUES
    ('Straight Cut Rustic Fries (10/10 mm)', 'Straight Cut- Rustic', 1),
    ('Shoestring Allumettes (7/7 mm)', NULL, 2),
    ('Steak Fries Pom’Steak (10/18 mm)', 'Streak Fries Pom''s Steak', 3),
    ('Crinkle Fries', NULL, 4),
    ('Spicy Wedges', NULL, 5),
    ('Finest Selection Extra Crispy Coated Thin Cut Fries (7/7 mm)', NULL, 6),
    ('All Premium Shoestring Fries (7/7 mm)', NULL, 7),
    ('Classic Cut Fries (Straight Cut)', NULL, 8),
    ('Deep Crinkle Cut Fries (12 mm)', NULL, 9),
    ('Sweet Potato Fries', NULL, 10),
    ('Crunchy Oval Hash Browns', NULL, 11);

UPDATE products p
JOIN lutosa_catalog_items item
    ON CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci IN (item.name, item.legacy_name)
SET p.name = item.name,
    p.image_url = CONCAT('products/Frozen Food/French Fries/Lutosa/Cutouts/', REPLACE(item.name, '/', 'x'), '.webp'),
    p.is_active = 1
WHERE p.brand_id = @lutosa_brand_id AND p.subcategory_id = @lutosa_fries_id;

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Frozen Food/French Fries/Lutosa/Cutouts/', REPLACE(item.name, '/', 'x'), '.webp'),
       sc.category_id, sc.id, @lutosa_brand_id, 1, item.sort_order
FROM lutosa_catalog_items item
JOIN subcategories sc ON sc.id = @lutosa_fries_id
WHERE @lutosa_brand_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = @lutosa_brand_id AND p.subcategory_id = sc.id
        AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
  );

DROP TEMPORARY TABLE lutosa_catalog_items;
COMMIT;
