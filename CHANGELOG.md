## [1.0.0-alpha.8](https://github.com/RahgoshaVPN/RahgoshaApp/compare/v1.0.0-alpha.7...v1.0.0-alpha.8) (2025-01-16)

### 🐛 Bug Fixes

* Fix keystore path in build and release workflow ([75ae0d0](https://github.com/RahgoshaVPN/RahgoshaApp/commit/75ae0d0ea2e589711c1776311c370da681c73150))

### 🚧 Refactors

* Add permission check before connecting to servers in home screen ([1aa3ded](https://github.com/RahgoshaVPN/RahgoshaApp/commit/1aa3ded092b756e6aedc6a91436da1b5a1381239))
* Adjust delay thresholds for color coding in servers screen ([f47da0a](https://github.com/RahgoshaVPN/RahgoshaApp/commit/f47da0a491099145b5f3ec797d94e0d5cc8119ef))
* Enhance build workflow to include APK signing process and reorganize keystore handling ([3983116](https://github.com/RahgoshaVPN/RahgoshaApp/commit/39831161383bf163da719761a53a5fb97d145592))
* Prevent tap action on selected index in servers screen ([6dfb008](https://github.com/RahgoshaVPN/RahgoshaApp/commit/6dfb008f4ff23fd2dec8df863b9636d32584f1b1))

### ✨ Styles

* Set system UI overlay style for improved navigation bar appearance ([24b4f37](https://github.com/RahgoshaVPN/RahgoshaApp/commit/24b4f37599a469b31d9bfa599b6308f225332092))

## [1.0.0-alpha.7](https://github.com/RahgoshaVPN/RahgoshaApp/compare/v1.0.0-alpha.6...v1.0.0-alpha.7) (2025-01-15)

### 🚧 Refactors

* Update versioning script to modify pubspec.yaml instead of build.gradle ([96a92e8](https://github.com/RahgoshaVPN/RahgoshaApp/commit/96a92e8b15d5eb346ea4b1e3c45e64f31e35ac03))

## [1.0.0-alpha.6](https://github.com/RahgoshaVPN/RahgoshaApp/compare/v1.0.0-alpha.5...v1.0.0-alpha.6) (2025-01-15)

### 🚧 Refactors

* Update build workflow to extract and pass version from semantic-release to change-version script ([07e612f](https://github.com/RahgoshaVPN/RahgoshaApp/commit/07e612ffb5777f15db7e82c43b4773793a4f6166))

## [1.0.0-alpha.5](https://github.com/RahgoshaVPN/RahgoshaApp/compare/v1.0.0-alpha.4...v1.0.0-alpha.5) (2025-01-15)

### 🚧 Refactors

* Clean up HomeScreen state management and improve URL change handling ([1cc44bb](https://github.com/RahgoshaVPN/RahgoshaApp/commit/1cc44bb941e471b2811a9388cbd0092df5cad154))

## [1.0.0-alpha.4](https://github.com/RahgoshaVPN/RahgoshaApp/compare/v1.0.0-alpha.3...v1.0.0-alpha.4) (2025-01-13)

### 🔥 Hot Fixes

* Ensure loading state is managed correctly when connecting to servers ([306e44f](https://github.com/RahgoshaVPN/RahgoshaApp/commit/306e44fa0fc52a787e16e5ce446419fa620a492d))

## [1.0.0-alpha.3](https://github.com/RahgoshaVPN/RahgoshaApp/compare/v1.0.0-alpha.2...v1.0.0-alpha.3) (2025-01-12)

### 🚀 Features

* Enable auto-update and hot connect features by default in settings ([b12cb7c](https://github.com/RahgoshaVPN/RahgoshaApp/commit/b12cb7c0b338e76b851bb98ac007a41deebedfc5))

### 🐛 Bug Fixes

* Fix custom font family to app bar title text style ([2f38275](https://github.com/RahgoshaVPN/RahgoshaApp/commit/2f382758f41a1dcbfccbb405afa08c3eb3f0234f))

### 🚧 Refactors

* Improve server connection handling with async disconnect and state update ([0a665ea](https://github.com/RahgoshaVPN/RahgoshaApp/commit/0a665ea722e832e31295398093ff4e3ff739dc87))
* Optimize app initialization by executing tasks in parallel and improve version fetching ([0758a12](https://github.com/RahgoshaVPN/RahgoshaApp/commit/0758a12b29334f578d79b38964c8203533c7aa63))
* Remove debug logging statements and clean up drawer widget ([fabe00f](https://github.com/RahgoshaVPN/RahgoshaApp/commit/fabe00faaad24a588b300b65de06deb64a90acc4))

## [1.0.0-alpha.2](https://github.com/RahgoshaVPN/RahgoshaApp/compare/v1.0.0-alpha.1...v1.0.0-alpha.2) (2025-01-11)

### 🚀 Features

* Add auto-update feature with customizable interval in settings ([a82b8eb](https://github.com/RahgoshaVPN/RahgoshaApp/commit/a82b8eb2d9c10d692214b10441ad0aa1fa827eda))

### 🐛 Bug Fixes

* Update APK download links in release template to include version number ([da17696](https://github.com/RahgoshaVPN/RahgoshaApp/commit/da17696b0b624013cace4faeffb1234a8003e220))
* Update V2Ray initialization to include notification icon resources ([26cc4bf](https://github.com/RahgoshaVPN/RahgoshaApp/commit/26cc4bf1e2d6273033e70164494376b874ace4bf))
* Update version display format in DrawerWidget ([c377cf4](https://github.com/RahgoshaVPN/RahgoshaApp/commit/c377cf4b37a7274ebbf9ecab26e4269c04c1ea51))

### 🔥 Hot Fixes

* Correct path resolution for APK distribution directory in rename script ([c3ba0fa](https://github.com/RahgoshaVPN/RahgoshaApp/commit/c3ba0fa719a49f5a54bf8abef21ac1dc310472ff))

### 🚧 Refactors

* Remove unused font families from various widgets and add fallback for Emoji ([6486988](https://github.com/RahgoshaVPN/RahgoshaApp/commit/648698833484dacf6a358c64e2e192ebb1f35af6))

## 1.0.0-alpha.1 (2025-01-11)

### 🚀 Features

* Add V2Ray status and URL notifiers for improved state management ([abcf79b](https://github.com/RahgoshaVPN/RahgoshaApp/commit/abcf79b110ceeb0d0bbfcfa7d8690c7dddd5845a))
* Integrate V2RayURLNotifier and enhance server selection logic ([55df58c](https://github.com/RahgoshaVPN/RahgoshaApp/commit/55df58c9481504cd74f476b0974ddafeddf0024a))

### 🐛 Bug Fixes

* Change URL parameter type to dynamic in V2RayURLNotifier for flexibility ([5611997](https://github.com/RahgoshaVPN/RahgoshaApp/commit/5611997fd9ee0d1c9730449b1e794290fd77d257))
* Disable updateServers button when v2rayStatus is CONNECTED ([3f62a51](https://github.com/RahgoshaVPN/RahgoshaApp/commit/3f62a5149ae1ec412752dcd51a9a6edada801210))
* Improve server update handling and user feedback in home screen ([43c6a8d](https://github.com/RahgoshaVPN/RahgoshaApp/commit/43c6a8dd732e25820d2c214eff83b4ca4be25743))
* Prevent memory leak by removing listener in dispose method and improve no servers found message ([efe50fc](https://github.com/RahgoshaVPN/RahgoshaApp/commit/efe50fc463cb246eee3f0fa0c3320f746d8e4993))
* Update DrawerHeader image to use rahgosha-banner.jpg ([35e2a60](https://github.com/RahgoshaVPN/RahgoshaApp/commit/35e2a60da73a2a71eb34b2b21239111b836ead1f))

### 🚧 Refactors

* Clean up main.dart by removing unused code and improving readability ([653e5ea](https://github.com/RahgoshaVPN/RahgoshaApp/commit/653e5ea2089aee7881e5b40cbfe12be324d1bcd3))
* Remove unnecessary debug logging in server selection modal ([2c3e868](https://github.com/RahgoshaVPN/RahgoshaApp/commit/2c3e86883307b4eaf76acf6a507f7ff56b4c7293))

### ✨ Styles

* Add fontFamilyFallback for Emoji support in defaultTextStyle ([ee5e59e](https://github.com/RahgoshaVPN/RahgoshaApp/commit/ee5e59e147b8676cf9261785349ba5f9e428cf42))
* Add fontFamilyFallback for Emoji support in servers screen ([ceca217](https://github.com/RahgoshaVPN/RahgoshaApp/commit/ceca217a713d719793a7ec9d30d9f9e8a40b84ff))
* **fonts:** Add Emoji font support to VPN card ([973cf4e](https://github.com/RahgoshaVPN/RahgoshaApp/commit/973cf4e528c1860e78daeecf978561e0b6cbaef9))
* Remove fontFamilyFallback for Emoji in defaultTextStyle ([7520470](https://github.com/RahgoshaVPN/RahgoshaApp/commit/75204704ad27a948875502d732ea303d3875d177))
