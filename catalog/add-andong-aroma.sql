-- Run against the website catalog database after deploying the Aroma photos.
START TRANSACTION;

SET @aroma_subcategory_id = (
    SELECT MIN(sc.id)
    FROM subcategories sc
    JOIN categories c ON c.id = sc.category_id
    WHERE c.slug = 'cooking-ingredients' AND sc.slug = 'frying-flour'
    HAVING COUNT(*) = 1
);

INSERT INTO brands (name, slug)
SELECT 'Aroma', 'aroma'
WHERE @aroma_subcategory_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'aroma' OR LOWER(name) = 'aroma');

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Cooking Ingredients/Frying Flour/Aroma/', item.filename, '.webp'),
       sc.category_id, sc.id, brand.id, 1, item.sort_order
FROM subcategories sc
CROSS JOIN (
    SELECT MIN(id) AS id
    FROM brands
    WHERE slug = 'aroma' OR LOWER(name) = 'aroma'
    HAVING COUNT(*) = 1
) brand
CROSS JOIN (
    SELECT 'All Purpose Seasoned Kentucky Crispy Flour (Original)' AS name,
           'All Purpose Seasoned Kentucky Crispy Flour (Original)' AS filename, 1 AS sort_order
    UNION ALL SELECT 'All Purpose Seasoned Kentucky Crispy Flour (Spicy)',
                     'All Purpose Seasoned Kentucky Crispy Flour Spicy', 2
    UNION ALL SELECT 'All Purpose Seasoned Kentucky Crispy Flour (Garlic and Spicy)',
                     'All Purpose Seasoned Kentucky Crispy Flour (Garlic and Spicy)', 3
    UNION ALL SELECT 'Tempura Flour', 'Tempura Flour', 4
    UNION ALL SELECT 'Banana Fritter Flour', 'Banana Fritter Flour', 5
    UNION ALL SELECT 'Banana and Cempedak Fritter Flour', 'Banana and Cempedak Fritter Flour', 6
    UNION ALL SELECT 'Waffle and Pancake Mix', 'Waffle and Pancake Mix', 7
) item
WHERE sc.id = @aroma_subcategory_id
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = brand.id
        AND (
            LOWER(p.name) IN (LOWER(item.name), LOWER(item.filename))
            OR p.image_url = CONCAT('products/Cooking Ingredients/Frying Flour/Aroma/', item.filename, '.webp')
        )
  );

COMMIT;
