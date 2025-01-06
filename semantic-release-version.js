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
  plugins: [
    "@semantic-release/commit-analyzer",
    "@semantic-release/release-notes-generator",
    "@semantic-release/changelog",
    [
      "@semantic-release/exec",
      {
        prepareCmd: "node .github/change-version.js \"${nextRelease.version}\""
      },
    ]
  ],
};
