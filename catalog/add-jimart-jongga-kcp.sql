-- Run against the website catalog database after deploying the workbook photos.
DROP TEMPORARY TABLE IF EXISTS jimart_workbook_items;
START TRANSACTION;

INSERT INTO subcategories (category_id, name, slug)
SELECT c.id, incoming.name, incoming.slug
FROM (
    SELECT 'instant-food' AS category_slug, 'Kimchi' AS name, 'kimchi' AS slug
    UNION ALL SELECT 'cooking-ingredients', 'Rice Cakes', 'rice-cakes'
    UNION ALL SELECT 'consumables', 'Cleaning Cloths', 'cleaning-cloths'
    UNION ALL SELECT 'consumables', 'Industrial Wipers', 'industrial-wipers'
    UNION ALL SELECT 'consumables', 'Safety Eyewear', 'safety-eyewear'
) incoming
JOIN categories c ON CONVERT(c.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = incoming.category_slug
WHERE NOT EXISTS (
    SELECT 1 FROM subcategories sc
    WHERE sc.category_id = c.id
      AND CONVERT(sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = incoming.slug
);

INSERT INTO brands (name, slug)
SELECT incoming.name, incoming.slug
FROM (
    SELECT 'Jongga' AS name, 'jongga' AS slug
    UNION ALL SELECT 'Scott', 'scott'
    UNION ALL SELECT 'Kimberly-Clark', 'kimberly-clark'
    UNION ALL SELECT 'Kleenex', 'kleenex'
    UNION ALL SELECT 'WypAll', 'wypall'
    UNION ALL SELECT 'Jackson Safety', 'jackson-safety'
) incoming
WHERE NOT EXISTS (
    SELECT 1 FROM brands b
    WHERE CONVERT(b.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = incoming.slug
);

CREATE TEMPORARY TABLE jimart_workbook_items (
    brand_slug VARCHAR(50) NOT NULL,
    category_slug VARCHAR(50) NOT NULL,
    subcategory_slug VARCHAR(50) NOT NULL,
    name VARCHAR(150) NOT NULL,
    legacy_name VARCHAR(150),
    image_url VARCHAR(255) NOT NULL,
    sort_order INT NOT NULL,
    PRIMARY KEY (brand_slug, name)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO jimart_workbook_items
    (brand_slug, category_slug, subcategory_slug, name, legacy_name, image_url, sort_order)
VALUES
    ('jongga', 'instant-food', 'kimchi', 'Mat Kimchi - Sweet & Spicy Cut Cabbage (200 g)', NULL, 'products/Instant Food/Kimchi/Jongga/Workbook Photos/Mat Kimchi - Sweet & Spicy Cut Cabbage (200 g).webp', 1),
    ('jongga', 'instant-food', 'kimchi', 'Poggi Kimchi - Whole Cabbage', NULL, 'products/Instant Food/Kimchi/Jongga/Workbook Photos/Poggi Kimchi - Whole Cabbage.webp', 2),
    ('jongga', 'instant-food', 'kimchi', 'Chonggak Kimchi - Ponytail Radish', NULL, 'products/Instant Food/Kimchi/Jongga/Workbook Photos/Chonggak Kimchi - Ponytail Radish.webp', 3),
    ('jongga', 'instant-food', 'kimchi', 'Kkaktugi - Diced Radish Kimchi', NULL, 'products/Instant Food/Kimchi/Jongga/Workbook Photos/Kkaktugi - Diced Radish Kimchi.webp', 4),
    ('jongga', 'instant-food', 'kimchi', 'Mat Kimchi - Sweet & Spicy Cut Cabbage (380 g)', NULL, 'products/Instant Food/Kimchi/Jongga/Workbook Photos/Mat Kimchi - Sweet & Spicy Cut Cabbage (380 g).webp', 5),
    ('jongga', 'instant-food', 'kimchi', 'Mat Kimchi - Sweet & Spicy Cut Cabbage (750 g)', NULL, 'products/Instant Food/Kimchi/Jongga/Workbook Photos/Mat Kimchi - Sweet & Spicy Cut Cabbage (750 g).webp', 6),
    ('jongga', 'instant-food', 'kimchi', 'Extra Carrot Kimchi', NULL, 'products/Instant Food/Kimchi/Jongga/Workbook Photos/Extra Carrot Kimchi.webp', 7),
    ('jongga', 'instant-food', 'kimchi', 'Extra Spicy Kimchi', NULL, 'products/Instant Food/Kimchi/Jongga/Workbook Photos/Extra Spicy Kimchi.webp', 8),
    ('jongga', 'cooking-ingredients', 'rice-cakes', 'Rice Cake (Stick Type)', NULL, 'products/Cooking Ingredients/Rice Cakes/Jongga/Workbook Photos/Rice Cake (Stick Type).webp', 9),
    ('jongga', 'cooking-ingredients', 'rice-cakes', 'Rice Cake (Sliced Type)', NULL, 'products/Cooking Ingredients/Rice Cakes/Jongga/Workbook Photos/Rice Cake (Sliced Type).webp', 10),
    ('jongga', 'instant-food', 'instant-noodles', 'Kimchi Ramen (Cup)', NULL, 'products/Instant Food/Instant Noodles/Jongga/Workbook Photos/Kimchi Ramen (Cup).webp', 11),
    ('jongga', 'instant-food', 'instant-noodles', 'Kimchi Ramen (Bowl)', NULL, 'products/Instant Food/Instant Noodles/Jongga/Workbook Photos/Kimchi Ramen (Bowl).webp', 12),
    ('jongga', 'instant-food', 'instant-noodles', 'Spicy Kimchi Ramen (Bowl)', NULL, 'products/Instant Food/Instant Noodles/Jongga/Workbook Photos/Spicy Kimchi Ramen (Bowl).webp', 13),
    ('scott', 'consumables', 'tissues', 'Bathroom Tissue UW (200 Sheets, 2-Ply)', 'Bathroom Tissue UW 200''s x 2ply', 'products/Consumables/Tissues/Scott/Workbook Photos/Bathroom Tissue UW (200 Sheets, 2-Ply).webp', 14),
    ('scott', 'consumables', 'tissues', 'Bathroom Tissue UW (160 Sheets, 2-Ply)', 'Bathroom Tissue UW 160''s x 2ply', 'products/Consumables/Tissues/Scott/Workbook Photos/Bathroom Tissue UW (160 Sheets, 2-Ply).webp', 15),
    ('scott', 'consumables', 'tissues', 'Extra Bath Tissue', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Extra Bath Tissue.webp', 16),
    ('scott', 'consumables', 'tissues', 'Centrepull Bathroom Tissue', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Centrepull Bathroom Tissue.webp', 17),
    ('scott', 'consumables', 'tissues', 'Hygienic Bathroom Tissue', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Hygienic Bathroom Tissue.webp', 18),
    ('scott', 'consumables', 'tissues', 'Aquarius HBT Dispenser', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Aquarius HBT Dispenser.webp', 19),
    ('scott', 'consumables', 'tissues', 'Essential Jumbo Roll Tissue', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Essential Jumbo Roll Tissue.webp', 20),
    ('scott', 'consumables', 'tissues', 'Aquarius JRT Dispenser (White)', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Aquarius JRT Dispenser (White).webp', 21),
    ('scott', 'consumables', 'tissues', 'Compact Towel Standard', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Compact Towel Standard.webp', 22),
    ('scott', 'consumables', 'tissues', 'Aquarius Compact Towel Dispenser', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Aquarius Compact Towel Dispenser.webp', 23),
    ('scott', 'consumables', 'tissues', 'Airflex Multi-Fold Hand Towel', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Airflex Multi-Fold Hand Towel.webp', 24),
    ('scott', 'consumables', 'tissues', 'Aquarius Multifold Towel Dispenser (Single)', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Aquarius Multifold Towel Dispenser (Single).webp', 25),
    ('scott', 'consumables', 'tissues', 'Aquarius Multifold Towel Dispenser (Double)', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Aquarius Multifold Towel Dispenser (Double).webp', 26),
    ('scott', 'consumables', 'tissues', 'M-Fold Fully Wrapped Hand Towel', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/M-Fold Fully Wrapped Hand Towel.webp', 27),
    ('scott', 'consumables', 'tissues', 'Essential M-Fold Towel', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Essential M-Fold Towel.webp', 28),
    ('scott', 'consumables', 'tissues', 'Printed Slim Roll Hand Towel (Core Plug)', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Printed Slim Roll Hand Towel (Core Plug).webp', 29),
    ('scott', 'consumables', 'tissues', 'Aquarius Slim Roll Hand Towel Dispenser', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Aquarius Slim Roll Hand Towel Dispenser.webp', 30),
    ('scott', 'consumables', 'tissues', 'Printed Hand Roll Towel (Core Plug)', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Printed Hand Roll Towel (Core Plug).webp', 31),
    ('scott', 'consumables', 'tissues', 'Aquarius Rolled Hand Towel Dispenser', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Aquarius Rolled Hand Towel Dispenser.webp', 32),
    ('scott', 'consumables', 'tissues', 'Facial Tissue Flat Rectangle', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Facial Tissue Flat Rectangle.webp', 33),
    ('scott', 'consumables', 'tissues', 'Orchid Luncheon Napkin Plain (Quarter Fold)', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Orchid Luncheon Napkin Plain (Quarter Fold).webp', 34),
    ('scott', 'consumables', 'tissues', 'Multi-Purpose Kitchen Towel', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Multi-Purpose Kitchen Towel.webp', 35),
    ('scott', 'consumables', 'tissues', 'Pop Up Dispenser (ABS)', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Pop Up Dispenser (ABS).webp', 36),
    ('kleenex', 'consumables', 'tissues', 'Cottonelle SRT (Ultra Soft)', NULL, 'products/Consumables/Tissues/Kleenex/Workbook Photos/Cottonelle SRT (Ultra Soft).webp', 37),
    ('kleenex', 'consumables', 'tissues', 'M-Fold Hand Towel', NULL, 'products/Consumables/Tissues/Kleenex/Workbook Photos/M-Fold Hand Towel.webp', 38),
    ('kleenex', 'consumables', 'tissues', 'Facial Tissue (Cube)', NULL, 'products/Consumables/Tissues/Kleenex/Workbook Photos/Facial Tissue (Cube).webp', 39),
    ('kleenex', 'consumables', 'tissues', 'Facial Tissue (Vintage Box)', NULL, 'products/Consumables/Tissues/Kleenex/Workbook Photos/Facial Tissue (Vintage Box).webp', 40),
    ('kleenex', 'consumables', 'tissues', 'Cocktail Napkin Plain', NULL, 'products/Consumables/Tissues/Kleenex/Workbook Photos/Cocktail Napkin Plain.webp', 41),
    ('kleenex', 'consumables', 'tissues', 'Dinner Napkin Plain', NULL, 'products/Consumables/Tissues/Kleenex/Workbook Photos/Dinner Napkin Plain.webp', 42),
    ('scott', 'consumables', 'tissues', 'Dispenser Fold Napkin', NULL, 'products/Consumables/Tissues/Scott/Workbook Photos/Dispenser Fold Napkin.webp', 43),
    ('kleenex', 'consumables', 'hand-cleanser', 'Moist Foam Soap', NULL, 'products/Consumables/Hand Cleanser/Kleenex/Workbook Photos/Moist Foam Soap.webp', 44),
    ('kleenex', 'consumables', 'hand-cleanser', 'Hair & Body Gel Soap', NULL, 'products/Consumables/Hand Cleanser/Kleenex/Workbook Photos/Hair & Body Gel Soap.webp', 45),
    ('kleenex', 'consumables', 'hand-cleanser', 'Fragrance and Dye Free Foam Soap', NULL, 'products/Consumables/Hand Cleanser/Kleenex/Workbook Photos/Fragrance and Dye Free Foam Soap.webp', 46),
    ('kleenex', 'consumables', 'hand-cleanser', 'Fragrance and Dye Free Antibacterial Foam Soap', NULL, 'products/Consumables/Hand Cleanser/Kleenex/Workbook Photos/Fragrance and Dye Free Antibacterial Foam Soap.webp', 47),
    ('kleenex', 'consumables', 'hand-cleanser', 'Fragrance and Dye Free Alcohol Foam Sanitiser (1 L)', NULL, 'products/Consumables/Hand Cleanser/Kleenex/Workbook Photos/Fragrance and Dye Free Alcohol Foam Sanitiser (1 L).webp', 48),
    ('kleenex', 'consumables', 'hand-cleanser', 'Fragrance and Dye Free Alcohol Foam Sanitiser (1.2 L)', NULL, 'products/Consumables/Hand Cleanser/Kleenex/Workbook Photos/Fragrance and Dye Free Alcohol Foam Sanitiser (1.2 L).webp', 49),
    ('kimberly-clark', 'consumables', 'hand-cleanser', 'Aquarius Cassette Skincare Dispenser', NULL, 'products/Consumables/Hand Cleanser/Kimberly-Clark/Workbook Photos/Aquarius Cassette Skincare Dispenser.webp', 50),
    ('scott', 'consumables', 'hand-cleanser', 'Electronic Skincare Dispenser', NULL, 'products/Consumables/Hand Cleanser/Scott/Workbook Photos/Electronic Skincare Dispenser.webp', 51),
    ('wypall', 'consumables', 'cleaning-cloths', 'X80 Quarter Fold Wipers - Red', NULL, 'products/Consumables/Cleaning Cloths/WypAll/Workbook Photos/X80 Quarter Fold Wipers - Red.webp', 52),
    ('wypall', 'consumables', 'cleaning-cloths', 'X80 Quarter Fold Wipers - Blue', NULL, 'products/Consumables/Cleaning Cloths/WypAll/Workbook Photos/X80 Quarter Fold Wipers - Blue.webp', 53),
    ('wypall', 'consumables', 'cleaning-cloths', 'X80 Quarter Fold Wipers - Green', NULL, 'products/Consumables/Cleaning Cloths/WypAll/Workbook Photos/X80 Quarter Fold Wipers - Green.webp', 54),
    ('wypall', 'consumables', 'cleaning-cloths', 'X80 Quarter Fold Wipers - Yellow', NULL, 'products/Consumables/Cleaning Cloths/WypAll/Workbook Photos/X80 Quarter Fold Wipers - Yellow.webp', 55),
    ('wypall', 'consumables', 'cleaning-cloths', 'Microfibre Cloth with Microban - Yellow', NULL, 'products/Consumables/Cleaning Cloths/WypAll/Workbook Photos/Microfibre Cloth with Microban - Yellow.webp', 56),
    ('wypall', 'consumables', 'cleaning-cloths', 'Microfibre Cloth with Microban - Blue', NULL, 'products/Consumables/Cleaning Cloths/WypAll/Workbook Photos/Microfibre Cloth with Microban - Blue.webp', 57),
    ('wypall', 'consumables', 'cleaning-cloths', 'Microfibre Cloth with Microban - Green', NULL, 'products/Consumables/Cleaning Cloths/WypAll/Workbook Photos/Microfibre Cloth with Microban - Green.webp', 58),
    ('wypall', 'consumables', 'cleaning-cloths', 'Microfibre Cloth with Microban - Red', NULL, 'products/Consumables/Cleaning Cloths/WypAll/Workbook Photos/Microfibre Cloth with Microban - Red.webp', 59),
    ('wypall', 'consumables', 'cleaning-cloths', 'Colour Coded Food Service Cloths - Green', NULL, 'products/Consumables/Cleaning Cloths/WypAll/Workbook Photos/Colour Coded Food Service Cloths - Green.webp', 60),
    ('wypall', 'consumables', 'cleaning-cloths', 'Colour Coded Food Service Cloths - Blue', NULL, 'products/Consumables/Cleaning Cloths/WypAll/Workbook Photos/Colour Coded Food Service Cloths - Blue.webp', 61),
    ('wypall', 'consumables', 'cleaning-cloths', 'Colour Coded Food Service Cloths - White', NULL, 'products/Consumables/Cleaning Cloths/WypAll/Workbook Photos/Colour Coded Food Service Cloths - White.webp', 62),
    ('wypall', 'consumables', 'cleaning-cloths', 'Colour Coded Food Service Cloths - Red', NULL, 'products/Consumables/Cleaning Cloths/WypAll/Workbook Photos/Colour Coded Food Service Cloths - Red.webp', 63),
    ('wypall', 'consumables', 'cleaning-cloths', 'Colour Coded Food Service Cloths - Yellow', NULL, 'products/Consumables/Cleaning Cloths/WypAll/Workbook Photos/Colour Coded Food Service Cloths - Yellow.webp', 64),
    ('wypall', 'consumables', 'industrial-wipers', 'X60 Quarter Fold Wipers - White', NULL, 'products/Consumables/Industrial Wipers/WypAll/Workbook Photos/X60 Quarter Fold Wipers - White.webp', 65),
    ('wypall', 'consumables', 'industrial-wipers', 'L10 Clinical Roll', NULL, 'products/Consumables/Industrial Wipers/WypAll/Workbook Photos/L10 Clinical Roll.webp', 66),
    ('wypall', 'consumables', 'industrial-wipers', 'L10 Roll Control Wipers', NULL, 'products/Consumables/Industrial Wipers/WypAll/Workbook Photos/L10 Roll Control Wipers.webp', 67),
    ('wypall', 'consumables', 'industrial-wipers', 'L10 Table Top Dispenser', NULL, 'products/Consumables/Industrial Wipers/WypAll/Workbook Photos/L10 Table Top Dispenser.webp', 68),
    ('wypall', 'consumables', 'industrial-wipers', 'Essential Task Wipers', NULL, 'products/Consumables/Industrial Wipers/WypAll/Workbook Photos/Essential Task Wipers.webp', 69),
    ('wypall', 'consumables', 'industrial-wipers', 'L10 Industrial Roll Wipers', NULL, 'products/Consumables/Industrial Wipers/WypAll/Workbook Photos/L10 Industrial Roll Wipers.webp', 70),
    ('wypall', 'consumables', 'industrial-wipers', 'X60 Jumbo Roll Wipers', NULL, 'products/Consumables/Industrial Wipers/WypAll/Workbook Photos/X60 Jumbo Roll Wipers.webp', 71),
    ('kimberly-clark', 'consumables', 'industrial-wipers', 'Aquarius Wipes Roll Control Dispenser', NULL, 'products/Consumables/Industrial Wipers/Kimberly-Clark/Workbook Photos/Aquarius Wipes Roll Control Dispenser.webp', 72),
    ('kimberly-clark', 'consumables', 'industrial-wipers', 'Floor Mounted Stand', NULL, 'products/Consumables/Industrial Wipers/Kimberly-Clark/Workbook Photos/Floor Mounted Stand.webp', 73),
    ('kimberly-clark', 'consumables', 'industrial-wipers', 'Leak & Spill Oil Pad (Medium)', NULL, 'products/Consumables/Industrial Wipers/Kimberly-Clark/Workbook Photos/Leak & Spill Oil Pad (Medium).webp', 74),
    ('kimberly-clark', 'consumables', 'industrial-wipers', 'Kimwipes EX-L', NULL, 'products/Consumables/Industrial Wipers/Kimberly-Clark/Workbook Photos/Kimwipes EX-L.webp', 75),
    ('kimberly-clark', 'consumables', 'industrial-wipers', 'Wipers for Solvent (Wettask)', NULL, 'products/Consumables/Industrial Wipers/Kimberly-Clark/Workbook Photos/Wipers for Solvent (Wettask).webp', 76),
    ('jackson-safety', 'consumables', 'safety-eyewear', 'V10 Unispec Clear OTG', NULL, 'products/Consumables/Safety Eyewear/Jackson Safety/Workbook Photos/V10 Unispec Clear OTG.webp', 77),
    ('jackson-safety', 'consumables', 'safety-eyewear', 'V10 Element Clear', NULL, 'products/Consumables/Safety Eyewear/Jackson Safety/Workbook Photos/V10 Element Clear.webp', 78),
    ('jackson-safety', 'consumables', 'safety-eyewear', 'V20 Purity CAF (Clear Anti-Fog)', NULL, 'products/Consumables/Safety Eyewear/Jackson Safety/Workbook Photos/V20 Purity CAF (Clear Anti-Fog).webp', 79),
    ('jackson-safety', 'consumables', 'safety-eyewear', 'V30 Nemesis CAF', NULL, 'products/Consumables/Safety Eyewear/Jackson Safety/Workbook Photos/V30 Nemesis CAF.webp', 80),
    ('jackson-safety', 'consumables', 'safety-eyewear', 'V30 Nemesis Smoke Mirror', NULL, 'products/Consumables/Safety Eyewear/Jackson Safety/Workbook Photos/V30 Nemesis Smoke Mirror.webp', 81),
    ('jackson-safety', 'consumables', 'safety-eyewear', 'V30 Nemesis Indoor / Outdoor', NULL, 'products/Consumables/Safety Eyewear/Jackson Safety/Workbook Photos/V30 Nemesis Indoor - Outdoor.webp', 82),
    ('jackson-safety', 'consumables', 'safety-eyewear', 'V30 Nemesis VL CAF (Clear Anti-Fog)', NULL, 'products/Consumables/Safety Eyewear/Jackson Safety/Workbook Photos/V30 Nemesis VL CAF (Clear Anti-Fog).webp', 83),
    ('jackson-safety', 'consumables', 'safety-eyewear', 'V30 Nemesis VL Smoke', NULL, 'products/Consumables/Safety Eyewear/Jackson Safety/Workbook Photos/V30 Nemesis VL Smoke.webp', 84),
    ('jackson-safety', 'consumables', 'safety-eyewear', 'V30 Nemesis Bronze (Camo Frame)', NULL, 'products/Consumables/Safety Eyewear/Jackson Safety/Workbook Photos/V30 Nemesis Bronze (Camo Frame).webp', 85),
    ('jackson-safety', 'consumables', 'safety-eyewear', 'V30 Nemesis Smoke AF (Camo Frame)', NULL, 'products/Consumables/Safety Eyewear/Jackson Safety/Workbook Photos/V30 Nemesis Smoke AF (Camo Frame).webp', 86),
    ('jackson-safety', 'consumables', 'safety-eyewear', 'V40 HellRaiser Smoke', NULL, 'products/Consumables/Safety Eyewear/Jackson Safety/Workbook Photos/V40 HellRaiser Smoke.webp', 87),
    ('jackson-safety', 'consumables', 'safety-eyewear', 'V40 HellRaiser CAF (Clear Anti-Fog)', NULL, 'products/Consumables/Safety Eyewear/Jackson Safety/Workbook Photos/V40 HellRaiser CAF (Clear Anti-Fog).webp', 88),
    ('jackson-safety', 'consumables', 'safety-eyewear', 'V40 Platinum X CAF (Clear Anti-Fog)', NULL, 'products/Consumables/Safety Eyewear/Jackson Safety/Workbook Photos/V40 Platinum X CAF (Clear Anti-Fog).webp', 89),
    ('jackson-safety', 'consumables', 'safety-eyewear', 'V40 Platinum X Smoke', NULL, 'products/Consumables/Safety Eyewear/Jackson Safety/Workbook Photos/V40 Platinum X Smoke.webp', 90);

UPDATE products p
JOIN brands b ON b.id = p.brand_id
JOIN categories c ON c.id = p.category_id
JOIN subcategories sc ON sc.id = p.subcategory_id AND sc.category_id = c.id
JOIN jimart_workbook_items item
    ON CONVERT(b.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.brand_slug
   AND CONVERT(c.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.category_slug
   AND CONVERT(sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.subcategory_slug
   AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci IN (item.name, item.legacy_name)
SET p.name = item.name, p.image_url = item.image_url, p.is_active = 1;

INSERT INTO products (name, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)
SELECT item.name, item.image_url, c.id, sc.id, b.id, 1, item.sort_order
FROM jimart_workbook_items item
JOIN brands b ON CONVERT(b.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.brand_slug
JOIN categories c ON CONVERT(c.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.category_slug
JOIN subcategories sc ON sc.category_id = c.id
    AND CONVERT(sc.slug USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.subcategory_slug
WHERE NOT EXISTS (
    SELECT 1 FROM products p
    WHERE p.brand_id = b.id AND p.subcategory_id = sc.id
      AND CONVERT(p.name USING utf8mb4) COLLATE utf8mb4_unicode_ci = item.name
);

DROP TEMPORARY TABLE jimart_workbook_items;
COMMIT;
