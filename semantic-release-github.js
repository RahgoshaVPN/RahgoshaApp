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
    [
      "@semantic-release/release-notes-generator",
      {
        preset: "angular",
        writerOpts: {
          groupBy: "type",
          commitGroupsSort: (a, b) => {
            const order = ["feat", "fix", "hotfix", "refactor", "style", "docs", "test", "build", "chore", "ci"];
            return order.indexOf(a.title) - order.indexOf(b.title);
          },
          groupTitleMap: {
            feat: "🚀 Features",
            fix: "🐛 Bug Fixes",
            hotfix: "🔥 Hot Fixes",
            refactor: "🚧 Refactors",
            style: "✨ Styles",
            docs: "📚 Documentation",
            test: "✅ Tests",
            build: "🏗️ Build",
            chore: "🛠️ Maintenance",
            ci: "🔄 CI/CD"
          }
        }
      }
    ],
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
