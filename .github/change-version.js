const fs = require('fs');
const path = require('path');

const pubspecPath = path.resolve('pubspec.yaml');
const version = process.argv[2];

if (!version) {
  console.error('Error: Version argument is required.');
  process.exit(1);
}

const buildNumber = process.env.BUILD_NUMBER || '0';
const versionRegex = /^version:\s\d+\.\d+\.\d+.*$/m;

try {
  const pubspecContent = fs.readFileSync(pubspecPath, 'utf8');
  const updatedContent = pubspecContent.replace(
    versionRegex,
    `version: ${version}+${buildNumber}`
  );
  fs.writeFileSync(pubspecPath, updatedContent, 'utf8');
  console.log(`Updated pubspec.yaml version to ${version}+${buildNumber}`);
} catch (error) {
  console.error(`Error updating pubspec.yaml: ${error.message}`);
  process.exit(1);
}
