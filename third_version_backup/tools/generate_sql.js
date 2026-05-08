const fs = require("fs");
const path = require("path");

const root = path.resolve(__dirname, "products");
const out = path.resolve(__dirname, "products_seed.sql");
const q = String.fromCharCode(39);

const slug = (value) => {
  const normalized = value
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
  return normalized || "item";
};

const sqlEscape = (value) => value.split(q).join(q + q);

const categories = new Map();
const subcategories = new Map();
const brands = new Map();
const products = [];

const walk = (dir) => {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      walk(full);
      continue;
    }
    const ext = path.extname(entry.name).toLowerCase();
    if (![".png", ".jpg", ".jpeg", ".webp"].includes(ext)) {
      continue;
    }
    const rel = path.relative(root, full).split(path.sep).join("/");
    const parts = rel.split("/");
    if (parts.length < 4) {
      continue;
    }
    const categoryName = parts[0];
    const subcategoryName = parts[1];
    const brandName = parts[2];
    const productName = path.basename(parts[parts.length - 1], ext);

    const categorySlug = slug(categoryName);
    const subcategorySlug = slug(subcategoryName);
    const brandSlug = slug(brandName);
    const productSlug = slug(productName);

    categories.set(categorySlug, categoryName);
    const subKey = `${categorySlug}|${subcategorySlug}`;
    if (!subcategories.has(subKey)) {
      subcategories.set(subKey, { name: subcategoryName, categorySlug });
    }
    brands.set(brandSlug, brandName);
    products.push({
      name: productName,
      slug: productSlug,
      image: `products/${rel}`,
      categorySlug,
      subcategorySlug,
      brandSlug
    });
  }
};

if (!fs.existsSync(root)) {
  throw new Error("Products folder not found.");
}

walk(root);

const lines = [];
const sortedCategories = [...categories.entries()].sort((a, b) => a[0].localeCompare(b[0]));
for (const [slugValue, nameValue] of sortedCategories) {
  const nameEsc = sqlEscape(nameValue);
  const slugEsc = sqlEscape(slugValue);
  lines.push(
    `INSERT INTO categories (name, slug, sort_order) VALUES (${q}${nameEsc}${q}, ${q}${slugEsc}${q}, 0) ON DUPLICATE KEY UPDATE name=VALUES(name), sort_order=VALUES(sort_order);`
  );
}

const sortedSubcategories = [...subcategories.entries()].sort((a, b) => a[0].localeCompare(b[0]));
for (const [key, subcat] of sortedSubcategories) {
  const nameEsc = sqlEscape(subcat.name);
  const subSlugEsc = sqlEscape(key.split("|")[1]);
  const catSlugEsc = sqlEscape(subcat.categorySlug);
  lines.push(
    `INSERT INTO subcategories (category_id, name, slug, sort_order) SELECT id, ${q}${nameEsc}${q}, ${q}${subSlugEsc}${q}, 0 FROM categories WHERE slug=${q}${catSlugEsc}${q} ON DUPLICATE KEY UPDATE name=VALUES(name), sort_order=VALUES(sort_order);`
  );
}

const sortedBrands = [...brands.entries()].sort((a, b) => a[0].localeCompare(b[0]));
for (const [slugValue, nameValue] of sortedBrands) {
  const nameEsc = sqlEscape(nameValue);
  const slugEsc = sqlEscape(slugValue);
  lines.push(
    `INSERT INTO brands (name, slug, sort_order) VALUES (${q}${nameEsc}${q}, ${q}${slugEsc}${q}, 0) ON DUPLICATE KEY UPDATE name=VALUES(name), sort_order=VALUES(sort_order);`
  );
}

products.sort((a, b) => a.name.localeCompare(b.name));
for (const product of products) {
  const nameEsc = sqlEscape(product.name);
  const slugEsc = sqlEscape(product.slug);
  const imgEsc = sqlEscape(product.image);
  const catSlugEsc = sqlEscape(product.categorySlug);
  const subSlugEsc = sqlEscape(product.subcategorySlug);
  const brandSlugEsc = sqlEscape(product.brandSlug);
  lines.push(
    `INSERT INTO products (name, slug, image_url, category_id, subcategory_id, brand_id, is_active, sort_order) VALUES (${q}${nameEsc}${q}, ${q}${slugEsc}${q}, ${q}${imgEsc}${q}, (SELECT id FROM categories WHERE slug=${q}${catSlugEsc}${q}), (SELECT s.id FROM subcategories s JOIN categories c ON c.id=s.category_id WHERE s.slug=${q}${subSlugEsc}${q} AND c.slug=${q}${catSlugEsc}${q}), (SELECT id FROM brands WHERE slug=${q}${brandSlugEsc}${q}), 1, 0) ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), is_active=VALUES(is_active), sort_order=VALUES(sort_order);`
  );
}

fs.writeFileSync(out, lines.join("\n"), "utf8");
console.log(out);
