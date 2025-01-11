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
