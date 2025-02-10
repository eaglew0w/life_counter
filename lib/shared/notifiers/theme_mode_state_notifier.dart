import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/models/theme_mode_state.dart';
import 'package:life_counter/shared/notifiers/resettable_notifier.dart';

class ThemeModeStateNotifier extends Notifier<ThemeModeState>
    implements ResettableNotifier {
  @override
  ThemeModeState build() {
    return ThemeModeState();
  }

  void setNextThemeMode() {
    if (state.themeMode == ThemeMode.dark) {
      state = ThemeModeState(themeMode: ThemeMode.light, isInitialMode: false);
    } else {
      state = ThemeModeState(themeMode: ThemeMode.dark, isInitialMode: false);
    }
  }

  @override
  void reset() {
    state = ThemeModeState(themeMode: initialThemeMode, isInitialMode: true);
  }
}
