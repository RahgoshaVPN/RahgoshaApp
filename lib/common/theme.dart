import 'package:flutter/material.dart';


enum AppTheme {
  system("system"),
  light("light"),
  dark("dark"),
  black("black");
  final String value;
  const AppTheme(this.value);

    static AppTheme fromString(String value) {
    return AppTheme.values.firstWhere(
      (theme) => theme.value == value,
      orElse: () => AppTheme.system,
    );
  }
}

abstract class ThemeColors {
  // General
  Color get backgroundColor;
  Color get secondaryBackgroundColor;
  Color get textColor;
  Color get secondaryTextColor;

  // Connection Button
  Color get connectedButtonColor;
  Color get connectingButton;
  Color get disconnectedButton;

  // States
  Color get loadingColor;
  Color get enabledColor;
  Color get disabledColor;

  // Brightness
  Brightness get brightness;
}

class DarkThemeColors extends ThemeColors {
  @override
  Color get backgroundColor => Color(0xFF121212);
  @override
  Color get secondaryBackgroundColor => Color(0xFF1E1E1E);
  @override
  Color get textColor => Color(0xFFE0E0E0);
  @override
  Color get secondaryTextColor => Color(0xFFB0B0B0);
  @override
  Color get connectedButtonColor => Color(0xFF3DFFB6);
  @override
  Color get connectingButton => Color(0xFFFFC857);
  @override
  Color get disconnectedButton => Color(0xFFF44336);
  @override
  Color get loadingColor => Color(0xFFFFC857);
  @override
  Color get enabledColor => Color(0xFF3DFFB6);
  @override
  Color get disabledColor=> Colors.grey;
  @override
  Brightness get brightness => Brightness.dark;
}

class LightThemeColors extends ThemeColors {
  @override
  Color get backgroundColor => Color(0xFFFFFFFF);
  @override
  Color get secondaryBackgroundColor => Color(0xFFF5F5F5);
  @override
  Color get textColor => Color(0xFF212121);
  @override
  Color get secondaryTextColor => Color(0xFF757575);
  @override
  Color get connectedButtonColor => Colors.green.shade600;
  @override
  Color get connectingButton => Color(0xFFFFC857);
  @override
  Color get disconnectedButton => Colors.red.shade600;
  @override
  Color get loadingColor => Color(0xFFFFC857);
  @override
  Color get enabledColor => Colors.green.shade600;
  @override
  Color get disabledColor=> Colors.red.shade600;
  @override
  Brightness get brightness => Brightness.light;

}

class BlackThemeColors extends ThemeColors {
  @override
  Color get backgroundColor => Color(0xFF000000);
  @override
  Color get secondaryBackgroundColor => Color(0xFF121212);
  @override
  Color get textColor => Color(0xFFFFFFFF);
  @override
  Color get secondaryTextColor => Color(0xFFB0B0B0);
  @override
  Color get connectedButtonColor => Color(0xFF3DFFB6);
  @override
  Color get connectingButton => Color(0xFFFFC857);
  @override
  Color get disconnectedButton => Color(0xFFF44336);
  @override
  Color get loadingColor => Color(0xFFFFC857);
  @override
  Color get enabledColor => Color(0xFF3DFFB6);
  @override
  Color get disabledColor=> Color(0xFFF44336);
  @override
  Brightness get brightness => Brightness.dark;
}

class SexColors {
  
  final Color backgroundColor = Color(0xFF121212);
  final Color secondaryBackgroundColor = Color(0xFF1E1E1E);
  final Color primaryColor = Color(0xFF3DFFB6);
  final Color secondaryColor = Color(0xFFFFC857);
  final Color redColor = Color(0xFFF44336);
  // final Color secondaryColor = Color(0xFF3DFFB6);
  // final Color primaryColor = Color(0xFFFFC857);
  final Color textColor = Color(0xFFE0E0E0);
  final Color secondaryTextColor = Color(0xFFB0B0B0);

}




// final themeColors = SexColors();

