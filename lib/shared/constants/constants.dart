import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

const String title = "MTG Life Counter";

const int playerNumber = 4;

const int lifeChangeDisplayTimer = 5;
const int defaultLife = 20;
const double alignmentXofPlayerLifeChange = 0;
const double alignmentYofPlayerLifeChange = 0.4;

const ThemeMode initialThemeMode = ThemeMode.dark;

const Icon resetIcon = Icon(Icons.restart_alt);

const Icon themeModeSystemIcon = Icon(Symbols.routine);
const Icon themeModeLightIcon = Icon(Icons.light_mode);
const Icon themeModeDarkIcon = Icon(Icons.dark_mode);

enum Players { player1, player2, player3, player4 }

enum PlayerPosition { none, left, right }

// Life Change Settings
const String lifeGainText = '+';
const String lifeLoseText = '-';
const int lifeGainOnTap = 1;
const int lifeLoseOnTap = -1;
const int lifeGainOnFlick = 5;
const int lifeLoseOnFlick = -5;
const int lifeGainOnLongPress = 5;
const int lifeLoseOnLongPress = -5;

const Color lifeGainButtonTextColor = Colors.green;
const Color lifeLoseButtonTextColor = Colors.red;

// フリック判定の為の値
const int flickThresholdForLifeChange = 75;

// Counter Symbols & Colors
const String poisonCounterSymbol = 'Φ';
const Color poisonColor = Colors.green;
const Color speedColor = Colors.orange;
const Color speedActiveColor = Colors.red;

// UI Dimensions & Styles
const double sheetVerticalPadding = 24.0;
const double sheetHorizontalPadding = 16.0;
const double sheetHandleWidth = 40.0;
const double sheetHandleHeight = 4.0;
const double sheetHandleRadius = 2.0;

const double matchControlTitleFontSize = 20.0;
const double lifeResetLabelFontSize = 12.0;
const double counterSymbolFontSize = 24.0;
const double menuResetButtonSize = 64.0;

// UI Texts
const String matchControlTitle = 'Match Control';
const String lifeResetLabel = 'Life Reset';
const String countersSectionTitle = 'Counters';
const String poisonCounterLabel = 'Poison Counter';
const String speedCounterLabel = 'Speed';

// Animation Durations
const Duration dayNightAnimationDuration = Duration(milliseconds: 1500);
