<?php
require __DIR__ . '/db.php';

echo "Database Diagnostic Tool\n";
echo "-----------------------\n";

try {
    // Detect environment
    $isLocal = in_array($_SERVER['REMOTE_ADDR'] ?? '', ['127.0.0.1', '::1']) || ($_SERVER['SERVER_NAME'] ?? '') === 'localhost';
    echo "Environment: " . ($isLocal ? "Local XAMPP" : "Production/Remote") . "\n";

    echo "Attempting to connect to the database...\n";
    $pdo = getDb();
    echo "SUCCESS: Connected to the database successfully!\n";

    // Test a simple query
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM products");
    $result = $stmt->fetch();
    echo "SUCCESS: Found " . $result['count'] . " products in the database.\n";

} catch (PDOException $e) {
    echo "ERROR: Database connection failed.\n";
    echo "Message: " . $e->getMessage() . "\n";
    echo "Code: " . $e->getCode() . "\n";

    echo "\nPossible fixes:\n";
    if (strpos($e->getMessage(), 'Connection refused') !== false) {
        echo "- Check if your MySQL/MariaDB service is running (e.g., XAMPP Control Panel).\n";
    }
    if (strpos($e->getMessage(), 'Access denied') !== false) {
        echo "- Check credentials in api/db.php. Local XAMPP often uses user 'root' with NO password.\n";
    }
    if (strpos($e->getMessage(), 'Unknown database') !== false || strpos($e->getMessage(), "Table 'majul764_product.products' doesn't exist") !== false) {
        echo "- Ensure the database and tables exist.\n";
        echo "  First, create the database 'majul764_product' in phpMyAdmin.\n";
        echo "  Then, run this SQL to create the tables:\n\n";
        echo "  CREATE TABLE categories (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), slug VARCHAR(255) UNIQUE, sort_order INT DEFAULT 0);\n";
        echo "  CREATE TABLE subcategories (id INT AUTO_INCREMENT PRIMARY KEY, category_id INT, name VARCHAR(255), slug VARCHAR(255), sort_order INT DEFAULT 0, FOREIGN KEY (category_id) REFERENCES categories(id));\n";
        echo "  CREATE TABLE brands (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), slug VARCHAR(255) UNIQUE, sort_order INT DEFAULT 0);\n";
        echo "  CREATE TABLE products (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), slug VARCHAR(255) UNIQUE, image_url TEXT, category_id INT, subcategory_id INT, brand_id INT, is_active TINYINT(1) DEFAULT 1, sort_order INT DEFAULT 0, FOREIGN KEY (category_id) REFERENCES categories(id), FOREIGN KEY (subcategory_id) REFERENCES subcategories(id), FOREIGN KEY (brand_id) REFERENCES brands(id));\n";
    }
} catch (Throwable $e) {
    echo "CRITICAL ERROR: " . $e->getMessage() . "\n";
}
