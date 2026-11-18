-- Run after deploying the matching Adabi pack images.
START TRANSACTION;

SET @frozen_category_id = (
    SELECT id FROM categories
    WHERE slug IN ('frozen-food', 'frozen') OR name = 'Frozen Food'
    ORDER BY (slug = 'frozen-food') DESC, (slug = 'frozen') DESC, id
    LIMIT 1
);

INSERT INTO brands (name, slug)
SELECT 'Adabi', 'adabi'
WHERE @frozen_category_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'adabi' OR name = 'Adabi');

SET @adabi_brand_id = (
    SELECT id FROM brands
    WHERE slug = 'adabi' OR name = 'Adabi'
    ORDER BY (slug = 'adabi') DESC, id
    LIMIT 1
);

INSERT INTO products (name, image_url, brand_id, category_id, is_active, sort_order)
SELECT item.name, item.image_url, @adabi_brand_id, @frozen_category_id, 1, 0
FROM (
    SELECT 'Paratha (Original) (5 pcs, 400 g)' AS name, 'products/Frozen Food/Flatbread/Adabi/paratha-original.svg' AS image_url
    UNION ALL
    SELECT 'Paratha (Onion) (5 pcs, 400 g)' AS name, 'products/Frozen Food/Flatbread/Adabi/paratha-onion.svg' AS image_url
    UNION ALL
    SELECT 'Roti Canai (5 pcs, 400 g)' AS name, 'products/Frozen Food/Flatbread/Adabi/roti-canai.svg' AS image_url
    UNION ALL
    SELECT 'Capati (8 pcs, 400 g)' AS name, 'products/Frozen Food/Flatbread/Adabi/capati.svg' AS image_url
    UNION ALL
    SELECT 'Paratha (Original) with Chicken Curry (5 pcs, 600 g)' AS name, 'products/Frozen Food/Flatbread/Adabi/paratha-original-with-chicken-curry.svg' AS image_url
    UNION ALL
    SELECT 'Paratha (Onion) with Chicken Curry (5 pcs, 600 g)' AS name, 'products/Frozen Food/Flatbread/Adabi/paratha-onion-with-chicken-curry.svg' AS image_url
    UNION ALL
    SELECT 'Roti Canai with Chicken Curry (5 pcs, 600 g)' AS name, 'products/Frozen Food/Flatbread/Adabi/roti-canai-with-chicken-curry.svg' AS image_url
    UNION ALL
    SELECT 'Capati with Chicken Curry (8 pcs, 600 g)' AS name, 'products/Frozen Food/Flatbread/Adabi/capati-with-chicken-curry.svg' AS image_url
) AS item
WHERE @frozen_category_id IS NOT NULL
  AND @adabi_brand_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM products AS existing
      WHERE existing.brand_id = @adabi_brand_id
        AND (existing.name = item.name OR existing.image_url = item.image_url)
  );

COMMIT;

SELECT p.name, p.is_active, p.image_url
FROM products AS p
WHERE p.brand_id = @adabi_brand_id
  AND p.category_id = @frozen_category_id
  AND p.image_url LIKE 'products/Frozen Food/Flatbread/Adabi/%'
ORDER BY p.name;
