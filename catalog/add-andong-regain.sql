-- Run against the website catalog database after deploying the Regain photos.
START TRANSACTION;

SET @regain_diapers_id = (
    SELECT MIN(sc.id)
    FROM subcategories sc
    JOIN categories c ON c.id = sc.category_id
    WHERE c.slug = 'consumables' AND sc.slug = 'diapers'
    HAVING COUNT(*) = 1
);

INSERT INTO brands (name, slug)
SELECT 'Regain', 'regain'
WHERE @regain_diapers_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'regain' OR LOWER(name) = 'regain');

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, CONCAT('products/Consumables/Diapers/Regain/', item.name, '.webp'),
       sc.category_id, sc.id, brand.id, 1, item.sort_order
FROM subcategories sc
CROSS JOIN (
    SELECT MIN(id) AS id FROM brands
    WHERE slug = 'regain' OR LOWER(name) = 'regain'
    HAVING COUNT(*) = 1
) brand
CROSS JOIN (
    SELECT 'Regain Adult Diapers M10' AS name, 1 AS sort_order
    UNION ALL SELECT 'Regain Adult Diapers L8', 2
    UNION ALL SELECT 'Regain Adult Diapers XL8', 3
    UNION ALL SELECT 'Regain Adult Pants M10', 4
    UNION ALL SELECT 'Regain Adult Pants L9', 5
    UNION ALL SELECT 'Regain Adult Pants XL8', 6
    UNION ALL SELECT 'Regain Adult Pants XXL7', 7
) item
WHERE sc.id = @regain_diapers_id
  AND NOT EXISTS (
      SELECT 1 FROM products p
      WHERE p.brand_id = brand.id
        AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
  );

COMMIT;
