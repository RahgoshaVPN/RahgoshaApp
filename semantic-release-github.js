const fs = require("fs");
const path = require("path");

const templatePath = path.join(__dirname, ".github", "release-template.md");

module.exports = {
  branches: [
    "master",
    { name: "beta", prerelease: "beta" },
    { name: "dev", prerelease: "dev" },
    { name: "alpha", prerelease: "alpha" } 
  ],
  repositoryUrl: "https://github.com/RahgoshaVPN/RahgoshaAPP",
  plugins: [
    "@semantic-release/commit-analyzer",
    "@semantic-release/release-notes-generator",
    "@semantic-release/changelog",
    [
      "@semantic-release/github",
      {
        releaseBodyTemplate: fs.readFileSync(templatePath, "utf8"),
        assets: [{ path: "dist/*.apk" }],
      },
    ],
    [
        "@semantic-release/exec",
        {
          prepareCmd: "node .github/change-version.js \"${nextRelease.version}\""
        },
    ],
    [
      "@semantic-release/git",
      {
        assets: ["CHANGELOG.md", "pubspec.yaml"],
        message: "chore(release): ${nextRelease.version} [skip ci]\n\n${nextRelease.notes}",
      },
    ],
  ],
};
