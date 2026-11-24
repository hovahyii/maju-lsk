-- Ji-Mart Enterprise bakery and supplies workbook catalog. Deploy the product photos before importing.
DROP TEMPORARY TABLE IF EXISTS jimart_catalog_batch;
START TRANSACTION;

INSERT INTO subcategories (category_id, name, slug)
SELECT c.id, source.name, source.slug
FROM (
    SELECT 'dairy' AS category_slug, 'Cream' AS name, 'cream' AS slug
    UNION ALL SELECT 'dairy', 'Butter', 'butter'
    UNION ALL SELECT 'flour', 'Starch', 'starch'
    UNION ALL SELECT 'consumables', 'Hand Gloves', 'hand-gloves'
    UNION ALL SELECT 'consumables', 'Protective Apparel', 'protective-apparel'
    UNION ALL SELECT 'cooking-ingredients', 'Protein', 'protein'
    UNION ALL SELECT 'chocolate-products', 'Cocoa Powder', 'cocoa-powder'
    UNION ALL SELECT 'dairy', 'Milk Powder', 'milk-powder'
    UNION ALL SELECT 'base', 'Nuts', 'nuts'
    UNION ALL SELECT 'base', 'Seeds', 'seeds'
    UNION ALL SELECT 'base', 'Dried Fruit', 'dried-fruit'
    UNION ALL SELECT 'chocolate-products', 'Fillings', 'fillings'
    UNION ALL SELECT 'instant-food', 'Desserts', 'desserts'
    UNION ALL SELECT 'leavening-agents', 'Baking Powder', 'banking-powder'
    UNION ALL SELECT 'chocolate-products', 'Couverture', 'couverture'
    UNION ALL SELECT 'chocolate-products', 'Cocoa Butter', 'cocoa-butter'
    UNION ALL SELECT 'consumables', 'Baking Tools', 'baking-tools'
    UNION ALL SELECT 'bread-pastray-cakes-products', 'Decorations', 'decorations'
    UNION ALL SELECT 'fats', 'Margarine', 'margarine'
    UNION ALL SELECT 'cooking-ingredients', 'Paste', 'paste'
    UNION ALL SELECT 'bread-pastray-cakes-products', 'Tartlet Shells', 'tartlet-shells'
    UNION ALL SELECT 'chocolate-products', 'Truffle Shells', 'truffle-shells'
) source
JOIN categories c ON CONVERT(c.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = source.category_slug
WHERE NOT EXISTS (
    SELECT 1 FROM subcategories sc
    WHERE sc.category_id = c.id AND CONVERT(sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = source.slug
);

INSERT INTO brands (name, slug)
SELECT source.name, source.slug
FROM (
    SELECT 'Redman' AS name, 'redman' AS slug
    UNION ALL SELECT 'Ever-Whip', 'ever-whip'
    UNION ALL SELECT 'Green House', 'green-house'
    UNION ALL SELECT 'Star Brand', 'star-brand'
    UNION ALL SELECT 'Windmill', 'windmill'
    UNION ALL SELECT 'KleenGuard', 'kleenguard'
    UNION ALL SELECT 'Jackson Safety', 'jackson-safety'
    UNION ALL SELECT 'Ayam Kens', 'ayam-kens'
    UNION ALL SELECT 'Safcol', 'safcol'
    UNION ALL SELECT 'Tulip Cocoa', 'tulip-cocoa'
    UNION ALL SELECT 'Barry Callebaut', 'barry-callebaut'
    UNION ALL SELECT 'Open Country', 'open-country'
    UNION ALL SELECT 'Blue Diamond', 'blue-diamond'
    UNION ALL SELECT 'Allinga Farms', 'allinga-farms'
    UNION ALL SELECT 'La Nogalera', 'la-nogalera'
    UNION ALL SELECT 'Franklin Baker', 'franklin-baker'
    UNION ALL SELECT 'Braun', 'braun'
    UNION ALL SELECT 'Crescent', 'crescent'
    UNION ALL SELECT 'Belcolade', 'belcolade'
    UNION ALL SELECT 'One Way', 'one-way'
    UNION ALL SELECT 'Orient', 'orient'
    UNION ALL SELECT 'Bakels', 'bakels'
    UNION ALL SELECT 'Deco Relief', 'deco-relief'
    UNION ALL SELECT 'Pastry Pro', 'pastry-pro'
    UNION ALL SELECT 'Vivo', 'vivo'
    UNION ALL SELECT 'You Ai', 'you-ai'
    UNION ALL SELECT 'Ji-Mart Enterprise', 'ji-mart-enterprise'
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
    ('redman', 'dairy', 'cream', 'Non-Dairy Whipping Cream', NULL, 'redman', 'dairy', 'cream', 'products/Dairy/Cream/Redman/Workbook Photos/Non-Dairy Whipping Cream.webp', 1),
    ('redman', 'dairy', 'butter', 'Unsalted Creamery Butter', NULL, 'redman', 'dairy', 'butter', 'products/Dairy/Butter/Redman/Workbook Photos/Unsalted Creamery Butter.webp', 2),
    ('redman', 'dairy', 'butter', 'Salted Creamery Butter', NULL, 'redman', 'dairy', 'butter', 'products/Dairy/Butter/Redman/Workbook Photos/Salted Creamery Butter.webp', 3),
    ('ever-whip', 'dairy', 'cream', 'V Non-Dairy Whipping Cream', NULL, 'ever-whip', 'dairy', 'cream', 'products/Dairy/Cream/Ever-Whip/Workbook Photos/V Non-Dairy Whipping Cream.webp', 4),
    ('redman', 'dairy', 'cream', 'Non-Dairy Whipping Cream (Whip Topping)', 'Non-Dairy Whip Topping Cream', 'ever-whip', 'dairy', 'cream', 'products/Dairy/Cream/Ever-Whip/Workbook Photos/Non-Dairy Whip Topping Cream.webp', 5),
    ('ever-whip', 'dairy', 'cream', 'AS Non-Dairy Whipping Cream', NULL, 'ever-whip', 'dairy', 'cream', 'products/Dairy/Cream/Ever-Whip/Workbook Photos/AS Non-Dairy Whipping Cream.webp', 6),
    ('green-house', 'dairy', 'cream', 'Macreme Non-Dairy Topping Cream', NULL, 'green-house', 'dairy', 'cream', 'products/Dairy/Cream/Green House/Workbook Photos/Macreme Non-Dairy Topping Cream.webp', 7),
    ('star-brand', 'flour', 'starch', 'Sago Starch', NULL, 'star-brand', 'flour', 'starch', 'products/Flour/Starch/Star Brand/Workbook Photos/Sago Starch.webp', 8),
    ('windmill', 'flour', 'starch', 'Potato Starch', NULL, 'windmill', 'flour', 'starch', 'products/Flour/Starch/Windmill/Workbook Photos/Potato Starch.webp', 9),
    ('kleenguard', 'consumables', 'hand-gloves', 'G10 Flex Blue Nitrile Gloves (S, M, L)', 'Blue', 'kleenguard', 'consumables', 'hand-gloves', 'products/Consumables/Hand Gloves/KleenGuard/Workbook Photos/G10 Flex Blue Nitrile Gloves (S, M, L).webp', 10),
    ('kleenguard', 'consumables', 'hand-gloves', 'G10 Flex White Nitrile Gloves (S, M, L)', 'White', 'kleenguard', 'consumables', 'hand-gloves', 'products/Consumables/Hand Gloves/KleenGuard/Workbook Photos/G10 Flex White Nitrile Gloves (S, M, L).webp', 11),
    ('jackson-safety', 'consumables', 'hand-gloves', 'G40 Blue Nitrile Coated Gloves (M, L)', NULL, 'jackson-safety', 'consumables', 'hand-gloves', 'products/Consumables/Hand Gloves/Jackson Safety/Workbook Photos/G40 Blue Nitrile Coated Gloves (M, L).webp', 12),
    ('jackson-safety', 'consumables', 'hand-gloves', 'G60 Purple Nitrile Cut-Resistant Gloves (S, M, L)', NULL, 'jackson-safety', 'consumables', 'hand-gloves', 'products/Consumables/Hand Gloves/Jackson Safety/Workbook Photos/G60 Purple Nitrile Cut-Resistant Gloves (S, M, L).webp', 13),
    ('jackson-safety', 'consumables', 'hand-gloves', 'G80 Green Chemical-Resistant Nitrile Gauntlets (Sizes 8, 9, 10)', NULL, 'jackson-safety', 'consumables', 'hand-gloves', 'products/Consumables/Hand Gloves/Jackson Safety/Workbook Photos/G80 Green Chemical-Resistant Nitrile Gauntlets (Sizes 8, 9, 10).webp', 14),
    ('kleenguard', 'consumables', 'protective-apparel', 'A40 XP KCA Protective Apparel (M, L, XL, XXL)', NULL, 'kleenguard', 'consumables', 'protective-apparel', 'products/Consumables/Protective Apparel/KleenGuard/Workbook Photos/A40 XP KCA Protective Apparel (M, L, XL, XXL).webp', 15),
    ('kleenguard', 'consumables', 'protective-apparel', 'A35 White Liquid Protective Apparel', NULL, 'kleenguard', 'consumables', 'protective-apparel', 'products/Consumables/Protective Apparel/KleenGuard/Workbook Photos/A35 White Liquid Protective Apparel.webp', 16),
    ('ayam-kens', 'cooking-ingredients', 'protein', 'Chicken Floss - Original', NULL, 'ayam-kens', 'cooking-ingredients', 'protein', 'products/Cooking Ingredients/Protein/Ayam Kens/Workbook Photos/Chicken Floss - Original.webp', 17),
    ('ayam-kens', 'cooking-ingredients', 'protein', 'Chicken Floss - Spicy', NULL, 'ayam-kens', 'cooking-ingredients', 'protein', 'products/Cooking Ingredients/Protein/Ayam Kens/Workbook Photos/Chicken Floss - Spicy.webp', 18),
    ('safcol', 'cooking-ingredients', 'protein', 'Tuna Flakes in Soybean Oil', 'Tuna Flakes In Soybeam Oil - Standing Order', 'safcol', 'cooking-ingredients', 'protein', 'products/Cooking Ingredients/Protein/Safcol/Workbook Photos/Tuna Flakes in Soybean Oil.webp', 19),
    ('tulip-cocoa', 'chocolate-products', 'cocoa-powder', 'Tulip 400 Cocoa Powder', 'Cocoa Powder', 'tulip-cocoa', 'chocolate-products', 'cocoa-powder', 'products/Chocolate Products/Cocoa Powder/Tulip Cocoa/Workbook Photos/Tulip 400 Cocoa Powder.webp', 20),
    ('barry-callebaut', 'chocolate-products', 'cocoa-powder', 'Cocoa Powder', NULL, 'barry-callebaut', 'chocolate-products', 'cocoa-powder', 'products/Chocolate Products/Cocoa Powder/Barry Callebaut/Workbook Photos/Cocoa Powder.webp', 21),
    ('open-country', 'dairy', 'milk-powder', 'Full Cream Milk Powder (25 kg)', NULL, 'open-country', 'dairy', 'milk-powder', 'products/Dairy/Milk Powder/Open Country/Workbook Photos/Full Cream Milk Powder (25 kg).webp', 22),
    ('open-country', 'dairy', 'milk-powder', 'Full Cream Milk Powder (1 kg)', NULL, 'open-country', 'dairy', 'milk-powder', 'products/Dairy/Milk Powder/Open Country/Workbook Photos/Full Cream Milk Powder (1 kg).webp', 23),
    ('blue-diamond', 'base', 'nuts', 'Ground Almonds', NULL, 'blue-diamond', 'base', 'nuts', 'products/Base/Nuts/Blue Diamond/Workbook Photos/Ground Almonds.webp', 24),
    ('blue-diamond', 'base', 'nuts', 'Diced Almonds', NULL, 'blue-diamond', 'base', 'nuts', 'products/Base/Nuts/Blue Diamond/Workbook Photos/Diced Almonds.webp', 25),
    ('blue-diamond', 'base', 'nuts', 'Almond Strips', NULL, 'blue-diamond', 'base', 'nuts', 'products/Base/Nuts/Blue Diamond/Workbook Photos/Almond Strips.webp', 26),
    ('blue-diamond', 'base', 'nuts', 'Whole Almonds with Skin', NULL, 'blue-diamond', 'base', 'nuts', 'products/Base/Nuts/Blue Diamond/Workbook Photos/Whole Almonds with Skin.webp', 27),
    ('blue-diamond', 'base', 'nuts', 'Whole Blanched Almonds', NULL, 'blue-diamond', 'base', 'nuts', 'products/Base/Nuts/Blue Diamond/Workbook Photos/Whole Blanched Almonds.webp', 28),
    ('allinga-farms', 'base', 'nuts', 'Flaked Almonds', NULL, 'allinga-farms', 'base', 'nuts', 'products/Base/Nuts/Allinga Farms/Workbook Photos/Flaked Almonds.webp', 29),
    ('redman', 'base', 'nuts', 'Ground Hazelnuts', NULL, 'redman', 'base', 'nuts', 'products/Base/Nuts/Redman/Workbook Photos/Ground Hazelnuts.webp', 30),
    ('redman', 'base', 'nuts', 'Whole Blanched Hazelnuts', NULL, 'redman', 'base', 'nuts', 'products/Base/Nuts/Redman/Workbook Photos/Whole Blanched Hazelnuts.webp', 31),
    ('redman', 'base', 'nuts', 'Macadamia Nuts', NULL, 'redman', 'base', 'nuts', 'products/Base/Nuts/Redman/Workbook Photos/Macadamia Nuts.webp', 32),
    ('redman', 'base', 'nuts', 'California Pistachios', NULL, 'redman', 'base', 'nuts', 'products/Base/Nuts/Redman/Workbook Photos/California Pistachios.webp', 33),
    ('redman', 'base', 'nuts', 'Brazil Nuts', NULL, 'redman', 'base', 'nuts', 'products/Base/Nuts/Redman/Workbook Photos/Brazil Nuts.webp', 34),
    ('redman', 'base', 'seeds', 'Pumpkin Seed', NULL, 'redman', 'base', 'seeds', 'products/Base/Seeds/Redman/Workbook Photos/Pumpkin Seed.webp', 35),
    ('redman', 'base', 'seeds', 'Melon Seed', NULL, 'redman', 'base', 'seeds', 'products/Base/Seeds/Redman/Workbook Photos/Melon Seed.webp', 36),
    ('redman', 'base', 'seeds', 'Sunflower Seed', NULL, 'redman', 'base', 'seeds', 'products/Base/Seeds/Redman/Workbook Photos/Sunflower Seed.webp', 37),
    ('redman', 'base', 'dried-fruit', 'Mixed Fruits', NULL, 'redman', 'base', 'dried-fruit', 'products/Base/Dried Fruit/Redman/Workbook Photos/Mixed Fruits.webp', 38),
    ('redman', 'base', 'dried-fruit', 'Diced Cherry - Red', NULL, 'redman', 'base', 'dried-fruit', 'products/Base/Dried Fruit/Redman/Workbook Photos/Diced Cherry - Red.webp', 39),
    ('redman', 'base', 'dried-fruit', 'Diced Cherry - Green', NULL, 'redman', 'base', 'dried-fruit', 'products/Base/Dried Fruit/Redman/Workbook Photos/Diced Cherry - Green.webp', 40),
    ('redman', 'base', 'dried-fruit', 'Citrus Peel', NULL, 'redman', 'base', 'dried-fruit', 'products/Base/Dried Fruit/Redman/Workbook Photos/Citrus Peel.webp', 41),
    ('redman', 'base', 'dried-fruit', 'Dried Cranberries', NULL, 'redman', 'base', 'dried-fruit', 'products/Base/Dried Fruit/Redman/Workbook Photos/Dried Cranberries.webp', 42),
    ('redman', 'base', 'dried-fruit', 'Sultana', NULL, 'redman', 'base', 'dried-fruit', 'products/Base/Dried Fruit/Redman/Workbook Photos/Sultana.webp', 43),
    ('redman', 'base', 'dried-fruit', 'Golden Raisins', NULL, 'redman', 'base', 'dried-fruit', 'products/Base/Dried Fruit/Redman/Workbook Photos/Golden Raisins.webp', 44),
    ('redman', 'base', 'dried-fruit', 'Dried Apricots', NULL, 'redman', 'base', 'dried-fruit', 'products/Base/Dried Fruit/Redman/Workbook Photos/Dried Apricots.webp', 45),
    ('la-nogalera', 'base', 'nuts', 'Pecan Nuts', NULL, 'la-nogalera', 'base', 'nuts', 'products/Base/Nuts/La Nogalera/Workbook Photos/Pecan Nuts.webp', 46),
    ('franklin-baker', 'base', 'seeds', 'Coconut Flake', NULL, 'franklin-baker', 'base', 'seeds', 'products/Base/Seeds/Franklin Baker/Workbook Photos/Coconut Flake.webp', 47),
    ('redman', 'chocolate-products', 'fillings', 'Wild Whole Blueberry Pie Filling', NULL, 'redman', 'chocolate-products', 'fillings', 'products/Chocolate Products/Fillings/Redman/Workbook Photos/Wild Whole Blueberry Pie Filling.webp', 48),
    ('redman', 'instant-food', 'desserts', 'Vanilla Flan (Crème Caramel)', NULL, 'redman', 'instant-food', 'desserts', 'products/Instant Food/Desserts/Redman/Workbook Photos/Vanilla Flan (Crème Caramel).webp', 49),
    ('redman', 'flour', 'starch', 'Corn Starch', NULL, 'redman', 'flour', 'starch', 'products/Flour/Starch/Redman/Workbook Photos/Corn Starch.webp', 50),
    ('braun', 'base', 'seeds', 'Bee Sting Mix (Florentine Mix)', 'Bee Sting Mix', 'braun', 'base', 'seeds', 'products/Base/Seeds/Braun/Workbook Photos/Bee Sting Mix (Florentine Mix).webp', 51),
    ('crescent', 'leavening-agents', 'banking-powder', 'Double Acting Baking Powder', NULL, 'crescent', 'leavening-agents', 'banking-powder', 'products/Leavening Agents/Baking Powder/Crescent/Workbook Photos/Double Acting Baking Powder.webp', 52),
    ('belcolade', 'chocolate-products', 'couverture', 'Dark Couverture Drops', 'Drops - Dark', 'belcolade', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Belcolade/Workbook Photos/Dark Couverture Drops.webp', 53),
    ('belcolade', 'chocolate-products', 'couverture', 'Milk Couverture Drops', 'Drops - Milk', 'belcolade', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Belcolade/Workbook Photos/Milk Couverture Drops.webp', 54),
    ('belcolade', 'chocolate-products', 'couverture', 'White Couverture Drops', 'Drops - White', 'belcolade', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Belcolade/Workbook Photos/White Couverture Drops.webp', 55),
    ('belcolade', 'chocolate-products', 'cocoa-butter', 'Cocoa Butter', NULL, 'belcolade', 'chocolate-products', 'cocoa-butter', 'products/Chocolate Products/Cocoa Butter/Belcolade/Workbook Photos/Cocoa Butter.webp', 56),
    ('belcolade', 'chocolate-products', 'couverture', 'Dark Couverture Block', 'Block - Dark - Stranding Order', 'belcolade', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Belcolade/Workbook Photos/Dark Couverture Block.webp', 57),
    ('belcolade', 'chocolate-products', 'couverture', 'Milk Couverture Block', 'Block - Milk - Stranding Order', 'belcolade', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Belcolade/Workbook Photos/Milk Couverture Block.webp', 58),
    ('belcolade', 'chocolate-products', 'couverture', 'White Couverture Block', 'BLock - White - Stranding Order', 'belcolade', 'chocolate-products', 'couverture', 'products/Chocolate Products/Couverture/Belcolade/Workbook Photos/White Couverture Block.webp', 59),
    ('one-way', 'consumables', 'baking-tools', 'Masterline Blue Piping Bags', NULL, 'one-way', 'consumables', 'baking-tools', 'products/Consumables/Baking Tools/One Way/Workbook Photos/Masterline Blue Piping Bags.webp', 60),
    ('one-way', 'consumables', 'baking-tools', 'Comfort Blue Piping Bags', NULL, 'one-way', 'consumables', 'baking-tools', 'products/Consumables/Baking Tools/One Way/Workbook Photos/Comfort Blue Piping Bags.webp', 61),
    ('orient', 'consumables', 'baking-tools', 'Cling Film with Cutter Box', NULL, 'orient', 'consumables', 'baking-tools', 'products/Consumables/Baking Tools/Orient/Workbook Photos/Cling Film with Cutter Box.webp', 62),
    ('bakels', 'consumables', 'baking-tools', 'Metal Dough Scraper', NULL, 'bakels', 'consumables', 'baking-tools', 'products/Consumables/Baking Tools/Bakels/Workbook Photos/Metal Dough Scraper.webp', 63),
    ('deco-relief', 'bread-pastray-cakes-products', 'decorations', 'Gold Leaves', NULL, 'deco-relief', 'bread-pastray-cakes-products', 'decorations', 'products/Bread, Pastry & Cakes Products/Decorations/Deco Relief/Workbook Photos/Gold Leaves.webp', 64),
    ('deco-relief', 'bread-pastray-cakes-products', 'decorations', 'Silver Leaves', NULL, 'deco-relief', 'bread-pastray-cakes-products', 'decorations', 'products/Bread, Pastry & Cakes Products/Decorations/Deco Relief/Workbook Photos/Silver Leaves.webp', 65),
    ('pastry-pro', 'bread-pastray-cakes-products', 'decorations', 'Oil-Based Frosting Sheets', NULL, 'pastry-pro', 'bread-pastray-cakes-products', 'decorations', 'products/Bread, Pastry & Cakes Products/Decorations/Pastry Pro/Workbook Photos/Oil-Based Frosting Sheets.webp', 66),
    ('vivo', 'fats', 'margarine', 'Classico Sheet (CL340LT)', 'Classico Sheet', 'vivo', 'fats', 'margarine', 'products/Fats/Margarine/Vivo/Workbook Photos/Classico Sheet (CL340LT).webp', 67),
    ('you-ai', 'cooking-ingredients', 'paste', 'Red Bean Paste', NULL, 'you-ai', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/You Ai/Workbook Photos/Red Bean Paste.webp', 68),
    ('you-ai', 'cooking-ingredients', 'paste', 'Dauyong Paste', NULL, 'you-ai', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/You Ai/Workbook Photos/Dauyong Paste.webp', 69),
    ('you-ai', 'cooking-ingredients', 'paste', 'Pandan Dauyong Paste', NULL, 'you-ai', 'cooking-ingredients', 'paste', 'products/Cooking Ingredients/Paste/You Ai/Workbook Photos/Pandan Dauyong Paste.webp', 70),
    ('ji-mart-enterprise', 'bread-pastray-cakes-products', 'tartlet-shells', 'Mini Tartlet Shells (45 mm)', NULL, 'ji-mart-enterprise', 'bread-pastray-cakes-products', 'tartlet-shells', 'products/Bread, Pastry & Cakes Products/Tartlet Shells/Ji-Mart Enterprise/Workbook Photos/Mini Tartlet Shells (45 mm).webp', 71),
    ('ji-mart-enterprise', 'bread-pastray-cakes-products', 'tartlet-shells', 'Medium Tartlet Shells (60 mm)', NULL, 'ji-mart-enterprise', 'bread-pastray-cakes-products', 'tartlet-shells', 'products/Bread, Pastry & Cakes Products/Tartlet Shells/Ji-Mart Enterprise/Workbook Photos/Medium Tartlet Shells (60 mm).webp', 72),
    ('ji-mart-enterprise', 'bread-pastray-cakes-products', 'tartlet-shells', 'Large Tartlet Shells (70 mm)', NULL, 'ji-mart-enterprise', 'bread-pastray-cakes-products', 'tartlet-shells', 'products/Bread, Pastry & Cakes Products/Tartlet Shells/Ji-Mart Enterprise/Workbook Photos/Large Tartlet Shells (70 mm).webp', 73),
    ('ji-mart-enterprise', 'chocolate-products', 'truffle-shells', 'Dark Chocolate Truffle Shells', NULL, 'ji-mart-enterprise', 'chocolate-products', 'truffle-shells', 'products/Chocolate Products/Truffle Shells/Ji-Mart Enterprise/Workbook Photos/Dark Chocolate Truffle Shells.webp', 74),
    ('ji-mart-enterprise', 'chocolate-products', 'truffle-shells', 'Milk Chocolate Truffle Shells', NULL, 'ji-mart-enterprise', 'chocolate-products', 'truffle-shells', 'products/Chocolate Products/Truffle Shells/Ji-Mart Enterprise/Workbook Photos/Milk Chocolate Truffle Shells.webp', 75),
    ('ji-mart-enterprise', 'chocolate-products', 'truffle-shells', 'White Chocolate Truffle Shells', NULL, 'ji-mart-enterprise', 'chocolate-products', 'truffle-shells', 'products/Chocolate Products/Truffle Shells/Ji-Mart Enterprise/Workbook Photos/White Chocolate Truffle Shells.webp', 76),
    ('ji-mart-enterprise', 'consumables', 'baking-tools', 'Protective Baking Mittens', NULL, 'ji-mart-enterprise', 'consumables', 'baking-tools', 'products/Consumables/Baking Tools/Ji-Mart Enterprise/Workbook Photos/Protective Baking Mittens.webp', 77),
    ('ji-mart-enterprise', 'consumables', 'baking-tools', 'Aluminium Foil with Cutter Box', NULL, 'ji-mart-enterprise', 'consumables', 'baking-tools', 'products/Consumables/Baking Tools/Ji-Mart Enterprise/Workbook Photos/Aluminium Foil with Cutter Box.webp', 78),
    ('ji-mart-enterprise', 'consumables', 'baking-tools', 'Silicone Baking Paper', NULL, 'ji-mart-enterprise', 'consumables', 'baking-tools', 'products/Consumables/Baking Tools/Ji-Mart Enterprise/Workbook Photos/Silicone Baking Paper.webp', 79),
    ('ji-mart-enterprise', 'base', 'dried-fruit', 'Dried Figs', NULL, 'ji-mart-enterprise', 'base', 'dried-fruit', 'products/Base/Dried Fruit/Ji-Mart Enterprise/Workbook Photos/Dried Figs.webp', 80),
    ('ji-mart-enterprise', 'base', 'dried-fruit', 'Jumbo Medjool Dates', NULL, 'ji-mart-enterprise', 'base', 'dried-fruit', 'products/Base/Dried Fruit/Ji-Mart Enterprise/Workbook Photos/Jumbo Medjool Dates.webp', 81),
    ('ji-mart-enterprise', 'chocolate-products', 'cocoa-powder', 'Black Cocoa Powder', NULL, 'ji-mart-enterprise', 'chocolate-products', 'cocoa-powder', 'products/Chocolate Products/Cocoa Powder/Ji-Mart Enterprise/Workbook Photos/Black Cocoa Powder.webp', 82),
    ('ji-mart-enterprise', 'bread-pastray-cakes-products', 'decorations', 'Silver Dust', NULL, 'ji-mart-enterprise', 'bread-pastray-cakes-products', 'decorations', 'products/Bread, Pastry & Cakes Products/Decorations/Ji-Mart Enterprise/Workbook Photos/Silver Dust.webp', 83),
    ('ji-mart-enterprise', 'chocolate-products', 'cocoa-butter', 'Cocoa Butter', NULL, 'ji-mart-enterprise', 'chocolate-products', 'cocoa-butter', 'products/Chocolate Products/Cocoa Butter/Ji-Mart Enterprise/Workbook Photos/Cocoa Butter.webp', 84);

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
