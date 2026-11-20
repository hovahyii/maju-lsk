-- Run against the website catalog database after deploying the Interflour photos.
DROP TEMPORARY TABLE IF EXISTS interflour_catalog_items;
START TRANSACTION;

SET @interflour_wheat_id = (
    SELECT MIN(sc.id)
    FROM subcategories sc
    JOIN categories c ON c.id = sc.category_id
    WHERE c.slug = 'flour' AND sc.slug = 'wheat-flour'
    HAVING COUNT(*) = 1
);

INSERT INTO brands (name, slug)
SELECT 'Interflour', 'interflour'
WHERE @interflour_wheat_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'interflour' OR LOWER(name) = 'interflour');

SET @interflour_brand_id = (
    SELECT MIN(id) FROM brands
    WHERE slug = 'interflour' OR LOWER(name) = 'interflour'
    HAVING COUNT(*) = 1
);

CREATE TEMPORARY TABLE interflour_catalog_items (
    name VARCHAR(120) NOT NULL PRIMARY KEY,
    legacy_name VARCHAR(120),
    filename VARCHAR(150) NOT NULL,
    sort_order INT NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO interflour_catalog_items (name, legacy_name, filename, sort_order) VALUES
    ('Golden Horse SSS', NULL, 'Golden Horse SSS.webp', 1),
    ('Golden Premium', NULL, 'Golden Premium.webp', 2),
    ('Red Horse', 'Red House', 'Red Horse.webp', 3),
    ('Yellow Horse', 'Yellow House', 'Yellow Horse.webp', 4),
    ('Blue Premium', NULL, 'Blue Premium.webp', 5),
    ('Blue Horse', NULL, 'Blue Horse.webp', 6),
    ('SFFM 99', NULL, 'SFFM 99.webp', 7),
    ('Roti Canai', NULL, 'Roti Canai.webp', 8),
    ('Pink Superwhite', 'Pink_Superwhite', 'Pink Superwhite.webp', 9),
    ('Green Horse', NULL, 'Green Horse.webp', 10),
    ('Wholemeal (Fine / Coarse)', 'Wholemeal Fine_Coarse', 'Wholemeal (Fine and Coarse).webp', 11),
    ('Green Horse Enriched (1 kg)', 'Green Horse Enriched', 'Green Horse Enriched (1 kg).webp', 12),
    ('Cap Lili Plain Flour (1 kg)', 'Cap Lili Plain Flour', 'Cap Lili Plain Flour (1 kg).webp', 13),
    ('Cap Lili Plain Flour (850 g)', 'Cap Lili Plain Flour 850g x10pkts', 'Cap Lili Plain Flour (850 g).webp', 14),
    ('Pink Horse', NULL, 'Pink Horse.webp', 15),
    ('Bakers Choice Superfine Wheat Flour', NULL, 'Bakers Choice Superfine Wheat Flour.webp', 16),
    ('Bakers Choice Bread Flour', NULL, 'Bakers Choice Bread Flour.webp', 17),
    ('Bakers Choice Pau Flour', NULL, 'Bakers Choice Pau Flour.webp', 18),
    ('Bakers Choice Self Raising Flour', NULL, 'Bakers Choice Self Raising Flour.webp', 19),
    ('Bakers Choice Cakes & Cookies Flour', NULL, 'Bakers Choice Cakes & Cookies Flour.webp', 20),
    ('Red Horse Bun Flour (Standing Order)', NULL, 'Red Horse Bun Flour (Standing Order).webp', 21);

UPDATE products p
JOIN interflour_catalog_items item
    ON CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci IN (item.name, item.legacy_name)
SET p.name = item.name,
    p.image_url = CONCAT('products/Flour/Wheat Flour/Interflour/Cutouts/', item.filename),
    p.is_active = 1
WHERE p.brand_id = @interflour_brand_id AND p.subcategory_id = @interflour_wheat_id;

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Flour/Wheat Flour/Interflour/Cutouts/', item.filename),
       sc.category_id, sc.id, @interflour_brand_id, 1, item.sort_order
FROM interflour_catalog_items item
JOIN subcategories sc ON sc.id = @interflour_wheat_id
WHERE @interflour_brand_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = @interflour_brand_id AND p.subcategory_id = sc.id
        AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
  );

DROP TEMPORARY TABLE interflour_catalog_items;
COMMIT;
