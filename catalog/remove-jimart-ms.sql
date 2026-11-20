-- Retire the discontinued Ji-Mart M&S products from the public catalogue.
START TRANSACTION;

UPDATE products
SET is_active = 0
WHERE is_active = 1
  AND brand_id IN (SELECT id FROM brands WHERE LOWER(slug) = 'm-s');

COMMIT;
