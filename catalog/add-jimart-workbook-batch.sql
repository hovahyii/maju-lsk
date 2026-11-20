-- Ji-Mart Enterprise workbook catalog. Deploy the product photos before importing.
DROP TEMPORARY TABLE IF EXISTS jimart_catalog_batch;
START TRANSACTION;

INSERT INTO subcategories (category_id, name, slug)
SELECT c.id, source.name, source.slug
FROM (
    SELECT 'cooking-ingredients' AS category_slug, 'Paste' AS name, 'paste' AS slug
    UNION ALL SELECT 'cooking-ingredients', 'Seasoning', 'seasoning'
    UNION ALL SELECT 'cooking-ingredients', 'Sauce', 'sauce'
    UNION ALL SELECT 'chocolate-products', 'Compound', 'compound'
    UNION ALL SELECT 'chocolate-products', 'Cocoa Powder', 'cocoa-powder'
    UNION ALL SELECT 'chocolate-products', 'Fillings', 'fillings'
    UNION ALL SELECT 'instant-food', 'Snacks', 'snacks'
    UNION ALL SELECT 'chocolate-products', 'Couverture', 'couverture'
    UNION ALL SELECT 'chocolate-products', 'Decorations', 'decorations'
    UNION ALL SELECT 'fats', 'Cooking Oil', 'cooking-oil'
    UNION ALL SELECT 'cooking-ingredients', 'Pasta', 'pasta'
    UNION ALL SELECT 'consumables', 'Animal Feed', 'animal-feed'
    UNION ALL SELECT 'cooking-ingredients', 'Frying Flour', 'frying-flour'
    UNION ALL SELECT 'sugar', 'Icing', 'icing'
    UNION ALL SELECT 'cooking-ingredients', 'Salt', 'salt'
    UNION ALL SELECT 'flour', 'Wheat Flour', 'wheat-flour'
    UNION ALL SELECT 'flour', 'Starch', 'starch'
    UNION ALL SELECT 'instant-food', 'Desserts', 'desserts'
    UNION ALL SELECT 'beverage', 'Fruit Juice', 'fruit-juice'
    UNION ALL SELECT 'dairy', 'Creamers', 'creamers'
    UNION ALL SELECT 'cooking-ingredients', 'Coconut Milk', 'coconut-milk'
    UNION ALL SELECT 'fats', 'Shortening', 'shortening'
    UNION ALL SELECT 'fats', 'Margarine', 'margarine'
    UNION ALL SELECT 'beverage', 'Syrup', 'syrup'
    UNION ALL SELECT 'beverage', 'Carbonated Drinks', 'carbonated-drinks'
    UNION ALL SELECT 'beverage', 'Water Gallon', 'water-gallon'
    UNION ALL SELECT 'beverage', 'Mineral Water', 'mineral-water'
    UNION ALL SELECT 'flour', 'Rice Flour', 'rice-flour'
    UNION ALL SELECT 'cooking-ingredients', 'Sago', 'sago'
    UNION ALL SELECT 'cooking-ingredients', 'Rice and Grains', 'rice-and-grains'
    UNION ALL SELECT 'cooking-ingredients', 'Dried Ingredients', 'dried-ingredients'
    UNION ALL SELECT 'sugar', 'Others', 'others'
    UNION ALL SELECT 'base', 'Seeds', 'seeds'
    UNION ALL SELECT 'cooking-ingredients', 'Beans and Pulses', 'beans-and-pulses'
    UNION ALL SELECT 'cooking-ingredients', 'Breadcrumbs', 'breadcrumbs'
) source
JOIN categories c ON CONVERT(c.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = source.category_slug
WHERE NOT EXISTS (
    SELECT 1 FROM subcategories sc
    WHERE sc.category_id = c.id AND CONVERT(sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = source.slug
);

INSERT INTO brands (name, slug)
SELECT source.name, source.slug
FROM (
    SELECT 'Tean''s Gourmet' AS name, 'tean-s-gourmet' AS slug
    UNION ALL SELECT 'Van Houten', 'van-houten'
    UNION ALL SELECT 'Win2', 'win2'
    UNION ALL SELECT 'Callebaut', 'callebaut'
    UNION ALL SELECT 'Cacao Barry', 'cacao-barry'
    UNION ALL SELECT 'Mona Lisa', 'mona-lisa'
    UNION ALL SELECT 'Cap Udang', 'cap-udang'
    UNION ALL SELECT 'Cap Mee Udang', 'cap-mee-udang'
    UNION ALL SELECT 'Cargill', 'cargill'
    UNION ALL SELECT 'Chin Kitchen', 'chin-kitchen'
    UNION ALL SELECT 'CP', 'cp'
    UNION ALL SELECT 'Gardens', 'gardens'
    UNION ALL SELECT 'Happy', 'happy'
    UNION ALL SELECT 'Jade Leaf Brand', 'jade-leaf-brand'
    UNION ALL SELECT 'NBI', 'nbi'
    UNION ALL SELECT 'Dadih', 'dadih'
    UNION ALL SELECT 'Yogee', 'yogee'
    UNION ALL SELECT 'N.O.I', 'no1'
    UNION ALL SELECT 'OK', 'ok'
    UNION ALL SELECT 'Peranakan Delights', 'peranakan-delights'
    UNION ALL SELECT 'Sampan', 'sampan'
    UNION ALL SELECT 'Yamie', 'yamie'
    UNION ALL SELECT 'M&S', 'm-s'
    UNION ALL SELECT 'Saraco', 'saraco'
    UNION ALL SELECT 'Crescent', 'crescent'
    UNION ALL SELECT 'Fritura', 'fritura'
    UNION ALL SELECT 'Sky Blue', 'sky-blue'
    UNION ALL SELECT 'Sunflower', 'sunflower'
) source
WHERE NOT EXISTS (
    SELECT 1 FROM brands b WHERE CONVERT(b.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = source.slug
);

CREATE TEMPORARY TABLE jimart_catalog_batch (
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

INSERT INTO jimart_catalog_batch
    (brand_slug, category_slug, subcategory_slug, name, legacy_name,
     prior_brand_slug, prior_category_slug, prior_subcategory_slug, image_url, sort_order)
VALUES
    ('tean-s-gourmet', 'cooking-ingredients', 'paste', 'Assam Paste for Seafood', 'Assam Fish Paste', 'tean-s-gourmet', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Tean''s Gourmet/Workbook Photos/Assam Paste for Seafood.webp', 1),
    ('tean-s-gourmet', 'cooking-ingredients', 'paste', 'Chicken Curry Paste', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Tean''s Gourmet/Workbook Photos/Chicken Curry Paste.webp', 2),
    ('tean-s-gourmet', 'cooking-ingredients', 'paste', 'Curry Laksa Paste', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Tean''s Gourmet/Workbook Photos/Curry Laksa Paste.webp', 3),
    ('tean-s-gourmet', 'cooking-ingredients', 'paste', 'Prawn Noodle Paste', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Tean''s Gourmet/Workbook Photos/Prawn Noodle Paste.webp', 4),
    ('tean-s-gourmet', 'cooking-ingredients', 'paste', 'Stir Fry Sauce Paste', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Tean''s Gourmet/Workbook Photos/Stir Fry Sauce Paste.webp', 5),
    ('tean-s-gourmet', 'cooking-ingredients', 'paste', 'Tom Yam Paste', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Tean''s Gourmet/Workbook Photos/Tom Yam Paste.webp', 6),
    ('tean-s-gourmet', 'cooking-ingredients', 'paste', 'Vegetarian Curry Paste', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Tean''s Gourmet/Workbook Photos/Vegetarian Curry Paste.webp', 7),
    ('tean-s-gourmet', 'cooking-ingredients', 'paste', 'Rendang Dry Curry Paste', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Tean''s Gourmet/Workbook Photos/Rendang Dry Curry Paste.webp', 8),
    ('tean-s-gourmet', 'cooking-ingredients', 'paste', 'Steaming Fish Paste (Nyonya Style)', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Tean''s Gourmet/Workbook Photos/Steaming Fish Paste (Nyonya Style).webp', 9),
    ('tean-s-gourmet', 'cooking-ingredients', 'paste', 'Fish Curry Paste', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Tean''s Gourmet/Workbook Photos/Fish Curry Paste.webp', 10),
    ('tean-s-gourmet', 'cooking-ingredients', 'paste', 'Hainanese Chicken Rice Paste', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Tean''s Gourmet/Workbook Photos/Hainanese Chicken Rice Paste.webp', 11),
    ('tean-s-gourmet', 'cooking-ingredients', 'paste', 'Assam Paste for Seafood (1 kg, By Indent)', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Tean''s Gourmet/Workbook Photos/Assam Paste for Seafood (1 kg, By Indent).webp', 12),
    ('tean-s-gourmet', 'cooking-ingredients', 'paste', 'Chicken Curry Paste (1 kg, By Indent)', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Tean''s Gourmet/Workbook Photos/Chicken Curry Paste (1 kg, By Indent).webp', 13),
    ('tean-s-gourmet', 'cooking-ingredients', 'paste', 'Curry Laksa Paste (1 kg, By Indent)', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Tean''s Gourmet/Workbook Photos/Curry Laksa Paste (1 kg, By Indent).webp', 14),
    ('tean-s-gourmet', 'cooking-ingredients', 'paste', 'Prawn Noodle Paste (1 kg, By Indent)', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Tean''s Gourmet/Workbook Photos/Prawn Noodle Paste (1 kg, By Indent).webp', 15),
    ('tean-s-gourmet', 'cooking-ingredients', 'seasoning', 'Herbs and Spices for Soup', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'seasoning', 'products/Cooking Ingredients/Seasoning/Tean''s Gourmet/Workbook Photos/Herbs and Spices for Soup.webp', 16),
    ('tean-s-gourmet', 'cooking-ingredients', 'seasoning', 'Klang Herbs and Spices for Soup Kau', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'seasoning', 'products/Cooking Ingredients/Seasoning/Tean''s Gourmet/Workbook Photos/Klang Herbs and Spices for Soup Kau.webp', 17),
    ('tean-s-gourmet', 'cooking-ingredients', 'seasoning', 'Ginseng Herbs Mix for Chicken Soup', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'seasoning', 'products/Cooking Ingredients/Seasoning/Tean''s Gourmet/Workbook Photos/Ginseng Herbs Mix for Chicken Soup.webp', 18),
    ('tean-s-gourmet', 'cooking-ingredients', 'seasoning', 'Herbal Mix for Chicken Soup', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'seasoning', 'products/Cooking Ingredients/Seasoning/Tean''s Gourmet/Workbook Photos/Herbal Mix for Chicken Soup.webp', 19),
    ('tean-s-gourmet', 'cooking-ingredients', 'seasoning', 'Emperor Chicken Herbs and Spices Mix', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'seasoning', 'products/Cooking Ingredients/Seasoning/Tean''s Gourmet/Workbook Photos/Emperor Chicken Herbs and Spices Mix.webp', 20),
    ('tean-s-gourmet', 'cooking-ingredients', 'sauce', 'Crispy Prawn Chilli (160 g)', 'Crispy Prawn Chilli', 'tean-s-gourmet', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Tean''s Gourmet/Workbook Photos/Crispy Prawn Chilli (160 g).webp', 21),
    ('tean-s-gourmet', 'cooking-ingredients', 'sauce', 'Crispy Anchovy Chilli (160 g)', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Tean''s Gourmet/Workbook Photos/Crispy Anchovy Chilli (160 g).webp', 22),
    ('tean-s-gourmet', 'cooking-ingredients', 'sauce', 'Crispy Chilli', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Tean''s Gourmet/Workbook Photos/Crispy Chilli.webp', 23),
    ('tean-s-gourmet', 'cooking-ingredients', 'sauce', 'Crispy Garlic Chilli', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Tean''s Gourmet/Workbook Photos/Crispy Garlic Chilli.webp', 24),
    ('tean-s-gourmet', 'cooking-ingredients', 'sauce', 'Crispy Mala Chilli', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Tean''s Gourmet/Workbook Photos/Crispy Mala Chilli.webp', 25),
    ('tean-s-gourmet', 'cooking-ingredients', 'sauce', 'Crispy Prawn Chilli (240 g)', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Tean''s Gourmet/Workbook Photos/Crispy Prawn Chilli (240 g).webp', 26),
    ('tean-s-gourmet', 'cooking-ingredients', 'sauce', 'Crispy Anchovy Chilli (240 g)', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Tean''s Gourmet/Workbook Photos/Crispy Anchovy Chilli (240 g).webp', 27),
    ('tean-s-gourmet', 'cooking-ingredients', 'sauce', 'Nasi Lemak Sambal Spicy Shrimp Sauce', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Tean''s Gourmet/Workbook Photos/Nasi Lemak Sambal Spicy Shrimp Sauce.webp', 28),
    ('tean-s-gourmet', 'cooking-ingredients', 'sauce', 'Spicy Belacan Paste', NULL, 'tean-s-gourmet', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Tean''s Gourmet/Workbook Photos/Spicy Belacan Paste.webp', 29),
    ('van-houten', 'chocolate-products', 'compound', 'Intense Dark Compound Block', NULL, 'van-houten', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Van Houten/Workbook Photos/Intense Dark Compound Block.webp', 30),
    ('van-houten', 'chocolate-products', 'compound', 'Semi Sweet Dark Compound Block', NULL, 'van-houten', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Van Houten/Workbook Photos/Semi Sweet Dark Compound Block.webp', 31),
    ('van-houten', 'chocolate-products', 'compound', 'Milk Compound Block', NULL, 'van-houten', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Van Houten/Workbook Photos/Milk Compound Block.webp', 32),
    ('van-houten', 'chocolate-products', 'compound', 'White Compound Block', NULL, 'van-houten', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Van Houten/Workbook Photos/White Compound Block.webp', 33),
    ('van-houten', 'chocolate-products', 'compound', 'Intense Dark Compound Button (1 kg)', 'Intense Dark Compound Button', 'van-houten', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Van Houten/Workbook Photos/Intense Dark Compound Button (1 kg).webp', 34),
    ('van-houten', 'chocolate-products', 'compound', 'Semi Sweet Dark Compound Button (1 kg)', 'Semi Sweet Dark Compound Button', 'van-houten', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Van Houten/Workbook Photos/Semi Sweet Dark Compound Button (1 kg).webp', 35),
    ('van-houten', 'chocolate-products', 'compound', 'Milk Compound Button', NULL, 'van-houten', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Van Houten/Workbook Photos/Milk Compound Button.webp', 36),
    ('van-houten', 'chocolate-products', 'compound', 'White Compound Button (1 kg)', 'White Compound Button', 'van-houten', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Van Houten/Workbook Photos/White Compound Button (1 kg).webp', 37),
    ('van-houten', 'chocolate-products', 'compound', 'Intense Dark Compound Button (10 kg)', NULL, 'van-houten', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Van Houten/Workbook Photos/Intense Dark Compound Button (10 kg).webp', 38),
    ('van-houten', 'chocolate-products', 'compound', 'Semi Sweet Dark Compound Button (10 kg)', NULL, 'van-houten', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Van Houten/Workbook Photos/Semi Sweet Dark Compound Button (10 kg).webp', 39),
    ('van-houten', 'chocolate-products', 'compound', 'White Compound Button (10 kg)', NULL, 'van-houten', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Van Houten/Workbook Photos/White Compound Button (10 kg).webp', 40),
    ('van-houten', 'chocolate-products', 'compound', 'Butterscotch', NULL, 'van-houten', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Van Houten/Workbook Photos/Butterscotch.webp', 41),
    ('van-houten', 'chocolate-products', 'compound', 'Semi Sweet Baking Chips 8000s (1 kg)', NULL, 'van-houten', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Van Houten/Workbook Photos/Semi Sweet Baking Chips 8000s (1 kg).webp', 42),
    ('van-houten', 'chocolate-products', 'compound', 'Semi Sweet Baking Chips 8000s (10 kg)', NULL, 'van-houten', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Van Houten/Workbook Photos/Semi Sweet Baking Chips 8000s (10 kg).webp', 43),
    ('van-houten', 'chocolate-products', 'compound', 'Semi Sweet Baking Chips 22000s (10 kg)', NULL, 'van-houten', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Van Houten/Workbook Photos/Semi Sweet Baking Chips 22000s (10 kg).webp', 44),
    ('van-houten', 'chocolate-products', 'cocoa-powder', 'Dark Brown Cocoa Powder 20-22', NULL, 'van-houten', 'chocolate-products', 'cocoa-powder', 'products/Chocolate Products/Cocoa Powder/Van Houten/Workbook Photos/Dark Brown Cocoa Powder 20-22.webp', 45),
    ('van-houten', 'chocolate-products', 'fillings', 'Chocolate Flavoured Filling', NULL, 'van-houten', 'chocolate-products', 'fillings', 'products/Chocolate Products/Fillings/Van Houten/Workbook Photos/Chocolate Flavoured Filling.webp', 46),
    ('win2', 'instant-food', 'snacks', 'Potato Crisp Tomato', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Potato Crisp Tomato.webp', 47),
    ('win2', 'instant-food', 'snacks', 'Potato Crisp Vegetable', 'Potato Crisp Vege Flav', 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Potato Crisp Vegetable.webp', 48),
    ('win2', 'instant-food', 'snacks', 'Potato Crisp BBQ', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Potato Crisp BBQ.webp', 49),
    ('win2', 'instant-food', 'snacks', 'Potato Crisp Sour Cream', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Potato Crisp Sour Cream.webp', 50),
    ('win2', 'instant-food', 'snacks', 'Potato Crisp Sweet Potato', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Potato Crisp Sweet Potato.webp', 51),
    ('win2', 'instant-food', 'snacks', 'Potato Crisp Sweet Corn', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Potato Crisp Sweet Corn.webp', 52),
    ('win2', 'instant-food', 'snacks', 'Potato Crisp BBQ (Box)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Potato Crisp BBQ (Box).webp', 53),
    ('win2', 'instant-food', 'snacks', 'Potato Crisp Vegetable (Box)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Potato Crisp Vegetable (Box).webp', 54),
    ('win2', 'instant-food', 'snacks', 'Potato Crisp Sour Cream (Box)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Potato Crisp Sour Cream (Box).webp', 55),
    ('win2', 'instant-food', 'snacks', 'Potato Crisp Sweet Corn (Box)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Potato Crisp Sweet Corn (Box).webp', 56),
    ('win2', 'instant-food', 'snacks', 'Magic Crunch Chocolate', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Magic Crunch Chocolate.webp', 57),
    ('win2', 'instant-food', 'snacks', 'Magic Crunch Strawberry', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Magic Crunch Strawberry.webp', 58),
    ('win2', 'instant-food', 'snacks', 'Magic Crunch Vanilla', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Magic Crunch Vanilla.webp', 59),
    ('win2', 'instant-food', 'snacks', 'Egg Tart Cake Original (Bag)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Egg Tart Cake Original (Bag).webp', 60),
    ('win2', 'instant-food', 'snacks', 'Egg Tart Cake Orange (Bag)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Egg Tart Cake Orange (Bag).webp', 61),
    ('win2', 'instant-food', 'snacks', 'Egg Tart Cake Original (Box)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Egg Tart Cake Original (Box).webp', 62),
    ('win2', 'instant-food', 'snacks', 'Egg Tart Cake Orange (Box)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Egg Tart Cake Orange (Box).webp', 63),
    ('win2', 'instant-food', 'snacks', 'Mini Muffin Original with Cream (Bag)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Mini Muffin Original with Cream (Bag).webp', 64),
    ('win2', 'instant-food', 'snacks', 'Mini Muffin Pandan with Cream (Bag)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Mini Muffin Pandan with Cream (Bag).webp', 65),
    ('win2', 'instant-food', 'snacks', 'Kokopie Chocolate with Vanilla Cream (Bag)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Kokopie Chocolate with Vanilla Cream (Bag).webp', 66),
    ('win2', 'instant-food', 'snacks', 'Mini Muffin Original with Cream (Box)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Mini Muffin Original with Cream (Box).webp', 67),
    ('win2', 'instant-food', 'snacks', 'Mini Muffin Pandan with Cream (Box)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Mini Muffin Pandan with Cream (Box).webp', 68),
    ('win2', 'instant-food', 'snacks', 'Kokopie Chocolate with Vanilla Cream (Box)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Kokopie Chocolate with Vanilla Cream (Box).webp', 69),
    ('win2', 'instant-food', 'snacks', 'Layer Cake Original', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Layer Cake Original.webp', 70),
    ('win2', 'instant-food', 'snacks', 'Layer Cake Pandan', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Layer Cake Pandan.webp', 71),
    ('win2', 'instant-food', 'snacks', 'Layer Cake Lemon', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Layer Cake Lemon.webp', 72),
    ('win2', 'instant-food', 'snacks', 'Chocolate Coated Layer Cake', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Chocolate Coated Layer Cake.webp', 73),
    ('win2', 'instant-food', 'snacks', 'Toasty Croutons Margarine Sugar (Box)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Toasty Croutons Margarine Sugar (Box).webp', 74),
    ('win2', 'instant-food', 'snacks', 'Toasty Croutons Garlic Butter (Box)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Toasty Croutons Garlic Butter (Box).webp', 75),
    ('win2', 'instant-food', 'snacks', 'Toasty Croutons Honey Mustard (Box)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Toasty Croutons Honey Mustard (Box).webp', 76),
    ('win2', 'instant-food', 'snacks', 'Toasty Croutons Margarine Sugar (100 g)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Toasty Croutons Margarine Sugar (100 g).webp', 77),
    ('win2', 'instant-food', 'snacks', 'Toasty Croutons Garlic Butter (100 g)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Toasty Croutons Garlic Butter (100 g).webp', 78),
    ('win2', 'instant-food', 'snacks', 'Toasty Croutons Honey Mustard (100 g)', NULL, 'win2', 'instant-food', 'snacks', 'products/Instant Food/Snacks/Win2/Workbook Photos/Toasty Croutons Honey Mustard (100 g).webp', 79),
    ('callebaut', 'chocolate-products', 'couverture', 'Dark Couverture Callets 70.5% (400 g)', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/Dark Couverture Callets 70.5% (400 g).webp', 80),
    ('callebaut', 'chocolate-products', 'couverture', 'Dark Couverture Callets 70.5% (2.5 kg)', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/Dark Couverture Callets 70.5% (2.5 kg).webp', 81),
    ('callebaut', 'chocolate-products', 'couverture', 'Dark Couverture Callets 70.5% (10 kg)', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/Dark Couverture Callets 70.5% (10 kg).webp', 82),
    ('callebaut', 'chocolate-products', 'couverture', 'Dark Couverture Callets 54.5% (400 g)', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/Dark Couverture Callets 54.5% (400 g).webp', 83),
    ('callebaut', 'chocolate-products', 'couverture', 'Dark Couverture Callets 54.5% (1 kg)', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/Dark Couverture Callets 54.5% (1 kg).webp', 84),
    ('callebaut', 'chocolate-products', 'couverture', 'Dark Couverture Callets 54.5% (2.5 kg)', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/Dark Couverture Callets 54.5% (2.5 kg).webp', 85),
    ('callebaut', 'chocolate-products', 'couverture', 'Dark Couverture Callets 54.5% (10 kg)', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/Dark Couverture Callets 54.5% (10 kg).webp', 86),
    ('callebaut', 'chocolate-products', 'couverture', 'Milk Couverture Callets 33.6% (400 g)', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/Milk Couverture Callets 33.6% (400 g).webp', 87),
    ('callebaut', 'chocolate-products', 'couverture', 'Milk Couverture Callets 33.6% (1 kg)', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/Milk Couverture Callets 33.6% (1 kg).webp', 88),
    ('callebaut', 'chocolate-products', 'couverture', 'Milk Couverture Callets 33.6% (2.5 kg)', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/Milk Couverture Callets 33.6% (2.5 kg).webp', 89),
    ('callebaut', 'chocolate-products', 'couverture', 'Milk Couverture Callets 33.6% (10 kg)', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/Milk Couverture Callets 33.6% (10 kg).webp', 90),
    ('callebaut', 'chocolate-products', 'couverture', 'White Couverture Callets 28% (400 g)', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/White Couverture Callets 28% (400 g).webp', 91),
    ('callebaut', 'chocolate-products', 'couverture', 'White Couverture Callets 28% (1 kg)', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/White Couverture Callets 28% (1 kg).webp', 92),
    ('callebaut', 'chocolate-products', 'couverture', 'White Couverture Callets 28% (2.5 kg)', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/White Couverture Callets 28% (2.5 kg).webp', 93),
    ('callebaut', 'chocolate-products', 'couverture', 'White Couverture Callets 28% (10 kg)', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/White Couverture Callets 28% (10 kg).webp', 94),
    ('callebaut', 'chocolate-products', 'couverture', 'Ruby Chocolate Callets 32.8%', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/Ruby Chocolate Callets 32.8%.webp', 95),
    ('callebaut', 'chocolate-products', 'couverture', 'Gold Caramel Chocolate 30.4%', NULL, 'callebaut', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Callebaut/Workbook Photos/Gold Caramel Chocolate 30.4%.webp', 96),
    ('callebaut', 'chocolate-products', 'decorations', 'Chocolate Sticks (8 cm, By Indent)', NULL, 'callebaut', 'chocolate-products', 'decorations', 'products/Chocolate Products/Decorations/Callebaut/Workbook Photos/Chocolate Sticks (8 cm, By Indent).webp', 97),
    ('cacao-barry', 'chocolate-products', 'cocoa-powder', 'Extra Brute Cocoa Powder', NULL, 'cacao-barry', 'chocolate-products', 'cocoa-powder', 'products/Chocolate Products/Cocoa Powder/Cacao Barry/Workbook Photos/Extra Brute Cocoa Powder.webp', 98),
    ('cacao-barry', 'chocolate-products', 'decorations', 'Pailleté Feuilletine', NULL, 'cacao-barry', 'chocolate-products', 'decorations', 'products/Chocolate Products/Decorations/Cacao Barry/Workbook Photos/Pailleté Feuilletine.webp', 99),
    ('cacao-barry', 'chocolate-products', 'fillings', 'Praline 50% Hazelnut', NULL, 'cacao-barry', 'chocolate-products', 'fillings', 'products/Chocolate Products/Fillings/Cacao Barry/Workbook Photos/Praline 50% Hazelnut.webp', 100),
    ('cacao-barry', 'chocolate-products', 'compound', 'Mycryo Cocoa Butter', NULL, 'cacao-barry', 'chocolate-products', 'compound', 'products/Chocolate Products/Compound/Cacao Barry/Workbook Photos/Mycryo Cocoa Butter.webp', 101),
    ('callebaut', 'chocolate-products', 'decorations', 'Dark Chocolate Crispearls', NULL, 'callebaut', 'chocolate-products', 'decorations', 'products/Chocolate Products/Decorations/Callebaut/Workbook Photos/Dark Chocolate Crispearls.webp', 102),
    ('callebaut', 'chocolate-products', 'decorations', 'Milk Chocolate Crispearls', NULL, 'callebaut', 'chocolate-products', 'decorations', 'products/Chocolate Products/Decorations/Callebaut/Workbook Photos/Milk Chocolate Crispearls.webp', 103),
    ('callebaut', 'chocolate-products', 'decorations', 'White Chocolate Crispearls', NULL, 'callebaut', 'chocolate-products', 'decorations', 'products/Chocolate Products/Decorations/Callebaut/Workbook Photos/White Chocolate Crispearls.webp', 104),
    ('callebaut', 'chocolate-products', 'decorations', 'Ruby Chocolate Crispearls', NULL, 'callebaut', 'chocolate-products', 'decorations', 'products/Chocolate Products/Decorations/Callebaut/Workbook Photos/Ruby Chocolate Crispearls.webp', 105),
    ('callebaut', 'chocolate-products', 'decorations', 'Salted Caramel Crispearls', NULL, 'callebaut', 'chocolate-products', 'decorations', 'products/Chocolate Products/Decorations/Callebaut/Workbook Photos/Salted Caramel Crispearls.webp', 106),
    ('mona-lisa', 'chocolate-products', 'decorations', 'Dark Chocolate Blossoms', NULL, 'mona-lisa', 'chocolate-products', 'decorations', 'products/Chocolate Products/Decorations/Mona Lisa/Workbook Photos/Dark Chocolate Blossoms.webp', 107),
    ('mona-lisa', 'chocolate-products', 'decorations', 'Milk Chocolate Blossoms', NULL, 'mona-lisa', 'chocolate-products', 'decorations', 'products/Chocolate Products/Decorations/Mona Lisa/Workbook Photos/Milk Chocolate Blossoms.webp', 108),
    ('mona-lisa', 'chocolate-products', 'decorations', 'White Chocolate Blossoms', NULL, 'mona-lisa', 'chocolate-products', 'decorations', 'products/Chocolate Products/Decorations/Mona Lisa/Workbook Photos/White Chocolate Blossoms.webp', 109),
    ('cap-udang', 'fats', 'cooking-oil', 'Cooking Oil (17 L)', 'Cooking Oil', 'cap-udang', 'fats', 'cooking-oil', 'products/Fats/Cooking Oil/Cap Udang/Workbook Photos/Cooking Oil (17 L).webp', 110),
    ('cap-udang', 'fats', 'cooking-oil', 'Cooking Oil (1.7 L)', NULL, 'cap-udang', 'fats', 'cooking-oil', 'products/Fats/Cooking Oil/Cap Udang/Workbook Photos/Cooking Oil (1.7 L).webp', 111),
    ('cap-mee-udang', 'cooking-ingredients', 'pasta', 'Rice Vermicelli (Mee Hoon)', NULL, 'cap-mee-udang', 'cooking-ingredients', 'pasta', 'products/Cooking Ingredients/Pasta/Cap Mee Udang/Workbook Photos/Rice Vermicelli (Mee Hoon).webp', 112),
    ('cargill', 'consumables', 'animal-feed', 'Broiler Starter Crumble (50 kg)', NULL, 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Broiler Starter Crumble (50 kg).webp', 113),
    ('cargill', 'consumables', 'animal-feed', 'Broiler Grower Pellet (50 kg)', NULL, 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Broiler Grower Pellet (50 kg).webp', 114),
    ('cargill', 'consumables', 'animal-feed', 'Rabbit Breeder Pellet (25 kg)', NULL, 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Rabbit Breeder Pellet (25 kg).webp', 115),
    ('cargill', 'consumables', 'animal-feed', 'Duck Layer Feed (50 kg)', NULL, 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Duck Layer Feed (50 kg).webp', 116),
    ('cargill', 'consumables', 'animal-feed', 'Broiler Starter Crumble (1 kg)', 'Broiler Starter Protein', 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Broiler Starter Crumble (1 kg).webp', 117),
    ('cargill', 'consumables', 'animal-feed', 'Broiler Grower Pellet (1 kg)', 'Broiler Grower Protein', 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Broiler Grower Pellet (1 kg).webp', 118),
    ('cargill', 'consumables', 'animal-feed', 'Standard Layer Pellet (1 kg)', 'Standard Layer Protein', 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Standard Layer Pellet (1 kg).webp', 119),
    ('cargill', 'consumables', 'animal-feed', 'Broiler Starter Crumble (2 kg)', NULL, 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Broiler Starter Crumble (2 kg).webp', 120),
    ('cargill', 'consumables', 'animal-feed', 'Broiler Grower Pellet (2 kg)', NULL, 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Broiler Grower Pellet (2 kg).webp', 121),
    ('cargill', 'consumables', 'animal-feed', 'Standard Layer Pellet (2 kg)', NULL, 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Standard Layer Pellet (2 kg).webp', 122),
    ('cargill', 'consumables', 'animal-feed', 'Domestic Starter Feed (1 kg)', 'Domestic Starter Protein', 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Domestic Starter Feed (1 kg).webp', 123),
    ('cargill', 'consumables', 'animal-feed', 'Domestic Grower Feed (1 kg)', 'Domestic Grower Protein', 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Domestic Grower Feed (1 kg).webp', 124),
    ('cargill', 'consumables', 'animal-feed', 'Domestic Starter Feed (2 kg)', NULL, 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Domestic Starter Feed (2 kg).webp', 125),
    ('cargill', 'consumables', 'animal-feed', 'Domestic Grower Feed (2 kg)', NULL, 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Domestic Grower Feed (2 kg).webp', 126),
    ('cargill', 'consumables', 'animal-feed', 'Rabbit Breeder Pellet (1 kg)', 'Rabbit Breeder Protein', 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Rabbit Breeder Pellet (1 kg).webp', 127),
    ('cargill', 'consumables', 'animal-feed', 'Duck Layer Feed (1 kg)', 'Duck Layer Protein', 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Duck Layer Feed (1 kg).webp', 128),
    ('cargill', 'consumables', 'animal-feed', 'Rumax Goat Feed (1 kg)', NULL, 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Rumax Goat Feed (1 kg).webp', 129),
    ('cargill', 'consumables', 'animal-feed', 'Rabbit Breeder Pellet (2 kg)', NULL, 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Rabbit Breeder Pellet (2 kg).webp', 130),
    ('cargill', 'consumables', 'animal-feed', 'Duck Layer Feed (2 kg)', NULL, 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Duck Layer Feed (2 kg).webp', 131),
    ('cargill', 'consumables', 'animal-feed', 'Rumax Goat Feed (2 kg)', NULL, 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Rumax Goat Feed (2 kg).webp', 132),
    ('cargill', 'consumables', 'animal-feed', 'Tilapia Starter Feed (2 mm, 1 kg)', 'Tilapia Starter Protein', 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Tilapia Starter Feed (2 mm, 1 kg).webp', 133),
    ('cargill', 'consumables', 'animal-feed', 'Patin Starter Feed (2 mm, 1 kg)', 'Patin Starter Protein', 'cargill', 'consumables', 'animal-feed', 'products/Consumables/Animal Feed/Cargill/Workbook Photos/Patin Starter Feed (2 mm, 1 kg).webp', 134),
    ('chin-kitchen', 'cooking-ingredients', 'frying-flour', 'Tepung Goreng Rangup - Garlic', NULL, 'chin-kitchen', 'cooking-ingredients', 'frying-flour', 'products/Cooking Ingredients/Frying Flour/Chin Kitchen/Workbook Photos/Tepung Goreng Rangup - Garlic.webp', 135),
    ('chin-kitchen', 'cooking-ingredients', 'frying-flour', 'Tepung Goreng Rangup - Original', NULL, 'chin-kitchen', 'cooking-ingredients', 'frying-flour', 'products/Cooking Ingredients/Frying Flour/Chin Kitchen/Workbook Photos/Tepung Goreng Rangup - Original.webp', 136),
    ('chin-kitchen', 'cooking-ingredients', 'frying-flour', 'Tepung Goreng Rangup - Chilli', NULL, 'chin-kitchen', 'cooking-ingredients', 'frying-flour', 'products/Cooking Ingredients/Frying Flour/Chin Kitchen/Workbook Photos/Tepung Goreng Rangup - Chilli.webp', 137),
    ('chin-kitchen', 'cooking-ingredients', 'frying-flour', 'Tepung Goreng Rangup - Turmeric', NULL, 'chin-kitchen', 'cooking-ingredients', 'frying-flour', 'products/Cooking Ingredients/Frying Flour/Chin Kitchen/Workbook Photos/Tepung Goreng Rangup - Turmeric.webp', 138),
    ('chin-kitchen', 'cooking-ingredients', 'frying-flour', 'Tepung Goreng Rangup - Curry', NULL, 'chin-kitchen', 'cooking-ingredients', 'frying-flour', 'products/Cooking Ingredients/Frying Flour/Chin Kitchen/Workbook Photos/Tepung Goreng Rangup - Curry.webp', 139),
    ('cp', 'sugar', 'icing', 'Maltose', 'Maltose', 'sunflower', 'sugar', 'icing', 'products/Sugar/Icing/CP/Workbook Photos/Maltose.webp', 140),
    ('gardens', 'cooking-ingredients', 'sauce', 'Chilli Sauce (340 g)', 'Chilli Sauce', 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Chilli Sauce (340 g).webp', 141),
    ('gardens', 'cooking-ingredients', 'sauce', 'Tomato Ketchup (330 g)', 'Tomato Ketchup', 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Tomato Ketchup (330 g).webp', 142),
    ('gardens', 'cooking-ingredients', 'sauce', 'Chilli Sauce Sachets', NULL, 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Chilli Sauce Sachets.webp', 143),
    ('gardens', 'cooking-ingredients', 'sauce', 'Tomato Sauce Sachets', NULL, 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Tomato Sauce Sachets.webp', 144),
    ('gardens', 'cooking-ingredients', 'sauce', 'Chilli Sauce (1 kg)', NULL, 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Chilli Sauce (1 kg).webp', 145),
    ('gardens', 'cooking-ingredients', 'sauce', 'Tomato Sauce (1 kg)', NULL, 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Tomato Sauce (1 kg).webp', 146),
    ('gardens', 'cooking-ingredients', 'sauce', 'Hickory Smoke BBQ Sauce (1 kg)', NULL, 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Hickory Smoke BBQ Sauce (1 kg).webp', 147),
    ('gardens', 'cooking-ingredients', 'sauce', 'Black Pepper Sauce (1 kg)', NULL, 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Black Pepper Sauce (1 kg).webp', 148),
    ('gardens', 'cooking-ingredients', 'sauce', 'Korean Hot Sauce', NULL, 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Korean Hot Sauce.webp', 149),
    ('gardens', 'cooking-ingredients', 'sauce', 'Thai Chilli Sauce (1 kg)', NULL, 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Thai Chilli Sauce (1 kg).webp', 150),
    ('gardens', 'cooking-ingredients', 'sauce', 'Chilli Sauce (500 g)', NULL, 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Chilli Sauce (500 g).webp', 151),
    ('gardens', 'cooking-ingredients', 'sauce', 'Chilli Garlic Sauce', NULL, 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Chilli Garlic Sauce.webp', 152),
    ('gardens', 'cooking-ingredients', 'sauce', 'Thai Chilli Sauce', NULL, 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Thai Chilli Sauce.webp', 153),
    ('gardens', 'cooking-ingredients', 'sauce', 'Tomato Ketchup (500 g)', NULL, 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Tomato Ketchup (500 g).webp', 154),
    ('gardens', 'cooking-ingredients', 'sauce', 'Hickory Smoked BBQ Sauce (Bottle)', NULL, 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Hickory Smoked BBQ Sauce (Bottle).webp', 155),
    ('gardens', 'cooking-ingredients', 'sauce', 'Black Pepper Sauce (Bottle)', NULL, 'gardens', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Gardens/Workbook Photos/Black Pepper Sauce (Bottle).webp', 156),
    ('happy', 'cooking-ingredients', 'salt', 'Iodised Refined Salt (500 g)', 'Iodised Refined Salt', 'happy', 'cooking-ingredients', 'salt', 'products/Cooking Ingredients/Salt/Happy/Workbook Photos/Iodised Refined Salt (500 g).webp', 157),
    ('happy', 'cooking-ingredients', 'salt', 'Iodised Refined Salt (1 kg)', NULL, 'happy', 'cooking-ingredients', 'salt', 'products/Cooking Ingredients/Salt/Happy/Workbook Photos/Iodised Refined Salt (1 kg).webp', 158),
    ('happy', 'cooking-ingredients', 'salt', 'Iodised White Salt (500 g)', 'Iodised White Salt', 'happy', 'cooking-ingredients', 'salt', 'products/Cooking Ingredients/Salt/Happy/Workbook Photos/Iodised White Salt (500 g).webp', 159),
    ('happy', 'cooking-ingredients', 'salt', 'Iodised White Salt (1 kg)', NULL, 'happy', 'cooking-ingredients', 'salt', 'products/Cooking Ingredients/Salt/Happy/Workbook Photos/Iodised White Salt (1 kg).webp', 160),
    ('jade-leaf-brand', 'flour', 'wheat-flour', 'Rice Flour', NULL, 'jade-leaf-brand', 'flour', 'wheat-flour', 'products/Flour/Wheat Flour/Jade Leaf Brand/Workbook Photos/Rice Flour.webp', 161),
    ('jade-leaf-brand', 'flour', 'wheat-flour', 'Glutinous Rice Flour', NULL, 'jade-leaf-brand', 'flour', 'wheat-flour', 'products/Flour/Wheat Flour/Jade Leaf Brand/Workbook Photos/Glutinous Rice Flour.webp', 162),
    ('jade-leaf-brand', 'flour', 'starch', 'Tapioca Starch (500 g)', NULL, 'jade-leaf-brand', 'flour', 'starch', 'products/Flour/Starch/Jade Leaf Brand/Workbook Photos/Tapioca Starch (500 g).webp', 163),
    ('jade-leaf-brand', 'flour', 'starch', 'Tapioca Starch (25 kg)', 'Tapioca Starch', 'jade-leaf-brand', 'flour', 'starch', 'products/Flour/Starch/Jade Leaf Brand/Workbook Photos/Tapioca Starch (25 kg).webp', 164),
    ('jade-leaf-brand', 'flour', 'starch', 'Corn Starch', NULL, 'jade-leaf-brand', 'flour', 'starch', 'products/Flour/Starch/Jade Leaf Brand/Workbook Photos/Corn Starch.webp', 165),
    ('nbi', 'instant-food', 'desserts', 'Drinking Jelly', NULL, 'nbi', 'instant-food', 'desserts', 'products/Instant Food/Desserts/NBI/Workbook Photos/Drinking Jelly.webp', 166),
    ('nbi', 'instant-food', 'desserts', 'Dadih Soya Fruits with Layer Jelly', NULL, 'nbi', 'instant-food', 'desserts', 'products/Instant Food/Desserts/NBI/Workbook Photos/Dadih Soya Fruits with Layer Jelly.webp', 167),
    ('nbi', 'instant-food', 'desserts', 'Dadih Soya Fruits with Nata de Coco', NULL, 'nbi', 'instant-food', 'desserts', 'products/Instant Food/Desserts/NBI/Workbook Photos/Dadih Soya Fruits with Nata de Coco.webp', 168),
    ('nbi', 'instant-food', 'desserts', 'Dadih Soya Fruits Pudding Assorted (16 Cups)', NULL, 'nbi', 'instant-food', 'desserts', 'products/Instant Food/Desserts/NBI/Workbook Photos/Dadih Soya Fruits Pudding Assorted (16 Cups).webp', 169),
    ('nbi', 'instant-food', 'desserts', 'Dadih Soya Fruits Pudding Assorted (20 Cups)', NULL, 'nbi', 'instant-food', 'desserts', 'products/Instant Food/Desserts/NBI/Workbook Photos/Dadih Soya Fruits Pudding Assorted (20 Cups).webp', 170),
    ('nbi', 'instant-food', 'desserts', 'Dadih Soya Fruits Pudding Assorted (45 Cups)', NULL, 'nbi', 'instant-food', 'desserts', 'products/Instant Food/Desserts/NBI/Workbook Photos/Dadih Soya Fruits Pudding Assorted (45 Cups).webp', 171),
    ('nbi', 'instant-food', 'desserts', 'Assorted Jelly', NULL, 'nbi', 'instant-food', 'desserts', 'products/Instant Food/Desserts/NBI/Workbook Photos/Assorted Jelly.webp', 172),
    ('nbi', 'instant-food', 'desserts', 'Yogurt Fruity Pudding', NULL, 'nbi', 'instant-food', 'desserts', 'products/Instant Food/Desserts/NBI/Workbook Photos/Yogurt Fruity Pudding.webp', 173),
    ('nbi', 'instant-food', 'desserts', 'Yogurt Fruity Pudding with Nata de Coco', NULL, 'nbi', 'instant-food', 'desserts', 'products/Instant Food/Desserts/NBI/Workbook Photos/Yogurt Fruity Pudding with Nata de Coco.webp', 174),
    ('nbi', 'instant-food', 'desserts', 'Dadih Iced Stick Soya Pudding', NULL, 'nbi', 'instant-food', 'desserts', 'products/Instant Food/Desserts/NBI/Workbook Photos/Dadih Iced Stick Soya Pudding.webp', 175),
    ('nbi', 'instant-food', 'desserts', 'Yogurt Berries Fruit Pudding with Nata de Coco', NULL, 'nbi', 'instant-food', 'desserts', 'products/Instant Food/Desserts/NBI/Workbook Photos/Yogurt Berries Fruit Pudding with Nata de Coco.webp', 176),
    ('nbi', 'instant-food', 'desserts', 'Nata de Coco - Gula Perang', NULL, 'nbi', 'instant-food', 'desserts', 'products/Instant Food/Desserts/NBI/Workbook Photos/Nata de Coco - Gula Perang.webp', 177),
    ('nbi', 'instant-food', 'desserts', 'Nata de Coco - Mango', NULL, 'nbi', 'instant-food', 'desserts', 'products/Instant Food/Desserts/NBI/Workbook Photos/Nata de Coco - Mango.webp', 178),
    ('nbi', 'instant-food', 'desserts', 'Nata de Coco - Lychee', NULL, 'nbi', 'instant-food', 'desserts', 'products/Instant Food/Desserts/NBI/Workbook Photos/Nata de Coco - Lychee.webp', 179),
    ('dadih', 'instant-food', 'desserts', 'Instant Soya Fruit Pudding Powder - Mango', 'Inst. Soya Fruits Pudding Powder Mango', 'dadih', 'instant-food', 'desserts', 'products/Instant Food/Desserts/Dadih/Workbook Photos/Instant Soya Fruit Pudding Powder - Mango.webp', 180),
    ('dadih', 'instant-food', 'desserts', 'Instant Soya Fruit Pudding Powder - Strawberry', 'Inst. Soya Fruits Pudding Powder Strawberry', 'dadih', 'instant-food', 'desserts', 'products/Instant Food/Desserts/Dadih/Workbook Photos/Instant Soya Fruit Pudding Powder - Strawberry.webp', 181),
    ('dadih', 'instant-food', 'desserts', 'Instant Soya Fruit Pudding Powder - Corn', 'Inst. Soya Fruits Pudding Powder Corn', 'dadih', 'instant-food', 'desserts', 'products/Instant Food/Desserts/Dadih/Workbook Photos/Instant Soya Fruit Pudding Powder - Corn.webp', 182),
    ('dadih', 'instant-food', 'desserts', 'Instant Soya Fruit Pudding Powder - Chocolate', 'Inst. Soya Fruits Pudding Powder Chocolate', 'dadih', 'instant-food', 'desserts', 'products/Instant Food/Desserts/Dadih/Workbook Photos/Instant Soya Fruit Pudding Powder - Chocolate.webp', 183),
    ('nbi', 'beverage', 'fruit-juice', 'Lemonade Fruit Drink with Jelly and Vitamin C', NULL, 'nbi', 'beverage', 'fruit-juice', 'products/Beverage/Fruit Juice/NBI/Workbook Photos/Lemonade Fruit Drink with Jelly and Vitamin C.webp', 184),
    ('nbi', 'beverage', 'fruit-juice', 'Mango Fruit Drink with Jelly and Vitamin C', NULL, 'nbi', 'beverage', 'fruit-juice', 'products/Beverage/Fruit Juice/NBI/Workbook Photos/Mango Fruit Drink with Jelly and Vitamin C.webp', 185),
    ('nbi', 'beverage', 'fruit-juice', 'Mixed Berry Fruit Drink with Jelly and Vitamin C', NULL, 'nbi', 'beverage', 'fruit-juice', 'products/Beverage/Fruit Juice/NBI/Workbook Photos/Mixed Berry Fruit Drink with Jelly and Vitamin C.webp', 186),
    ('yogee', 'instant-food', 'desserts', 'Konjac Jelly - Lychee (14 g)', NULL, 'yogee', 'instant-food', 'desserts', 'products/Instant Food/Desserts/Yogee/Workbook Photos/Konjac Jelly - Lychee (14 g).webp', 187),
    ('yogee', 'instant-food', 'desserts', 'Konjac Jelly - Mango (14 g)', NULL, 'yogee', 'instant-food', 'desserts', 'products/Instant Food/Desserts/Yogee/Workbook Photos/Konjac Jelly - Mango (14 g).webp', 188),
    ('yogee', 'instant-food', 'desserts', 'Konjac Jelly - Blackcurrant', NULL, 'yogee', 'instant-food', 'desserts', 'products/Instant Food/Desserts/Yogee/Workbook Photos/Konjac Jelly - Blackcurrant.webp', 189),
    ('yogee', 'instant-food', 'desserts', 'Konjac Jelly - Honeydew', NULL, 'yogee', 'instant-food', 'desserts', 'products/Instant Food/Desserts/Yogee/Workbook Photos/Konjac Jelly - Honeydew.webp', 190),
    ('yogee', 'instant-food', 'desserts', 'Konjac Jelly - Apple', 'Konjac Jelly Apple', 'yogee', 'instant-food', 'desserts', 'products/Instant Food/Desserts/Yogee/Workbook Photos/Konjac Jelly - Apple.webp', 191),
    ('yogee', 'instant-food', 'desserts', 'Konjac Jelly - Grape', 'Konjac Jelly Grape', 'yogee', 'instant-food', 'desserts', 'products/Instant Food/Desserts/Yogee/Workbook Photos/Konjac Jelly - Grape.webp', 192),
    ('yogee', 'instant-food', 'desserts', 'Isotonic Konjac Jelly - Lemon', 'Isotonic Konjac Jelly Lemon', 'yogee', 'instant-food', 'desserts', 'products/Instant Food/Desserts/Yogee/Workbook Photos/Isotonic Konjac Jelly - Lemon.webp', 193),
    ('yogee', 'instant-food', 'desserts', 'Konjac Jelly - Lychee (20 g)', NULL, 'yogee', 'instant-food', 'desserts', 'products/Instant Food/Desserts/Yogee/Workbook Photos/Konjac Jelly - Lychee (20 g).webp', 194),
    ('yogee', 'instant-food', 'desserts', 'Konjac Jelly - Mango (20 g)', NULL, 'yogee', 'instant-food', 'desserts', 'products/Instant Food/Desserts/Yogee/Workbook Photos/Konjac Jelly - Mango (20 g).webp', 195),
    ('yogee', 'instant-food', 'desserts', 'Konjac Jelly - Strawberry', NULL, 'yogee', 'instant-food', 'desserts', 'products/Instant Food/Desserts/Yogee/Workbook Photos/Konjac Jelly - Strawberry.webp', 196),
    ('no1', 'instant-food', 'snacks', 'Salted Cashewnut', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Salted Cashewnut.webp', 197),
    ('no1', 'instant-food', 'snacks', 'Salted Pistachios', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Salted Pistachios.webp', 198),
    ('no1', 'instant-food', 'snacks', 'All Natural Cocktail', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/All Natural Cocktail.webp', 199),
    ('no1', 'instant-food', 'snacks', 'Honey Almond', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Honey Almond.webp', 200),
    ('no1', 'instant-food', 'snacks', 'Cocktail Nuts', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Cocktail Nuts.webp', 201),
    ('no1', 'instant-food', 'snacks', 'Party Snacks', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Party Snacks.webp', 202),
    ('no1', 'instant-food', 'snacks', 'Salted Peanut', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Salted Peanut.webp', 203),
    ('no1', 'instant-food', 'snacks', 'Sesame Peanut', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Sesame Peanut.webp', 204),
    ('no1', 'instant-food', 'snacks', 'Coated Coconut Peanut', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Coated Coconut Peanut.webp', 205),
    ('no1', 'instant-food', 'snacks', 'Peanut Crackers', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Peanut Crackers.webp', 206),
    ('no1', 'instant-food', 'snacks', 'Salted Broad Beans without Skin', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Salted Broad Beans without Skin.webp', 207),
    ('no1', 'instant-food', 'snacks', 'Onion and Garlic Broad Beans without Skin', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Onion and Garlic Broad Beans without Skin.webp', 208),
    ('no1', 'instant-food', 'snacks', 'Satay Broad Beans', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Satay Broad Beans.webp', 209),
    ('no1', 'instant-food', 'snacks', 'Chilli Broad Beans', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Chilli Broad Beans.webp', 210),
    ('no1', 'instant-food', 'snacks', 'Onion Broad Beans', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Onion Broad Beans.webp', 211),
    ('no1', 'instant-food', 'snacks', 'Salted Green Peas', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Salted Green Peas.webp', 212),
    ('no1', 'instant-food', 'snacks', 'Coated Green Peas', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Coated Green Peas.webp', 213),
    ('no1', 'instant-food', 'snacks', 'White Sugar Peanut', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/White Sugar Peanut.webp', 214),
    ('no1', 'instant-food', 'snacks', 'Honey Cashewnut', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Honey Cashewnut.webp', 215),
    ('no1', 'instant-food', 'snacks', 'Seaweed With Almond Slices Original', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Seaweed With Almond Slices Original.webp', 216),
    ('no1', 'instant-food', 'snacks', 'Seaweed With Almond Slices Hot & Spicy', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Seaweed With Almond Slices Hot & Spicy.webp', 217),
    ('no1', 'instant-food', 'snacks', 'Seaweed with Pumpkin Seeds Original', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Seaweed with Pumpkin Seeds Original.webp', 218),
    ('no1', 'instant-food', 'snacks', 'Seaweed with Popping Grains Original', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Seaweed with Popping Grains Original.webp', 219),
    ('no1', 'instant-food', 'snacks', 'Real Potato Stick Lightly Salted', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Real Potato Stick Lightly Salted.webp', 220),
    ('no1', 'instant-food', 'snacks', 'Real Potato Stick Black Pepper', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Real Potato Stick Black Pepper.webp', 221),
    ('no1', 'instant-food', 'snacks', 'Real Potato Stick Hot & Spicy', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Real Potato Stick Hot & Spicy.webp', 222),
    ('no1', 'instant-food', 'snacks', 'Fun Stix Salted', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Fun Stix Salted.webp', 223),
    ('no1', 'instant-food', 'snacks', 'Potato Chips Salted', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Potato Chips Salted.webp', 224),
    ('no1', 'instant-food', 'snacks', 'Potato Chips Cream & Onion', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Potato Chips Cream & Onion.webp', 225),
    ('no1', 'instant-food', 'snacks', 'Salted Cassava Chips', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Salted Cassava Chips.webp', 226),
    ('no1', 'instant-food', 'snacks', 'Seaweed Wasabi Cassava Chips', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Seaweed Wasabi Cassava Chips.webp', 227),
    ('no1', 'instant-food', 'snacks', 'Sour Cream & Onion Cassava Chips', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Sour Cream & Onion Cassava Chips.webp', 228),
    ('no1', 'instant-food', 'snacks', 'Mixed Root Chips', NULL, 'no1', 'instant-food', 'snacks', 'products/Instant Food/Snacks/N.O.I/Workbook Photos/Mixed Root Chips.webp', 229),
    ('ok', 'dairy', 'creamers', 'Sweetened Creamer (Easy-Open Can with Cap)', NULL, 'ok', 'dairy', 'creamers', 'products/Dairy/Creamers/OK/Workbook Photos/Sweetened Creamer (Easy-Open Can with Cap).webp', 230),
    ('ok', 'dairy', 'creamers', 'Sweetened Creamer (Easy-Open Can)', NULL, 'ok', 'dairy', 'creamers', 'products/Dairy/Creamers/OK/Workbook Photos/Sweetened Creamer (Easy-Open Can).webp', 231),
    ('ok', 'dairy', 'creamers', 'Sweetened Beverage Creamer', NULL, 'ok', 'dairy', 'creamers', 'products/Dairy/Creamers/OK/Workbook Photos/Sweetened Beverage Creamer.webp', 232),
    ('ok', 'dairy', 'creamers', 'Evaporated Creamer', NULL, 'ok', 'dairy', 'creamers', 'products/Dairy/Creamers/OK/Workbook Photos/Evaporated Creamer.webp', 233),
    ('peranakan-delights', 'cooking-ingredients', 'paste', 'Nyonya Kapitan', NULL, 'peranakan-delights', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Peranakan Delights/Workbook Photos/Nyonya Kapitan.webp', 234),
    ('peranakan-delights', 'cooking-ingredients', 'paste', 'Nyonya Rendang', NULL, 'peranakan-delights', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Peranakan Delights/Workbook Photos/Nyonya Rendang.webp', 235),
    ('peranakan-delights', 'cooking-ingredients', 'paste', 'Nyonya Red Curry', NULL, 'peranakan-delights', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Peranakan Delights/Workbook Photos/Nyonya Red Curry.webp', 236),
    ('peranakan-delights', 'cooking-ingredients', 'paste', 'Nyonya Pongteh', NULL, 'peranakan-delights', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Peranakan Delights/Workbook Photos/Nyonya Pongteh.webp', 237),
    ('peranakan-delights', 'cooking-ingredients', 'paste', 'Nyonya Sauce', NULL, 'peranakan-delights', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Peranakan Delights/Workbook Photos/Nyonya Sauce.webp', 238),
    ('peranakan-delights', 'cooking-ingredients', 'paste', 'Nyonya Sambal', NULL, 'peranakan-delights', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/Peranakan Delights/Workbook Photos/Nyonya Sambal.webp', 239),
    ('sampan', 'cooking-ingredients', 'sauce', 'Chili Giling (Bottle)', NULL, 'sampan', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Sampan/Workbook Photos/Chili Giling (Bottle).webp', 240),
    ('sampan', 'cooking-ingredients', 'sauce', 'Tomato Sauce', NULL, 'sampan', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Sampan/Workbook Photos/Tomato Sauce.webp', 241),
    ('sampan', 'cooking-ingredients', 'sauce', 'Chili Giling (400 g)', NULL, 'sampan', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Sampan/Workbook Photos/Chili Giling (400 g).webp', 242),
    ('sampan', 'cooking-ingredients', 'sauce', 'Chili Giling (800 g)', NULL, 'sampan', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Sampan/Workbook Photos/Chili Giling (800 g).webp', 243),
    ('sampan', 'cooking-ingredients', 'sauce', 'Chili Giling (200 g)', NULL, 'sampan', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Sampan/Workbook Photos/Chili Giling (200 g).webp', 244),
    ('yamie', 'cooking-ingredients', 'sauce', 'Chilli Sauce Sachets', NULL, 'yamie', 'cooking-ingredients', 'sauce', 'products/Cooking Ingredients/Sauce/Yamie/Workbook Photos/Chilli Sauce Sachets.webp', 245),
    ('m-s', 'cooking-ingredients', 'coconut-milk', 'Coconut Milk', NULL, 'm-s', 'cooking-ingredients', 'coconut-milk', 'products/Cooking Ingredients/Coconut Milk/M&S/Workbook Photos/Coconut Milk.webp', 246),
    ('saraco', 'fats', 'cooking-oil', 'Pure Vegetable Oil (16 L)', NULL, 'saraco', 'fats', 'cooking-oil', 'products/Fats/Cooking Oil/Saraco/Workbook Photos/Pure Vegetable Oil (16 L).webp', 247),
    ('saraco', 'fats', 'cooking-oil', 'Pure Vegetable Oil (5 L)', NULL, 'saraco', 'fats', 'cooking-oil', 'products/Fats/Cooking Oil/Saraco/Workbook Photos/Pure Vegetable Oil (5 L).webp', 248),
    ('saraco', 'fats', 'cooking-oil', 'Pure Vegetable Oil (2 L)', NULL, 'saraco', 'fats', 'cooking-oil', 'products/Fats/Cooking Oil/Saraco/Workbook Photos/Pure Vegetable Oil (2 L).webp', 249),
    ('saraco', 'fats', 'shortening', 'Shortening 492', NULL, 'saraco', 'fats', 'shortening', 'products/Fats/Shortening/Saraco/Workbook Photos/Shortening 492.webp', 250),
    ('crescent', 'fats', 'margarine', 'Margarine 392 (18 kg)', NULL, 'crescent', 'fats', 'margarine', 'products/Fats/Margarine/Crescent/Workbook Photos/Margarine 392 (18 kg).webp', 251),
    ('crescent', 'fats', 'margarine', 'Margarine 392 (1 kg)', NULL, 'crescent', 'fats', 'margarine', 'products/Fats/Margarine/Crescent/Workbook Photos/Margarine 392 (1 kg).webp', 252),
    ('crescent', 'fats', 'margarine', 'Margarine 392 (500 g)', NULL, 'crescent', 'fats', 'margarine', 'products/Fats/Margarine/Crescent/Workbook Photos/Margarine 392 (500 g).webp', 253),
    ('fritura', 'fats', 'cooking-oil', 'Frying Oil Classic', NULL, 'fritura', 'fats', 'cooking-oil', 'products/Fats/Cooking Oil/Fritura/Workbook Photos/Frying Oil Classic.webp', 254),
    ('sky-blue', 'beverage', 'syrup', 'Rose', NULL, 'sky-blue', 'beverage', 'syrup', 'products/Beverage/Syrup/Sky Blue/Workbook Photos/Rose.webp', 255),
    ('sky-blue', 'beverage', 'syrup', 'Orange', NULL, 'sky-blue', 'beverage', 'syrup', 'products/Beverage/Syrup/Sky Blue/Workbook Photos/Orange.webp', 256),
    ('sky-blue', 'beverage', 'syrup', 'Banana', NULL, 'sky-blue', 'beverage', 'syrup', 'products/Beverage/Syrup/Sky Blue/Workbook Photos/Banana.webp', 257),
    ('sky-blue', 'beverage', 'syrup', 'Sarsi', NULL, 'sky-blue', 'beverage', 'syrup', 'products/Beverage/Syrup/Sky Blue/Workbook Photos/Sarsi.webp', 258),
    ('sky-blue', 'beverage', 'syrup', 'Mango', NULL, 'sky-blue', 'beverage', 'syrup', 'products/Beverage/Syrup/Sky Blue/Workbook Photos/Mango.webp', 259),
    ('sky-blue', 'beverage', 'syrup', 'Cherry', NULL, 'sky-blue', 'beverage', 'syrup', 'products/Beverage/Syrup/Sky Blue/Workbook Photos/Cherry.webp', 260),
    ('sky-blue', 'beverage', 'syrup', 'Lychee', NULL, 'sky-blue', 'beverage', 'syrup', 'products/Beverage/Syrup/Sky Blue/Workbook Photos/Lychee.webp', 261),
    ('sky-blue', 'beverage', 'syrup', 'Lemon', NULL, 'sky-blue', 'beverage', 'syrup', 'products/Beverage/Syrup/Sky Blue/Workbook Photos/Lemon.webp', 262),
    ('sky-blue', 'beverage', 'carbonated-drinks', 'Cherry', NULL, 'sky-blue', 'beverage', 'carbonated-drinks', 'products/Beverage/Carbonated Drinks/Sky Blue/Workbook Photos/Cherry.webp', 263),
    ('sky-blue', 'beverage', 'carbonated-drinks', 'Cream Soda', NULL, 'sky-blue', 'beverage', 'carbonated-drinks', 'products/Beverage/Carbonated Drinks/Sky Blue/Workbook Photos/Cream Soda.webp', 264),
    ('sky-blue', 'beverage', 'carbonated-drinks', 'Lemon', NULL, 'sky-blue', 'beverage', 'carbonated-drinks', 'products/Beverage/Carbonated Drinks/Sky Blue/Workbook Photos/Lemon.webp', 265),
    ('sky-blue', 'beverage', 'carbonated-drinks', 'Orange', NULL, 'sky-blue', 'beverage', 'carbonated-drinks', 'products/Beverage/Carbonated Drinks/Sky Blue/Workbook Photos/Orange.webp', 266),
    ('sky-blue', 'beverage', 'carbonated-drinks', 'Pineapple', NULL, 'sky-blue', 'beverage', 'carbonated-drinks', 'products/Beverage/Carbonated Drinks/Sky Blue/Workbook Photos/Pineapple.webp', 267),
    ('sky-blue', 'beverage', 'carbonated-drinks', 'Sarsi', NULL, 'sky-blue', 'beverage', 'carbonated-drinks', 'products/Beverage/Carbonated Drinks/Sky Blue/Workbook Photos/Sarsi.webp', 268),
    ('sky-blue', 'beverage', 'carbonated-drinks', 'Orange (PET Bottle)', NULL, 'sky-blue', 'beverage', 'carbonated-drinks', 'products/Beverage/Carbonated Drinks/Sky Blue/Workbook Photos/Orange (PET Bottle).webp', 269),
    ('sky-blue', 'beverage', 'carbonated-drinks', 'Sarsi (PET Bottle)', NULL, 'sky-blue', 'beverage', 'carbonated-drinks', 'products/Beverage/Carbonated Drinks/Sky Blue/Workbook Photos/Sarsi (PET Bottle).webp', 270),
    ('sky-blue', 'beverage', 'carbonated-drinks', 'Cream Soda (PET Bottle)', NULL, 'sky-blue', 'beverage', 'carbonated-drinks', 'products/Beverage/Carbonated Drinks/Sky Blue/Workbook Photos/Cream Soda (PET Bottle).webp', 271),
    ('sky-blue', 'beverage', 'carbonated-drinks', 'Cherry (PET Bottle)', NULL, 'sky-blue', 'beverage', 'carbonated-drinks', 'products/Beverage/Carbonated Drinks/Sky Blue/Workbook Photos/Cherry (PET Bottle).webp', 272),
    ('sky-blue', 'beverage', 'carbonated-drinks', 'Lemon (PET Bottle)', NULL, 'sky-blue', 'beverage', 'carbonated-drinks', 'products/Beverage/Carbonated Drinks/Sky Blue/Workbook Photos/Lemon (PET Bottle).webp', 273),
    ('sky-blue', 'beverage', 'carbonated-drinks', 'Pineapple (PET Bottle)', NULL, 'sky-blue', 'beverage', 'carbonated-drinks', 'products/Beverage/Carbonated Drinks/Sky Blue/Workbook Photos/Pineapple (PET Bottle).webp', 274),
    ('sky-blue', 'beverage', 'water-gallon', 'Empty Gallon (19 L)', 'Empty Gallon', 'sky-blue', 'beverage', 'water-gallon', 'products/Beverage/Water Gallon/Sky Blue/Workbook Photos/Empty Gallon (19 L).webp', 275),
    ('sky-blue', 'beverage', 'mineral-water', 'Drinking Water (1.5 L)', NULL, 'sky-blue', 'beverage', 'mineral-water', 'products/Beverage/Mineral Water/Sky Blue/Workbook Photos/Drinking Water (1.5 L).webp', 276),
    ('sky-blue', 'beverage', 'mineral-water', 'Drinking Water (500 mL)', NULL, 'sky-blue', 'beverage', 'mineral-water', 'products/Beverage/Mineral Water/Sky Blue/Workbook Photos/Drinking Water (500 mL).webp', 277),
    ('sunflower', 'flour', 'rice-flour', 'Corn Flour', NULL, 'sunflower', 'flour', 'rice-flour', 'products/Flour/Rice Flour/Sunflower/Workbook Photos/Corn Flour.webp', 278),
    ('sunflower', 'flour', 'rice-flour', 'White Corn Flour', NULL, 'sunflower', 'flour', 'rice-flour', 'products/Flour/Rice Flour/Sunflower/Workbook Photos/White Corn Flour.webp', 279),
    ('sunflower', 'flour', 'rice-flour', 'Hong Kong Flour', NULL, 'sunflower', 'flour', 'rice-flour', 'products/Flour/Rice Flour/Sunflower/Workbook Photos/Hong Kong Flour.webp', 280),
    ('sunflower', 'flour', 'rice-flour', 'Original Super Flour', NULL, 'sunflower', 'flour', 'rice-flour', 'products/Flour/Rice Flour/Sunflower/Workbook Photos/Original Super Flour.webp', 281),
    ('sunflower', 'flour', 'rice-flour', 'Plain Flour', NULL, 'sunflower', 'flour', 'rice-flour', 'products/Flour/Rice Flour/Sunflower/Workbook Photos/Plain Flour.webp', 282),
    ('sunflower', 'flour', 'rice-flour', 'Plain Wheat Flour', NULL, 'sunflower', 'flour', 'rice-flour', 'products/Flour/Rice Flour/Sunflower/Workbook Photos/Plain Wheat Flour.webp', 283),
    ('sunflower', 'flour', 'rice-flour', 'Soon Kuay Flour', NULL, 'sunflower', 'flour', 'rice-flour', 'products/Flour/Rice Flour/Sunflower/Workbook Photos/Soon Kuay Flour.webp', 284),
    ('sunflower', 'flour', 'rice-flour', 'Super Flour', NULL, 'sunflower', 'flour', 'rice-flour', 'products/Flour/Rice Flour/Sunflower/Workbook Photos/Super Flour.webp', 285),
    ('sunflower', 'flour', 'rice-flour', 'Tim Sum Flour', NULL, 'sunflower', 'flour', 'rice-flour', 'products/Flour/Rice Flour/Sunflower/Workbook Photos/Tim Sum Flour.webp', 286),
    ('sunflower', 'flour', 'starch', 'Potato Starch', NULL, 'sunflower', 'flour', 'starch', 'products/Flour/Starch/Sunflower/Workbook Photos/Potato Starch.webp', 287),
    ('sunflower', 'flour', 'starch', 'Sweet Potato Starch', NULL, 'sunflower', 'flour', 'starch', 'products/Flour/Starch/Sunflower/Workbook Photos/Sweet Potato Starch.webp', 288),
    ('sunflower', 'flour', 'starch', 'Tapioca Starch', NULL, 'sunflower', 'flour', 'starch', 'products/Flour/Starch/Sunflower/Workbook Photos/Tapioca Starch.webp', 289),
    ('sunflower', 'cooking-ingredients', 'sago', 'Sago Powder', NULL, 'sunflower', 'cooking-ingredients', 'sago', 'products/Cooking Ingredients/Sago/Sunflower/Workbook Photos/Sago Powder.webp', 290),
    ('sunflower', 'cooking-ingredients', 'sago', 'Pandan Sago', NULL, 'sunflower', 'cooking-ingredients', 'sago', 'products/Cooking Ingredients/Sago/Sunflower/Workbook Photos/Pandan Sago.webp', 291),
    ('sunflower', 'cooking-ingredients', 'sago', 'Small Sago', NULL, 'sunflower', 'cooking-ingredients', 'sago', 'products/Cooking Ingredients/Sago/Sunflower/Workbook Photos/Small Sago.webp', 292),
    ('sunflower', 'cooking-ingredients', 'sago', 'Coarse Sago', NULL, 'sunflower', 'cooking-ingredients', 'sago', 'products/Cooking Ingredients/Sago/Sunflower/Workbook Photos/Coarse Sago.webp', 293),
    ('sunflower', 'cooking-ingredients', 'rice-and-grains', 'Black Glutinous Rice', NULL, 'sunflower', 'cooking-ingredients', 'rice-and-grains', 'products/Cooking Ingredients/Rice and Grains/Sunflower/Workbook Photos/Black Glutinous Rice.webp', 294),
    ('sunflower', 'cooking-ingredients', 'rice-and-grains', 'Red Milled Rice', NULL, 'sunflower', 'cooking-ingredients', 'rice-and-grains', 'products/Cooking Ingredients/Rice and Grains/Sunflower/Workbook Photos/Red Milled Rice.webp', 295),
    ('sunflower', 'cooking-ingredients', 'rice-and-grains', 'Undermilled Rice', NULL, 'sunflower', 'cooking-ingredients', 'rice-and-grains', 'products/Cooking Ingredients/Rice and Grains/Sunflower/Workbook Photos/Undermilled Rice.webp', 296),
    ('sunflower', 'cooking-ingredients', 'rice-and-grains', 'Holland Barley', NULL, 'sunflower', 'cooking-ingredients', 'rice-and-grains', 'products/Cooking Ingredients/Rice and Grains/Sunflower/Workbook Photos/Holland Barley.webp', 297),
    ('sunflower', 'cooking-ingredients', 'dried-ingredients', 'Dried Winter Melon', NULL, 'sunflower', 'cooking-ingredients', 'dried-ingredients', 'products/Cooking Ingredients/Dried Ingredients/Sunflower/Workbook Photos/Dried Winter Melon.webp', 298),
    ('sunflower', 'sugar', 'others', 'Red Sugar', NULL, 'sunflower', 'sugar', 'others', 'products/Sugar/Others/Sunflower/Workbook Photos/Red Sugar.webp', 299),
    ('sunflower', 'sugar', 'others', 'Black Sugar', NULL, 'sunflower', 'sugar', 'others', 'products/Sugar/Others/Sunflower/Workbook Photos/Black Sugar.webp', 300),
    ('sunflower', 'sugar', 'others', 'Brown Sugar', NULL, 'sunflower', 'sugar', 'others', 'products/Sugar/Others/Sunflower/Workbook Photos/Brown Sugar.webp', 301),
    ('sunflower', 'sugar', 'others', 'Caster Sugar', NULL, 'sunflower', 'sugar', 'others', 'products/Sugar/Others/Sunflower/Workbook Photos/Caster Sugar.webp', 302),
    ('sunflower', 'sugar', 'icing', 'Icing Sugar', NULL, 'sunflower', 'sugar', 'icing', 'products/Sugar/Icing/Sunflower/Workbook Photos/Icing Sugar.webp', 303),
    ('sunflower', 'cooking-ingredients', 'dried-ingredients', 'Fa Cai Zhai Cai', NULL, 'sunflower', 'cooking-ingredients', 'dried-ingredients', 'products/Cooking Ingredients/Dried Ingredients/Sunflower/Workbook Photos/Fa Cai Zhai Cai.webp', 304),
    ('sunflower', 'cooking-ingredients', 'dried-ingredients', 'Bean Curd Skin', NULL, 'sunflower', 'cooking-ingredients', 'dried-ingredients', 'products/Cooking Ingredients/Dried Ingredients/Sunflower/Workbook Photos/Bean Curd Skin.webp', 305),
    ('sunflower', 'base', 'seeds', 'Black Sesame', NULL, 'sunflower', 'base', 'seeds', 'products/Base/Seeds/Sunflower/Workbook Photos/Black Sesame.webp', 306),
    ('sunflower', 'base', 'seeds', 'White Sesame', NULL, 'sunflower', 'base', 'seeds', 'products/Base/Seeds/Sunflower/Workbook Photos/White Sesame.webp', 307),
    ('sunflower', 'cooking-ingredients', 'rice-and-grains', 'Chinese Barley', NULL, 'sunflower', 'cooking-ingredients', 'rice-and-grains', 'products/Cooking Ingredients/Rice and Grains/Sunflower/Workbook Photos/Chinese Barley.webp', 308),
    ('sunflower', 'cooking-ingredients', 'beans-and-pulses', 'Green Beans', NULL, 'sunflower', 'cooking-ingredients', 'beans-and-pulses', 'products/Cooking Ingredients/Beans and Pulses/Sunflower/Workbook Photos/Green Beans.webp', 309),
    ('sunflower', 'cooking-ingredients', 'beans-and-pulses', 'Green Beans and Sago', 'Green Beans + Sago', 'sunflower', 'cooking-ingredients', 'beans-and-pulses', 'products/Cooking Ingredients/Beans and Pulses/Sunflower/Workbook Photos/Green Beans and Sago.webp', 310),
    ('sunflower', 'cooking-ingredients', 'beans-and-pulses', 'Red Beans', NULL, 'sunflower', 'cooking-ingredients', 'beans-and-pulses', 'products/Cooking Ingredients/Beans and Pulses/Sunflower/Workbook Photos/Red Beans.webp', 311),
    ('sunflower', 'cooking-ingredients', 'beans-and-pulses', 'Red Beans and Sago', 'Red Beans + Sago', 'sunflower', 'cooking-ingredients', 'beans-and-pulses', 'products/Cooking Ingredients/Beans and Pulses/Sunflower/Workbook Photos/Red Beans and Sago.webp', 312),
    ('sunflower', 'cooking-ingredients', 'breadcrumbs', 'White Bread Crumbs', NULL, 'sunflower', 'cooking-ingredients', 'breadcrumbs', 'products/Cooking Ingredients/Breadcrumbs/Sunflower/Workbook Photos/White Bread Crumbs.webp', 313),
    ('sunflower', 'cooking-ingredients', 'breadcrumbs', 'Yellow Bread Crumbs', 'Yelllow Bread Crumbs', 'sunflower', 'cooking-ingredients', 'breadcrumbs', 'products/Cooking Ingredients/Breadcrumbs/Sunflower/Workbook Photos/Yellow Bread Crumbs.webp', 314),
    ('sunflower', 'cooking-ingredients', 'breadcrumbs', 'Orange Bread Crumbs', NULL, 'sunflower', 'cooking-ingredients', 'breadcrumbs', 'products/Cooking Ingredients/Breadcrumbs/Sunflower/Workbook Photos/Orange Bread Crumbs.webp', 315),
    ('van-houten', 'chocolate-products', 'couverture', 'Dark Couverture Buttons (65.7%)', NULL, 'van-houten', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Van Houten/Workbook Photos/Dark Couverture Buttons (65.7%).webp', 316),
    ('van-houten', 'chocolate-products', 'couverture', 'Dark Couverture Buttons (53%)', 'Dark Couverture Button', 'van-houten', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Van Houten/Workbook Photos/Dark Couverture Buttons (53%).webp', 317),
    ('van-houten', 'chocolate-products', 'couverture', 'Milk Couverture Buttons (29.5%)', 'Milk Couverture Button', 'van-houten', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Van Houten/Workbook Photos/Milk Couverture Buttons (29.5%).webp', 318),
    ('van-houten', 'chocolate-products', 'couverture', 'White Couverture Buttons (23.7%)', NULL, 'van-houten', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Van Houten/Workbook Photos/White Couverture Buttons (23.7%).webp', 319);

UPDATE products p
JOIN brands prior_b ON prior_b.id = p.brand_id
JOIN categories prior_c ON prior_c.id = p.category_id
JOIN subcategories prior_sc ON prior_sc.id = p.subcategory_id AND prior_sc.category_id = prior_c.id
JOIN jimart_catalog_batch item ON (
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
FROM jimart_catalog_batch item
JOIN brands b ON CONVERT(b.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.brand_slug
JOIN categories c ON CONVERT(c.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.category_slug
JOIN subcategories sc ON sc.category_id = c.id AND CONVERT(sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.subcategory_slug
WHERE NOT EXISTS (
    SELECT 1 FROM products p
    WHERE p.brand_id = b.id AND p.subcategory_id = sc.id
      AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
);

DROP TEMPORARY TABLE jimart_catalog_batch;
COMMIT;
