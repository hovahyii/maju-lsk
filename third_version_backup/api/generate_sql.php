<?php
header('Content-Type: text/plain; charset=utf-8');
/**
 * Generate SQL seed from folder structure:
 * products/<Main Category>/<Sub Category>/<Brand>/<Product Name>.(png|jpg)
 *
 * Outputs INSERT statements for:
 * - categories (name, slug)
 * - subcategories (category_id, name, slug)
 * - brands (name, slug)
 * - products (name, slug, image_url, category_id, subcategory_id, brand_id)
 *
 * Usage:
 * - Upload this file to your hosting (api/generate_sql.php)
 * - Open https://YOUR_DOMAIN/api/generate_sql.php
 * - Copy the SQL and run it in phpMyAdmin (after creating the tables)
 */

$root = realpath(__DIR__ . '/../products');
if (!$root || !is_dir($root)) {
  echo "-- ERROR: products folder not found\n";
  exit;
}

function slugify($s) {
  $s = mb_strtolower($s, 'UTF-8');
  $s = preg_replace('/[^a-z0-9]+/i', '-', $s);
  $s = trim($s, '-');
  return $s ?: 'item';
}

function sqlEscape($s) {
  return str_replace("'", "''", $s);
}

$categories = [];       // slug => name
$subcategories = [];    // "catSlug|subSlug" => ['name' => ..., 'catSlug' => ...]
$brands = [];           // slug => name
$products = [];         // rows

$rii = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($root, FilesystemIterator::SKIP_DOTS));
foreach ($rii as $file) {
  if (!$file->isFile()) continue;
  $ext = strtolower(pathinfo($file->getFilename(), PATHINFO_EXTENSION));
  if (!in_array($ext, ['png','jpg','jpeg','webp'])) continue;

  $rel = str_replace('\\', '/', substr($file->getPathname(), strlen($root)+1));
  $parts = explode('/', $rel);
  if (count($parts) < 4) continue;

  $catName  = $parts[0];
  $subName  = $parts[1];
  $brandName= $parts[2];
  $prodName = pathinfo($parts[count($parts)-1], PATHINFO_FILENAME);

  $catSlug   = slugify($catName);
  $subSlug   = slugify($subName);
  $brandSlug = slugify($brandName);
  $prodSlug  = slugify($prodName);

  $categories[$catSlug] = $catName;
  $key = $catSlug.'|'.$subSlug;
  if (!isset($subcategories[$key])) {
    $subcategories[$key] = ['name' => $subName, 'catSlug' => $catSlug];
  }
  $brands[$brandSlug] = $brandName;

  $imageUrl = 'products/' . $rel;
  $products[] = [
    'name' => $prodName,
    'slug' => $prodSlug,
    'image' => $imageUrl,
    'catSlug' => $catSlug,
    'subSlug' => $subSlug,
    'brandSlug' => $brandSlug
  ];
}

echo "SET NAMES utf8mb4;\n\n";
echo "-- Categories\n";
ksort($categories);
foreach ($categories as $slug => $name) {
  $nameEsc = sqlEscape($name);
  $slugEsc = sqlEscape($slug);
  echo "INSERT INTO categories (name, slug, sort_order) VALUES ('$nameEsc', '$slugEsc', 0)\n";
  echo "  ON DUPLICATE KEY UPDATE name=VALUES(name), sort_order=VALUES(sort_order);\n";
}
echo "\n-- Subcategories\n";
ksort($subcategories);
foreach ($subcategories as $key => $obj) {
  $nameEsc = sqlEscape($obj['name']);
  $subSlugEsc = sqlEscape(explode('|', $key)[1]);
  $catSlugEsc = sqlEscape($obj['catSlug']);
  echo "INSERT INTO subcategories (category_id, name, slug, sort_order)\n";
  echo "  SELECT id, '$nameEsc', '$subSlugEsc', 0 FROM categories WHERE slug='$catSlugEsc'\n";
  echo "  ON DUPLICATE KEY UPDATE name=VALUES(name), sort_order=VALUES(sort_order);\n";
}

echo "\n-- Brands\n";
ksort($brands);
foreach ($brands as $slug => $name) {
  $nameEsc = sqlEscape($name);
  $slugEsc = sqlEscape($slug);
  echo "INSERT INTO brands (name, slug, sort_order) VALUES ('$nameEsc', '$slugEsc', 0)\n";
  echo "  ON DUPLICATE KEY UPDATE name=VALUES(name), sort_order=VALUES(sort_order);\n";
}

echo "\n-- Products\n";
foreach ($products as $p) {
  $name = sqlEscape($p['name']);
  $slug = sqlEscape($p['slug']);
  $img  = sqlEscape($p['image']);
  $cat  = sqlEscape($p['catSlug']);
  $sub  = sqlEscape($p['subSlug']);
  $brand= sqlEscape($p['brandSlug']);
  echo "INSERT INTO products (name, slug, image_url, category_id, subcategory_id, brand_id, is_active, sort_order)\n";
  echo "  VALUES ('$name', '$slug', '$img',\n";
  echo "          (SELECT id FROM categories WHERE slug='$cat'),\n";
  echo "          (SELECT s.id FROM subcategories s JOIN categories c ON c.id=s.category_id WHERE s.slug='$sub' AND c.slug='$cat'),\n";
  echo "          (SELECT id FROM brands WHERE slug='$brand'),\n";
  echo "          1, 0)\n";
  echo "  ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), is_active=VALUES(is_active), sort_order=VALUES(sort_order);\n";
}

echo "\n-- Done\n";
