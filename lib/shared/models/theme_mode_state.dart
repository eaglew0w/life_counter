import 'package:flutter/material.dart';
import 'package:life_counter/shared/constants/constants.dart';

class ThemeModeState {
  ThemeMode themeMode;
  bool isInitialMode;

  ThemeModeState(
      {this.themeMode = initialThemeMode, this.isInitialMode = true});
}
