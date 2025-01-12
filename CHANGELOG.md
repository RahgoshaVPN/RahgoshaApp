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
