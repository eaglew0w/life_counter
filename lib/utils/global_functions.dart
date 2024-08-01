import 'package:flutter/material.dart';
import 'package:life_counter/constants/constants.dart';
import 'package:life_counter/models/background_state.dart';

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

Color getBackgroundColor(BackgroundState backgroundState) {
  Color retColor = backgroundColorDefault;

  switch (backgroundState) {
    case BackgroundState.unset:
      retColor = backgroundColorDefault;
      break;
    case BackgroundState.day:
      retColor = backgroundColorDay;
      break;
    case BackgroundState.night:
      retColor = backgorundColorNight;
      break;
    default:
      retColor = backgroundColorDefault;
      break;
  }

  return retColor;
}

BackgroundState getNextBackground(BackgroundState backgroundState) {
  BackgroundState retNextBackground = BackgroundState.unset;

  switch (backgroundState) {
    case BackgroundState.unset:
      retNextBackground = BackgroundState.day;
      break;
    case BackgroundState.day:
      retNextBackground = BackgroundState.night;
      break;
    case BackgroundState.night:
      retNextBackground = BackgroundState.day;
      break;
    default:
      retNextBackground = BackgroundState.day;
      break;
  }

  return retNextBackground;
}

Icon getBackgroundIcon(BackgroundState backgroundState) {
  Icon retIcon = backgroundUnsetIcon;

  switch (backgroundState) {
    case BackgroundState.unset:
      retIcon = backgroundUnsetIcon;
      break;
    case BackgroundState.day:
      retIcon = backgroundDayIcon;
      break;
    case BackgroundState.night:
      retIcon = backgroundNightIcon;
      break;
    default:
      retIcon = backgroundUnsetIcon;
      break;
  }

  return retIcon;
}
