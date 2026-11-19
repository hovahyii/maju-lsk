-- Run against the website catalog database after deploying the product images.
START TRANSACTION;

INSERT INTO brands (name, slug)
SELECT 'Nutrifres', 'nutrifres'
WHERE EXISTS (
    SELECT 1 FROM categories c
    JOIN subcategories sc ON sc.category_id = c.id
    WHERE c.slug = 'beverage' AND sc.slug IN ('fruit-juice', 'syrup')
)
AND NOT EXISTS (
    SELECT 1 FROM brands WHERE slug = 'nutrifres' OR name = 'Nutrifres'
);

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, item.image_url, c.id, sc.id, brand.id, 1, item.sort_order
FROM categories c
JOIN subcategories sc ON sc.category_id = c.id
JOIN (
    SELECT 'fruit-juice' AS subcategory, 'Honey Dew Concentrate (1 kg)' AS name,
           'products/Beverage/Fruit Juice/Nutrifres/Honey Dew Concentrate.webp' AS image_url, 1 AS sort_order
    UNION ALL SELECT 'syrup', 'Gula Melaka Syrup (1 kg)', 'products/Beverage/Syrup/Nutrifres/Gula Melaka Syrup.webp', 2
    UNION ALL SELECT 'fruit-juice', 'Calamansi Plum Concentrate (1 kg)', 'products/Beverage/Fruit Juice/Nutrifres/Calamansi Plum Concentrate.webp', 3
    UNION ALL SELECT 'fruit-juice', 'Kiwi Concentrate (1 kg)', 'products/Beverage/Fruit Juice/Nutrifres/Kiwi Concentrate.webp', 4
    UNION ALL SELECT 'fruit-juice', 'Mango Concentrate (1 kg)', 'products/Beverage/Fruit Juice/Nutrifres/Mango Concentrate.webp', 5
    UNION ALL SELECT 'fruit-juice', 'Honey Wheatgrass Concentrate (1 kg)', 'products/Beverage/Fruit Juice/Nutrifres/Honey Wheatgrass Concentrate.webp', 6
    UNION ALL SELECT 'fruit-juice', 'Pandan Wheatgrass Concentrate (1 kg)', 'products/Beverage/Fruit Juice/Nutrifres/Pandan Wheatgrass Concentrate.webp', 7
    UNION ALL SELECT 'fruit-juice', 'Lychee Concentrate (1 kg)', 'products/Beverage/Fruit Juice/Nutrifres/Lychee Concentrate.webp', 8
    UNION ALL SELECT 'fruit-juice', 'Orange Concentrate (1 kg)', 'products/Beverage/Fruit Juice/Nutrifres/Orange Concentrate.webp', 9
    UNION ALL SELECT 'fruit-juice', 'Winter Melon Concentrate (1 kg)', 'products/Beverage/Fruit Juice/Nutrifres/Winter Melon Concentrate.webp', 10
    UNION ALL SELECT 'fruit-juice', 'Lemon Concentrate (1 kg)', 'products/Beverage/Fruit Juice/Nutrifres/Lemon Concentrate.webp', 11
    UNION ALL SELECT 'fruit-juice', 'Strawberry Concentrate (1 kg)', 'products/Beverage/Fruit Juice/Nutrifres/Strawberry Concentrate.webp', 12
    UNION ALL SELECT 'fruit-juice', 'Pineapple Concentrate (1 kg)', 'products/Beverage/Fruit Juice/Nutrifres/Pineapple Concentrate.webp', 13
    UNION ALL SELECT 'fruit-juice', 'Soursop Concentrate (1 kg)', 'products/Beverage/Fruit Juice/Nutrifres/Soursop Concentrate.webp', 14
    UNION ALL SELECT 'fruit-juice', 'Sour Plum Concentrate (1 kg)', 'products/Beverage/Fruit Juice/Nutrifres/Sour Plum Concentrate.webp', 15
    UNION ALL SELECT 'fruit-juice', 'Blue Hawaii Concentrate (1 kg)', 'products/Beverage/Fruit Juice/Nutrifres/Blue Hawaii Concentrate.webp', 16
    UNION ALL SELECT 'fruit-juice', 'Mixed Tropical Fruits Concentrate (850 mL)', 'products/Beverage/Fruit Juice/Nutrifres/Mixed Tropical Fruits Concentrate.webp', 17
    UNION ALL SELECT 'fruit-juice', 'Honey Lemon Concentrate (850 mL)', 'products/Beverage/Fruit Juice/Nutrifres/Honey Lemon Concentrate.webp', 18
    UNION ALL SELECT 'fruit-juice', 'Peach Concentrate (850 mL)', 'products/Beverage/Fruit Juice/Nutrifres/Peach Concentrate.webp', 19
    UNION ALL SELECT 'syrup', 'Dark Chocolate Syrup (710 g)', 'products/Beverage/Syrup/Nutrifres/Dark Chocolate Syrup.webp', 20
    UNION ALL SELECT 'syrup', 'Mint Flavoured Syrup (750 mL)', 'products/Beverage/Syrup/Nutrifres/Mint Flavoured Syrup.webp', 21
    UNION ALL SELECT 'syrup', 'Sugar Cane Flavoured Syrup (750 mL)', 'products/Beverage/Syrup/Nutrifres/Sugar Cane Flavoured Syrup.webp', 22
    UNION ALL SELECT 'syrup', 'Strawberry Flavoured Syrup (750 mL)', 'products/Beverage/Syrup/Nutrifres/Strawberry Flavoured Syrup.webp', 23
    UNION ALL SELECT 'syrup', 'Crème Flavoured Syrup (750 mL)', 'products/Beverage/Syrup/Nutrifres/Creme Flavoured Syrup.webp', 24
    UNION ALL SELECT 'syrup', 'Vanilla Flavoured Syrup (750 mL)', 'products/Beverage/Syrup/Nutrifres/Vanilla Flavoured Syrup.webp', 25
    UNION ALL SELECT 'syrup', 'French Vanilla Flavoured Syrup (750 mL)', 'products/Beverage/Syrup/Nutrifres/French Vanilla Flavoured Syrup.webp', 26
    UNION ALL SELECT 'syrup', 'Hazelnut Flavoured Syrup (750 mL)', 'products/Beverage/Syrup/Nutrifres/Hazelnut Flavoured Syrup.webp', 27
    UNION ALL SELECT 'syrup', 'Roasted Hazelnut Flavoured Syrup (750 mL)', 'products/Beverage/Syrup/Nutrifres/Roasted Hazelnut Flavoured Syrup.webp', 28
    UNION ALL SELECT 'syrup', 'Toffee Nut Flavoured Syrup (750 mL)', 'products/Beverage/Syrup/Nutrifres/Toffee Nut Flavoured Syrup.webp', 29
    UNION ALL SELECT 'syrup', 'Butterscotch Flavoured Syrup (750 mL)', 'products/Beverage/Syrup/Nutrifres/Butterscotch Flavoured Syrup.webp', 30
    UNION ALL SELECT 'syrup', 'Caramel Flavoured Syrup (750 mL)', 'products/Beverage/Syrup/Nutrifres/Caramel Flavoured Syrup.webp', 31
    UNION ALL SELECT 'syrup', 'Salted Caramel Flavoured Syrup (750 mL)', 'products/Beverage/Syrup/Nutrifres/Salted Caramel Flavoured Syrup.webp', 32
) item ON item.subcategory = sc.slug
CROSS JOIN (
    SELECT MIN(id) AS id FROM brands WHERE slug = 'nutrifres' OR name = 'Nutrifres'
    HAVING COUNT(*) = 1
) brand
WHERE c.slug = 'beverage'
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = brand.id
        AND (p.name = item.name OR p.image_url = item.image_url)
  );

