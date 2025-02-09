import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/notifiers/resettable_notifier.dart';

class ThemeModeNotifier extends Notifier<ThemeMode>
    implements ResettableNotifier {
  @override
  ThemeMode build() {
    return initialThemeMode;
  }

  void setNextThemeMode() {
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
  }

  @override
  void reset() {
    state = initialThemeMode;
  }
}
