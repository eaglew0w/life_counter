import 'package:flutter/material.dart';

const Color backgroundColorDefault = Colors.black;
final Color backgroundColorDay = Colors.amber[900]!;
final Color backgorundColorNight = Colors.indigo[900]!;

const Color textColorDefault = Colors.white;
final Color lifeChangeButtonColor = Colors.grey[600]!;

const int lifeChangeDisplayTimer = 5;
const int defaultLife = 20;
const double alignmentXofPlayerLifeChange = 0;
const double alignmentYofPlayerLifeChange = 0.4;

enum Background { unset, day, night }

const Background defaultBackground = Background.unset;

const Icon resetIcon = Icon(Icons.restart_alt);

const Icon backgroundUnsetIcon = Icon(Icons.restore);
const Icon backgroundDayIcon = Icon(Icons.light_mode);
const Icon backgroundNightIcon = Icon(Icons.dark_mode);

class ChangeLifeInfo {
  // もうちょっといい感じに管理したい
  static String gainText = '+';
  static String loseText = '-';
  static int gainOnTap = 1;
  static int loseOnTap = -1;
  static int gainOnFlick = 5;
  static int loseOnFlick = -5;
}

// フリック判定の為の値
const int flickThresholdForLifeChange = 75;
