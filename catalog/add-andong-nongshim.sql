-- Run against the website catalog database after deploying the Nongshim photos.
DROP TEMPORARY TABLE IF EXISTS nongshim_catalog_items;
START TRANSACTION;

SET @nongshim_noodles_id = (
    SELECT MIN(sc.id)
    FROM subcategories sc
    JOIN categories c ON c.id = sc.category_id
    WHERE c.slug = 'instant-food' AND sc.slug = 'instant-noodles'
    HAVING COUNT(*) = 1
);

INSERT INTO brands (name, slug)
SELECT 'Nongshim', 'nongshim'
WHERE @nongshim_noodles_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'nongshim' OR LOWER(name) = 'nongshim');

SET @nongshim_brand_id = (
    SELECT MIN(id) FROM brands
    WHERE slug = 'nongshim' OR LOWER(name) = 'nongshim'
    HAVING COUNT(*) = 1
);

CREATE TEMPORARY TABLE nongshim_catalog_items (
    name VARCHAR(120) NOT NULL PRIMARY KEY,
    sort_order INT NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO nongshim_catalog_items (name, sort_order) VALUES
    ('Shin Ramyun Kimchi Noodle', 1),
    ('Shin Ramyun Red Super Spicy Noodle', 2),
    ('Shin Ramyun Stir Fry Noodle', 3),
    ('Shin Ramyun Toomba Stir Fry Noodle', 4),
    ('Soon Veggie Ramyun Noodle Soup', 5),
    ('Chapagetti (Original)', 6),
    ('Shin Cup Noodle Soup', 7),
    ('Shin Ramyun Noodle Soup', 8);

UPDATE products p
JOIN nongshim_catalog_items item
    ON CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
SET p.image_url = CONCAT('products/Instant Food/Instant Noodles/Nongshim/Cutouts/', item.name, '.webp'),
    p.is_active = 1
WHERE p.brand_id = @nongshim_brand_id AND p.subcategory_id = @nongshim_noodles_id;

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Instant Food/Instant Noodles/Nongshim/Cutouts/', item.name, '.webp'),
       sc.category_id, sc.id, @nongshim_brand_id, 1, item.sort_order
FROM nongshim_catalog_items item
JOIN subcategories sc ON sc.id = @nongshim_noodles_id
WHERE @nongshim_brand_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = @nongshim_brand_id AND p.subcategory_id = sc.id
        AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
  );

DROP TEMPORARY TABLE nongshim_catalog_items;
COMMIT;
