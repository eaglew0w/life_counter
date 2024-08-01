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
