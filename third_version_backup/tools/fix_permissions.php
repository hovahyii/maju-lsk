<?php
// fix_permissions.php
// Place this in your public_html folder and run it via browser: yourdomain.com/fix_permissions.php

function chmod_recursive($path, $dir_perms, $file_perms)
{
    $dir = new DirectoryIterator($path);
    foreach ($dir as $item) {
        if ($item->isDot())
            continue;

        $fullPath = $item->getPathname();

        if ($item->isDir()) {
            echo "Setting DIR: $fullPath to " . decoct($dir_perms) . "<br>";
            chmod($fullPath, $dir_perms);
            chmod_recursive($fullPath, $dir_perms, $file_perms);
        } else {
            echo "Setting FILE: $fullPath to " . decoct($file_perms) . "<br>";
            chmod($fullPath, $file_perms);
        }
    }
}

$startDir = __DIR__ . '/products';
if (is_dir($startDir)) {
    echo "Starting permission fix for: $startDir<br>";
    chmod($startDir, 0755);
    chmod_recursive($startDir, 0755, 0644);
    echo "<br>DONE! Try accessing your images now.";
} else {
    echo "ERROR: 'products' folder not found in " . __DIR__;
}
?>