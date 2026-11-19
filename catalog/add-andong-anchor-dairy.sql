-- Run against the website catalog database after deploying the dairy images.
START TRANSACTION;

INSERT INTO categories (name, slug)
SELECT 'Dairy', 'dairy'
WHERE NOT EXISTS (
    SELECT 1 FROM categories WHERE slug IN ('dairy', 'dairy-products')
);

SET @dairy_category_id = (
    SELECT MIN(id)
    FROM categories
    WHERE slug IN ('dairy', 'dairy-products')
    HAVING COUNT(*) = 1
);

INSERT INTO subcategories (category_id, name, slug)
SELECT @dairy_category_id, incoming.name, incoming.slug
FROM (
    SELECT 'Butter' AS name, 'butter' AS slug
    UNION ALL SELECT 'Cream', 'cream'
    UNION ALL SELECT 'Milk', 'milk'
    UNION ALL SELECT 'Cheese', 'cheese'
) incoming
WHERE @dairy_category_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM subcategories sc
      WHERE sc.category_id = @dairy_category_id AND sc.slug = incoming.slug
  );

INSERT INTO brands (name, slug)
SELECT incoming.name, incoming.slug
FROM (
    SELECT 'Anchor' AS name, 'anchor' AS slug
    UNION ALL SELECT 'Chesdale', 'chesdale'
    UNION ALL SELECT 'Perfect Italiano', 'perfect-italiano'
) incoming
WHERE @dairy_category_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM brands b
      WHERE b.slug = incoming.slug
         OR LOWER(b.name) = LOWER(incoming.name)
         OR (incoming.slug = 'anchor' AND (
             b.slug = 'anchor-food-professionals' OR LOWER(b.name) = 'anchor food professionals'
         ))
  );

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, item.image_url, sc.category_id, sc.id, brand.id, 1, item.sort_order
FROM (
    SELECT 'butter' AS subcategory_slug, 'anchor' AS brand_key, 'Salted Minidish Butter' AS name, 'products/Dairy/Butter/Anchor/Salted Minidish Butter.webp' AS image_url, 1 AS sort_order
    UNION ALL SELECT 'butter', 'anchor', 'Unsalted Minidish Butter', 'products/Dairy/Butter/Anchor/Unsalted Minidish Butter.webp', 2
    UNION ALL SELECT 'butter', 'anchor', 'Salted Block Butter', 'products/Dairy/Butter/Anchor/Salted Block Butter.webp', 3
    UNION ALL SELECT 'butter', 'anchor', 'Unsalted Block Butter', 'products/Dairy/Butter/Anchor/Unsalted Block Butter.webp', 4
    UNION ALL SELECT 'butter', 'anchor', 'Salted Bulk Butter', 'products/Dairy/Butter/Anchor/Salted Bulk Butter.webp', 5
    UNION ALL SELECT 'butter', 'anchor', 'Unsalted Bulk Butter', 'products/Dairy/Butter/Anchor/Unsalted Bulk Butter.webp', 6
    UNION ALL SELECT 'butter', 'anchor', 'Unsalted Lactic Butter Sheet', 'products/Dairy/Butter/Anchor/Unsalted Lactic Butter Sheet.webp', 7
    UNION ALL SELECT 'butter', 'anchor', 'Salted Pat Butter', 'products/Dairy/Butter/Anchor/Salted Pat Butter.webp', 8
    UNION ALL SELECT 'butter', 'anchor', 'Unsalted Pat Butter (Foil)', 'products/Dairy/Butter/Anchor/Unsalted Pat Butter (Foil).webp', 9
    UNION ALL SELECT 'butter', 'anchor', 'Salted Tin Butter', 'products/Dairy/Butter/Anchor/Salted Tin Butter.webp', 10
    UNION ALL SELECT 'cream', 'anchor', 'UHT Whipping Cream', 'products/Dairy/Cream/Anchor/UHT Whipping Cream.webp', 11
    UNION ALL SELECT 'cream', 'anchor', 'Whipped Cream', 'products/Dairy/Cream/Anchor/Whipped Cream.webp', 12
    UNION ALL SELECT 'cream', 'anchor', 'Extra Yield Cooking Cream', 'products/Dairy/Cream/Anchor/Extra Yield Cooking Cream.webp', 13
    UNION ALL SELECT 'milk', 'anchor', 'UHT Full Cream Milk', 'products/Dairy/Milk/Anchor/UHT Full Cream Milk.webp', 14
    UNION ALL SELECT 'milk', 'anchor', 'UHT Low Fat Milk', 'products/Dairy/Milk/Anchor/UHT Low Fat Milk.webp', 15
    UNION ALL SELECT 'cheese', 'anchor', 'Mozzarella Shredded Cheese IQF', 'products/Dairy/Cheese/Anchor/Mozzarella Shredded Cheese IQF.webp', 16
    UNION ALL SELECT 'cheese', 'anchor', 'Mozzarella Block Cheese', 'products/Dairy/Cheese/Anchor/Mozzarella Block Cheese.webp', 17
    UNION ALL SELECT 'cheese', 'anchor', 'Colby & Cheddar Shredded Cheese', 'products/Dairy/Cheese/Anchor/Colby & Cheddar Shredded Cheese.webp', 18
    UNION ALL SELECT 'cheese', 'anchor', 'Cheddar Block Cheese (2 kg)', 'products/Dairy/Cheese/Anchor/Cheddar Block Cheese (2 kg).webp', 19
    UNION ALL SELECT 'cheese', 'anchor', 'Cheddar Block Cheese (5 kg)', 'products/Dairy/Cheese/Anchor/Cheddar Block Cheese (5 kg).webp', 20
    UNION ALL SELECT 'cheese', 'anchor', 'High Melt Processed Cheddar Cheese', 'products/Dairy/Cheese/Anchor/High Melt Processed Cheddar Cheese.webp', 21
    UNION ALL SELECT 'cheese', 'anchor', 'Cream Cheese Block (1 kg)', 'products/Dairy/Cheese/Anchor/Cream Cheese Block (1 kg).webp', 22
    UNION ALL SELECT 'cheese', 'anchor', 'Cream Cheese Block (20 kg)', 'products/Dairy/Cheese/Anchor/Cream Cheese Block (20 kg).webp', 23
    UNION ALL SELECT 'cheese', 'anchor', '84-Slice Processed Cheddar Cheese', 'products/Dairy/Cheese/Anchor/84-Slice Processed Cheddar Cheese.webp', 24
    UNION ALL SELECT 'cheese', 'anchor', '84-Slice Processed Cheddar Cheese (Coloured)', 'products/Dairy/Cheese/Anchor/84-Slice Processed Cheddar Cheese (Coloured).webp', 25
    UNION ALL SELECT 'cheese', 'chesdale', '48-Slice Processed Cheddar Cheese', 'products/Dairy/Cheese/Chesdale/48-Slice Processed Cheddar Cheese.webp', 26
    UNION ALL SELECT 'cheese', 'perfect-italiano', 'Grated Parmesan Cheese', 'products/Dairy/Cheese/Perfect Italiano/Grated Parmesan Cheese.webp', 27
) item
JOIN subcategories sc ON sc.slug = item.subcategory_slug AND sc.category_id = @dairy_category_id
JOIN (
    SELECT 'anchor' AS brand_key, MIN(id) AS id
    FROM brands
    WHERE slug IN ('anchor', 'anchor-food-professionals')
       OR LOWER(name) IN ('anchor', 'anchor food professionals')
    HAVING COUNT(*) = 1
    UNION ALL
    SELECT 'chesdale', MIN(id) FROM brands
    WHERE slug = 'chesdale' OR LOWER(name) = 'chesdale'
    HAVING COUNT(*) = 1
    UNION ALL
    SELECT 'perfect-italiano', MIN(id) FROM brands
    WHERE slug = 'perfect-italiano' OR LOWER(name) = 'perfect italiano'
    HAVING COUNT(*) = 1
) brand ON brand.brand_key = item.brand_key
WHERE NOT EXISTS (
    SELECT 1 FROM products p
    WHERE p.image_url = item.image_url
       OR (p.brand_id = brand.id AND p.subcategory_id = sc.id AND p.name = item.name)
);

COMMIT;
