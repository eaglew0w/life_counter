import 'package:flutter/material.dart';
import 'package:life_counter/shared/constants/constants.dart';

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

Icon getThemeModeIcon(ThemeMode themeMode) {
  Icon retIcon = themeModeSystemIcon;
  switch (themeMode) {
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
  return retIcon;
}
