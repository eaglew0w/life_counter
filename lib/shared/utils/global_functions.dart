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

Background getNextBackground(Background background) {
  Background retNextBackground = Background.unset;

  switch (background) {
    case Background.unset:
      retNextBackground = Background.day;
      break;
    case Background.day:
      retNextBackground = Background.night;
      break;
    case Background.night:
      retNextBackground = Background.day;
      break;
    default:
      retNextBackground = Background.unset;
      break;
  }
  return retNextBackground;
}

Color getBackgroundColor(Background background) {
  Color retColor = backgroundColorDefault;

  switch (background) {
    case Background.unset:
      retColor = backgroundColorDefault;
      break;
    case Background.day:
      retColor = backgroundColorDay;
      break;
    case Background.night:
      retColor = backgorundColorNight;
      break;
    default:
      retColor = backgroundColorDefault;
      break;
  }

  return retColor;
}

Icon getBackgroundIcon(Background background) {
  Icon retIcon = backgroundUnsetIcon;

  switch (background) {
    case Background.unset:
      retIcon = backgroundUnsetIcon;
      break;
    case Background.day:
      retIcon = backgroundDayIcon;
      break;
    case Background.night:
      retIcon = backgroundNightIcon;
      break;
    default:
      retIcon = backgroundUnsetIcon;
      break;
  }

  return retIcon;
}
