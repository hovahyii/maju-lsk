-- Ji-Mart Enterprise EAPP Bakery Fat 2026 catalogue.
DROP TEMPORARY TABLE IF EXISTS jimart_eapp_items;
START TRANSACTION;

INSERT INTO subcategories (category_id, name, slug)
SELECT c.id, source.name, source.slug
FROM (
    SELECT 'fats' AS category_slug, 'Margarine' AS name, 'margarine' AS slug
    UNION ALL SELECT 'fats', 'Butter', 'butter'
    UNION ALL SELECT 'fats', 'Cooking Oil', 'cooking-oil'
    UNION ALL SELECT 'fats', 'Shortening', 'shortening'
) source
JOIN categories c ON CONVERT(c.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = source.category_slug
WHERE NOT EXISTS (
    SELECT 1 FROM subcategories sc
    WHERE sc.category_id = c.id AND CONVERT(sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = source.slug
);

INSERT INTO brands (name, slug)
SELECT source.name, source.slug
FROM (
    SELECT 'Blue Bell' AS name, 'blue-bell' AS slug
    UNION ALL SELECT 'Brooke', 'brooke'
    UNION ALL SELECT 'Gold Box', 'gold-box'
    UNION ALL SELECT 'Taroona', 'taroona'
) source
WHERE NOT EXISTS (
    SELECT 1 FROM brands b WHERE CONVERT(b.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = source.slug
);

CREATE TEMPORARY TABLE jimart_eapp_items (
    brand_slug VARCHAR(50) NOT NULL,
    category_slug VARCHAR(50) NOT NULL,
    subcategory_slug VARCHAR(50) NOT NULL,
    name VARCHAR(150) NOT NULL,
    legacy_name VARCHAR(150),
    prior_brand_slug VARCHAR(50) NOT NULL,
    prior_category_slug VARCHAR(50) NOT NULL,
    prior_subcategory_slug VARCHAR(50) NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    sort_order INT NOT NULL,
    PRIMARY KEY (brand_slug, category_slug, subcategory_slug, name)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO jimart_eapp_items
    (brand_slug, category_slug, subcategory_slug, name, legacy_name,
     prior_brand_slug, prior_category_slug, prior_subcategory_slug, image_url, sort_order)
VALUES
    ('blue-bell', 'fats', 'margarine', 'Baker''s Margarine', NULL, 'blue-bell', 'fats', 'margarine', 'products/Fats/Margarine/Blue Bell/Workbook Photos/Baker''s Margarine.webp', 1),
    ('blue-bell', 'fats', 'margarine', 'Butter Margarine 3% (20 kg)', NULL, 'blue-bell', 'fats', 'margarine', 'products/Fats/Margarine/Blue Bell/Workbook Photos/Butter Margarine 3% (20 kg).webp', 2),
    ('blue-bell', 'fats', 'margarine', 'Butter Margarine 3% (1 kg)', NULL, 'blue-bell', 'fats', 'margarine', 'products/Fats/Margarine/Blue Bell/Workbook Photos/Butter Margarine 3% (1 kg).webp', 3),
    ('blue-bell', 'fats', 'butter', 'Salted Culinary Butter', NULL, 'blue-bell', 'fats', 'butter', 'products/Fats/Butter/Blue Bell/Workbook Photos/Salted Culinary Butter.webp', 4),
    ('brooke', 'fats', 'butter', 'Lightly Salted Butter Blend 25%', NULL, 'brooke', 'fats', 'butter', 'products/Fats/Butter/Brooke/Workbook Photos/Lightly Salted Butter Blend 25%.webp', 5),
    ('brooke', 'fats', 'butter', 'Unsalted Butter Blend 25%', NULL, 'brooke', 'fats', 'butter', 'products/Fats/Butter/Brooke/Workbook Photos/Unsalted Butter Blend 25%.webp', 6),
    ('brooke', 'fats', 'butter', 'Lightly Salted Oliobutta Butter Blend 8%', NULL, 'brooke', 'fats', 'butter', 'products/Fats/Butter/Brooke/Workbook Photos/Lightly Salted Oliobutta Butter Blend 8%.webp', 7),
    ('brooke', 'fats', 'butter', 'Lightly Salted Melange Butter Blend 25%', NULL, 'brooke', 'fats', 'butter', 'products/Fats/Butter/Brooke/Workbook Photos/Lightly Salted Melange Butter Blend 25%.webp', 8),
    ('brooke', 'fats', 'cooking-oil', 'Frymaster Donut Soy Frying Oil', NULL, 'brooke', 'fats', 'cooking-oil', 'products/Fats/Cooking Oil/Brooke/Workbook Photos/Frymaster Donut Soy Frying Oil.webp', 9),
    ('brooke', 'fats', 'cooking-oil', 'Frymaster Elite Vegetable Frying Oil', NULL, 'brooke', 'fats', 'cooking-oil', 'products/Fats/Cooking Oil/Brooke/Workbook Photos/Frymaster Elite Vegetable Frying Oil.webp', 10),
    ('gold-box', 'fats', 'shortening', 'Baker''s Shortening', NULL, 'gold-box', 'fats', 'shortening', 'products/Fats/Shortening/Gold Box/Workbook Photos/Baker''s Shortening.webp', 11),
    ('gold-box', 'fats', 'margarine', 'Peak 4D Bio Margarine', NULL, 'gold-box', 'fats', 'margarine', 'products/Fats/Margarine/Gold Box/Workbook Photos/Peak 4D Bio Margarine.webp', 12),
    ('taroona', 'fats', 'butter', 'Butter Oil Substitute (BOS)', NULL, 'taroona', 'fats', 'butter', 'products/Fats/Butter/Taroona/Workbook Photos/Butter Oil Substitute (BOS).webp', 13);

UPDATE products p
JOIN brands prior_b ON prior_b.id = p.brand_id
JOIN categories prior_c ON prior_c.id = p.category_id
JOIN subcategories prior_sc ON prior_sc.id = p.subcategory_id AND prior_sc.category_id = prior_c.id
JOIN jimart_eapp_items item ON (
    CONVERT(prior_b.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.brand_slug
    AND CONVERT(prior_c.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.category_slug
    AND CONVERT(prior_sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.subcategory_slug
    AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
) OR (
    CONVERT(prior_b.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.prior_brand_slug
    AND CONVERT(prior_c.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.prior_category_slug
    AND CONVERT(prior_sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.prior_subcategory_slug
    AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci IN (item.name, item.legacy_name)
)
JOIN brands b ON CONVERT(b.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.brand_slug
JOIN categories c ON CONVERT(c.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.category_slug
JOIN subcategories sc ON sc.category_id = c.id AND CONVERT(sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.subcategory_slug
SET p.name = item.name, p.image_url = item.image_url, p.is_active = 1,
    p.brand_id = b.id, p.category_id = c.id, p.subcategory_id = sc.id;

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, item.image_url, c.id, sc.id, b.id, 1, item.sort_order
FROM jimart_eapp_items item
JOIN brands b ON CONVERT(b.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.brand_slug
JOIN categories c ON CONVERT(c.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.category_slug
JOIN subcategories sc ON sc.category_id = c.id AND CONVERT(sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.subcategory_slug
WHERE NOT EXISTS (
    SELECT 1 FROM products p
    WHERE p.brand_id = b.id AND p.subcategory_id = sc.id
      AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
);

DROP TEMPORARY TABLE jimart_eapp_items;
COMMIT;
