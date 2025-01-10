import 'package:flutter/material.dart';

class ThemeColors {
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

final themeColors = ThemeColors();

final defaultTextStyle = 
  TextStyle(
    fontFamily: "Vazirmatn", 
    fontFamilyFallback: ["Emoji"],
    color: themeColors.textColor,
  );


final defaultTextTheme = TextTheme(
  titleLarge: defaultTextStyle,
  titleMedium: defaultTextStyle,
  titleSmall: defaultTextStyle,
  
  bodyLarge: defaultTextStyle,
  bodyMedium: defaultTextStyle,
  bodySmall: defaultTextStyle,
  labelLarge: defaultTextStyle,
  labelMedium: defaultTextStyle,
  labelSmall: defaultTextStyle,
);