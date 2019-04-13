import 'package:flutter/material.dart';

///
/// Created by dumingwei on 2019/4/13.
/// Desc:
///

class GlobalConfig {
  static ThemeData geThemeData(bool dark) {
    if (dark) {
      return themeDataDark;
    } else {
      return themeDataLight;
    }
  }

  static bool dark = false;

  static ThemeData themeData = geThemeData(dark);

  static ThemeData themeDataLight = new ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light,
  );

  static ThemeData themeDataDark = new ThemeData.dark();
}
