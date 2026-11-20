-- Syarikat Andong starches and frozen fruit. Deploy the product photos before importing.
DROP TEMPORARY TABLE IF EXISTS andong_starch_fruit_items;
START TRANSACTION;

INSERT INTO subcategories (category_id, name, slug)
SELECT c.id, source.name, source.slug
FROM (
    SELECT 'flour' AS category_slug, 'Starch' AS name, 'starch' AS slug
    UNION ALL SELECT 'cooking-ingredients', 'Custard Powder', 'custard-powder'
    UNION ALL SELECT 'frozen-food', 'Frozen Fruits', 'frozen-fruits'
    UNION ALL SELECT 'frozen-food', 'Smoothie Kits', 'smoothie-kits'
) source
JOIN categories c ON CONVERT(c.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = source.category_slug
WHERE NOT EXISTS (
    SELECT 1 FROM subcategories sc
    WHERE sc.category_id = c.id AND CONVERT(sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = source.slug
);

INSERT INTO brands (name, slug)
SELECT source.name, source.slug
FROM (
    SELECT 'Cap Kapal ABC' AS name, 'cap-kapal-abc' AS slug
    UNION ALL SELECT 'Cap Bintang', 'cap-bintang'
    UNION ALL SELECT 'Extra Natural', 'extra-natural'
) source
WHERE NOT EXISTS (
    SELECT 1 FROM brands b WHERE CONVERT(b.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = source.slug
);

CREATE TEMPORARY TABLE andong_starch_fruit_items (
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

INSERT INTO andong_starch_fruit_items
    (brand_slug, category_slug, subcategory_slug, name, legacy_name,
     prior_brand_slug, prior_category_slug, prior_subcategory_slug, image_url, sort_order)
VALUES
    ('cap-kapal-abc', 'flour', 'starch', 'Tapioca Starch (1 kg)', NULL, 'cap-kapal-abc', 'flour', 'starch', 'products/Flour/Starch/Cap Kapal ABC/Workbook Photos/Tapioca Starch (1 kg).webp', 1),
    ('cap-kapal-abc', 'flour', 'starch', 'Tapioca Starch (500 g)', NULL, 'cap-kapal-abc', 'flour', 'starch', 'products/Flour/Starch/Cap Kapal ABC/Workbook Photos/Tapioca Starch (500 g).webp', 2),
    ('cap-bintang', 'flour', 'starch', 'Potato Starch (1 kg)', NULL, 'cap-bintang', 'flour', 'starch', 'products/Flour/Starch/Cap Bintang/Workbook Photos/Potato Starch (1 kg).webp', 3),
    ('cap-bintang', 'flour', 'starch', 'Potato Starch (200 g)', NULL, 'cap-bintang', 'flour', 'starch', 'products/Flour/Starch/Cap Bintang/Workbook Photos/Potato Starch (200 g).webp', 4),
    ('cap-bintang', 'flour', 'starch', 'Corn Starch (1 kg)', NULL, 'cap-bintang', 'flour', 'starch', 'products/Flour/Starch/Cap Bintang/Workbook Photos/Corn Starch (1 kg).webp', 5),
    ('cap-bintang', 'flour', 'starch', 'Corn Starch (400 g)', NULL, 'cap-bintang', 'flour', 'starch', 'products/Flour/Starch/Cap Bintang/Workbook Photos/Corn Starch (400 g).webp', 6),
    ('cap-bintang', 'flour', 'starch', 'Wheat Starch', NULL, 'cap-bintang', 'flour', 'starch', 'products/Flour/Starch/Cap Bintang/Workbook Photos/Wheat Starch.webp', 7),
    ('cap-bintang', 'flour', 'starch', 'Green Bean Starch', NULL, 'cap-bintang', 'flour', 'starch', 'products/Flour/Starch/Cap Bintang/Workbook Photos/Green Bean Starch.webp', 8),
    ('cap-bintang', 'flour', 'starch', 'Sago Starch', NULL, 'cap-bintang', 'flour', 'starch', 'products/Flour/Starch/Cap Bintang/Workbook Photos/Sago Starch.webp', 9),
    ('cap-bintang', 'cooking-ingredients', 'custard-powder', 'Custard Powder', NULL, 'cap-bintang', 'cooking-ingredients', 'custard-powder', 'products/Cooking Ingredients/Custard Powder/Cap Bintang/Workbook Photos/Custard Powder.webp', 10),
    ('extra-natural', 'frozen-food', 'frozen-fruits', 'Frozen Strawberries', NULL, 'extra-natural', 'frozen-food', 'frozen-fruits', 'products/Frozen Food/Frozen Fruits/Extra Natural/Workbook Photos/Frozen Strawberries.webp', 11),
    ('extra-natural', 'frozen-food', 'frozen-fruits', 'Frozen Blueberries', NULL, 'extra-natural', 'frozen-food', 'frozen-fruits', 'products/Frozen Food/Frozen Fruits/Extra Natural/Workbook Photos/Frozen Blueberries.webp', 12),
    ('extra-natural', 'frozen-food', 'frozen-fruits', 'Frozen Raspberries', NULL, 'extra-natural', 'frozen-food', 'frozen-fruits', 'products/Frozen Food/Frozen Fruits/Extra Natural/Workbook Photos/Frozen Raspberries.webp', 13),
    ('extra-natural', 'frozen-food', 'frozen-fruits', 'Frozen Mixed Berries', NULL, 'extra-natural', 'frozen-food', 'frozen-fruits', 'products/Frozen Food/Frozen Fruits/Extra Natural/Workbook Photos/Frozen Mixed Berries.webp', 14),
    ('extra-natural', 'frozen-food', 'frozen-fruits', 'Frozen Blackberries', NULL, 'extra-natural', 'frozen-food', 'frozen-fruits', 'products/Frozen Food/Frozen Fruits/Extra Natural/Workbook Photos/Frozen Blackberries.webp', 15),
    ('extra-natural', 'frozen-food', 'frozen-fruits', 'Frozen Mango Cubes', NULL, 'extra-natural', 'frozen-food', 'frozen-fruits', 'products/Frozen Food/Frozen Fruits/Extra Natural/Workbook Photos/Frozen Mango Cubes.webp', 16),
    ('extra-natural', 'frozen-food', 'smoothie-kits', 'Fruit Mix Smoothie Kit - Berrylicious', NULL, 'extra-natural', 'frozen-food', 'smoothie-kits', 'products/Frozen Food/Smoothie Kits/Extra Natural/Workbook Photos/Fruit Mix Smoothie Kit - Berrylicious.webp', 17),
    ('extra-natural', 'frozen-food', 'smoothie-kits', 'Fruit Mix Smoothie Kit - Melon Crush', NULL, 'extra-natural', 'frozen-food', 'smoothie-kits', 'products/Frozen Food/Smoothie Kits/Extra Natural/Workbook Photos/Fruit Mix Smoothie Kit - Melon Crush.webp', 18),
    ('extra-natural', 'frozen-food', 'smoothie-kits', 'Fruit Mix Smoothie Kit - Hearty Green', NULL, 'extra-natural', 'frozen-food', 'smoothie-kits', 'products/Frozen Food/Smoothie Kits/Extra Natural/Workbook Photos/Fruit Mix Smoothie Kit - Hearty Green.webp', 19),
    ('extra-natural', 'frozen-food', 'smoothie-kits', 'Fruit Mix Smoothie Kit - Citrus Punch', NULL, 'extra-natural', 'frozen-food', 'smoothie-kits', 'products/Frozen Food/Smoothie Kits/Extra Natural/Workbook Photos/Fruit Mix Smoothie Kit - Citrus Punch.webp', 20),
    ('extra-natural', 'frozen-food', 'smoothie-kits', 'Fruit Mix Smoothie Kit - Tangy Tropical', NULL, 'extra-natural', 'frozen-food', 'smoothie-kits', 'products/Frozen Food/Smoothie Kits/Extra Natural/Workbook Photos/Fruit Mix Smoothie Kit - Tangy Tropical.webp', 21),
    ('extra-natural', 'frozen-food', 'smoothie-kits', 'Fruit Mix Smoothie Kit - Mango Passion', NULL, 'extra-natural', 'frozen-food', 'smoothie-kits', 'products/Frozen Food/Smoothie Kits/Extra Natural/Workbook Photos/Fruit Mix Smoothie Kit - Mango Passion.webp', 22);

UPDATE products p
JOIN brands prior_b ON prior_b.id = p.brand_id
JOIN categories prior_c ON prior_c.id = p.category_id
JOIN subcategories prior_sc ON prior_sc.id = p.subcategory_id AND prior_sc.category_id = prior_c.id
JOIN andong_starch_fruit_items item ON (
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
FROM andong_starch_fruit_items item
JOIN brands b ON CONVERT(b.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.brand_slug
JOIN categories c ON CONVERT(c.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.category_slug
JOIN subcategories sc ON sc.category_id = c.id AND CONVERT(sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.subcategory_slug
WHERE NOT EXISTS (
    SELECT 1 FROM products p
    WHERE p.brand_id = b.id AND p.subcategory_id = sc.id
      AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
);

DROP TEMPORARY TABLE andong_starch_fruit_items;
COMMIT;
