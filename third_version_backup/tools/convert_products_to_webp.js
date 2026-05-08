const fs = require("fs");
const path = require("path");
const sharp = require("sharp");

const root = path.resolve(__dirname, "products");
const quality = 80;

const exts = new Set([".png", ".jpg", ".jpeg"]);

const walk = (dir, files = []) => {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      walk(full, files);
    } else {
      files.push(full);
    }
  }
  return files;
};

const convert = async () => {
  if (!fs.existsSync(root)) {
    throw new Error("products folder not found");
  }
  const files = walk(root).filter((file) => exts.has(path.extname(file).toLowerCase()));
  for (const file of files) {
    const out = file.replace(/\.[^/.]+$/, ".webp");
    await sharp(file).webp({ quality }).toFile(out);
    fs.unlinkSync(file);
  }
};

convert()
  .then(() => {
    process.stdout.write("done\n");
  })
  .catch((err) => {
    process.stderr.write(err.message + "\n");
    process.exit(1);
  });