-- Retire each legacy range card once all individual cards in that range are active.
UPDATE products
SET is_active = 0
WHERE id IN (
    SELECT range_card.id
    FROM (
        SELECT legacy.id
        FROM products legacy
        JOIN brands b ON b.id = legacy.brand_id
        JOIN products individual ON individual.brand_id = legacy.brand_id
            AND individual.category_id = legacy.category_id
            AND individual.subcategory_id = legacy.subcategory_id
            AND individual.is_active = 1
            AND individual.image_url LIKE 'products/Beverage/%/Nutrifres/%.webp'
            AND individual.image_url NOT IN (
                'products/Beverage/Fruit Juice/Nutrifres/Concentrate.webp',
                'products/Beverage/Syrup/Nutrifres/Flavoured Syrup.webp'
            )
        WHERE (b.slug = 'nutrifres' OR b.name = 'Nutrifres')
          AND (
              (legacy.name IN ('Concentrate', 'Nutrifres Fruit Concentrate')
               AND legacy.image_url = 'products/Beverage/Fruit Juice/Nutrifres/Concentrate.webp')
              OR
              (legacy.name = 'Nutrifres Flavoured Syrup (750 mL)'
               AND legacy.image_url = 'products/Beverage/Syrup/Nutrifres/Flavoured Syrup.webp')
          )
        GROUP BY legacy.id, legacy.image_url
        HAVING COUNT(DISTINCT individual.image_url) >= CASE
            WHEN legacy.image_url = 'products/Beverage/Fruit Juice/Nutrifres/Concentrate.webp' THEN 18
            ELSE 14
        END
    ) range_card
);

COMMIT;

SELECT p.name, sc.name AS subcategory, p.image_url, p.is_active
FROM products p
JOIN brands b ON b.id = p.brand_id
JOIN subcategories sc ON sc.id = p.subcategory_id
WHERE (b.slug = 'nutrifres' OR b.name = 'Nutrifres')
  AND sc.slug IN ('fruit-juice', 'syrup')
  AND p.is_active = 1
ORDER BY p.sort_order, p.name;
