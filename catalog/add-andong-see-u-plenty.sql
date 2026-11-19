-- Run against the website catalog database after deploying the See-U and Plenty photos.
DROP TEMPORARY TABLE IF EXISTS andong_tissue_items;
START TRANSACTION;

SET @andong_tissues_id = (
    SELECT MIN(sc.id)
    FROM subcategories sc
    JOIN categories c ON c.id = sc.category_id
    WHERE c.slug = 'consumables' AND sc.slug = 'tissues'
    HAVING COUNT(*) = 1
);

INSERT INTO brands (name, slug)
SELECT incoming.name, incoming.slug
FROM (
    SELECT 'See-U' AS name, 'see-u' AS slug
    UNION ALL SELECT 'Plenty', 'plenty'
) incoming
WHERE @andong_tissues_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM brands b
      WHERE CONVERT(b.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = incoming.slug
         OR CONVERT(b.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = incoming.name
  );

SET @see_u_id = (
    SELECT MIN(id) FROM brands WHERE slug = 'see-u' OR LOWER(name) = 'see-u'
    HAVING COUNT(*) = 1
);
SET @plenty_id = (
    SELECT MIN(id) FROM brands WHERE slug = 'plenty' OR LOWER(name) = 'plenty'
    HAVING COUNT(*) = 1
);

CREATE TEMPORARY TABLE andong_tissue_items (
    brand_id BIGINT NULL,
    brand_folder VARCHAR(20) NOT NULL,
    name VARCHAR(120) NOT NULL,
    sort_order INT NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO andong_tissue_items (brand_id, brand_folder, name, sort_order) VALUES
    (@see_u_id, 'See-U', 'Pop Up Tissue 4 in 1', 1),
    (@see_u_id, 'See-U', 'BT DME Green Value', 2),
    (@see_u_id, 'See-U', 'BT NE Green Value', 3),
    (@see_u_id, 'See-U', 'BT DME Classic', 4),
    (@see_u_id, 'See-U', 'Kitchen Towel (Single Pack)', 5),
    (@see_u_id, 'See-U', 'FT Facial Tissue', 6),
    (@see_u_id, 'See-U', 'Facial Tissue ECO Value Pack', 7),
    (@see_u_id, 'See-U', 'Luncheon Napkin (Quarter Fold)', 8),
    (@see_u_id, 'See-U', 'L-Fold Hand Towel', 9),
    (@see_u_id, 'See-U', 'M-Fold Hand Towel', 10),
    (@plenty_id, 'Plenty', 'BT MMF PC', 1),
    (@plenty_id, 'Plenty', 'Facial Tissue EE', 2),
    (@plenty_id, 'Plenty', 'Kitchen Towel MD (2 in 1)', 3),
    (@plenty_id, 'Plenty', 'DN Napkins', 4),
    (@plenty_id, 'Plenty', 'CN Napkins', 5),
    (@plenty_id, 'Plenty', 'Luncheon Napkin', 6),
    (@plenty_id, 'Plenty', 'HKC Pocket Tissue (10 in 1)', 7),
    (@plenty_id, 'Plenty', 'Bathroom Tissue EE (4 in 1)', 8),
    (@plenty_id, 'Plenty', 'Facial Tissue Premium TP (Travel Pack)', 9),
    (@plenty_id, 'Plenty', 'Facial Tissue Premium HP (Soft Pack)', 10),
    (@plenty_id, 'Plenty', 'Facial Tissue Premium HP (Hard Pack)', 11),
    (@plenty_id, 'Plenty', 'Facial Tissue Premium HP (5 in 1 Hard Pack)', 12);

UPDATE products p
JOIN andong_tissue_items item ON item.brand_id = p.brand_id
    AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
SET p.image_url = CONCAT('products/Consumables/Tissues/', item.brand_folder, '/Cutouts/', item.name, '.webp'),
    p.is_active = 1
WHERE p.subcategory_id = @andong_tissues_id;

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Consumables/Tissues/', item.brand_folder, '/Cutouts/', item.name, '.webp'),
       sc.category_id, sc.id, item.brand_id, 1, item.sort_order
FROM andong_tissue_items item
JOIN subcategories sc ON sc.id = @andong_tissues_id
WHERE item.brand_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = item.brand_id AND p.subcategory_id = sc.id
        AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
  );

DROP TEMPORARY TABLE andong_tissue_items;
COMMIT;
