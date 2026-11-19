-- Run against the website catalog database after deploying the Samyang photos.
DROP TEMPORARY TABLE IF EXISTS samyang_catalog_items;
START TRANSACTION;

SET @samyang_noodles_id = (
    SELECT MIN(sc.id)
    FROM subcategories sc
    JOIN categories c ON c.id = sc.category_id
    WHERE c.slug = 'instant-food' AND sc.slug = 'instant-noodles'
    HAVING COUNT(*) = 1
);

INSERT INTO brands (name, slug)
SELECT 'Samyang', 'samyang'
WHERE @samyang_noodles_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'samyang' OR LOWER(name) = 'samyang');

SET @samyang_brand_id = (
    SELECT MIN(id) FROM brands
    WHERE slug = 'samyang' OR LOWER(name) = 'samyang'
    HAVING COUNT(*) = 1
);

CREATE TEMPORARY TABLE samyang_catalog_items (
    name VARCHAR(120) NOT NULL PRIMARY KEY,
    legacy_name VARCHAR(120),
    sort_order INT NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO samyang_catalog_items (name, legacy_name, sort_order) VALUES
    ('Buldak Original Ramen (Multipack)', 'Hot Chicken Flavoured Ramen', 1),
    ('Buldak Original Ramen (Bowl)', NULL, 2),
    ('Buldak Carbonara Ramen (Multipack)', 'Hot Chicken Carbonara Ramen', 3),
    ('Buldak Carbonara Ramen (Bowl)', NULL, 4),
    ('Buldak Cheese Ramen (Multipack)', 'Hot Chicken Cheese Ramen', 5),
    ('Buldak Cheese Ramen (Bowl)', NULL, 6),
    ('Buldak Cream Carbonara Ramen (Multipack)', NULL, 7),
    ('Buldak Cream Carbonara Ramen (Bowl)', NULL, 8),
    ('Buldak Extreme Ramen (Multipack)', 'Hot Chicken Extreme Ramen', 9),
    ('Buldak Extreme Ramen (Bowl)', NULL, 10),
    ('Buldak Rose Ramen (Multipack)', NULL, 11),
    ('Buldak Rose Ramen (Bowl)', NULL, 12),
    ('Buldak Jjajang Ramen (Multipack)', NULL, 13),
    ('Buldak Jjajang Ramen (Bowl)', NULL, 14),
    ('Buldak Stew Ramen (Multipack)', NULL, 15),
    ('Buldak Quattro Cheese Ramen (Multipack)', NULL, 16),
    ('Buldak Habanero Lime Ramen (Multipack)', NULL, 17),
    ('Buldak Swicy Ramen (Multipack)', NULL, 18),
    ('Buldak Swicy Ramen (Bowl)', NULL, 19),
    ('Buldak Original Ramen (Cup)', NULL, 20),
    ('Buldak Extreme Ramen (Cup)', NULL, 21),
    ('Buldak Cheese Ramen (Cup)', NULL, 22),
    ('Buldak Carbonara Ramen (Cup)', NULL, 23);

UPDATE products p
JOIN samyang_catalog_items item
    ON CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci IN (item.name, item.legacy_name)
SET p.name = item.name,
    p.image_url = CONCAT('products/Instant Food/Instant Noodles/Samyang/Cutouts/', item.name, '.webp'),
    p.is_active = 1
WHERE p.brand_id = @samyang_brand_id AND p.subcategory_id = @samyang_noodles_id;

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Instant Food/Instant Noodles/Samyang/Cutouts/', item.name, '.webp'),
       sc.category_id, sc.id, @samyang_brand_id, 1, item.sort_order
FROM samyang_catalog_items item
JOIN subcategories sc ON sc.id = @samyang_noodles_id
WHERE @samyang_brand_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = @samyang_brand_id AND p.subcategory_id = sc.id
        AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
  );

DROP TEMPORARY TABLE samyang_catalog_items;
COMMIT;
