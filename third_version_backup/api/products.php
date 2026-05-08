<?php
require __DIR__ . '/db.php';

header('Content-Type: application/json; charset=utf-8');

try {
    $pdo = getDb();

    $where = ['p.is_active = 1'];
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

    echo json_encode(['data' => $stmt->fetchAll()]);
} catch (Throwable $e) {
    http_response_code(500);
    echo json_encode([
        'error' => 'Server error',
        'message' => $e->getMessage()
    ]);
}
