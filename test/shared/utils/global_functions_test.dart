import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/models/theme_mode_state.dart';
import 'package:life_counter/shared/utils/global_functions.dart';

void main() {
  group('GlobalFunctions のテスト', () {
    group('addAbsoluteValueText のテスト', () {
      test('正の値の場合、 "+" 記号が付与されること', () {
        expect(addAbsoluteValueText(5), '+5');
        expect(addAbsoluteValueText(1), '+1');
      });

      test('負の値の場合、そのままの文字列になること', () {
        expect(addAbsoluteValueText(-5), '-5');
        expect(addAbsoluteValueText(-1), '-1');
      });

      test('ゼロの場合、空文字になること', () {
        expect(addAbsoluteValueText(0), '');
      });
    });

    group('getThemeModeIcon のテスト', () {
      test('isInitialMode が true の場合、 themeModeSystemIcon を返すこと', () {
        final state =
            ThemeModeState(themeMode: ThemeMode.dark, isInitialMode: true);
        expect(getThemeModeIcon(state), themeModeSystemIcon);
      });

      test(
          'isInitialMode が false かつ themeMode が dark の場合、 themeModeDarkIcon を返すこと',
          () {
        final state =
            ThemeModeState(themeMode: ThemeMode.dark, isInitialMode: false);
        expect(getThemeModeIcon(state), themeModeDarkIcon);
      });

      test(
          'isInitialMode が false かつ themeMode が light の場合、 themeModeLightIcon を返すこと',
          () {
        final state =
            ThemeModeState(themeMode: ThemeMode.light, isInitialMode: false);
        expect(getThemeModeIcon(state), themeModeLightIcon);
      });

      test(
          'isInitialMode が false かつ themeMode が system の場合、 themeModeSystemIcon を返すこと',
          () {
        final state =
            ThemeModeState(themeMode: ThemeMode.system, isInitialMode: false);
        expect(getThemeModeIcon(state), themeModeSystemIcon);
      });
    });
  });
}
