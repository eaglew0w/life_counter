import 'package:flutter/material.dart';

const String title = "MTG Life Counter";

const int playerNumber = 4;

const int lifeChangeDisplayTimer = 5;
const int defaultLife = 20;
const double alignmentXofPlayerLifeChange = 0;
const double alignmentYofPlayerLifeChange = 0.4;

const ThemeMode initialThemeMode = ThemeMode.dark;

const Icon resetIcon = Icon(Icons.restart_alt);

const Icon themeModeSystemIcon = Icon(Icons.settings_system_daydream);
const Icon themeModeLightIcon = Icon(Icons.light_mode);
const Icon themeModeDarkIcon = Icon(Icons.dark_mode);

enum Players { player1, player2, player3, player4 }

enum PlayerPosition { none, left, right }

class ChangeLifeInfo {
  // もうちょっといい感じに管理したい
  static String gainText = '+';
  static String loseText = '-';
  static int gainOnTap = 1;
  static int loseOnTap = -1;
  static int gainOnFlick = 5;
  static int loseOnFlick = -5;
  static int gainOnLongPress = 5;
  static int loseOnLongPress = -5;
}

// フリック判定の為の値
const int flickThresholdForLifeChange = 75;
