const fs = require("fs");
const path = require("path");
const handlebars = require("handlebars");

const templatePath = path.join(__dirname, ".github", "release-template.md");

module.exports = {
    branches: ["master", { name: "beta", prerelease: true }],
    repositoryUrl: "https://github.com/RahgoshaVPN/RahgoshaAPP",
    plugins: [
      "@semantic-release/commit-analyzer",
      "@semantic-release/release-notes-generator",
      "@semantic-release/changelog",
      [
        "@semantic-release/github", 
        {
            releaseBodyTemplate: fs.readFileSync(templatePath, "utf8"),
          assets: [
            { path: "dist/*.apk" }
          ]
        }
      ],
      [
        "@semantic-release/git",
        {
          assets: ["CHANGELOG.md", "pubspec.yaml"],
          message: "chore(release): ${nextRelease.version} [skip ci]\n\n${nextRelease.notes}"
        },
      ],
    {
        generateNotes: async (pluginConfig, context) => {
          // Custom logic to update the version in pubspec.yaml
          const pubspecPath = "pubspec.yaml";
          const versionRegex = /^version:\s\d+\.\d+\.\d+.*$/m;
          const pubspecContent = fs.readFileSync(pubspecPath, "utf8");
          const updatedContent = pubspecContent.replace(versionRegex, `version: ${context.nextRelease.version}`);
          fs.writeFileSync(pubspecPath, updatedContent, "utf8");
        }
    }
    ]

  };
  