-- Run against the website catalog database after deploying the Arbella photos.
START TRANSACTION;

SET @arbella_pasta_subcategory_id = (
    SELECT MIN(sc.id)
    FROM subcategories sc
    JOIN categories c ON c.id = sc.category_id
    WHERE c.slug = 'cooking-ingredients' AND sc.slug = 'pasta'
    HAVING COUNT(*) = 1
);

INSERT INTO brands (name, slug)
SELECT 'Arbella', 'arbella'
WHERE @arbella_pasta_subcategory_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'arbella' OR LOWER(name) = 'arbella');

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Cooking Ingredients/Pasta/Arbella/', item.name, '.webp'),
       sc.category_id, sc.id, brand.id, 1, item.sort_order
FROM subcategories sc
CROSS JOIN (
    SELECT MIN(id) AS id
    FROM brands
    WHERE slug = 'arbella' OR LOWER(name) = 'arbella'
    HAVING COUNT(*) = 1
) brand
CROSS JOIN (
    SELECT 'Penne Rigate' AS name, 1 AS sort_order
    UNION ALL SELECT 'Shell Pasta', 2
    UNION ALL SELECT 'Fusilli', 3
    UNION ALL SELECT 'Elbow Pasta', 4
    UNION ALL SELECT 'Macaroni', 5
    UNION ALL SELECT 'Linguine', 6
    UNION ALL SELECT 'Fettuccine', 7
    UNION ALL SELECT 'Spaghetti (1.4 mm)', 8
    UNION ALL SELECT 'Spaghetti (1.9 mm)', 9
    UNION ALL SELECT 'Space Series Pasta', 10
    UNION ALL SELECT 'Semolina', 11
) item
WHERE sc.id = @arbella_pasta_subcategory_id
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = brand.id
        AND (
            LOWER(REPLACE(p.name, ' ', '')) = LOWER(REPLACE(item.name, ' ', ''))
            OR p.image_url = CONCAT('products/Cooking Ingredients/Pasta/Arbella/', item.name, '.webp')
        )
  );

COMMIT;
