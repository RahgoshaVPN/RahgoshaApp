const fs = require('fs');
const path = require('path');

const buildGradlePath = path.resolve('android/app/build.gradle');
const versionName = process.argv[2];

if (!versionName) {
  console.error('Error: Version argument is required.');
  process.exit(1);
}

const versionCode = process.env.BUILD_NUMBER || '1'; // Default to 1 if BUILD_NUMBER is not provided
const versionNameRegex = /versionName\s+"[\d.]+"/;
const versionCodeRegex = /versionCode\s+\d+/;

try {
  const buildGradleContent = fs.readFileSync(buildGradlePath, 'utf8');

  // Replace versionName
  let updatedContent = buildGradleContent.replace(
    versionNameRegex,
    `versionName "${versionName}"`
  );

  // Replace versionCode
  updatedContent = updatedContent.replace(
    versionCodeRegex,
    `versionCode ${versionCode}`
  );

  fs.writeFileSync(buildGradlePath, updatedContent, 'utf8');
  console.log(
    `Updated build.gradle: versionName="${versionName}" and versionCode=${versionCode}`
  );
} catch (error) {
  console.error(`Error updating build.gradle: ${error.message}`);
  process.exit(1);
}
