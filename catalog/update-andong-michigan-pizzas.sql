-- Run against the website catalog database after deploying the Michigan photos.
START TRANSACTION;

UPDATE products p
JOIN brands b ON b.id = p.brand_id
JOIN subcategories sc ON sc.id = p.subcategory_id AND sc.category_id = p.category_id
JOIN categories c ON c.id = p.category_id
JOIN (
    SELECT 'All Cheese' AS previous_name, 'Masaleh All Cheese Pizza' AS name
    UNION ALL SELECT 'Beef Pepperoni', 'Masaleh Beef Pepperoni Pizza'
    UNION ALL SELECT 'Hawaiian Chicken', 'Masaleh Hawaiian Chicken Pizza'
) item ON CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci IN (item.previous_name, item.name)
SET p.name = item.name,
    p.image_url = CONCAT('products/Frozen Food/Pizza/michigan/Cutouts/', item.name, '.webp')
WHERE (b.slug = 'michigan' OR LOWER(b.name) = 'michigan')
  AND c.slug = 'frozen-food' AND sc.slug = 'pizza';

COMMIT;
