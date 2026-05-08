<?php
function getDb(): PDO
{
    $host = 'localhost';
    $db = 'majul764_product';
    $charset = 'utf8mb4';

    // Detect environment (CLI, Localhost, or 127.0.0.1)
    $isLocal = php_sapi_name() === 'cli'
        || in_array($_SERVER['REMOTE_ADDR'] ?? '', ['127.0.0.1', '::1'])
        || ($_SERVER['SERVER_NAME'] ?? '') === 'localhost'
        || ($_SERVER['HTTP_HOST'] ?? '') === 'localhost';

    if ($isLocal) {
        $host = 'localhost';
        $user = 'root';
        $pass = '';
    } else {
        // Production / Remote (using the cPanel details you provided)
        $host = '127.0.0.1'; // Using IP can sometimes bypass socket permission issues
        $user = 'majul764_admin';
        $pass = 'MQ_$#sfZc_pLx&(U';
    }

    $port = '3306';
    $dsn = "mysql:host=$host;port=$port;dbname=$db;charset=$charset";
    $options = [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false
    ];

    return new PDO($dsn, $user, $pass, $options);
}
