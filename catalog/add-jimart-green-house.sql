-- Run against the website catalog database after deploying the Green House photos.
START TRANSACTION;

SET @green_house_bakery_id = (
    SELECT MIN(id) FROM categories
    WHERE slug = 'bread-pastray-cakes-products'
    HAVING COUNT(*) = 1
);

INSERT INTO subcategories (category_id, name, slug)
SELECT @green_house_bakery_id, incoming.name, incoming.slug
FROM (
    SELECT 'Emulco and Flavouring' AS name, 'emulco-and-flavouring' AS slug
    UNION ALL SELECT 'Food Colouring', 'food-colouring'
) incoming
WHERE @green_house_bakery_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM subcategories sc
      WHERE sc.category_id = @green_house_bakery_id
        AND CONVERT(sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = incoming.slug
  );

INSERT INTO brands (name, slug)
SELECT 'Green House', 'greenhouse'
WHERE @green_house_bakery_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM brands
      WHERE slug IN ('greenhouse', 'green-house') OR LOWER(name) IN ('greenhouse', 'green house')
  );

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, item.image_url, sc.category_id, sc.id, brand.id, 1, item.sort_order
FROM (
    SELECT 'emulco-and-flavouring' AS subcategory_slug, 'Chocolate Emulco (500 g)' AS name, 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Chocolate Emulco (500 g).webp' AS image_url, 1 AS sort_order
    UNION ALL SELECT 'emulco-and-flavouring', 'Coffee Emulco (500 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Coffee Emulco (500 g).webp', 2
    UNION ALL SELECT 'emulco-and-flavouring', 'Espresso Emulco (500 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Espresso Emulco (500 g).webp', 3
    UNION ALL SELECT 'emulco-and-flavouring', 'Matcha Emulco (500 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Matcha Emulco (500 g).webp', 4
    UNION ALL SELECT 'emulco-and-flavouring', 'Pandan Coconut Emulco (500 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Pandan Coconut Emulco (500 g).webp', 5
    UNION ALL SELECT 'emulco-and-flavouring', 'Pistachio Emulco (500 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Pistachio Emulco (500 g).webp', 6
    UNION ALL SELECT 'emulco-and-flavouring', 'Red Velvet Emulco (500 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Red Velvet Emulco (500 g).webp', 7
    UNION ALL SELECT 'emulco-and-flavouring', 'Strawberry Emulco (500 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Strawberry Emulco (500 g).webp', 8
    UNION ALL SELECT 'emulco-and-flavouring', 'Vanilla Flavour (500 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Vanilla Flavour (500 g).webp', 9
    UNION ALL SELECT 'emulco-and-flavouring', 'Yam Emulco (500 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Yam Emulco (500 g).webp', 10
    UNION ALL SELECT 'food-colouring', 'Liquid Colour - Apple Green (500 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Liquid Colour - Apple Green (500 g).webp', 11
    UNION ALL SELECT 'food-colouring', 'Liquid Colour - Black (500 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Liquid Colour - Black (500 g).webp', 12
    UNION ALL SELECT 'food-colouring', 'Liquid Colour - Egg Yellow (500 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Liquid Colour - Egg Yellow (500 g).webp', 13
    UNION ALL SELECT 'food-colouring', 'Liquid Colour - Lemon Yellow (500 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Liquid Colour - Lemon Yellow (500 g).webp', 14
    UNION ALL SELECT 'food-colouring', 'Liquid Colour - Red (500 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Liquid Colour - Red (500 g).webp', 15
    UNION ALL SELECT 'food-colouring', 'Liquid Colour - White (500 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Liquid Colour - White (500 g).webp', 16
    UNION ALL SELECT 'emulco-and-flavouring', 'Chocolate Emulco (30 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Chocolate Emulco (30 g).webp', 17
    UNION ALL SELECT 'emulco-and-flavouring', 'Coffee Emulco (30 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Coffee Emulco (30 g).webp', 18
    UNION ALL SELECT 'emulco-and-flavouring', 'Pandan Coconut Emulco (30 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Pandan Coconut Emulco (30 g).webp', 19
    UNION ALL SELECT 'emulco-and-flavouring', 'Red Velvet Emulco (30 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Red Velvet Emulco (30 g).webp', 20
    UNION ALL SELECT 'emulco-and-flavouring', 'Vanilla Flavour (30 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Vanilla Flavour (30 g).webp', 21
    UNION ALL SELECT 'emulco-and-flavouring', 'Yam Emulco (30 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Yam Emulco (30 g).webp', 22
    UNION ALL SELECT 'emulco-and-flavouring', 'Pistachio Emulco (30 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Pistachio Emulco (30 g).webp', 23
    UNION ALL SELECT 'emulco-and-flavouring', 'Green Tea Emulco (30 g)', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Green Tea Emulco (30 g).webp', 24
    UNION ALL SELECT 'emulco-and-flavouring', 'Blueberry Emulco (30 g) - By Indent', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Blueberry Emulco (30 g) - By Indent.webp', 25
    UNION ALL SELECT 'emulco-and-flavouring', 'Cappuccino Emulco (30 g) - By Indent', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Cappuccino Emulco (30 g) - By Indent.webp', 26
    UNION ALL SELECT 'emulco-and-flavouring', 'Creamy Vanilla Emulco (30 g) - By Indent', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Creamy Vanilla Emulco (30 g) - By Indent.webp', 27
    UNION ALL SELECT 'emulco-and-flavouring', 'Durian Emulco (30 g) - By Indent', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Durian Emulco (30 g) - By Indent.webp', 28
    UNION ALL SELECT 'emulco-and-flavouring', 'Earl Grey Emulco (30 g) - By Indent', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Earl Grey Emulco (30 g) - By Indent.webp', 29
    UNION ALL SELECT 'emulco-and-flavouring', 'Gula Melaka Emulco (30 g) - By Indent', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Gula Melaka Emulco (30 g) - By Indent.webp', 30
    UNION ALL SELECT 'emulco-and-flavouring', 'Ruby Chocolate Emulco (30 g) - By Indent', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Ruby Chocolate Emulco (30 g) - By Indent.webp', 31
    UNION ALL SELECT 'emulco-and-flavouring', 'Strawberry Emulco (30 g) - By Indent', 'products/Bread, Pastray & Cakes Products/Emulco and Flavouring/Green House/Strawberry Emulco (30 g) - By Indent.webp', 32
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - Apple Green (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - Apple Green (30 g).webp', 33
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - Egg Yellow (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - Egg Yellow (30 g).webp', 34
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - Red (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - Red (30 g).webp', 35
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - Purple (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - Purple (30 g).webp', 36
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - White (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - White (30 g).webp', 37
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - Black (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - Black (30 g).webp', 38
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - Lemon Yellow (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - Lemon Yellow (30 g).webp', 39
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - Dark Green (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - Dark Green (30 g).webp', 40
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - Bright Red (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - Bright Red (30 g).webp', 41
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - Candy Pink (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - Candy Pink (30 g).webp', 42
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - Hot Pink (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - Hot Pink (30 g).webp', 43
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - Violet (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - Violet (30 g).webp', 44
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - Blue (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - Blue (30 g).webp', 45
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - Royal Blue (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - Royal Blue (30 g).webp', 46
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - Turquoise (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - Turquoise (30 g).webp', 47
    UNION ALL SELECT 'food-colouring', 'Gel Food Colour - Brown (30 g)', 'products/Bread, Pastray & Cakes Products/Food Colouring/Green House/Gel Food Colour - Brown (30 g).webp', 48
) item
JOIN subcategories sc ON sc.category_id = @green_house_bakery_id
    AND CONVERT(sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.subcategory_slug
CROSS JOIN (
    SELECT MIN(id) AS id
    FROM brands
    WHERE slug IN ('greenhouse', 'green-house') OR LOWER(name) IN ('greenhouse', 'green house')
    HAVING COUNT(*) = 1
) brand
WHERE NOT EXISTS (
    SELECT 1 FROM products p
    WHERE p.brand_id = brand.id AND p.subcategory_id = sc.id
      AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
);

COMMIT;
