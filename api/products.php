<?php
require __DIR__ . '/db.php';

header('Content-Type: application/json; charset=utf-8');

try {
    $pdo = getDb();

    $where = [AVAILABLE_PRODUCT_SQL];
    $params = [];

    if (!empty($_GET['category'])) {
        $where[] = 'c.slug = :category';
        $params[':category'] = $_GET['category'];
    }

    if (!empty($_GET['subcategory'])) {
        $where[] = 'sc.slug = :subcategory';
        $params[':subcategory'] = $_GET['subcategory'];
    }

    if (!empty($_GET['brand'])) {
        $where[] = 'b.slug = :brand';
        $params[':brand'] = $_GET['brand'];
    }

    $sql = "SELECT p.id, p.name, p.image_url,
                   b.name AS brand_name, b.slug AS brand_slug,
                   sc.name AS subcategory_name, sc.slug AS subcategory_slug,
                   c.name AS category_name, c.slug AS category_slug
            FROM products p
            JOIN categories c ON c.id = p.category_id
            LEFT JOIN subcategories sc ON sc.id = p.subcategory_id
            LEFT JOIN brands b ON b.id = p.brand_id";

    if ($where) {
        $sql .= " WHERE " . implode(" AND ", $where);
    }

    $sql .= " ORDER BY p.sort_order ASC, p.name ASC";

    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);

    $products = $stmt->fetchAll();
    $updatedAromaPhotos = [
        'All Purpose Seasoned Kentucky Crispy Flour (Original).webp',
        'All Purpose Seasoned Kentucky Crispy Flour Spicy.webp',
        'Banana Fritter Flour.webp',
        'Tempura Flour.webp',
    ];
    foreach ($products as &$product) {
        $image = $product['image_url'] ?? '';
        if (strpos($image, 'products/Cooking Ingredients/Frying Flour/Aroma/') === 0
            && in_array(basename($image), $updatedAromaPhotos, true)) {
            $product['image_url'] .= '?v=aroma-front-back';
        }
    }
    unset($product);

    echo json_encode(['data' => $products]);
} catch (Throwable $e) {
    http_response_code(500);
    echo json_encode([
        'error' => 'Server error',
        'message' => $e->getMessage()
    ]);
}
