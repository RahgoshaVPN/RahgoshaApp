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
    [
      "@semantic-release/commit-analyzer",
      {
        preset: "angular",
        releaseRules: [
          { type: "fix", release: "patch" },
          { type: "feat", release: "minor" },
          { type: "hotfix", release: "patch" },
          { type: "refactor", release: "patch" },
          { type: "style", release: "patch" },
          { type: "docs", release: false },
          { type: "chore", release: false },
          { type: "test", release: false },
          { type: "build", release: false },
          { type: "ci", release: false }
        ]
      }
    ],
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
