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
        publishCmd: `
          node -e "
          const fs = require('fs');
          const path = require('path');
          const pubspecPath = path.resolve('pubspec.yaml');
          const versionRegex = /^version:\\s\\d+\\.\\d+\\.\\d+.*$/m;
          const pubspecContent = fs.readFileSync(pubspecPath, 'utf8');
          const updatedContent = pubspecContent.replace(versionRegex, 'version: \${nextRelease.version}+${process.env.BUILD_NUMBER}');
          fs.writeFileSync(pubspecPath, updatedContent, 'utf8');
          console.log('Updated pubspec.yaml version to \${nextRelease.version}+${process.env.BUILD_NUMBER}');
          "
        `,
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
