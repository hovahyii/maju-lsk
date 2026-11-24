START TRANSACTION;

INSERT INTO brands (name, slug)
SELECT 'Redman', 'redman'
WHERE NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'redman');

UPDATE products p
JOIN brands current_brand ON current_brand.id = p.brand_id AND current_brand.slug = 'ever-whip'
JOIN brands redman ON redman.slug = 'redman'
JOIN categories c ON c.id = p.category_id AND c.slug = 'dairy'
JOIN subcategories sc ON sc.id = p.subcategory_id AND sc.category_id = c.id AND sc.slug = 'cream'
SET p.brand_id = redman.id,
    p.name = 'Non-Dairy Whipping Cream (Whip Topping)'
WHERE p.name = 'Non-Dairy Whip Topping Cream';

COMMIT;
