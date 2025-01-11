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

## 1.0.0-alpha.1 (2025-01-08)

### 🚀 Features

* Enhance ServersScreen with asynchronous data loading and delay indicators ([2e71c5d](https://github.com/RahgoshaVPN/RahgoshaApp/commit/2e71c5d6f4e354930fd5f2145bdba948082ba821))
* Integrate V2RayStatusNotifier with MultiProvider for state management ([b548e0c](https://github.com/RahgoshaVPN/RahgoshaApp/commit/b548e0c350373b5c76c208e9a17e344070fed1cb))
* **release-notes:** change release notes preset to conventional commits for better compatibility ([8b65c1f](https://github.com/RahgoshaVPN/RahgoshaApp/commit/8b65c1fa226bb7d77ed7a85bc28b9dc84c2f112b))
* **release-notes:** update configuration to use presetConfig for improved organization and clarity ([d1b8625](https://github.com/RahgoshaVPN/RahgoshaApp/commit/d1b8625ff8b7a21483e104e092b1264db204d0d6))
* **ui:** convert ServerSelectionModal to StatelessWidget for improved simplicity and reusability ([db4464e](https://github.com/RahgoshaVPN/RahgoshaApp/commit/db4464e04bdaa42ab3da9dc1d6a750e41fb25a0d))

### 🐛 Bug Fixes

* Change semantic-release command to dry-run for testing purposes ([839dd69](https://github.com/RahgoshaVPN/RahgoshaApp/commit/839dd695afbafd3383bed39a5c3d18195973444f))
* Enhance server parsing by including URL and remark in full configuration ([112ac6b](https://github.com/RahgoshaVPN/RahgoshaApp/commit/112ac6bcd5bd2b4007aa59bcb90a31da09dc0aab))
* Include build number in pubspec.yaml version during release process ([a104b9e](https://github.com/RahgoshaVPN/RahgoshaApp/commit/a104b9eeb964bdffc371ac4c61dba4f748b255d3))
* Remove hardcoded repository URL from semantic-release configuration ([9d4b8a9](https://github.com/RahgoshaVPN/RahgoshaApp/commit/9d4b8a9260160e3bb29d06b2b7ab2824b320b03a))
* Simplify V2Ray initialization by removing unnecessary parameters ([b1b9017](https://github.com/RahgoshaVPN/RahgoshaApp/commit/b1b9017c5de7ca5c2d8beee4ff5a64c2e95beb46))
* Update pubspec.yaml version dynamically in release process ([78ec3eb](https://github.com/RahgoshaVPN/RahgoshaApp/commit/78ec3eb30c34cb2ee134719563300f25da774dc1))
* Update version in pubspec.yaml to 1.0.0 ([1a4e5a6](https://github.com/RahgoshaVPN/RahgoshaApp/commit/1a4e5a685a3e92e2f1e4d1887bd5a9ea1a2c0791))
* Update version in pubspec.yaml to 1.0.0-alpha.1+4 ([91f99c5](https://github.com/RahgoshaVPN/RahgoshaApp/commit/91f99c528395a316cecc6ebc9a74b96ab496840c))
* Update version in pubspec.yaml to 1.0.0-alpha.1+51 ([bf96772](https://github.com/RahgoshaVPN/RahgoshaApp/commit/bf96772639a7ea93ebdbcf8f78ccde3a6ce1826c))
* Update version in pubspec.yaml to 1.0.0+1 ([4149a07](https://github.com/RahgoshaVPN/RahgoshaApp/commit/4149a07cdb973f3dcafc097792dc4861c5ef69fc))
* Update version in pubspec.yaml to 1.0.0+2 ([26bb5fa](https://github.com/RahgoshaVPN/RahgoshaApp/commit/26bb5fa60642d7d20c0f21e9858d7496f8253ad6))
* Update version in pubspec.yaml to 1.0.0+3 and enhance release configuration ([a6b3524](https://github.com/RahgoshaVPN/RahgoshaApp/commit/a6b352427042cfcc5e10b6092a8cda761a98929c))
* Update version in pubspec.yaml to 1.0.0+4 ([49e0bbf](https://github.com/RahgoshaVPN/RahgoshaApp/commit/49e0bbfffc8e81ccd67b99905c32c865487e5e72))
* Update version in pubspec.yaml to 1.0.0+5 ([f928cc2](https://github.com/RahgoshaVPN/RahgoshaApp/commit/f928cc240ee72fdf4831958b8fcf4446f9a0083a))
* Update version in pubspec.yaml to 1.0.0+6 ([27d3332](https://github.com/RahgoshaVPN/RahgoshaApp/commit/27d33329fe84bc967ebfe834853297c5e75173be))

### ✨ Styles

* Improve UI of servers screen by adjusting container height and replacing ListTile with GestureDetector ([6b3bf77](https://github.com/RahgoshaVPN/RahgoshaApp/commit/6b3bf771e0bb3e4fa37d1748dd34300e08e86f42))
