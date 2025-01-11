const fs = require("fs");
const path = require("path");

const version = process.argv[2];
const distDir = path.resolve(__dirname, "dist");

fs.readdirSync(distDir).forEach((file) => {
  if (file.endsWith(".apk")) {
    const oldPath = path.join(distDir, file);
    const newPath = path.join(
      distDir,
      `${path.basename(file, ".apk")}-v${version}.apk`
    );
    fs.renameSync(oldPath, newPath);
  }
});
