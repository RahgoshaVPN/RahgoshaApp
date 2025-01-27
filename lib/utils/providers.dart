import 'package:flutter/material.dart';
import 'package:flutter_v2ray/model/v2ray_status.dart';
import 'package:rahgosha/common/theme.dart';
import 'package:rahgosha/utils/appcache.dart';


class V2RayStatusNotifier extends ChangeNotifier {
  final ValueNotifier<V2RayStatus> v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());

  void updateStatus(V2RayStatus status) {
    v2rayStatus.value = status;
    notifyListeners();
  }
}

class V2RayURLNotifier extends ChangeNotifier {
  dynamic url;

  void updateURL(dynamic newUrl) {
    url = newUrl;
    notifyListeners();
  }
}

class ThemeProvider extends ChangeNotifier {
  AppTheme appTheme = AppTheme.system;

  void updateTheme(AppTheme newAppTheme) {
    cache.set("appTheme", newAppTheme.value);
    appTheme = newAppTheme;
    notifyListeners();
  }

  ThemeColors getColors(BuildContext context) {
    switch (cache.get("appTheme") ?? appTheme.value) {
      case "light":
        return LightThemeColors();
      case "dark":
        return DarkThemeColors();
      case "black":
        return BlackThemeColors();
      default:
        final brightness = MediaQuery.of(context).platformBrightness;
        if (brightness == Brightness.dark) {
          return DarkThemeColors();
        } else {
          return LightThemeColors();
        }
    }
  }
}

