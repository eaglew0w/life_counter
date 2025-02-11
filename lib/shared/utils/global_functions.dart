import 'package:flutter/material.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/models/theme_mode_state.dart';

String addAbsoluteValueText(int value) {
  String retString = '';
  if (value == 0) {
    retString = '';
  } else if (value > 0) {
    retString = '+$value';
  } else {
    retString = '$value';
  }
  return retString;
}

Icon getThemeModeIcon(ThemeModeState themeModeState) {
  Icon retIcon = themeModeSystemIcon;
  if (themeModeState.isInitialMode == false) {
    switch (themeModeState.themeMode) {
      case ThemeMode.dark:
        retIcon = themeModeDarkIcon;
        break;
      case ThemeMode.light:
        retIcon = themeModeLightIcon;
        break;
      case ThemeMode.system:
        retIcon = themeModeSystemIcon;
        break;
    }
  }
  return retIcon;
}
