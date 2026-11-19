-- Run against the website catalog database after deploying the Mum Mum photos.
DROP TEMPORARY TABLE IF EXISTS mum_mum_catalog_items;
START TRANSACTION;

SET @mum_mum_dim_sum_id = (
    SELECT MIN(sc.id)
    FROM subcategories sc
    JOIN categories c ON c.id = sc.category_id
    WHERE c.slug = 'frozen-food' AND sc.slug = 'dim-sum'
    HAVING COUNT(*) = 1
);

INSERT INTO brands (name, slug)
SELECT 'Mum Mum', 'mum-mum'
WHERE @mum_mum_dim_sum_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'mum-mum' OR LOWER(name) = 'mum mum');

SET @mum_mum_brand_id = (
    SELECT MIN(id) FROM brands
    WHERE slug = 'mum-mum' OR LOWER(name) = 'mum mum'
    HAVING COUNT(*) = 1
);

CREATE TEMPORARY TABLE mum_mum_catalog_items (
    name VARCHAR(100) NOT NULL,
    legacy_name VARCHAR(100),
    sort_order INT NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO mum_mum_catalog_items (name, legacy_name, sort_order) VALUES
    ('Prawn Siew Mai', 'Prawn Siew Mai 198g x 24pkts', 1),
    ('Beancurd Prawn Roll', 'Beancurd Prawn Roll 240g x 16pkts', 2),
    ('Golden BBQ Chicken Pau', NULL, 3),
    ('Golden Lava Pau', 'Goldan Lava Pau', 4);

UPDATE products p
JOIN brands b ON b.id = p.brand_id
JOIN subcategories sc ON sc.id = @mum_mum_dim_sum_id AND sc.category_id = p.category_id
JOIN mum_mum_catalog_items item
    ON CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci IN (
        item.name, item.legacy_name, CONCAT('Mum Mum ', item.name), CONCAT('Mum Mum ', item.legacy_name)
    )
SET p.name = item.name,
    p.image_url = CONCAT('products/Frozen Food/Dim Sum/Mum Mum/', item.name, '.webp'),
    p.brand_id = @mum_mum_brand_id,
    p.subcategory_id = sc.id,
    p.is_active = 1
WHERE @mum_mum_brand_id IS NOT NULL
  AND (b.id = @mum_mum_brand_id OR b.slug = 'easy-meal-everyday' OR LOWER(b.name) = 'easy meal everyday');

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Frozen Food/Dim Sum/Mum Mum/', item.name, '.webp'),
       sc.category_id, sc.id, @mum_mum_brand_id, 1, item.sort_order
FROM mum_mum_catalog_items item
JOIN subcategories sc ON sc.id = @mum_mum_dim_sum_id
WHERE @mum_mum_brand_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = @mum_mum_brand_id AND p.category_id = sc.category_id
        AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
  );

DROP TEMPORARY TABLE mum_mum_catalog_items;

COMMIT;
